;# thread::wait . 讓新建立的 Thread 進入事件循環 (Event loop), 否則此 Thread 在執行後就會結束.
;# thread::release . 退出特定 Thread. 或不指定 $ID, 則為當前的 Thread.
;# thread::exit . 結束當前的 Thread, 但不可用於結束其他 Thread.

;# A, 此 package require 後, 就會新增一 thread id.
package require Thread
puts [thread::id]
;# 輸出: tid00001A9C

;# B, Create 2 threads.
puts [set t1 [thread::create]]
;# 輸出: tid000019C8

puts [set t2 [thread::create]]
;# 輸出: tid00001CD4

;# C, List exist thread IDs.
thread::names
;# 輸出: tid00001CD4 tid000019C8 tid00002080
