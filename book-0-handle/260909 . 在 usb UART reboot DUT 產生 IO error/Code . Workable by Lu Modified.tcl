
proc _f_comm_env_setup {} {
	set ::COMM_METHOD [::twapi::read_inifile_key "CONTROL" "METHOD" -inifile "./MainConfig.ini" -default "NA"]

	;# RS232
	set ::COMM_SERVER1 		[::twapi::read_inifile_key "CONTROL" "SERVER1" -inifile "./MainConfig.ini" -default "NA"]
	set ::COMM_SERVER_COS 	[lindex [split [regexp -all -inline {COS\d=[23RSH]+} $::COMM_SERVER1] =] 0]
	set ::COMM_SERVER_TYPE 	[lindex [split [regexp -all -inline {COS\d=[23RSH]+} $::COMM_SERVER1] =] 1]
	set ::COMM_SERVER_PORT 	COM[lindex [split [regexp -all -inline {COM=\d+} $::COMM_SERVER1] =] 1]
	set ::COMM_SERVER_BAUD 	[lindex [split [regexp -all -inline {COM=\d+,\d+,} $::COMM_SERVER1] ,] 1]

	set ::COMM_CLIENT1 		[::twapi::read_inifile_key "CONTROL" "CLIENT1" -inifile "./MainConfig.ini" -default "NA"]
	set ::COMM_CLIENT_COS 	[lindex [split [regexp -all -inline {COS\d=[23RSH]+} $::COMM_CLIENT1] =] 0]
	set ::COMM_CLIENT_TYPE 	[lindex [split [regexp -all -inline {COS\d=[23RSH]+} $::COMM_CLIENT1] =] 1]
	set ::COMM_CLIENT_PORT 	COM[lindex [split [regexp -all -inline {COM=\d+} $::COMM_CLIENT1] =] 1]
	set ::COMM_CLIENT_BAUD 	[lindex [split [regexp -all -inline {COM=\d+,\d+,} $::COMM_CLIENT1] ,] 1]

	;# SSH
	set ::COMM_SERVER2 		[::twapi::read_inifile_key "CONTROL" "SERVER2" -inifile "./MainConfig.ini" -default "NA"]
	set ::COMM_CLIENT2 		[::twapi::read_inifile_key "CONTROL" "CLIENT2" -inifile "./MainConfig.ini" -default "NA"]

	set ::COS1 				$::COMM_SERVER_COS
	set ::COS2 				$::COMM_CLIENT_COS

	set ::event_callback_cos1 	""
	set ::event_callback_cos2 	""
}

_f_comm_env_setup

;#---------------------------------------------------------------------------
;# 實際開啟序列埠 (共用給初次連線與重連). 成功回 channel, 失敗回 ""
;#---------------------------------------------------------------------------
;# _f_comm_open_serial COM8 115200
proc _f_comm_open_serial { port baud } {
	if {[catch {
		set dev "\\\\.\\$port"
		set ch [open $dev r+]
		fconfigure $ch -mode "$baud,n,8,1" \
                       -translation binary \
                       -buffering none \
                       -blocking 0
    } err]} {
        return ""
    }
    return $ch
}

;# _f_comm_ConfigConsole_rs232 $::COS1
;# _f_comm_ConfigConsole_rs232 $::COS2
proc _f_comm_ConfigConsole_rs232 { COS } {
	if {$COS == "COS1"} {
		set port $::COMM_SERVER_PORT
		set baud $::COMM_SERVER_BAUD
	} elseif { $COS == "COS2" } {
		set port $::COMM_CLIENT_PORT
		set baud $::COMM_CLIENT_BAUD
	}

	set ch ""

    set ch [_f_comm_open_serial $port $baud]
    if {$ch eq ""} {
        return -code error "RS232 連線失敗 ($port)"
    }

    # puts "ch B: $ch"

    if { [string index $COS end-0] == 1} {
    	set ::COS1 $ch
    	puts "COS: $COS . $::COS1 --> port: $port . baud: $baud"
    } elseif {[string index $COS end-0] == 2} {
    	set ::COS2 $ch
    	puts "COS: $COS . $::COS2 --> port: $port . baud: $baud"
    }

    fileevent $ch readable [list _f_comm_readConsole $ch]
    return $ch
}

;# _f_comm_ConfigConsoleDisconnect $::COS1
;# _f_comm_ConfigConsoleDisconnect $::COS2
proc _f_comm_ConfigConsoleDisconnect { COS } {
    catch { fileevent $COS readable {} }
    if { [catch {close $COS} err] } {
        return 0
    }

    if { $COS == $::COS1 } {
    	set ::COS1 COS1
    	puts "::COS1 --> $::COS1"
    } elseif { $COS == $::COS2 } {
    	set ::COS2 COS2
    	puts "::COS2 --> $::COS2"
    }

    return 1
}

