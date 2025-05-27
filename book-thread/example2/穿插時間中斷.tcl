proc vwait_mseconds {msec} {
	 set vwait_flag 0
	 after [expr $msec] { set vwait_flag 1 }
	 vwait vwait_flag
}

proc f_say1 {} {
    for {set i 1} {$i <= 5} {incr i} {
        puts "say1 . $i"
	vwait_mseconds 1000
    }
}

proc f_say2 {} {
    for {set i 1} {$i <= 5} {incr i} {
        puts "say2 . $i"
	vwait_mseconds 500
    }
}

package require Thread
tsv::set share mainTid [thread::id]

set tid1 [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list f_say1]
}]

set tid2 [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list f_say2]
}]

puts "wait 5 seconds .. start"
vwait_mseconds 5000
puts "wait 5 seconds .. end"

thread::join $tid1
thread::join $tid2

;# 輸出
say1 . 1
say2 . 1
say2 . 2
say2 . 3
say2 . 4
say2 . 5
say1 . 2
say1 . 3
say1 . 4
say1 . 5
