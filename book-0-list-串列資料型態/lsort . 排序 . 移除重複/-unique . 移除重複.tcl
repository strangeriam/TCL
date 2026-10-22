
;# 排除相同的 Port number
set ports ""
foreach {whole num} [regexp -all -inline {port\s+(\d+)} $get_info] {
	lappend ports $num
}
set ngPorts [lsort -integer -unique $ports]
;# 輸出
1 2 13 14 25 26 37 38

set totalFail [llength $ngPorts]
;# 輸出
8

;# =====================================================
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
