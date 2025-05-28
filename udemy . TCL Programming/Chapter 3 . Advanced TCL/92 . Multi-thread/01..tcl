;# 需使用 tclsh 才能實際操作 thread 的實作.

package require Thread

thread::create {
  for {set i 0} {$i < 5} {incr i} {
    puts "Side thread interation $i"
    after 5000  
  }
}

for {set i 0} {$i < 5} {incr i} {
    puts "Main thread interation $i"
    after 2000
}

;# 輸出
Main thread interation 0
Main thread interation 1
Main thread interation 2
Side thread interation 1
Main thread interation 3
Main thread interation 4
Side thread interation 2
Side thread interation 3
Side thread interation 4
