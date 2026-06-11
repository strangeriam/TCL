
if {[info exists faillist]} { unset faillist }
foreach line [regexp -all -inline {port \d+} $get_info] {
		puts "line: $line"
    append faillist "[lindex $line 1], "
}

if { [info exists faillist]} {
  puts "faillist: $faillist"
}

;# 移除相同項目
set list1 "AAA AAA BBB CCC CCC CCC"

if {[info exists appendL]} { unset appendL }
foreach item $list1 {
	if {[regexp $item $list1]} {
		append appendL "$item "
		set list1 [string map "$item \"\"" $list1]
	}
}

## 移除 appendL 最後的空白.
set appendL [string trim $appendL]




set get_info {
15:43:03:089| ------ --------- ------------------
15:43:03:089| port 1 (0/0):
15:43:03:089| port 2 (0/1):
15:43:03:089| port 13 (0/12):
15:43:03:089| port 14 (0/13):
15:43:03:089| port 25 (0/24):
15:43:03:089| port 26 (0/25):
15:43:03:089| port 37 (0/36):
15:43:03:445| port 38 (0/37):
15:43:03:445| return code is 1
15:43:03:445| rc==GT_FAIL, possible reason: function doesn't exists

15:43:05:254| ------ --------- ------------------
15:43:05:254| port 1 (0/0):
15:43:05:254| port 2 (0/1):
15:43:05:254| port 13 (0/12):
15:43:05:254| port 14 (0/13):
15:43:05:254| port 25 (0/24):
15:43:05:254| port 26 (0/25):
15:43:05:254| port 37 (0/36):
15:43:05:254| port 38 (0/37):
15:43:05:254| return code is 1
}
