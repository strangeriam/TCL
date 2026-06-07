
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
root@(none):/diagnostic# acc_iai_i2c device

##### (1970-01-01 00:18:13) Starting Diagnostic Test Case: acc_iai_i2c device  

I2C Test: Scan I2C devices

+------------------+-----------+-------+----------+---------+--------+
| all              |   Name    | Board | Location | Address | Result |
|  :               +-----------+-------+----------+---------+--------+
|  \_n             |           |       |          |         |        |
|     :_i2c_0      |           |       |          |         |        |
|     :  :_0x48    | TMP75_1   | CPU   | N        | 0x48    | PASS   |
|     :  :_0x54    | ID_EEPROM | CPU   | N        | 0x54    | PASS   |
|     :  :_0x66    | CPLD      | CPU   | N        | 0x66    | PASS   |
|     :  \_0x76    | CLKgen    | CPU   | N        | 0x76    | PASS   |
|     \_i2c_1      |           |       |          |         |        |
|        \_0x11    | RoT       | CPI   | N        | 0x11    | FAIL   |
+------------------+-----------+-------+----------+---------+--------+

###### (1970-01-01 00:18:14) Ending Diagnostic Test Case: acc_iai_i2c device ............ FAIL 

Accton ErrorCode : 073
0 minutes and 1 seconds elapsed.

LogFile: /mnt/log_rw/log/accdcp/unilog/acc_iai_i2c+device_19700101001813_FAIL
root@(none):/diagnostic# 
}
