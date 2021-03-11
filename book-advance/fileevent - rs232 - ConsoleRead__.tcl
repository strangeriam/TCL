
proc com_read {consoleid} {
      global console_log str

      set str ""
      catch { set str [read $consoleid] }

      if { [string length $str]>0 } {
            lappend console_log $str
            puts -nonewline $str
      }

      vwait_seconds 1
      puts \n\nLOG==>\n$str
      return $str
}

proc com_write {consoleid str { newline 1 }} {
      if { $newline==0 } {
              catch {puts -nonewline $consoleid $str}
      } else {
              catch {puts $consoleid $str}
      }
}

proc com_open_1 {} {
      global com_fd

      if { ![catch { set com_fd [open com1 r+] } result] } {
               puts "\ncom1 successful.."
               fileevent $com_fd  readable [list com_read $com_fd]
               fconfigure $com_fd -blocking 0 -buffering line -mode 115200,n,8,1
               return $com_fd
      } else {
               puts "\ncom1 open fail..close com1."
               f_com_close $com_fd
      }
}

proc com_open_2 {} {
      global com2_fd

      if { ![catch { set com2_fd [open com4 r+] } result] } {
               puts "\ncom4 successful.."
               fileevent $com2_fd readable [list com_read $com2_fd]
               fconfigure $com2_fd -blocking 0 -buffering line -mode 115200,n,8,1
               return $com2_fd
      } else {
               puts "\ncom4 open fail..close com4."
               f_com_close $com2_fd
      }
}

com_open_1
com_open_2



com_write $com_fd  "cat /etc/openwrt_release | grep DISTRIB_REVISION"
com_write $com2_fd "cat /etc/openwrt_release | grep DISTRIB_REVISION"
