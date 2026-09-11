;############################################################################
;# comm2.tcl - RS232 console 通訊 (USB-to-Serial reboot 防護版)
;#---------------------------------------------------------------------------
;# 針對 USB-to-Serial 轉接器的特性:
;#   - DUT reboot/斷電時, USB-serial 裝置會從 Windows 消失再重新枚舉
;#   - 舊的 COM handle 完全失效, 必須 close, 不能沿用
;#   - 裝置消失期間 open 會失敗 (找不到裝置), 要等它回來
;#   - 重新枚舉後 COM 埠號「可能改變」(COM8 -> COM9), 需重新偵測
;#
;# 修正重點:
;#   1. 所有 read/eof/puts 對 channel 的操作都包 catch
;#   2. I/O error 時關閉舊 channel, 進入「等待裝置回來」重連流程
;#   3. 重連時掃描系統目前存在的 COM 埠, 支援埠號改變
;#   4. 可用 VID/PID 或描述字串鎖定同一顆 USB-serial
;############################################################################

;# ---- 連線參數 ----
set ::comm_port      "COM8"     ;# 初始 / 目前使用的 COM 埠
set ::comm_baud      "115200"
set ::comm_buffer    ""
set ::event_callback ""
set ::comm_COS       "COS1"

;# ---- USB-serial 重連設定 ----
set ::comm_reconnect      1     ;# 1=reboot/斷線自動重連, 0=僅忽略錯誤
set ::comm_reconnecting   0     ;# 內部狀態: 是否正在重連中 (避免重入)
;# 埠號可能改變時, 用以下條件鎖定「同一顆」USB-serial:
;#   allow_port_change = 1 : 若原埠消失, 接受系統上「新出現的」COM 埠
;#   match_hint        : (選填) 用來比對埠的提示 (VID_xxxx&PID_xxxx 或描述關鍵字),
;#                       空字串表示不比對 (只要有 COM 埠回來就用)
set ::comm_allow_port_change  1
set ::comm_match_hint         ""    ;# 例: "VID_10C4&PID_EA60" (CP2102) 或 "FTDI"


;# _f_ConfigConsole_rs232 COM8 COS1
proc _f_ConfigConsole_rs232 { port COS } {
    set ::comm_port $port
    set ::comm_COS  $COS

    set ch [_f_open_serial $port]
    if {$ch eq ""} {
        return -code error "RS232 連線失敗 ($port)"
    }

    set ::COS[string index $COS end-0] $ch
    fileevent $ch readable [list _f_getconsole $ch]
    return $ch
}


;#---------------------------------------------------------------------------
;# 實際開啟序列埠 (共用給初次連線與重連). 成功回 channel, 失敗回 ""
;#---------------------------------------------------------------------------
proc _f_open_serial { port } {
    if {[catch {
        set dev "\\\\.\\$port"
        set ch [open $dev r+]
        fconfigure $ch -mode "$::comm_baud,n,8,1" \
                       -translation binary \
                       -buffering none \
                       -blocking 0
    } err]} {
        # puts "COMM2: open $port failed: $err"
        return ""
    }
    return $ch
}


;# _f_transmit $::COS1 "reboot"
proc _f_transmit { ch cmd } {
    ;# reboot 當下 USB-serial 可能已消失, 寫入會拋錯 -> 包 catch
    if {[catch {
        puts $ch $cmd
        flush $ch
    } err]} {
        puts "COMM2: transmit ignored (device busy/gone): $err"
        return 0
    }
    return 1
}


# --- RS232 讀取事件處理 ---
;# _f_getconsole $::COS1
proc _f_getconsole { ch } {

    ;# 若正在重連, 這個舊 channel 的事件一律忽略
    if {$::comm_reconnecting} {
        catch { fileevent $ch readable {} }
        return
    }

    ;# --- 1. EOF 檢查 (包 catch, USB 拔除時 eof 也可能拋錯) ---
    if {[catch {eof $ch} isEof]} {
        _f_handle_io_error $ch "eof-check: $isEof"
        return
    }
    if {$isEof} {
        puts "COMM2: EOF detected (device likely rebooting)"
        _f_handle_io_error $ch "eof"
        return
    }

    ;# --- 2. 讀取 (核心: USB-serial 消失時 read 拋 I/O error) ---
    if {[catch {read $ch} data]} {
        _f_handle_io_error $ch "read: $data"
        return
    }

    if {$data eq ""} return

    ;# --- 3. 累加 buffer + 觸發回呼 ---
    append ::comm_buffer $data
    if {$::event_callback ne ""} {
        if {[catch {{*}$::event_callback $data} cberr]} {
            puts "COMM2: event_callback error: $cberr"
        }
    }
}


;#---------------------------------------------------------------------------
;# USB-serial 斷線 / I/O error 統一處理
;#---------------------------------------------------------------------------
proc _f_handle_io_error { ch reason } {
    ;# 避免多個事件同時觸發重複進入
    if {$::comm_reconnecting} return
    set ::comm_reconnecting 1

    puts "COMM2: device I/O lost ($reason)"

    ;# 舊 channel 已失效: 解除事件並關閉 (USB 已消失, close 也可能拋錯)
    catch { fileevent $ch readable {} }
    catch { close $ch }

    ;# 清掉舊 channel 變數
    set ::COS[string index $::comm_COS end-0] ""

    if {!$::comm_reconnect} {
        puts "COMM2: reconnect disabled."
        set ::comm_reconnecting 0
        return
    }

    ;# 進入「等裝置回來」流程
    puts "COMM2: waiting for USB-serial to re-enumerate ..."
    after 2000 [list _f_reconnect_usb_serial 1]
}


