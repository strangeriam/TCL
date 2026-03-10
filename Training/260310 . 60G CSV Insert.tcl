
set ::path_report D:\/worktmp\/REPORT
set ::resultFile $::path_report\/report.csv
if { ![file exist $::path_report] } { file mkdir $::path_report }

;# ================================================
set build_date_time [clock format [clock seconds] -format "%y/%m/%d_%H:%M:%S"]
set build_date [lindex [string map {_ " "} $build_date_time] 0]
set build_time [lindex [string map {_ " "} $build_date_time] 1]

;# Step 1: 將 Item 寫入 csv 的第一行.
;# ================================================
;# total item: 13
set itemlist [list SN DATE TIME BRD_VER CHANNEL SECTOR PHASE ANTENNA SPACE1 TEMP_RF PW_TX PW_BG_START PW_BG_END]

foreach item $itemlist {
	append csvItem $item,
}

if { ! [file exists $::resultFile] } {
	_f_WriteFile $::resultFile w $csvItem\n
}

;# Step 2: 將 值 寫入 Item 對應 TEMP_RF 下的欄位.
;# ================================================
;# 取得 Item "TEMP_RF" 所在欄位數.
set csvItem_split [split $csvItem ,]
lsearch $csvItem_split TEMP_RF
;# 輸出: 9

;# add 12 values.
set datalist [list data1 data2 data3 data4 data5 data6 data7 data8 data9 data10 data11 data12]

;# replace data10 to 99.9
lset datalist 9 99.9





;# ================================================
proc _f_WriteFile { fname access data } {
	if { 	[catch {
			set fd [open $fname $access]
			puts -nonewline $fd $data
			close $fd
		} retmsg] } {

  		return 0
	} else {
		return 1
	}
}


if {[info exists ::csvData]} { unset ::csvData }
