#; 刪除內有 ssr 的行.
2024/03/31,15:07:42,ssr1=1
2024/03/31,15:07:42,ssr2=1
2024/03/31,15:07:42,ssr3=1
2024/03/31,15:07:42,ssr4=1
2024/03/31,15:07:42,ssr5=1
2024/03/31,15:07:42,ssr6=1

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
2024/03/31,15:07:41,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.009995A
2024/03/31,15:07:41,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.008133A
2024/03/31,15:07:41,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.005783A
2024/03/31,15:07:41,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.007751A
2024/03/31,15:07:41,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.000504A
2024/03/31,15:07:41,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.004166A
2024/03/31,15:07:42,ssr1=1
2024/03/31,15:07:42,ssr2=1
2024/03/31,15:07:42,ssr3=1
2024/03/31,15:07:42,ssr4=1
2024/03/31,15:07:42,ssr5=1
2024/03/31,15:07:42,ssr6=1
2024/03/31,15:07:42,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.010040A
2024/03/31,15:07:42,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.006485A
2024/03/31,15:07:42,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.009613A
2024/03/31,15:07:42,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.007355A
2024/03/31,15:07:42,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=-0.000793A
2024/03/31,15:07:42,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.003555A
2024/03/31,15:07:43,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.293671A
2024/03/31,15:07:43,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.279434A
2024/03/31,15:07:43,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=0.278687A
2024/03/31,15:07:43,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.271286A
2024/03/31,15:07:43,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.280624A
2024/03/31,15:07:43,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.284607A

#; Example:
#; Step 1: 將檔案內容存入 $infile
set namefile "C:/testlog/testLog_current/2024_03_31_15_07_37_wdo.log"
set infile [_f_ReadFile $namefile]

#; Step 2: 移除含有 ssr 的行, 並產生新變數 $infile2
#; 輸出會留下空白的行, 需再一步抹除 空白行.
regsub -all -line ".*ssr.*" $infile "" infile2
set infile2

#; OUTPUT:
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
2024/03/31,15:07:41,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.009995A
2024/03/31,15:07:41,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.008133A
2024/03/31,15:07:41,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.005783A
2024/03/31,15:07:41,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.007751A
2024/03/31,15:07:41,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.000504A
2024/03/31,15:07:41,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.004166A
- 空白行 1-
- 空白行 2-
- 空白行 3-
- 空白行 4-
- 空白行 5-
- 空白行 6-
2024/03/31,15:07:42,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.010040A
2024/03/31,15:07:42,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.006485A
2024/03/31,15:07:42,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.009613A
2024/03/31,15:07:42,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.007355A
2024/03/31,15:07:42,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=-0.000793A
2024/03/31,15:07:42,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.003555A
2024/03/31,15:07:43,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.293671A
2024/03/31,15:07:43,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.279434A
2024/03/31,15:07:43,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=0.278687A
2024/03/31,15:07:43,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.271286A
2024/03/31,15:07:43,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.280624A
2024/03/31,15:07:43,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.284607A

#; Step 3: 抹除 空白行.
set infile3 [regsub -all -line {(?:^[ \t]*|//.*)(?:\n|\Z)} $infile2 ""]
set infile3

#; OUTPUT:
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
2024/03/31,15:07:41,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.009995A
2024/03/31,15:07:41,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.008133A
2024/03/31,15:07:41,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.005783A
2024/03/31,15:07:41,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.007751A
2024/03/31,15:07:41,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.000504A
2024/03/31,15:07:41,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.004166A
2024/03/31,15:07:42,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.010040A
2024/03/31,15:07:42,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.006485A
2024/03/31,15:07:42,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=-0.009613A
2024/03/31,15:07:42,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.007355A
2024/03/31,15:07:42,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=-0.000793A
2024/03/31,15:07:42,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.003555A
2024/03/31,15:07:43,vcp1_dut_1_B46AD4398300,SerialNumber=625977,port=0,Current=0.293671A
2024/03/31,15:07:43,vcp1_dut_3_B46AD4398364,SerialNumber=625977,port=1,Current=0.279434A
2024/03/31,15:07:43,vcp1_dut_5_B46AD439836A,SerialNumber=625977,port=2,Current=0.278687A
2024/03/31,15:07:43,vcp2_dut_2_B46AD439830C,SerialNumber=626059,port=0,Current=0.271286A
2024/03/31,15:07:43,vcp2_dut_4_B46AD4398298,SerialNumber=626059,port=1,Current=0.280624A
2024/03/31,15:07:43,vcp2_dut_6_B46AD43982D2,SerialNumber=626059,port=2,Current=0.284607A

#; Done
