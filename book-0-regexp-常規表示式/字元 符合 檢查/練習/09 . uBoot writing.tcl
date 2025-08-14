
set itemlist [list 	01_sbl1 \
					02_mibib \
					03_bootconfig \
					04_bootconfig1 \
					05_tz \
					06_devcfg \
					07_ddr \
					08_appsblenv \
					09_uboot \
					10_priv \
					11_ubi \
					12_wififw]

set reglist [list 	sbl1 \
					mibib \
					bootconfig \
					bootconfig1 \
					tz \
					devcfg \
					ddr-AP-MP03.5-C1_512M16_DDR3 \
					appsblenv \
					u-boot \
					priv_data1 \
					ubi \
					wifi_fw_ipq5018_qcn6122cs ]

if { [info exists faillist] } { unset faillist }

foreach item $itemlist val $reglist {
	if { [regexp -linestop "Flashing $val\:.*" $get_info tmp] } {
		if { ! [regexp {done} $tmp] } {
			append faillist "$item "
		}
	}
}

if { [info exists faillist] } {
	_f_termmsg_V1 "faillist: $faillist"
}

set get_info {
IPQ5018# 
IPQ5018# imgaddr=$fileaddr && source $imgaddr:script
## Executing script at 44000000
crc32+ SPI_ADDR_LEN=3
SF: Detected W25Q128FW with page size 256 Bytes, erase size 4 KiB, total 16 MiB
soc_hw_version : Validation success
machid : Validation success
Flashing sbl1:                          [ done ]
Flashing mibib:                         [ done ]
Flashing bootconfig:                    [ done ]
Flashing bootconfig1:                   [ done ]
Flashing tz:                            [  ]
Flashing devcfg:                        [ done ]
Flashing ddr-AP-MP03.5-C1_512M16_DDR3:  [ do ]
Flashing appsblenv:                     [ done ]
Flashing u-boot:                        [ xdone ]
Flashing priv_data1:                    [ dox ]
Flashing ubi:                           [ done ]
Flashing wifi_fw_ipq5018_qcn6122cs:     [ done ]
IPQ5018# 
}
