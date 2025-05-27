proc f_sayHello_john {} {
	puts \n
	for {set i 1} {$i <= 5} {incr i} {
		puts "H e l l o ... $i"
		after 500
	}
	puts \n
}

proc f_sayHi_Lu {} {
	puts \n
	for {set i 1} {$i <= 5} {incr i} {
		puts "H I ... $i"
		after 500
	}
	puts \n
}

package require Thread
tsv::set share mainTid [thread::id]

set tid1 [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list f_sayHello_john]
}]

set tid2 [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list f_sayHi_Lu]
}]

set ::bye 0
after 3000 [list set ::bye 1]
vwait ::bye

thread::join $tid1
thread::join $tid2
puts "bye~~~"


## ===========
## 輸出 220929
## ===========
2.7.2
tid00004ADC
tid0000210C
tid000048F0
0
after#2




H I ... 1
H I ... 2
H I ... 3
H I ... 4
H I ... 5


H e l l o ... 1
H e l l o ... 2
H e l l o ... 3
H e l l o ... 4
H e l l o ... 5


0
0
bye~~~