;#---------------------------------------------------------------------------
;# 掃描系統目前存在的 COM 埠 (讀註冊表 SERIALCOMM)
;# 回傳 COM 埠清單, 例: {COM8 COM3}
;#---------------------------------------------------------------------------
proc _f_list_serial_ports {} {
    set ports {}
    ;# 方法 1: registry 套件 (Windows 內建於 ActiveTcl/Magicsplat)
    if {![catch {package require registry}]} {
        set key "HKEY_LOCAL_MACHINE\\HARDWARE\\DEVICEMAP\\SERIALCOMM"
        if {![catch {registry values $key} vals]} {
            foreach v $vals {
                if {![catch {registry get $key $v} portname]} {
                    lappend ports $portname
                }
            }
        }
        return $ports
    }

    ;# 方法 2: 沒有 registry 套件 -> 用 reg.exe 命令列 fallback
    if {![catch {exec reg query "HKLM\\HARDWARE\\DEVICEMAP\\SERIALCOMM"} out]} {
        foreach line [split $out \n] {
            ;# 每行格式: <裝置路徑>    REG_SZ    COMx
            if {[regexp {REG_SZ\s+(COM\d+)} $line -> p]} {
                lappend ports $p
            }
        }
    }
    return $ports
}


;#---------------------------------------------------------------------------
;# 依 match_hint 用 WMI 找對應的 COM 埠 (選填, 用於精準鎖定同一顆轉接器)
;# 回傳 COM 埠或 ""
;#---------------------------------------------------------------------------
proc _f_find_port_by_hint { hint } {
    if {$hint eq ""} { return "" }
    ;# 用 PowerShell WMI 查 PnP 序列裝置, 比對 hint (VID/PID 或描述)
    set psCmd {
        Get-CimInstance Win32_PnPEntity |
        Where-Object { $_.Name -match 'COM\d+' } |
        Select-Object -ExpandProperty Name
    }
    if {[catch {exec powershell -NoProfile -Command $psCmd} out]} {
        return ""
    }
    foreach line [split $out \n] {
        ;# 比對 hint (不分大小寫)
        if {[string match -nocase "*$hint*" $line]} {
            if {[regexp {\((COM\d+)\)} $line -> p]} {
                return $p
            }
        }
    }
    return ""
}


;#---------------------------------------------------------------------------
;# USB-serial 重連: 等裝置回來, 支援埠號改變
;#---------------------------------------------------------------------------
proc _f_reconnect_usb_serial { {attempt 1} {max 60} } {
    if {$attempt > $max} {
        puts "COMM2: reconnect FAILED after $max attempts"
        set ::comm_reconnecting 0
        return 0
    }

    ;# --- 決定要開哪個埠 ---
    set target $::comm_port

    ;# (a) 若指定了 match_hint, 優先用 WMI 精準找同一顆轉接器
    if {$::comm_match_hint ne ""} {
        set found [_f_find_port_by_hint $::comm_match_hint]
        if {$found ne ""} {
            set target $found
        }
    } elseif {$::comm_allow_port_change} {
        ;# (b) 允許埠號改變: 若原埠不在現有清單, 改用目前存在的第一個 COM 埠
        set ports [_f_list_serial_ports]
        if {[llength $ports] > 0 && [lsearch -exact $ports $::comm_port] < 0} {
            set target [lindex $ports 0]
            puts "COMM2: original $::comm_port gone, trying new port $target"
        }
    }

    ;# --- 嘗試開啟 ---
    set ch [_f_open_serial $target]
    if {$ch eq ""} {
        ;# 裝置還沒回來 (USB 尚未枚舉完), 稍後再試
        after 1000 [list _f_reconnect_usb_serial [expr {$attempt + 1}] $max]
        return 0
    }

    ;# --- 成功: 更新狀態, 重新掛事件 ---
    set ::comm_port $target
    set ::COS[string index $::comm_COS end-0] $ch
    fileevent $ch readable [list _f_getconsole $ch]
    set ::comm_reconnecting 0
    puts "COMM2: reconnected on $target after reboot (attempt $attempt)"

    ;# (選填) 通知上層已重連, 可在此重送登入指令等
    if {[info exists ::comm_reconnect_callback] && $::comm_reconnect_callback ne ""} {
        catch { {*}$::comm_reconnect_callback $ch $target }
    }
    return $ch
}


# --- 設定事件回呼 ---
proc _f_set_event_callback {callback} {
    set ::event_callback $callback
}

;# 設定「重連成功後」的回呼 (可用來重新登入 DUT)
;#   callback 會收到 (channel, port) 兩個參數
proc _f_set_reconnect_callback {callback} {
    set ::comm_reconnect_callback $callback
}


;# _f_ConfigConsoleDisconnect $::COS1
proc _f_ConfigConsoleDisconnect { COS } {
    catch { fileevent $COS readable {} }
    if { [catch {close $COS} err] } {
        return 0
    }
    return 1
}


;# _f_waitfor $::COS2 $::expected_prompt 500
;# 注意: 若中途發生 reboot, channel 會被重連換掉, 這裡用全域 buffer 比對較穩
proc _f_waitfor { ch waitfor timeout_ms } {
    set start [clock milliseconds]
    set ::comm_buffer ""      ;# 清空, 只比對這次等待期間的新資料

    while 1 {
        update idletasks
        update

        ;# 直接比對事件驅動累積的全域 buffer
        ;# (reboot 重連後, _f_getconsole 仍會把新資料 append 進 ::comm_buffer)
        if { [regexp $waitfor $::comm_buffer]} {
            ::debug::log "COMM: prompt detected"
            return 1
        }

        set elapsed [expr {[clock milliseconds] - $start}]
        if {$elapsed >= $timeout_ms} {
            ::debug::log "Prompt wait timeout (${timeout_ms}ms)"
            return 0
        }

        after 50
    }
}
