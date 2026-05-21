
set pattern {\d \|\s+[A-Z_0-9]+ \|\s+0x\d+ \|\s+N \|\s+N \|\s+[0-9-]+ \|\s+\d+ \|\s+\d+ \|\s+PASS}
regexp -all -inline $pattern $get_info

set get_info {
4 | PHY_88E1780_5 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS |
}
;# 輸出: {|  4 | PHY_88E1780_5 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS}

set get_info {
6 |       TMP75_1 |    0x48 |     N |        N | -40 | 125 |        32 |   PASS |
}
;# 輸出: {|  6 |       TMP75_1 |    0x48 |     N |        N | -40 | 125 |        32 |   PASS}

;#================================================================================================
foreach line [regexp -all -inline $pattern $get_info] {
	puts "line: $line"
}
;# 輸出:
line: 0 | PHY_88E1780_1 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS
line: 1 | PHY_88E1780_2 |     0x0 |     N |        N |   0 | 125 |        37 |   PASS
line: 2 | PHY_88E1780_3 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS
line: 3 | PHY_88E1780_4 |     0x0 |     N |        N |   0 | 125 |        32 |   PASS
line: 4 | PHY_88E1780_5 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS
line: 5 | PHY_88E1780_6 |     0x0 |     N |        N |   0 | 125 |        36 |   PASS
line: 6 |       TMP75_1 |    0x48 |     N |        N | -40 | 125 |        32 |   PASS

set get_info {
root@(none):/diagnostic# stdout_xform_temperature.sh
Switching application is already running, doing nothing.

+----+---------------+---------+-------+----------+-----+-----+-----------+--------+
| id |     name      | address | board | location | min | max | value('C) | result |
+----+---------------+---------+-------+----------+-----+-----+-----------+--------+
|  0 | PHY_88E1780_1 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS |
|  1 | PHY_88E1780_2 |     0x0 |     N |        N |   0 | 125 |        37 |   PASS |
|  2 | PHY_88E1780_3 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS |
|  3 | PHY_88E1780_4 |     0x0 |     N |        N |   0 | 125 |        32 |   PASS |
|  4 | PHY_88E1780_5 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS |
|  5 | PHY_88E1780_6 |     0x0 |     N |        N |   0 | 125 |        36 |   PASS |
|  6 |       TMP75_1 |    0x48 |     N |        N | -40 | 125 |        32 |   PASS |
+----+---------------+---------+-------+----------+-----+-----+-----------+--------+
root@(none):/diagnostic# 
}

;#========================================================================================
foreach line [regexp -all -inline $pattern $get_info] {
	puts "line: $line"
}
;# 輸出:
line: 1 | PHY_88E1780_2 |     0x0 |     N |        N |   0 | 125 |        37 |   PASS
line: 2 | PHY_88E1780_3 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS
line: 4 | PHY_88E1780_5 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS
line: 5 | PHY_88E1780_6 |     0x0 |     N |        N |   0 | 125 |        36 |   PASS

set get_info {
root@(none):/diagnostic# stdout_xform_temperature.sh
Switching application is already running, doing nothing.

+----+---------------+---------+-------+----------+-----+-----+-----------+--------+
| id |     name      | address | board | location | min | max | value('C) | result |
+----+---------------+---------+-------+----------+-----+-----+-----------+--------+
|  0 | PHY_88E1780_1 |     0x0 |     N |        N |   0 | 125 |        34 |   FAIL |
|  1 | PHY_88E1780_2 |     0x0 |     N |        N |   0 | 125 |        37 |   PASS |
|  2 | PHY_88E1780_3 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS |
|  3 | PHY_88E1780_4 |     0x0 |     N |        N |   0 | 125 |        32 |   FAIL |
|  4 | PHY_88E1780_5 |     0x0 |     N |        N |   0 | 125 |        34 |   PASS |
|  5 | PHY_88E1780_6 |     0x0 |     N |        N |   0 | 125 |        36 |   PASS |
|  6 |       TMP75_1 |    0x48 |     N |        N | -40 | 125 |        32 |   FAIL |
+----+---------------+---------+-------+----------+-----+-----+-----------+--------+
root@(none):/diagnostic# 
}

;# ============================================
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


