
## ,2412 MHz MCS0 BW-20 ANT_1 22 dBm VHT NA 
set p04 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+ dBm [A-Z][A-Z][A-Z]+ NA }

## ,2422 MHz MCS9 BW-40 ANT_1 17.5 dBm VHT NA 
set p05 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+\.\d+ dBm [A-Z][A-Z][A-Z]+ NA }

set data_04 $p04$p04$p04$p04$p04$p04
set data_05 $p05$p05$p05$p05$p05$p05

## =========
## ,2412 MHz MCS0 BW-20 ANT_1 22 dBm VHT NA 
set pattern101 $data_04$data_04$data_04$data_04 			;# 2412 MCS0 VHT
set pattern102 $data_04$data_04$data_04$data_04 			;# 2442 MCS0 VHT
set pattern103 $data_04$data_04$data_04$data_04 			;# 2472 MCS0 VHT

## ,2412 MHz MCS8 BW-20 ANT_1 19 dBm VHT NA 
set pattern104 $data_04$data_04$data_04$data_04 			;# 2412 MCS8 VHT
set pattern105 $data_04$data_04$data_04$data_04 			;# 2442 MCS8 VHT
set pattern106 $data_04$data_04$data_04$data_04 			;# 2472 MCS8 VHT

## ,2422 MHz MCS0 BW-40 ANT_1 21 dBm VHT NA 
set pattern107 $data_04$data_04$data_04$data_04 			;# 2422 MCS0 VHT
set pattern108 $data_04$data_04$data_04$data_04 			;# 2442 MCS0 VHT
set pattern109 $data_04$data_04$data_04$data_04 			;# 2462 MCS0 VHT

## ,2422 MHz MCS9 BW-40 ANT_1 17.5 dBm VHT NA 
set pattern110 $data_05$data_05$data_05$data_05 			;# 2422 MCS9 17.5 VHT
set pattern111 $data_05$data_05$data_05$data_05 			;# 2442 MCS9 17.5 VHT
set pattern112 $data_05$data_05$data_05$data_05 			;# 2462 MCS9 17.5 VHT

set patternD $pattern101$pattern102$pattern103$pattern104$pattern105$pattern106$pattern107$pattern108$pattern109$pattern110$pattern111$pattern112


## ,2412 MHz MCS0 BW-20 ANT_1 22 dBm HE_SU NA 
set p06 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+ dBm [A-Z][A-Z]_[A-Z][A-Z]+ NA }
set data_06 $p06$p06$p06

## ,2412 MHz MCS0 BW-20 ANT_1 22 dBm HE_SU NA 
set pattern103 $data_06$data_06$data_06$data_06 			;# 2412 MCS0 HE_SU
set pattern104 $data_06$data_06$data_06$data_06 			;# 2442 MCS0 HE_SU
set pattern105 $data_06$data_06$data_06$data_06 			;# 2472 MCS0 HE_SU

set patternE $pattern103$pattern104$pattern105


## ,2412 MHz MCS11 BW-20 ANT_1 18.5 dBm HE_SU NA 
set p07 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+\.\d+ dBm [A-Z][A-Z]_[A-Z][A-Z]+ NA }
set data_07 $p07$p07$p07

## ,2412 MHz MCS11 BW-20 ANT_1 18.5 dBm HE_SU NA 
set pattern106 $data_07$data_07$data_07$data_07 			;# 2412 MCS11 1.8 HE_SU
set pattern107 $data_07$data_07$data_07$data_07 			;# 2442 MCS11 1.8 HE_SU
set pattern108 $data_07$data_07$data_07$data_07 			;# 2472 MCS11 1.8 HE_SU

set patternF $pattern106$pattern107$pattern108


## ,2422 MHz MCS0 BW-40 ANT_1 21 dBm HE_SU NA 
set p08 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+ dBm [A-Z][A-Z]_[A-Z][A-Z]+ NA }
set data_08 $p08$p08$p08

## ,2412 MHz MCS0 BW-20 ANT_1 22 dBm HE_SU NA 
set pattern109 $data_08$data_08$data_08$data_08 			;# 2422 MCS0 HE_SU
set pattern110 $data_08$data_08$data_08$data_08 			;# 2442 MCS0 HE_SU
set pattern111 $data_08$data_08$data_08$data_08 			;# 2462 MCS0 HE_SU

set pattern112 $data_08$data_08$data_08$data_08 			;# 2422 MCS11 HE_SU
set pattern113 $data_08$data_08$data_08$data_08 			;# 2442 MCS11 HE_SU
set pattern114 $data_08$data_08$data_08$data_08 			;# 2462 MCS11 HE_SU

set patternG $pattern109$pattern110$pattern111$pattern112$pattern113$pattern114

set pattern $patternD$patternE$patternF$patternG

regexp -all -inline -- $pattern $infile

