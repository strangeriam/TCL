
set ::path_report D:\/worktmp\/REPORT
set ::resultFile $::path_report\/report.csv

if { ![file exist $::path_report] } { file mkdir $::path_report }

set build_date_time [clock format [clock seconds] -format "%y/%m/%d_%H:%M:%S"]
set build_date [lindex [string map {_ " "} $build_date_time] 0]
set build_time [lindex [string map {_ " "} $build_date_time] 1]


set itemlist [list 	SN \
							DATE \
							TIME \
							BRD_VER \
							CHANNEL \
							SECTOR \
							PHASE \
							ANTENNA \
							"" \
							TEMP_RF \
							PW_TX \
							PW_BG_START \
							PW_BG_END]

foreach item $itemlist {
	append csvItem $item,
}

if { ! [file exists $::resultFile] } {
	_f_WriteFile $::resultFile w $csvItem\n
}




if {[info exists ::csvData]} { unset ::csvData }
