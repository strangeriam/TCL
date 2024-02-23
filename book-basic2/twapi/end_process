
# Establish Telnet
open "|metadata/plink -telnet 192.168.1.1" w+

set pid [twapi::get_process_ids -name plink.exe]
## pid: 14032 7444 4560

for {set i 0} {$i < [llength $pid]} {incr i} {
            set pid_kill [lindex $pid $i]
            puts "\npid_kill : $pid_kill\n"
            twapi::end_process $pid_kill
}

## ========================================
twapi::end_process $id

## Kill many IDs with same Application same, such as plink.exe.
##
set plink_pids ""
set plink_pids [twapi::get_process_ids -name plink.exe]

for { set i 0 } {$i <= [expr {[llength $plink_pids] }]} {incr i} {
      puts "i.. $i"
      set id [lindex $plink_pids [expr {$i + 1}]]
      catch { twapi::end_process $id } err
}

## ========================================
set pid [twapi::get_process_ids -name plink.exe]

set tmp [llength $pid]
set tmp [lindex $pid [expr $tmp -1]]
twapi::end_process $tmp

set pid [twapi::get_process_ids -name plink.exe]
if { $pid == "" } {puts "quit kill"}
