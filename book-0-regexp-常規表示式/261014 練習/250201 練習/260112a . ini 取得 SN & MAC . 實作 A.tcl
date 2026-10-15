- 實作 A -
[DutScanSpec]
01_2D=^2D;SN1;([0-9A-Z]{14})N([0-9]{5});MAC1;(649D99|649D99)([0-9A-F]{6})$

輸入: 2D=2D;SN1;FSLS715X202511N00123;MAC1;649D99940123
需輸出
SN --> FSLS715X202511N00123
MAC --> 649D99940123

;# CODE get SN
;# ============
set scanner "2D=2D;SN1;FSLS715X202511N00123;MAC1;649D99940123"

set patternSN {([0-9A-Z]{14})N([0-9]{5})}
regexp -line $patternSN $scanner SN
set SN

輸出: FSLS715X202511N00123

;# CODE get MAC
;# ============
set scanner "2D=2D;SN1;FSLS715X202511N00123;MAC1;649D99940123"

set patternMAC {(649D99|649D99)([0-9A-F]{6})}
regexp -line $patternMAC $scanner MAC
set MAC

輸出: 649D99940123
