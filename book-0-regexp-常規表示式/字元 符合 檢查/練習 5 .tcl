
proc _f_ReadFile { fname } {
	if { [file exists $fname] } {
		set fd [open $fname r]
		set data [read $fd]
		close $fd
		return $data
	} else {
		return ""
	}
}

cd D:/Dropbox/12-Office-Sync-MTS/36_ECS4650/Others/250515_failCheck_PoE
set infile [_f_ReadFile Fail.txt]

if {[info exists faillist]} {
	unset faillist
}
