package require Thread

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
    for {set i 1} {$i <= 8} {incr i} {
        puts "say2 . $i"
	vwait_mseconds 500
    }
}

unset ::sstop

tsv::set share mainTid [thread::id]

set tid1 [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list f_say1]
}]

f_say2

puts "wait 20 seconds .. start"
vwait_mseconds 20000
puts "wait 20 seconds .. end"

thread::join $tid1

;# 輸出
say2 . 1
say1 . 1
say1 . 2
say1 . 3
say1 . 4
say1 . 5
say2 . 2
say2 . 3
say2 . 4
say2 . 5
say2 . 6
say2 . 7
say2 . 8
