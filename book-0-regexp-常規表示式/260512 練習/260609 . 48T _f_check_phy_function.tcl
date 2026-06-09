Poupose: Get these id are correct.
88E1780 #0:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8

88E1780 #1:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8

88E1780 #2:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8

88E1780 #3:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8

88E1780 #4:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8

88E1780 #5:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8
;# ==================================================


 ;# Step 1 ---> Remove Log time
set get_info1 [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]

 ;# Step 2 ---> Get like this.
88E1780 #0:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8
=================
set pattern {88E1780 #\d:\nPHY ID 1:\s0x[A-F0-9]{4}\nPHY ID 2:\s0x[A-F0-9]{4}}
set get_info2 [regexp -all -inline $pattern $get_info1]

 ;# Step 3 ---> get each line of {88E1780 #0:PHY ID 1: 0x002B PHY ID 2: 0x0AD8}
foreach line [regsub -all "\n" $get_info2 " "] {
  puts $line
}

;# OUTPUT:
88E1780 #0: PHY ID 1: 0x002B PHY ID 2: 0x0AD8
88E1780 #1: PHY ID 1: 0x002B PHY ID 2: 0x0AD8
88E1780 #2: PHY ID 1: 0x002B PHY ID 2: 0x0AD8
88E1780 #3: PHY ID 1: 0x002B PHY ID 2: 0x0AD8
88E1780 #4: PHY ID 1: 0x002B PHY ID 2: 0x0AD8
88E1780 #5: PHY ID 1: 0x002B PHY ID 2: 0x0AD8

;# Jude PASS & FAIL
foreach line [regsub -all "\n" $get_info2 " "] {
  set chip_id [lrange $line 0 1]
  set phy1 [lindex $line 5]
  set phy2 [lindex $line end-0]
  # puts "chip_id: $chip_id . phy1: $phy1 . phy2: $phy2"

  if { $phy1 == "0x002B" && $phy2 == "0x0AD8"} {
     puts "$line ,PASS"
  } else {
     puts "$line ,FAIL"
  }
}

;# OUTPUT



;# ==================================================
set get_info {
m_access_phy_id.sh
14:30:42:429| Start Switching Application..................................................................................................................OK.
14:32:34:091| Access PHY ID through XM0 MDC/MDIO...
14:32:34:112| 
14:32:34:112| 88E1780 #0:
14:32:34:112| PHY ID 1: 0x002B
14:32:36:015| PHY ID 2: 0x0AD8
14:32:36:026| 88E1780 #1:
14:32:36:026| PHY ID 1: 0x002B
14:32:37:881| PHY ID 2: 0x0AD8
14:32:37:901| 88E1780 #2:
14:32:37:901| PHY ID 1: 0x002B
14:32:39:789| PHY ID 2: 0x0AD8
14:32:39:789| 88E1780 #3:
14:32:39:809| PHY ID 1: 0x002B
14:32:41:675| PHY ID 2: 0x0AD8
14:32:41:696| Switching application is already running, doing nothing.
14:32:41:718| Access PHY ID through XM1 MDC/MDIO...
14:32:41:718| 
14:32:41:718| 88E1780 #4:
14:32:41:718| PHY ID 1: 0x002B
14:32:43:593| PHY ID 2: 0x0AD8
14:32:43:605| 88E1780 #5:
14:32:43:605| PHY ID 1: 0x002B
14:32:45:510| PHY ID 2: 0x0AD8
14:32:45:510| root@(none):/diagnostic#
}
