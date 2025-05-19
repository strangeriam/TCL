
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

cd D:/Dropbox/12-Office-Sync-MTS/36_ECS4650/Others/250515_failCheck_PoE
set infile [_f_ReadFile Fail.txt]

if {[info exists ngList]} {
	unset ngList
}

set pattern {\d+\s+\|\s+\d+ \|\s+\-\d+ \|\s+\d+\s+\|\s+\d+\s+\|\s+\d+\s+\|\s+FAIL}

foreach line [regexp -all -inline $pattern $infile] {
	set ngPort [string trim [lindex [split $line |] 1]]

	append ngList "$ngPort "
}

puts "ngList: $ngList"


# 輸出
ngList: 2 6 8 4  


# Example Log

Console(Diagnostics)# test 1 1 80260000
Console(Diagnostics)# 
Test Iteration: 1 of 1
----- Test In Progress -----
[80260000] [POE Load Test unit1]
POE general initialization has been done.
ti_poe_set_port_enable poe_mode[0] round[0] enable[0]

Board: ES4650AC5X
Model: P48
Total Test Rounds: 8 Rounds
Round 0 | Port_Start  1 | Port_End  8 | POE_MODE AT | PPL 34000 mW
Round 1 | Port_Start  9 | Port_End 16 | POE_MODE AT | PPL 34000 mW
Round 2 | Port_Start 17 | Port_End 24 | POE_MODE AT | PPL 34000 mW
Round 3 | Port_Start 25 | Port_End 32 | POE_MODE AT | PPL 34000 mW
Round 4 | Port_Start 33 | Port_End 40 | POE_MODE AT | PPL 34000 mW
Round 5 | Port_Start 41 | Port_End 44 | POE_MODE BT | PPL 94000 mW
Round 6 | Port_Start 45 | Port_End 48 | POE_MODE BT | PPL 94000 mW
ti_poe_set_port_enable poe_mode[0] round[0] enable[1]

Collect poe 0 information....please wait.....

ti_poe_get_round_consumed_pwr_diag voltage_mv:0 mV
ti_poe_get_round_consumed_pwr_diag current_ma:0 mA
ti_poe_get_round_consumed_pwr_diag power_mw:0 mW
ti_poe_get_round_consumed_pwr_diag port_num:0 
ti_poe_get_round_consumed_pwr_diag voltage_mv:54666 mV
ti_poe_get_round_consumed_pwr_diag current_ma:547 mA
ti_poe_get_round_consumed_pwr_diag power_mw:29902 mW
ti_poe_get_round_consumed_pwr_diag port_num:1 
ti_poe_get_round_consumed_pwr_diag voltage_mv:54541 mV
ti_poe_get_round_consumed_pwr_diag current_ma:526 mA
ti_poe_get_round_consumed_pwr_diag power_mw:28688 mW
ti_poe_get_round_consumed_pwr_diag port_num:2 
ti_poe_get_round_consumed_pwr_diag voltage_mv:0 mV
ti_poe_get_round_consumed_pwr_diag current_ma:0 mA
ti_poe_get_round_consumed_pwr_diag power_mw:0 mW
ti_poe_get_round_consumed_pwr_diag port_num:3 
ti_poe_get_round_consumed_pwr_diag voltage_mv:0 mV
ti_poe_get_round_consumed_pwr_diag current_ma:0 mA
ti_poe_get_round_consumed_pwr_diag power_mw:0 mW
ti_poe_get_round_consumed_pwr_diag port_num:4 
ti_poe_get_round_consumed_pwr_diag voltage_mv:54530 mV
ti_poe_get_round_consumed_pwr_diag current_ma:532 mA
ti_poe_get_round_consumed_pwr_diag power_mw:29009 mW
ti_poe_get_round_consumed_pwr_diag port_num:5 
ti_poe_get_round_consumed_pwr_diag voltage_mv:0 mV
ti_poe_get_round_consumed_pwr_diag current_ma:0 mA
ti_poe_get_round_consumed_pwr_diag power_mw:0 mW
ti_poe_get_round_consumed_pwr_diag port_num:6 
ti_poe_get_round_consumed_pwr_diag voltage_mv:54706 mV
ti_poe_get_round_consumed_pwr_diag current_ma:540 mA
ti_poe_get_round_consumed_pwr_diag power_mw:29541 mW
ti_poe_get_round_consumed_pwr_diag port_num:7 
ti_poe_get_round_consumed_pwr_diag ok
----------------------------------------------------------------------------------------
|          |            | Power Con. |             |   Vmain   | Calculated |          |
| pseport# | front port |  Deviation | Consumption |  Voltage  |   Current  |  Status  |
|          |            |      (mW)  |    (mW)     |    (V)    |     (mA)   |          |
----------------------------------------------------------------------------------------
|  1  |  2 |  -30000 |       0  |     0     |     0      |     FAIL |
|  2  |  1 |     -98 |   29902  |    54     |   547      |       OK |
|  3  |  5 |   -1312 |   28688  |    54     |   526      |       OK |
|  4  |  6 |  -30000 |       0  |     0     |     0      |     FAIL |
|  5  |  8 |  -30000 |       0  |     0     |     0      |     FAIL |
|  6  |  7 |    -991 |   29009  |    54     |   532      |       OK |
|  7  |  4 |  -30000 |       0  |     0     |     0      |     FAIL |
|  8  |  3 |    -459 |   29541  |    54     |   540      |       OK |
--------------------------------------------------------------------------------------------------------
-----  Test Completed  -----
----------------------------------------------------------------------------FAILED (DATE: 2022-06-07 - TIME: 07:39:00 )

Main Board LM75-1 Temp. 127 C

Main Board LM75-2 Temp. 127 C

Main Board LM75-3 Temp. 1 C
CPU Temp = 52 degree C



--------------------------------  [    SYSTEM] TEST  -------------------------------
-----------------------------------------------------------------------------------------
 Test NO.  |         Group      |ON/OFF|  PASS   |  FAIL   |     Test Name      | Description
-----------------------------------------------------------------------------------------
  80260000 |           poe,sys  | OFF  |       0 |       1 |           POE Test | POE Load Test unit1

Failure Summation:
  Test No. Test Name                     Fail
[80260000] POE Test                         1

--------------------------------------------------------------------------------
 TEST Iteration 1 of 1 Completed.
--------------------------------------------------------------------------------

Console(Diagnostics)# 
