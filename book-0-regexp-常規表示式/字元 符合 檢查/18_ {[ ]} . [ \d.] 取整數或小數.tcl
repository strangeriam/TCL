當最後一個數字是 0 或 0.111 的取得.

## 數字是 0
set infile {,4T4R,25.0259,-20.0967,-9.22368,-8.96866,-62.3048,0}

set line_start {,4T4R}
set v02 [string repeat {,{0,1}\d+\.\d+,-{0,1}\d+\.\d+,-{0,1}\d+\.\d+,-{0,1}\d+\.\d+,-{0,1}\d+\.\d+,[\d.]+} 1]
regexp -all -inline $line_start$v02 $infile

## 輸出
,4T4R,25.0259,-20.0967,-9.22368,-8.96866,-62.3048,0


## =========================================
## 數字是 0.111
set infile {,4T4R,25.0259,-20.0967,-9.22368,-8.96866,-62.3048,0.111}

set line_start {,4T4R}
set v02 [string repeat {,{0,1}\d+\.\d+,-{0,1}\d+\.\d+,-{0,1}\d+\.\d+,-{0,1}\d+\.\d+,-{0,1}\d+\.\d+,[\d.]+} 1]
regexp -all -inline $line_start$v02 $infile

## 輸出
,4T4R,25.0259,-20.0967,-9.22368,-8.96866,-62.3048,0.111


## =========================================
set infile {,2412 MHz MCS8 BW-20 ANT_1 18 dBm VHT NA }
regexp -all -inline -- {,-{0,1}\d+ MHz [\w-]+ [\w-]+ [\w_]+ [\d.]+ dBm [\w_]+ NA } $infile

## 輸出
{,2412 MHz MCS8 BW-20 ANT_1 18 dBm VHT NA }

set infile {,2412 MHz MCS8 BW-20 ANT_1 21.5 dBm VHT NA }
regexp -all -inline -- {,-{0,1}\d+ MHz [\w-]+ [\w-]+ [\w_]+ [\d.]+ dBm [\w_]+ NA } $infile

## 輸出
{,2412 MHz MCS8 BW-20 ANT_1 21.5 dBm VHT NA }

