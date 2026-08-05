set ::HW_pid 0x20b
set ::HW_bid 0
set ::Uboot_ver 0.0.1.9
set ::HW_hwver R01
set ::SN EC2332000362
set ::MAC 5C:17:83:4A:A4:A0
set ::HW_ID ECS4150-28F

set HWitem [list "Project ID" \
					 "Board ID" \
					 "Bootloader Version" \
					 "Hardware Version" \
					 "Serial Number" \
					 "Mac Address" \
					 "Model Number" ]

set HWval [list $::HW_pid \
					$::HW_bid \
					$::Uboot_ver \
					$::HW_hwver \
					$::SN \
					$::MAC \
					$::HW_ID]

foreach item $HWitem val $HWval {
		if { [ regexp ID $item ] } {
				set regline "${item}\\s+=0x[format "%08x" $val]"
		} else {
				set regline "${item}\\s+=$val"
		}

		if { ![regexp -line $regline [_f_getconsole]] } {
			_f_termmsg_V1 "$item . $val ,FAIL"
			set ::s0 "$item . $val ,FAIL" ; set ::ErrorCode "SYS"
			return 0
		} else {
			_f_termmsg_V2 "$item . $val ,PASS" "" = -nodisplaytime
		}
}

# ==================================================
set get_info {
printsysinfo
14:46:41:481| UC_MGR_GetSysInfo 000000023fe00000 ok
14:46:41:531| ----------------------------------------
14:46:41:531| Project ID           =0x0000020b
14:46:41:531| Board ID             =0x00000004
14:46:41:531| Bootloader Version   =0.0.1.9
14:46:41:531| Hardware Version     =R01
14:46:41:531| Serial Number        =EC2332000362
14:46:41:531| Mac Address          =5C:17:83:4A:A4:A0
14:46:41:531| Manufacture Date     =2026-08-05
14:46:41:531| Model Number         =ECS4150-28F
14:46:41:531| Service Tag          =CONFIG_SERVICE_TAG
14:46:41:531| ----------------------------------------
14:46:41:531| Marvell>>
}

