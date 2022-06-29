proc test_case_time_1 { init } {

		if { $::var_lbl_status == "TEST" && $::test_case_time_init == "" } {
				set ::test_case_time_init [clock seconds]
		}

		set tmp [clock seconds]
		set tmp [expr $tmp - $::test_case_time_init]

		return [clock format $tmp -format "%M:%S"]
}

proc test_case_time_2_show {} {

		if { $::var_lbl_status == "PASS" || $::var_lbl_status == "FAIL" } {
				if { $::user == "LU" } { puts "\nLEAVE Test Time Counting...\n" }
				return 0
		}

   	 	set ::var_lbl_time [test_case_time_1 0]

  	 	after 500 test_case_time_2_show
}

set ::test_case_time_init ""
test_case_time_1 1
test_case_time_2_show

## Stop Time Counting
## $::var_lbl_status : PASS or FAIL
set ::var_lbl_status FAIL
