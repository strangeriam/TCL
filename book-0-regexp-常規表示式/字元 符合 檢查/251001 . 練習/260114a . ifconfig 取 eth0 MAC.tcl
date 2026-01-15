
set mac ""

set mac 64:9D:99:94:01:23
regexp "eth0\\s+Link encap:Ethernet\\s+HWaddr $mac" $get_info




set get_info {
AP-N506H-0123:~# ifconfig
br-admin_ui Link encap:Ethernet  HWaddr 64:9D:99:94:01:26  
          inet addr:10.254.254.1  Bcast:10.254.254.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

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

AP-N506H-0123:~# 
}
