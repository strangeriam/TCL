if { [info exists faillist] } { unset faillist }

set itemlist [list 	20000001 20000002 20000003 20000004 20000005 \
					20000007 20000008 20000009 20000010 20000011 \
					20000012 20000020 20000021 20000022 40000010 \
					\
					10000000 10000010 10000020 10000030 10000100 \
					10000200 10000300 10000310 10000320 10000330 \
					\
					10000340 00000001 40000020 40000160 40000170 \
					70200000 70300000 70400000 70540000 90000020 ]

foreach item $itemlist {
	set line "${item}.*ON\\s+\\|\\s+0.*\\s+1"
	if { [regexp -line $line $get_info] } {
		lappend faillist $item
	}
}

if { [info exists faillist] } {
	puts "faillist:\n$faillist"
}
