set get_info {
iperf3 -c 192.168.1.11 -t 10
16:19:18:760| Connecting to host 192.168.1.11, port 5201
16:19:18:778| [  5] local 192.168.1.201 port 34028 connected to 192.168.1.11 port 5201
16:19:18:834| [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
16:19:19:835| [  5]   0.00-1.00   sec  2.77 MBytes  23.2 Mbits/sec    0    143 KBytes       
16:19:19:844| [  5]   1.00-2.00   sec  2.49 MBytes  20.9 Mbits/sec    0    151 KBytes       
16:19:20:833| [  5]   2.00-3.00   sec  3.04 MBytes  25.6 Mbits/sec    0    161 KBytes       
16:19:21:835| [  5]   3.00-4.00   sec  2.11 MBytes  17.7 Mbits/sec    0    168 KBytes       
16:19:22:835| [  5]   4.00-5.00   sec  2.80 MBytes  23.5 Mbits/sec    0    189 KBytes       
16:19:23:836| [  5]   5.00-6.00   sec  2.55 MBytes  21.4 Mbits/sec    0    189 KBytes       
16:19:24:837| [  5]   6.00-7.00   sec  2.73 MBytes  22.9 Mbits/sec    0    274 KBytes       
16:19:25:839| [  5]   7.00-8.00   sec  2.92 MBytes  24.5 Mbits/sec    0    274 KBytes       
16:19:26:850| [  5]   8.00-9.00   sec  3.36 MBytes  28.1 Mbits/sec    0    274 KBytes       
16:19:27:839| [  5]   9.00-10.00  sec  3.04 MBytes  25.5 Mbits/sec    0    274 KBytes       
16:19:28:901| - - - - - - - - - - - - - - - - - - - - - - - - -
16:19:28:901| [ ID] Interval           Transfer     Bitrate         Retr
16:19:28:916| [  5]   0.00-10.00  sec  27.8 MBytes  23.3 Mbits/sec    0             sender
16:19:28:916| [  5]   0.00-10.04  sec  27.2 MBytes  22.7 Mbits/sec                  receiver
16:19:28:916| 
16:19:28:916| iperf Done.
16:19:28:932| admin@EAP104:~#
}

set pattern_sender {\d+.\d+-+\d+.\d+\s+sec+\s+\d+.\d+\s+\D+\s+\d+.\d+\s+\D+\s+\d+\s+sender}
regexp -all -inline $pattern_sender $get_info

set pattern_receiver {\d+.\d+-+\d+.\d+\s+sec+\s+\d+.\d+\s+\D+\s+\d+.\d+\s+\D+\s\s+receiver}
regexp -all -inline $pattern_receiver $get_info

