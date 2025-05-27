;# 此 package require 後, 就會新增一 thread id.
package require Thread
puts [thread::id]
;# 輸出: 

;# B, Create 2 threads.
puts [set t1 [thread::create]]
;# 輸出: tid000019C8

puts [set t2 [thread::create]]
;# 輸出: tid00001CD4

;# C, List exist thread IDs.
thread::names
;# 輸出: tid00001CD4 tid000019C8 tid00002080
