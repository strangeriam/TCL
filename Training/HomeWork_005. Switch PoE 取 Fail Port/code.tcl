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

set totalS 3
for {set i 1} {$i <= $totalS} {incr i} {
	set faillist [PoE_Test_analyze_250715]
	if { [llength $faillist] == 0 } { break }

	set totalFail [llength $faillist]
	_f_termmsg_V1 "faillist \($totalFail\) . Try ${i}/$totalS\n$faillist"

	if {$i == $totalS} {
		_f_Client_SelectUI "CALL PE/TE for NG ports \($totalFail\) . ${i}/$totalS\n\b\b$faillist" FailOnly "./bitmap/parts/ECS4150-28P_ETH.png"
		set ::s0 "PoE Fail" ; set ::ErrorCode "PoE"
		return 0
	}

	_f_Client_SelectUI "NG ports list \($totalFail\) . Try ${i}/$totalS\n\b\b$faillist" PassOnly "./bitmap/parts/ECS4150-28P_ETH.png" "TXT:RETRY"
  }
