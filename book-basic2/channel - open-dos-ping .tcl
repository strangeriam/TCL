
set fd [open "| ping 127.0.0.1" r]

fconfigure $fd -blocking 0

while {![eof $fd]} {
        update
        if {[gets $fd buf] == -1} {continue}
        puts [string trim $buf]
}

close $fd
