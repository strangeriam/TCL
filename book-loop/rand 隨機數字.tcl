
for {set i 1} {$i <= 3} {incr i} {
  set t [expr { int(500*rand()) }]
  puts "t: $t"
}

# 輸出
t: 101
t: 15
t: 244
