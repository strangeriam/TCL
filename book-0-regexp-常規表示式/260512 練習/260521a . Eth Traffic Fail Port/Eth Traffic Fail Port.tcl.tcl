
set spec 900
if {[info exists ngList]} { unset ngList }
foreach line [regexp -all -inline {\d+\s+0/[ 0-9]+\s+} $get_info] {
	if { [lindex $line end-0] < $spec } {
			set ngPort [lindex $line 0]
			append ngList "$ngPort "
	}
}

if {[info exists ngList]} {
	puts "NG PORT: $ngList"
	return 0
}

