proc PoE_Test_analyze_250715 {} {
	set get_info [_f_getconsole]
	set pattern {\d+\s+\|\s+\d+ \|\s+\-\d+ \|\s+\d+\s+\|\s+\d+\s+\|\s+\d+\s+\|\s+FAIL}
	if {[info exists faillist]} { unset faillist }

	foreach line [regexp -all -inline $pattern $get_info] {
		set ngPort [string trim [lindex [split $line |] 1]]
		append faillist "$ngPort "
	}

	if {![info exists faillist]} { set faillist "" }
	return [lsort -integer $faillist]
}
