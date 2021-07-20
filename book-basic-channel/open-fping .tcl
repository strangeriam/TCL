
proc fping { ip_address } {

      set fd [open "| fping $ip_address" r]
      fconfigure $fd -blocking 0

      while {![eof $fd]} {
              update
              if {[gets $fd buf] == -1} {continue}
              puts [string trim $buf]
      }

      close $fd
}

fping 192.168.2.1


## OUTPUT
## =====================================================
Fast pinger version 3.00
(c) Wouter Dhondt (http://www.kwakkelflap.com)

Pinging 192.168.2.1 with 32 bytes of data every 1000 ms:

Reply[1] from 192.168.2.1: bytes=32 time=0.8 ms TTL=64
Reply[2] from 192.168.2.1: bytes=32 time=11.9 ms TTL=64
Reply[3] from 192.168.2.1: bytes=32 time=0.7 ms TTL=64
Reply[4] from 192.168.2.1: bytes=32 time=1.0 ms TTL=64

Ping statistics for 192.168.2.1:
Packets: Sent = 4, Received = 4, Lost = 0 (0% loss)
Approximate round trip times in milli-seconds:
Minimum = 0.7 ms, Maximum = 11.9 ms, Average = 3.6 ms
## =====================================================
