
set listitem [list "Address is" \
			      "IP Address:" ]
set listvalue [list "00.E0.0C.00.00.FD" \
					 "192.168.1.11" ]

foreach item $listitem value $listvalue {
		if { ![regexp -line "$item $value" $get_info] } {
			puts "$item . $value ,FAIL"
		}
		puts "$item . $value ,PASS"
}




set get_info {
11:46:24:243| Console#show ip interface
11:46:24:285| 
11:46:24:285| VLAN 1 is Administrative Up - Link Up
11:46:24:328| 
11:46:24:328|   Address is 00-E0-0C-00-00-FD
11:46:24:328| 
11:46:24:328|   Index: 1001, MTU: 1500
11:46:24:328| 
11:46:24:328|   Address Mode is User specified
11:46:24:328| 
11:46:24:328|   IP Address: 192.168.1.11 Mask: 255.255.255.0
11:46:24:328| 
11:46:24:328|   Proxy ARP is disabled
11:46:24:328| 
11:46:24:328|   DHCP Client Vendor Class ID (text): OpenLAN
11:46:24:328| 
11:46:24:328|   DHCP Relay Server: 
11:46:24:328| 
11:46:24:328| Console#
}
