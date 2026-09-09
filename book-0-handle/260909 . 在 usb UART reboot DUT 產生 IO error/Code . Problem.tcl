

;# _f_ConfigConsole_rs232 COM8 COS1
proc _f_ConfigConsole_rs232 { port COS } {
    # puts "COMM2: Opening RS232 - port=$port, baud=115200"

    if {[catch {
        set dev "\\\\.\\COM8"
        set ch [open $dev r+]
        fconfigure $ch -mode "115200,n,8,1" \
                       -translation binary \
                       -buffering none \
                       -blocking 0
    } err]} {
        puts "COMM2 ERROR: Failed to open RS232 Port ($port): $err"
        return -code error "RS232 連線失敗 ($port): $err"
    }

    # puts "ch: $ch"

	set ::COS[string index $COS end-0] $ch
	fileevent $ch readable [list _f_getconsole $ch]

    # puts "COMM2: RS232 COM: $port connected."
    return $ch
}


;# _f_transmit $::COS1 "ls -la"
;# _f_transmit $::COS1 "reboot"
proc _f_transmit { ch cmd } {
	puts $ch $cmd
	flush $ch
}

# --- RS232 讀取事件處理 ---
;# _f_getconsole $::COS1
proc _f_getconsole { COS } {
	set ch $COS

    if {[eof $ch]} {
        puts "COMM: RS232 $::COS1 EOF detected"
        _f_ConfigConsoleDisconnect $::COS1
        return
    }

    puts "11111111111111111111"

    if { ![catch $ch err]} {
    	puts "AAAAAAAAAAAAAAAAAAAAAAAa"
    }

    set data [read $ch]

    puts "222222222222222222"

    if {$data eq ""} return
    puts "333333333333333333333"


    # 加入緩衝區
	append buffer $data

	# 觸發回呼
	if {$::event_callback ne ""} {
    	{*}$::event_callback $data
	}

    puts "COMM RX \[$::COS1\]: $data"
}

# --- 設定事件回呼 ---
proc _f_set_event_callback {callback} {
	set ::event_callback $callback
}



;# _f_ConfigConsoleDisconnect $::COS1
proc _f_ConfigConsoleDisconnect { COS } {
	if { [catch {close $COS} err] } {
		return 0
	}
	return 1
}


;# _f_waitfor $::COS2 $::expected_prompt 500
proc _f_waitfor { ch waitfor timeout_ms } {
    set start [clock milliseconds]
    while 1 {
        update idletasks
        update

        set tmp [read $ch]
        if { [regexp $waitfor $tmp]} {
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

	return $tmp
}

