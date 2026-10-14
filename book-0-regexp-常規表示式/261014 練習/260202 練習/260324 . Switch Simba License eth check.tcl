
set ::num_port_check 30

for {set num 1} {$num <= $::num_port_check} {incr num} {
		if { ! [regexp "Eth 1/[format %2s $num]+\\\s+Up" $get_info] } {
			if { ! [regexp "Eth 1/[format %2s $num]+\\\s+Down" $get_info] } {
				puts "Check Eth1/[format %2s $num] lic Status ,FAIL"
				return 0
			} else {
				puts "Check Eth1/[format %2s $num] lic Status ,PASS"
			}
		} else {
			puts "Check Eth1/[format %2s $num] lic Status ,PASS"
		}
}

;# 輸出:
Check Eth1/ 1 lic Status ,PASS
Check Eth1/ 2 lic Status ,PASS
Check Eth1/ 3 lic Status ,PASS
Check Eth1/ 4 lic Status ,PASS
Check Eth1/ 5 lic Status ,PASS
Check Eth1/ 6 lic Status ,PASS
Check Eth1/ 7 lic Status ,PASS
Check Eth1/ 8 lic Status ,PASS
Check Eth1/ 9 lic Status ,PASS
Check Eth1/10 lic Status ,PASS
Check Eth1/11 lic Status ,PASS
Check Eth1/12 lic Status ,PASS
Check Eth1/13 lic Status ,PASS
Check Eth1/14 lic Status ,PASS
Check Eth1/15 lic Status ,PASS
Check Eth1/16 lic Status ,PASS
Check Eth1/17 lic Status ,PASS
Check Eth1/18 lic Status ,PASS
Check Eth1/19 lic Status ,PASS
Check Eth1/20 lic Status ,PASS
Check Eth1/21 lic Status ,PASS
Check Eth1/22 lic Status ,PASS
Check Eth1/23 lic Status ,PASS
Check Eth1/24 lic Status ,PASS
Check Eth1/25 lic Status ,PASS
Check Eth1/26 lic Status ,PASS
Check Eth1/27 lic Status ,PASS
Check Eth1/28 lic Status ,PASS
Check Eth1/29 lic Status ,PASS
Check Eth1/30 lic Status ,PASS


set get_info {
Console#terminal length 0
Console#show interfaces brief
Interface Name              Status    PVID Pri Speed/Duplex  Type         Trunk
--------- ----------------- --------- ---- --- ------------- ------------ -----
Eth 1/ 1                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 2                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 3                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 4                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 5                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 6                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 7                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 8                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/ 9                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/10                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/11                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/12                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/13                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/14                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/15                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/16                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/17                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/18                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/19                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/20                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/21                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/22                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/23                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/24                    Down         1   0 10Gfull       10GBASE SFP+ None 
Eth 1/25                    Down         1   0 100Gfull      100GBASE QSFP None 
Eth 1/26                    Down         1   0 100Gfull      100GBASE QSFP None 
Eth 1/27                    Down         1   0 100Gfull      100GBASE QSFP None 
Eth 1/28                    Down         1   0 100Gfull      100GBASE QSFP None 
Eth 1/29                    Down         1   0 100Gfull      100GBASE QSFP None 
Eth 1/30                    Down         1   0 100Gfull      100GBASE QSFP None 
Console#
}
