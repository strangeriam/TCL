
## ==============
## 輸出講解 220929
## ==============

package require Thread
## 2.7.2    ;# 印出 Thread 版本

proc f_sayHello_john {} {
	puts "\nHello John...\n"
	for {set i 1} {$i <= 5} {incr i} {
		puts "John $i"
		after 500
	}
	puts "End John"
}

tsv::set share mainTid [thread::id]
## tid00003508    ;# 印出 mainTid 的 Thread ID.

set tid [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list f_sayHello_john]
}]

## tid00005D98 ;# 印出 tid 的 Thread ID.

set ::bye 0
## 0

after 3000 [list set ::bye 1]
## after#2

vwait ::bye
## 0

thread::join $tid
## Hello John...
## 
## John 1
## John 2
## John 3
## John 4
## John 5
## End John

puts "bye~~~"
## bye~~~   ;# 印出 bye~~~
