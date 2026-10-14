
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

;# ==================================================================
set get_info {
14:36:11:112| root@(none):/diagnostic# acc_cool_fan speed high
14:36:11:139| 5m
14:36:11:203| ##### (1970-01-01 00:02:05) Starting Diagnostic Test Case:[0m acc_cool_fan speed high  
14:36:11:203| 
14:36:11:213| FAN: Set speed
14:36:11:213| 
14:36:19:262| +-----+--------------+--------+
14:36:19:262| |     | Actual Speed |        |
14:36:19:262| | No. |    (RPM)     | Result |
14:36:19:262| +-----+--------------+--------+
14:36:19:262| |  1  |    8035      | FAIL   |
14:36:19:304| |  2  |    7946      | FAIL   |
14:36:19:304| +-----+--------------+--------+
14:36:19:304| fan_speed_high FAILED.
14:36:19:304| 5m
14:36:19:304| ###### (1970-01-01 00:02:13) Ending Diagnostic Test Case:[0m acc_cool_fan speed high ............[1;31m FAIL [0m
14:36:19:304| 
14:36:19:304| Accton ErrorCode : 131
14:36:19:304| 0 minutes and 8 seconds elapsed.
14:36:19:304| 
14:36:19:304| LogFile: /mnt/log_rw/log/accdcp/unilog/acc_cool_fan+speed+high_19700101000205_FAIL
14:36:19:304| root@(none):/diagnostic# 
}