;# _f_comm_transmit "date" $::COS1
;# _f_comm_transmit "reboot" $::COS1

;# _f_comm_transmit "date" $::COS2
;# _f_comm_transmit "reboot" $::COS2
proc _f_comm_transmit { cmd COS } {
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
proc _f_comm_readConsole { COS } {
    if {[catch {eof $COS} isEof]} {
        _f_comm_handle_io_error $COS "eof-check: $isEof"
        return
    }
    if {$isEof} {
        puts "COMM2: EOF detected (device likely rebooting)"
        _f_comm_handle_io_error $COS "eof"
        return
    }

    ;# --- 2. 讀取 (核心: USB-serial 消失時 read 拋 I/O error) ---
    if {[catch {read $COS} data]} {
        _f_comm_handle_io_error $COS "read: $data"
        return
    }

    if {$data eq ""} return

    ;# --- 3. 累加 buffer + 觸發回呼 ---
    if {$COS == $::COS1} {
	    append ::comm_buffer_cos1 $data
	    if {$::event_callback_cos1 ne ""} {
	        if {[catch {{*}$::event_callback_cos1 $data} cberr]} {
	            puts "COMM2: event_callback_cos1 error: $cberr"
	        }
	    }

	    set ::commBuffer_cos1 $::comm_buffer_cos1
	    return $::comm_buffer_cos1

    } elseif {$COS == $::COS2} {
	    append ::comm_buffer_cos2 $data
	    if {$::event_callback_cos2 ne ""} {
	        if {[catch {{*}$::event_callback_cos2 $data} cberr]} {
	            puts "COMM2: event_callback_cos2 error: $cberr"
	        }
	    }

	    set ::commBuffer_cos2 $::comm_buffer_cos2
	    return $::comm_buffer_cos2
    }

    return 0
}

;# _f_comm_getconsole $::COS2
proc _f_comm_getconsole { COS } {
	if {$COS == "$::COS1"} {
		set comm_buffer $::commBuffer_cos1
	} elseif {$COS == "$::COS2"} {
		set comm_buffer $::commBuffer_cos2
	}

    return $comm_buffer
}

;# _f_comm_clear $::COS1
;# _f_comm_clear $::COS2
proc _f_comm_clear { COS } {
	if { $COS == "$::COS1"} {
		if { [info exists ::commBuffer_cos1] } {
			unset ::commBuffer_cos1
			return 1
		}
	} elseif { $COS == "$::COS2" } {
		if { [info exists ::commBuffer_cos2] } {
			unset ::commBuffer_cos2
			return 1
		}
	}

	return 0
}

;#---------------------------------------------------------------------------
;# USB-serial 斷線 / I/O error 統一處理
;#---------------------------------------------------------------------------
proc _f_comm_handle_io_error { COS reason } {
    puts "COMM2: device I/O lost ($reason)"

    catch { fileevent $COS readable {} }
    catch { close $COS }

    ;# 清掉舊 channel 變數
    set ::COS[string index $COS end-0] ""

    if {$COS == $::COS1} {
		set port $::COMM_SERVER_PORT
		set baud $::COMM_SERVER_BAUD
    } elseif {$COS == $::COS2} {
		set port $::COMM_CLIENT_PORT
		set baud $::COMM_CLIENT_BAUD
    }

    after 2000
	set ::COS[string index $COS end-0] [_f_comm_reconnect_usb_serial $port $baud]
}

;#---------------------------------------------------------------------------
;# USB-serial 重連: 等裝置回來, 支援埠號改變
;#---------------------------------------------------------------------------
proc _f_comm_reconnect_usb_serial { port baud } {
    set ch [_f_comm_open_serial $port $baud]
    # puts "Lu.ch: $ch"

    if {$ch eq ""} {
        after 1000 [list _f_comm_reconnect_usb_serial $port $baud]
        return 0
    }

    fileevent $ch readable [list _f_comm_readConsole $ch]
    return $ch
}


# --- 設定事件回呼 ---
proc _f_comm_set_event_callback_COS1 {callback} {
	set ::event_callback_cos1 $callback
}

proc _f_comm_set_event_callback_COS2 {callback} {
	set ::event_callback_cos2 $callback
}

;# _f_waitfor $::COS2 $::expected_prompt 500
;# 注意: 若中途發生 reboot, channel 會被重連換掉, 這裡用全域 buffer 比對較穩
proc _f_comm_waitfor { ch waitfor timeout_ms } {
    set start [clock milliseconds]
    set ::comm_buffer ""      ;# 清空, 只比對這次等待期間的新資料

    while 1 {
        update idletasks
        update

        ;# 直接比對事件驅動累積的全域 buffer
        ;# (reboot 重連後, _f_comm_getconsole 仍會把新資料 append 進 ::comm_buffer)
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


;# 獨立工具.

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

