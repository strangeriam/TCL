
set listitem [list low mid high default low]
foreach item $listitem {
		if { ! [_f_Diag_TestC "FAN . Speed $item" T969 "acc_cool_fan speed $item" 15] } {
			if {$item == "high"} {
				if { [info exists faillist] } {unset faillist}
				set pattern {\d\s+\|\s+\d+\s+\|}
				set spec 7500

				foreach line [regexp -all -inline $pattern [_f_getconsole]] {
				    set fan_id [lindex $line 0]
				    set fan_rpm [lindex $line 2]
				    if { $fan_rpm < "$spec" } {
				        lappend faillist "FAN${fan_id}:${fan_rpm} "
				    } else {
				        _f_termmsg_V2 "FAN ${item} (Spec: >= $spec) . FAN${fan_id}:${fan_rpm} ,PASS" "" = -nodisplaytime
				    }
				}
				if { [info exists faillist] } {
					_f_termmsg_V1 "FAN $item (Spec: >= $spec) . $faillist ,FAIL"
					set ::s0 "FAN fail!" ; set ::ErrorCode "FAN"
					return 0
				}
			} else {
				_f_termmsg_V1 "FAN . $item ,FAIL"
				set ::s0 "FAN fail!" ; set ::ErrorCode "FAN"
				return 0
			}
		} else {
			_f_termmsg_V2 "FAN . $item ,PASS" "" = -nodisplaytime
		}
}







;# ===========================================================
set get_info {
oot@(none):/diagnostic# 
root@(none):/diagnostic# acc_cool_fan speed low

##### (1970-01-01 00:00:39) Starting Diagnostic Test Case: acc_cool_fan speed low  

FAN: Set speed

+-----+--------------+--------+
|     | Actual Speed |        |
| No. |    (RPM)     | Result |
+-----+--------------+--------+
|  1  |    1785      | FAIL   |
|  2  |    1785      | FAIL   |
+-----+--------------+--------+
fan_speed_low FAILED.

###### (1970-01-01 00:00:47) Ending Diagnostic Test Case: acc_cool_fan speed low ............ FAIL 

Accton ErrorCode : 131
0 minutes and 8 seconds elapsed.

LogFile: /mnt/log_rw/log/accdcp/unilog/acc_cool_fan+speed+low_19700101000039_FAIL
root@(none):/diagnostic# 
root@(none):/diagnostic# 
root@(none):/diagnostic# acc_cool_fan speed mid

##### (1970-01-01 00:01:12) Starting Diagnostic Test Case: acc_cool_fan speed mid  

FAN: Set speed

+-----+--------------+--------+
|     | Actual Speed |        |
| No. |    (RPM)     | Result |
+-----+--------------+--------+
|  1  |    4285      | FAIL   |
|  2  |    4285      | FAIL   |
+-----+--------------+--------+
fan_speed_mid FAILED.

###### (1970-01-01 00:01:20) Ending Diagnostic Test Case: acc_cool_fan speed mid ............ FAIL 

Accton ErrorCode : 131
0 minutes and 8 seconds elapsed.

LogFile: /mnt/log_rw/log/accdcp/unilog/acc_cool_fan+speed+mid_19700101000112_FAIL
root@(none):/diagnostic# 
root@(none):/diagnostic# acc_cool_fan speed high

##### (1970-01-01 00:01:32) Starting Diagnostic Test Case: acc_cool_fan speed high  

FAN: Set speed

+-----+--------------+--------+
|     | Actual Speed |        |
| No. |    (RPM)     | Result |
+-----+--------------+--------+
|  1  |    7767      | FAIL   |
|  2  |    7678      | FAIL   |
+-----+--------------+--------+
fan_speed_high FAILED.

###### (1970-01-01 00:01:41) Ending Diagnostic Test Case: acc_cool_fan speed high ............ FAIL 

Accton ErrorCode : 131
0 minutes and 9 seconds elapsed.

LogFile: /mnt/log_rw/log/accdcp/unilog/acc_cool_fan+speed+high_19700101000132_FAIL
root@(none):/diagnostic# acc_cool_fan speed default

##### (1970-01-01 00:01:57) Starting Diagnostic Test Case: acc_cool_fan speed default  

FAN: Set speed

+-----+--------------+--------+
|     | Actual Speed |        |
| No. |    (RPM)     | Result |
+-----+--------------+--------+
|  1  |    8303      | FAIL   |
|  2  |    8214      | FAIL   |
+-----+--------------+--------+
fan_speed_default FAILED.

###### (1970-01-01 00:02:05) Ending Diagnostic Test Case: acc_cool_fan speed default ............ FAIL 

Accton ErrorCode : 131
0 minutes and 8 seconds elapsed.

LogFile: /mnt/log_rw/log/accdcp/unilog/acc_cool_fan+speed+default_19700101000157_FAIL
root@(none):/diagnostic# 
}
