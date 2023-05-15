擷取 MAC address 所對應的 IP address.

set aaa {
lu@raspberrypi:~$ dhcp-lease-list
To get manufacturer names please download http://standards.ieee.org/regauth/oui/oui.txt to /usr/local/etc/oui.txt
Reading leases from /var/lib/dhcp/dhcpd.leases
MAC                IP              hostname       valid until         manufacturer        
===============================================================================================
72:88:6b:ae:32:d8  192.168.2.11    KB-AE-32-D8    2023-05-09 19:31:23 -NA-                
lu@raspberrypi:~$ 
}

set dhcp_ip ""
if { [regexp -linestop "$mac.*" $aaa dhcp_ip] == 1 } {
      set dut_ip [lindex $dhcp_ip 1]
}

puts "dut_ip : $dut_ip"
