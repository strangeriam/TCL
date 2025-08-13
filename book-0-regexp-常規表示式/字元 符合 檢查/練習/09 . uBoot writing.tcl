
set reglist [list 	"Flashing sbl1:" \
					"Flashing mibib:" \
					"Flashing bootconfig:" \
					"Flashing bootconfig1" \
					"Flashing tz:" \
					"Flashing devcfg:" \
					"Flashing ddr-AP-MP03.5-C1_512M16_DDR3:" \
					"Flashing appsblenv:" \
					"Flashing u-boot:" \
					"Flashing priv_data1:" \
					"Flashing ubi:" \
					"Flashing wifi_fw_ipq5018_qcn6122cs:"]

foreach item $reglist {
	if { [regexp -linestop ${item}.* $get_info tmp] } {
		if { ! [regexp {done} $tmp] } {
	 		puts "FAIL: $item"
			return 0
	 	}
	}
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
Flashing tz:                            [ done ]
Flashing devcfg:                        [ done ]
Flashing ddr-AP-MP03.5-C1_512M16_DDR3:  [ done ]
Flashing appsblenv:                     [ done ]
Flashing u-boot:                        [ done ]
Flashing priv_data1:                    [ done ]
Flashing ubi:                           [ done ]
Flashing wifi_fw_ipq5018_qcn6122cs:     [ done ]
IPQ5018# 
}
