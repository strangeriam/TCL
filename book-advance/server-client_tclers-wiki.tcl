## OUTPUT:
## ===================================
## OPENED
## READ LINE: A Test Line
## Return line: 16 -- This is a return
## ===================================

#
# Define two auxiliary procs
#
proc serverOpen {channel addr port} {
        global connected

        set connected 1
        fileevent $channel readable [list readLine Server $channel]
        puts "OPENED"
}

proc readLine {who channel} {
        global didRead

        if { [gets $channel line] < 0} {
                fileevent $channel readable {}
                after idle "close $channel;set out 1"
        } else {
                puts "READ LINE: $line"
                puts $channel "This is a return"
                flush $channel;
                set didRead 1
        }
}

set connected 0
# catch {socket -server serverOpen 33000} server
set server [socket -server serverOpen 33000]

after 100 update

set sock [socket -async 127.0.0.1 33000]
vwait connected

puts $sock "A Test Line"
flush $sock
vwait didRead
set len [gets $sock line]
puts "Return line: $len -- $line"

catch {close $sock}
vwait out
close $server
