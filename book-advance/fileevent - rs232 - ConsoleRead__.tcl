proc ConsoleRead {consoleid} {
      global console_log

      set str ""
      catch { set str [read $consoleid] }

      if { [string length $str]>0 } {
            lappend console_log $str
            puts -nonewline $str
      }

      return $str
}

proc com_try {} {
      global com_fd

      if { ![catch { set com_fd [open "com1:" r+] } result] } {
               fileevent $com_fd readable [list ConsoleRead $com_fd]
               fconfigure $com_fd -blocking 0 -buffering line -mode 115200,n,8,1
               return $com_fd
      }
}

com_try

ConsoleWrite $com_fd "brctl show"

f_com_close $com_fd
