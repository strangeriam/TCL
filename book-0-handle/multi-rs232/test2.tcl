
set com_fd2 ""

proc ConsoleWrite {consoleid str { newline 1 }} {
      if { $newline==0 } {
              catch {puts -nonewline $consoleid $str}
      } else {
              catch {puts $consoleid $str}
      }
}

proc ConsoleRead {consoleid} {
      global console_log console_log2

      set str ""
      catch { set str [read $consoleid] }

      if { [string length $str]>0 } {
            lappend console_log $str
            lappend console_log2 $str
            puts -nonewline $str
      }

      return $str
}

proc f_com_open_2 {} {
      global com_fd2

      set port 4

      puts "Configure COM 2 to PORT $port..."

      if { ![catch { set com_fd2 [open com$port r+] } result] } {

               puts "Get RS232 - 2 --> COM$port."
               fconfigure $com_fd2 -blocking 0 -buffering line -mode 115200,n,8,1

               return $com_fd2
      } else {
               for {set i 1} {$i <= 3} {incr i} {
                     puts "RS232 - 2 of Port $port not available..." ; after 1500
               }

               f_com_close2 $com_fd2

               return 0
      }
}

proc f_com_close2 { consoleid } {

      puts "Close COM $consoleid"

      catch {close $consoleid}
      set consoleid 0
}

f_com_close2 $com_fd2
f_com_open_2

#puts "\n\n=== TEST 2 = BEGIN ====================\n\n"

for {set arg2 0} {$arg2 <= 10} {incr arg2} {
      puts "\n\n=== TEST 2 = $arg2\n\n"

      ConsoleWrite $com_fd2 "cat /etc/openwrt_release | grep DISTRIB_REVISION"
      after 1000
      set com2_log [ConsoleRead $com_fd2]

      puts com2_log==>\n$com2_log
      after 5000
}

#puts "\n\n=== TEST 2 = DONE ======================\n\n"
