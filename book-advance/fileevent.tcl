# file: test/calc.tcl --
#     Demo program
#
for {set i 0} {$i < 10} {incr i} {
      after 1000
      puts $i
      flush stdout
}

## file: test/test1.tcl
##    Main program
proc getline {chan} {
      global done

      gets $chan line

      if { ! [eof $chan] } {
                  puts ">> $line"
      } else {
                  close $chan
                  set done 1
      }
}

set program [open "|tclsh test/calc.tcl" r]
fileevent $program readable [list getline $program]
fconfigure $program -buffering line

vwait done

## ==============================
## Interrupting the other program
## Close the channel after 100 seconds ...
after 100000 {
      catch {
          close $program
      }
      set done 1
}
