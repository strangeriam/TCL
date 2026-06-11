
if {[info exists faillist]} { unset faillist }
foreach line [regexp -all -inline {port \d+} $get_info] {
	puts "line: $line"
    append faillist "[format %02d [lindex $line 1]] "
}

if { [info exists faillist]} {
  puts "faillist: $faillist"
}
;# 輸出
faillist: 01 02 13 14 25 26 37 38 01 02 13 14 25 26 37 38 

;# 移除相同項目
if {[info exists FAILList]} { unset FAILList }
foreach port $faillist {
	puts "port: $port"
	if {[regexp $port $faillist]} {
		append FAILList "$port "
		set faillist [string map "$port \"\"" $faillist]
	}
}
set FAILList

;# 輸出
01 02 13 14 25 26 37 38 

## 移除 appendL 最後的空白.
set FAILList [string trim $FAILList]
;# 輸出
01 02 13 14 25 26 37 38


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
