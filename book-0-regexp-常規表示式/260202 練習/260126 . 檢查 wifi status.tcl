檢查項目
wlan0: 是否為 "UP BROADCAST MULTICAST"
wlan1: 是否為 "UP BROADCAST RUNNING MULTICAST"
為 1 OK, 為 0 NG

====================================================
if {[regexp {.*wlan1} $get_info]} {
          if {[regexp {.*wlan1} $get_info tmp]} {
		if {[regexp {wlan0.*} $tmp]} {
			if {[regexp {wlan0.*} $tmp tmp]} {
				if {[regexp {UP BROADCAST MULTICAST} $tmp]} {
					return "wlan0 OK"
				} else {
					return "wlan0 NG"
				}
			}
		}
	}
}

輸出: wlan0 OK

if {[regexp {wlan1.*} $get_info]} {
	if {[regexp {wlan1.*} $get_info tmp]} {
			if {[regexp {UP BROADCAST RUNNING MULTICAST} $tmp]} {
				return "wlan1 OK"
			} else {
				return "wlan1 NG"
			}
	}
}

輸出: wlan1 OK

====================================================
set get_info {
AP-N506H-0123:~# ifconfig
up0v0     Link encap:Ethernet  HWaddr 64:9D:99:94:01:23  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wlan0     Link encap:Ethernet  HWaddr 64:9D:99:94:01:25  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:4096 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wlan1     Link encap:Ethernet  HWaddr 64:9D:99:94:01:26  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:5 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:4096 
          RX bytes:0 (0.0 B)  TX bytes:808 (808.0 B)

AP-N506H-0123:~#
}
