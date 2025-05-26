
proc timediff { one two } {
      set listone [split $one :]
      foreach {h m s} $listone break

      set onesec [expr $h*60*60+$m*60+$s]

      set listtwo [split $two :]
      foreach {h m s} $listtwo break

      set twosec [expr $h*60*60+$m*60+$s]
      return [expr abs($onesec-$twosec)]
}

puts [timediff "14:33:50" "14:34:10"]
puts [timediff "14:34:20" "14:34:10"]


## ====================================

proc timediff { one two } {
    
      set listone [split $one :]
      foreach {h m s} $listone break

      set onesec [expr $h*60*60+$m*60+$s]

      set listtwo [split $two :]
      foreach {h m s} $listtwo break

      set twosec [expr $h*60*60+$m*60+$s]
      return [expr abs($onesec-$twosec)]
}

set zero_time [clock format [clock seconds] -format "%H:%M:%S"]
set now_time [clock format [clock seconds] -format "%H:%M:%S"]

set total 10
for {set i 1} {$i <= $total} {incr i} {
      set zero_time [clock format [clock seconds] -format "%H:%M:%S"]
      puts [ timediff $zero_time $now_time ]
      after 1000
}

## ====================================

set total 70
for {set i 1} {$i < $total} {incr i} {
      
      if {$i == 1} {
            set time_1 [clock seconds]
      }

      after 1000
      set time_2 [clock seconds]

      set time_A [expr $time_2 - $time_1]
      set time_B [clock format $time_A -format "%M:%S"]
      puts $time_B
}

OUTPUT:
00:01
00:02
00:03
.
.
00:57
00:59
01:00
01:01
01:02
.
.
