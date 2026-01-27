檢查項目
wlan0: 是否為 "UP BROADCAST MULTICAST"
wlan1: 是否為 "UP BROADCAST RUNNING MULTICAST"

====================================================
set get_info {
AP-N506H-0123:~# ifconfig wlan0 && ifconfig wlan1
wlan0     Link encap:Ethernet  HWaddr 64:9D:99:94:01:25  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:4096 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wlan1     Link encap:Ethernet  HWaddr 64:9D:99:94:01:26  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:4096 
          RX bytes:0 (0.0 B)  TX bytes:848 (848.0 B)

AP-N506H-0123:~# 
}
