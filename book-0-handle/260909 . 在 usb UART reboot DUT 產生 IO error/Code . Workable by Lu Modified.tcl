
set ::comm_buffer 			""
set ::event_callback 		""

;#---------------------------------------------------------------------------
;# 實際開啟序列埠 (共用給初次連線與重連). 成功回 channel, 失敗回 ""
;#---------------------------------------------------------------------------
;# _f_open_serial COM8 115200
proc _f_open_serial { port baud } {
	if {[catch {
		set dev "\\\\.\\$port"
		set ch [open $dev r+]
		fconfigure $ch -mode "$baud,n,8,1" \
                       -translation binary \
                       -buffering none \
                       -blocking 0
    } err]} {
        # puts "COMM2: open $port failed: $err"
        return ""
    }
    return $ch
}

;# _f_ConfigConsole_rs232 COM8 COS1
proc _f_ConfigConsole_rs232 { port COS } {
    set ch [_f_open_serial $port 115200]
    if {$ch eq ""} {
        return -code error "RS232 連線失敗 ($port)"
    }

    set ::COS[string index $COS end-0] $ch
    fileevent $ch readable [list _f_getconsole $ch]
    return $ch
}

;# _f_ConfigConsoleDisconnect $::COS1
proc _f_ConfigConsoleDisconnect { COS } {
    catch { fileevent $COS readable {} }
    if { [catch {close $COS} err] } {
        return 0
    }
    return 1
}

;# _f_transmit $::COS1 "ls -la"
;# _f_transmit $::COS1 "reboot"
proc _f_transmit { COS cmd } {
    ;# reboot 當下 USB-serial 可能已消失, 寫入會拋錯 -> 包 catch
    if {[catch {
        puts $COS $cmd
        flush $COS
    } err]} {
        puts "COMM2: transmit ignored (device busy/gone): $err"
        return 0
    }
    return 1
}

# --- RS232 讀取事件處理 ---
;# _f_getconsole $::COS1
proc _f_getconsole { COS } {
    ;# 若正在重連, 這個舊 channel 的事件一律忽略
    # if {$::comm_reconnecting} {
    #     catch { fileevent $COS readable {} }
    #     return
    # }

    ;# --- 1. EOF 檢查 (包 catch, USB 拔除時 eof 也可能拋錯) ---
    if {[catch {eof $COS} isEof]} {
        _f_handle_io_error $COS "eof-check: $isEof"
        return
    }
    if {$isEof} {
        puts "COMM2: EOF detected (device likely rebooting)"
        _f_handle_io_error $COS "eof"
        return
    }

    ;# --- 2. 讀取 (核心: USB-serial 消失時 read 拋 I/O error) ---
    if {[catch {read $COS} data]} {
        _f_handle_io_error $COS "read: $data"
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
;# _f_handle_io_error $::COS1
proc _f_handle_io_error { COS reason } {
    puts "COMM2: device I/O lost ($reason)"

    catch { fileevent $COS readable {} }
    catch { close $COS }

    ;# 清掉舊 channel 變數
    set ::COS[string index $COS end-0] ""

    # after 2000 [list _f_reconnect_usb_serial COS1]
    after 2000
	set ::COS[string index $COS end-0] [_f_reconnect_usb_serial]
}

;#---------------------------------------------------------------------------
;# USB-serial 重連: 等裝置回來, 支援埠號改變
;#---------------------------------------------------------------------------
proc _f_reconnect_usb_serial {} {
    set ch [_f_open_serial COM8 115200]
    puts "Lu.ch: $ch"

    if {$ch eq ""} {
        after 1000 [list _f_reconnect_usb_serial COS1]
        return 0
    }

    # set ::COS[string index $COS end-0] $ch
    fileevent $ch readable [list _f_getconsole $ch]
    return $ch
}


# --- 設定事件回呼 ---
proc _f_set_event_callback {callback} {
	set ::event_callback $callback
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

