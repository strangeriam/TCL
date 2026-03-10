
set ::path_report D:\/worktmp\/REPORT
set ::resultFile $::path_report\/report.csv

if { ![file exist $::path_report] } { file mkdir $::path_report }

set build_date_time [clock format [clock seconds] -format "%y/%m/%d_%H:%M:%S"]
set build_date [lindex [string map {_ " "} $build_date_time] 0]
set build_time [lindex [string map {_ " "} $build_date_time] 1]


if {[info exists ::csvData]} { unset ::csvData }
