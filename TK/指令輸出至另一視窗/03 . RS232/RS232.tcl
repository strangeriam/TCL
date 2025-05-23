proc com_read_250523 { com_fd { wait_time 5 }} {
	global w

	set start [clock seconds]

	while 1 {
		if { [clock seconds] - $start > $wait_time } { return 0 }

		set resp [read $com_fd]
		if { [string length $resp] == 0} {
			vwait_mseconds 200 ; update
		} else {
			$w.t insert end $resp
			$w.t see end
		}
	}
}

package require Tk
UI_ShowLog
set ::console_port 12
set ::com_fd [com_open $::console_port]

puts $::com_fd "ls -la"
com_read_250523 $::com_fd
