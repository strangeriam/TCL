proc _f_WriteFile { fname access data } {
	if { 	[catch {
			set fd [open $fname $access]
			puts -nonewline $fd $data
			close $fd
		} retmsg] } {

  		return 0
	} else {
		return 1
	}
}
