
set ::path_report D:\/worktmp\/REPORT
set ::resultFile $::path_report\/report.csv

if { ![file exist $::path_report] } { file mkdir $::path_report }

if {[info exists ::csvData]} { unset ::csvData }
