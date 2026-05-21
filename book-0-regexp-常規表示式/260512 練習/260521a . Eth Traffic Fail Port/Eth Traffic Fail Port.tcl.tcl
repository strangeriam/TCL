
set pattern {\d \|\s+[A-Z_0-9]+ \|\s+0x\d+ \|\s+N \|\s+N \|\s+[0-9-]+ \|\s+\d+ \|\s+\d+ \|\s+[PASSFIL]+}

if {[info exists ngList]} { unset ngList }
foreach line [regexp -all -inline $pattern $get_info] {
	if { [lindex $line end-0] == "PASS" } {
			puts "Check PASS --> $line"
	} else {
			puts "Check FAIL --> $line"
			set ngPort [lindex $line 0]
			append ngList "$ngPort "
	}
}

if {[info exists ngList]} {
	puts "NG PHY: $ngList"
	return 0
}

return 1
