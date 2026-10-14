;# Skip RoT check

set listitem [list TMP75_1 ID_EEPROM CPLD CLKgen RoT]

foreach item $listitem line [regexp -all -inline {\| [A-Za-z1-7_]+\s+\|\s[CPUI]{3}\s+\|\sN\s+\|\s\dx\d+\s+\|\s[PASSFIL]{4}} $get_info] {
	puts "item: $item . line:\n$line"

	if { [lindex $line 1] != "RoT" } {
		if { [lindex $line 1] == "$item" } {
			if { [lindex $line end-0] == "FAIL" } {
				puts "Check Result of \"$item\" ,FAIL"
			} else {
				puts "Check Result of \"$item\" ,PASS"
			}
		} else {
			puts "Check Name of \"$item\" ,FAIL"
		}
	}
}

;# ============================================
set get_info {
acc_iai_i2c device
14:42:43:916| 5m
14:42:43:995| ##### (1970-01-01 00:02:58) Starting Diagnostic Test Case:[0m acc_iai_i2c device  
14:42:43:995| 
14:42:43:995| I2C Test: Scan I2C devices
14:42:43:995| 
14:42:44:419| +------------------+-----------+-------+----------+---------+--------+
14:42:44:419| | all              |   Name    | Board | Location | Address | Result |
14:42:44:419| |  :               +-----------+-------+----------+---------+--------+
14:42:44:419| |  \_n             |           |       |          |         |        |
14:42:44:419| |     :_i2c_0      |           |       |          |         |        |
14:42:44:419| |     :  :_0x48    | TMP75_1   | CPU   | N        | 0x48    | PASS   |
14:42:44:419| |     :  :_0x54    | ID_EEPROM | CPU   | N        | 0x54    | PASS   |
14:42:44:419| |     :  :_0x66    | CPLD      | CPU   | N        | 0x66    | PASS   |
14:42:44:419| |     :  \_0x76    | CLKgen    | CPU   | N        | 0x76    | PASS   |
14:42:44:419| |     \_i2c_1      |           |       |          |         |        |
14:42:44:419| |        \_0x11    | RoT       | CPU   | N        | 0x11    | FAIL   |
14:42:44:419| +------------------+-----------+-------+----------+---------+--------+
14:42:44:419| 5m
14:42:44:419| ###### (1970-01-01 00:02:58) Ending Diagnostic Test Case:[0m acc_iai_i2c device ............[1;31m FAIL [0m
14:42:44:419| 
14:42:44:419| Accton ErrorCode : 073
14:42:44:419| 0 minutes and 0 seconds elapsed.
14:42:44:419| 
14:42:44:419| LogFile: /mnt/log_rw/log/accdcp/unilog/acc_iai_i2c+device_19700101000258_FAIL
14:42:44:419| root@(none):/diagnostic# 
}
