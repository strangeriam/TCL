


regexp {eth0\s+encap:Ethernet}




set get_info {
AP-N506H-0123:~# ifconfig
br-admin_ui Link encap:Ethernet  HWaddr 64:9D:99:94:01:26  
          inet addr:10.254.254.1  Bcast:10.254.254.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

down      Link encap:Ethernet  HWaddr 64:9D:99:94:01:24  
          inet6 addr: fe80::669d:99ff:fe94:124/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:78 errors:0 dropped:0 overruns:0 frame:0
          TX packets:18 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:14172 (13.8 KiB)  TX bytes:2172 (2.1 KiB)

down2v0   Link encap:Ethernet  HWaddr 64:9D:99:94:01:24  
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::669d:99ff:fe94:124/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:77 errors:0 dropped:0 overruns:0 frame:0
          TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:14100 (13.7 KiB)  TX bytes:1238 (1.2 KiB)

eth0      Link encap:Ethernet  HWaddr 64:9D:99:94:01:23  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
          Interrupt:85 

eth1      Link encap:Ethernet  HWaddr 64:9D:99:94:01:24  
          inet6 addr: fe80::669d:99ff:fe94:124/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:244 errors:0 dropped:0 overruns:0 frame:0
          TX packets:291 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:40624 (39.6 KiB)  TX bytes:54914 (53.6 KiB)
          Interrupt:86 

eth1.4083 Link encap:Ethernet  HWaddr 64:9D:99:94:01:24  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:90 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:16680 (16.2 KiB)

eth1.4084 Link encap:Ethernet  HWaddr 64:9D:99:94:01:24  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:90 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:16680 (16.2 KiB)

eth1.4085 Link encap:Ethernet  HWaddr 64:9D:99:94:01:24  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:90 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:16680 (16.2 KiB)

eth1.4086 Link encap:Ethernet  HWaddr 64:9D:99:94:01:24  
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:187 errors:0 dropped:0 overruns:0 frame:0
          TX packets:12 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:24738 (24.1 KiB)  TX bytes:1416 (1.3 KiB)

ifb-dhcp  Link encap:Ethernet  HWaddr D6:E4:54:5C:C5:F9  
          inet6 addr: fe80::d4e4:54ff:fe5c:c5f9/64 Scope:Link
          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:32 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

ifb-dhcprelay Link encap:Ethernet  HWaddr 5A:1C:DA:F4:69:28  
          inet6 addr: fe80::581c:daff:fef4:6928/64 Scope:Link
          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:32 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

ifb-dns   Link encap:Ethernet  HWaddr E2:46:C4:1A:46:75  
          inet6 addr: fe80::e046:c4ff:fe1a:4675/64 Scope:Link
          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:32 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:192 errors:0 dropped:0 overruns:0 frame:0
          TX packets:192 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:13696 (13.3 KiB)  TX bytes:13696 (13.3 KiB)

spotfilter-ifb Link encap:Ethernet  HWaddr DA:4D:35:94:FD:29  
          inet6 addr: fe80::d84d:35ff:fe94:fd29/64 Scope:Link
          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:32 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

up        Link encap:Ethernet  HWaddr 64:9D:99:94:01:23  
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

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
          TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:4096 
          RX bytes:0 (0.0 B)  TX bytes:236 (236.0 B)

AP-N506H-0123:~# 
}
