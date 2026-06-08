
set ::HW_pid 0x00000537
set ::HW_bid 0x00000000
set ::HW_hwver R0A
set ::HW_ID ECS4150-48T

set itemlist [list  sn \
                    mac \
                    hw_version \
                    manuf_date \
                    proj_id \
                    board_id \
                    mod_id ]

set valuelist [list EC2332000362 \
                    90:2D:77:21:7C:60 \
                    [clock format [clock second] -format "%Y-%m-%d"] \
                    $::HW_hwver \
                    $::HW_pid \
                    $::HW_bid \
                    $::HW_ID ]

	foreach item $itemlist value $valuelist {
		set regline "$item\] $value"
		if { ![regexp -line $regline $get_info] } {
			_f_termmsg_V1 "$regline ,FAIL"
		} else {
			_f_termmsg_V2 "$regline ,PASS" "" = -nodisplaytime
		}
	}


set get_info {
root@(none):/diagnostic# ideeprom_get_all.sh
[       mac] 90:2d:77:21:7c:60 
[        sn] EC2332000362 
[hw_version] R0A 
[manuf_date] 2026-06-06 
[    mod_id] ECS4150-48T 
[   proj_id] 0x00000537 
[  board_id] 0x00000000 
root@(none):/diagnostic# 
}
