## client.tcl
set chan [socket 127.0.0.1 9900]
while {1} {
	puts -nonewline "Message? "
	flush stdout
	set msg [gets stdin]

	puts $chan $msg
	flush $chan
	puts "server response: [gets $chan]"
}


## server.tcl

proc accept {chan addr port} {
	chan configure $chan -buffering line     ;# automate flushing
	puts "receiving from client"
	while {1} {
		set clientMsg [gets $chan]
		puts "$addr:$port client $clientMsg"
		puts $chan "received: $clientMsg"
		#puts "sent $clientMsg"
	}
}

socket -server accept 9900
vwait forever
