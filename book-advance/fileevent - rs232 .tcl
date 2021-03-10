proc com_try {} {
      global com_fd

      if { ![catch { set com_fd [open "COM1:" r+] } result] } {

               puts "Get Console connection --> COM1."
               fconfigure $com_fd -blocking 0 -buffering line -mode 115200,n,8,1 -translation cr
               return $com_fd
      }
}

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

fileevent $com_fd readable [list getline $com_fd]
fconfigure $com_fd -buffering line

ConsoleWrite $com_fd ls
vwait_seconds 1
#set aaa [ConsoleRead $com_fd]

puts "aaa ==>$aaa"
