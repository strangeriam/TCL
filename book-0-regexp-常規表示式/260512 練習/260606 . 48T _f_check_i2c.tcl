
if { [info exists faillist] } {unset faillist}

set pattern {\d\s+\|\s+\d+\s+\| FAIL}
foreach line [regexp -all -inline $pattern $get_info] {
    set fan_id [lindex $line 0]
    set fan_rpm [lindex $line 2]
    if { $fan_rpm < 7500 } {
        lappend faillist "FAN${fan_id}:${fan_rpm} "
    } else {
        puts "HIGH Speed of FAN${fan_id}:${fan_rpm} ,PASS"
    }
}

if { [info exists faillist] } {
		puts "HIGH Speed $faillist ,FAIL"
}


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
