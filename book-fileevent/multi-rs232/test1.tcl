
set com_fd1 ""

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

proc f_com_open_1 {} {
      global com_fd1

      set port 1

      puts "Configure COM 1 to PORT $port..."

      if { ![catch { set com_fd1 [open com$port r+] } result] } {

               puts "Get RS232 - 1 --> COM$port."
               fconfigure $com_fd1 -blocking 0 -buffering line -mode 115200,n,8,1

               return $com_fd1
      } else {
               for {set i 1} {$i <= 3} {incr i} {
                     puts "RS232 - 1 of Port $port not available..." ; after 1500
               }

               f_com_close2 $com_fd1

               return 0
      }
}

proc f_com_close2 { consoleid } {

      puts "Close COM $consoleid"

      catch {close $consoleid}
      set consoleid 0
}

f_com_close2 $com_fd1
f_com_open_1

#puts "\n\n=== TEST 1 = START ====================\n\n"

for {set arg1 0} {$arg1 <= 10} {incr arg1} {
    puts "\n\n=== TEST 1 = $arg1\n\n"

ConsoleWrite $com_fd1 "cat /etc/openwrt_release | grep DISTRIB_REVISION"
after 1000
set com1_log [ConsoleRead $com_fd1]

puts com1_log==>\n$com1_log
after 5000

}

#puts "\n\n=== TEST 1 = END ======================\n\n"
