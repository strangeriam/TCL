proc PoE_Test_analyze_250715 {} {
	set get_info $::log
	set pattern {\d+\s+\|\s+\d+ \|\s+\-\d+ \|\s+\d+\s+\|\s+\d+\s+\|\s+\d+\s+\|\s+FAIL}
	if {[info exists faillist]} { unset faillist }

	foreach line [regexp -all -inline $pattern $get_info] {
		set ngPort [string trim [lindex [split $line |] 1]]
		append faillist "$ngPort "
	}

	if {![info exists faillist]} { set faillist "" }
	return [lsort -integer $faillist]
}

proc _f_POE_Power_28P_26W_C4 {} {
	set totalS 3
	for {set i 1} {$i <= $totalS} {incr i} {
		set faillist [PoE_Test_analyze_250715]
		if { [llength $faillist] == 0 } { break }
	
		set totalFail [llength $faillist]
	
		if {$i == $totalS} {
			puts "\nCALL PE/TE for NG ports \($totalFail\) . Try ${i}/$totalS\n\b\b$faillist"
			return 0
		}
	
		puts "\nNG ports list \($totalFail\) . Try ${i}/$totalS\n\b\b$faillist"
	}
 
 	return 1
}

;#

