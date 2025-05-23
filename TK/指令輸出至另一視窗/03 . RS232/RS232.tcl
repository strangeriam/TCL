proc com_read { com_fd { wait_time 30 }} {
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

puts $::com_fd "ls -la"
com_read $::com_fd
