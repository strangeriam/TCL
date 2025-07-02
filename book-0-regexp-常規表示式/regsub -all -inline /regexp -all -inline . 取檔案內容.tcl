#; 取出電流值 eg. Current=0.291763A
#; filename: 2024_03_31_15_07_37_wdo.log
#; 檔案內容
2024/03/31,15:07:39,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.010742A
2024/03/31,15:07:39,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.005676A
2024/03/31,15:07:39,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.004730A
2024/03/31,15:07:39,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.007538A
2024/03/31,15:07:39,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.001053A
2024/03/31,15:07:39,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.001984A
2024/03/31,15:07:40,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.013123A
2024/03/31,15:07:40,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.005508A
2024/03/31,15:07:40,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.004669A
2024/03/31,15:07:40,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.010849A
2024/03/31,15:07:40,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.002731A
2024/03/31,15:07:40,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.002136A

#; Example:
set data_filename "C:/testlog/testLog_current/2024_03_31_15_07_37_wdo.log"
set file_content [_f_ReadFile $data_filename]
regexp -all -inline -- {Current=-{0,1}\d+\.\d+} $file_content

#; OUTPUT:
Current=0.010742 Current=0.005676 Current=-0.004730 Current=0.007538 Current=0.001053 Current=0.001984 Current=0.013123 Current=0.005508 Current=-0.004669 Current=0.010849 Current=0.002731 Current=0.002136
