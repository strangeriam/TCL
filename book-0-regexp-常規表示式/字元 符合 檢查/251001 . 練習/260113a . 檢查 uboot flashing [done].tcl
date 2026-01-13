set listitem [list 	sbl1 \
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

if { [info exists faillist] } {unset faillist}

foreach item $listitem {
	set regline "Flashing ${item}"
	if { ![regexp -line "${regline}:\\s+. done ." $get_info]} {
		append faillist "$regline "
	} else {
		puts "Check \"${regline}\" ,PASS"
	}
}

if { [info exists faillist] } { puts "$faillist ,FAIL" }



set get_info {
09:21:32:938| ## Executing script at 44000000
09:21:32:938| 
09:21:32:938| crc32+ SPI_ADDR_LEN=3
09:21:32:938| 
09:21:32:938| SF: Detected W25Q128FW with page size 256 Bytes, erase size 4 KiB, total 16 MiB
09:21:32:938| 
09:21:32:938| soc_hw_version : Validation success
09:21:32:938| 
09:21:32:938| machid : Validation success
09:21:32:965| 
09:21:32:965| Flashing sbl1:                          [ done ]
09:21:34:013| 
09:21:34:028| Flashing mibib:                         [ fail ]
09:21:34:280| 
09:21:34:280| Flashing bootconfig:                    [ done ]
09:21:34:578| 
09:21:34:578| Flashing bootconfig1:                   [ done ]
09:21:34:830| 
09:21:34:830| Flashing tz:                            [  ]
09:21:38:763| 
09:21:38:763| Flashing devcfg:                        [ done ]
09:21:39:048| 
09:21:39:048| Flashing ddr-AP-MP03.5-C1_512M16_DDR3:  [ done ]
09:21:39:282| 
09:21:39:282| Flashing appsblenv:                     [ done ]
09:21:39:707| 
09:21:39:707| Flashing u-boot:                        [ done ]
09:21:43:177| 
09:21:43:177| Flashing priv_data1:                    [ done ]
09:21:43:480| 
09:21:43:480| Flashing ubi:                           [ done ]
09:21:51:699| 
09:21:51:699| Flashing wifi_fw_ipq5018_qcn6122cs:     [ done ]
09:21:53:167| 
09:21:53:167| IPQ5018#
}
