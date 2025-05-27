## CODE ==============

package require Thread

proc f_sayHello {} {
      for {set i 1} {$i <= 3} {incr i} {
              after [expr { int(500*rand()) }]
              puts \n
              puts "\[$i\] Thread [thread::id] says hello."
      }
}

for {set num 1} {$num <= 3} {incr num} {
      set id [thread::create [f_sayHello]]
      puts "\n\[-$num-\] Started thread $id"
}

puts "Exist threads: [thread::names]\n"

while { [llength [thread::names]] > 1 } {
        after 500
        puts "You are under [thread::names]\n"
}

puts "Code End"



## Code 解說 =====
## ===============
package require Thread

proc f_sayHello {} {
      for {set i 1} {$i <= 3} {incr i} {
              ## 產生亂數 0~499, [expr { int(500*rand()) }]
              ## 依亂數時間 0~499 等待, after
              after [expr { int(500*rand()) }]

              ## 列印 Thread ID.
              puts "\[$i\] Thread [thread::id] says hello."
      }
}

for {set num 1} {$num <= 3} {incr num} {
      set id [thread::create [f_sayHello]]
      puts "\n\[-$num-\] Started thread $id"
}

puts "*** Exist threads: [thread::names]\n"

# Wait until all other threads are finished.
while { [llength [thread::name]] > 1 } {
        after 500
        puts "*** You are under [thread::names]\n"
}

puts "*** Completed, Bro!"


## OUTPUT:
## Create 3 threads.
## =================
## Print a hello message 3 times,
## waiting a random amount of time between messages.


[1] Thread tid00003978 says hello.
[2] Thread tid00003978 says hello.
[3] Thread tid00003978 says hello.

[-1-] Started thread tid0000512C
[1] Thread tid00003978 says hello.
[2] Thread tid00003978 says hello.
[3] Thread tid00003978 says hello.

[-2-] Started thread tid0000408C
[1] Thread tid00003978 says hello.
[2] Thread tid00003978 says hello.
[3] Thread tid00003978 says hello.

[-3-] Started thread tid000023BC
*** Exist threads: tid00003978

*** Completed, Bro!
