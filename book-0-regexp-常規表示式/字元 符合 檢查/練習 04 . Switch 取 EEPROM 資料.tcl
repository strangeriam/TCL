
proc _f_ReadFile { fname } {
	if { [file exists $fname] } {
		set fd [open $fname r]
		set data [read $fd]
		close $fd
		return $data
	} else {
		return ""
	}
}

cd D:/Dropbox/12-Office-Sync-MTS/36_ECS4650/Others/ethspf_fail_check
set infile [_f_ReadFile Fail2.txt]

set HWInfo [list pid bid hwver serialno macadr mdate modelno]
set HWval [list $::HW_pid \
					$::HW_bid \
					$::HW_hwver \
					[_f_vini_profilerd SFIS SN] \
					[Output_Mac_convstr_JmpNo [_f_vini_profilerd SFIS MAC] : 0] \
					[clock format [expr [clock second] + 2 ] -format "%Y-%m-%d"] \
					$::HW_ID]

if { [info exists faillist] } {unset faillist}

set HWitem [list "Project ID" \
					"Board ID" \
					"Hardware Version" \
					"Serial Number" \
					"Mac Address" \
					"Manufacture Date" \
					"Model Number" ]

foreach item $HWitem val $HWval {
		if { [ regexp ID $item ] } {
			set regline "${item}\\s+=0x[format "%08x" $val]"
		} else {
			if { [ regexp Date $item ] } {
				set regline "${item}\\s+=\\d+-\\d+-\\d+"
			} else {
				set regline "${item}\\s+=$val"
			}
    }

		if { ![regexp -line $regline $infile] } {
			lappend faillist "${item}:${val}"
		}
	}

	if { [info exists faillist] } { puts "$faillist Fail" }




# Log
## =====================================
Marvell>> printsysinfo
UC_MGR_GetSysInfo 00000002ffe00000 ok
----------------------------------------
Project ID           =0x0000020d
Board ID             =0x00000001
Bootloader Version   =0.0.2.0
Hardware Version     =R01
Serial Number        =EC2430001796
Mac Address          =7C:8D:9C:4D:9E:20
Manufacture Date     =2025-02-17
Model Number         =ECS4650-54P
Service Tag          =CONFIG_SERVICE_TAG
----------------------------------------
Marvell>> <INTERRUPT>
Marvell>> 
