package require Thread

proc dut1 {} {
        set com_fd [com_open 11]

        ConsoleWrite $com_fd "uname -a"
        vwait_mseconds 500
        set uartRes [ConsoleRead $com_fd]
        #puts "\n\nuartRes : $uartRes\n\n"

        vwait_seconds 5
        com_close $com_fd
}

proc dut2 {} {
	set com_fd [com_open 12]

	ConsoleWrite $com_fd "route -n"
        vwait_seconds 1
        set uartRes [ConsoleRead $com_fd]
        #puts "uartRes : $uartRes"

        com_close $com_fd
}

for {set i 1} {$i <= 3} {incr i} {
        puts "\n\n\n- $i -\n\n\n"
        set tid1 [thread::create [dut1]]
        set tid2 [thread::create [dut2]]
}


## Code End
