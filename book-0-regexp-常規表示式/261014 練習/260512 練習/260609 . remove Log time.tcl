Remove format "14:30:42:429| "

set get_info2 [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]
puts $get_info2

;# OUTPUT:
m_access_phy_id.sh
Start Switching Application..................................................................................................................OK.
Access PHY ID through XM0 MDC/MDIO...

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
Switching application is already running, doing nothing.
Access PHY ID through XM1 MDC/MDIO...

88E1780 #4:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8
88E1780 #5:
PHY ID 1: 0x002B
PHY ID 2: 0x0AD8
root@(none):/diagnostic#



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
