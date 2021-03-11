proc getline {chan} {
        gets $chan line

        if { ![eof $chan] } {
                puts "$line"
        } else {
                close $chan
        }
}

proc com_try {} {
      global com_fd

      if { ![catch { set com_fd [open "com1:" r+] } result] } {
               fileevent $com_fd readable [list getline $com_fd]
               fconfigure $com_fd -blocking 0 -buffering line -mode 115200,n,8,1
               return $com_fd
      }
}

com_try

ConsoleWrite $com_fd "brctl show"
vwait_seconds 1

f_com_close $com_fd
