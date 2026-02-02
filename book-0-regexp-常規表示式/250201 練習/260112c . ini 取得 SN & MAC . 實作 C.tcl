- 實作 C -
[DutScanSpec]
01_SN=^EC([0-9A-Z]{10})$
02_MAC=^(E001A6|E4448F|E49D73|14448F)([0-9A-F]{6})$
輸入: {SN=EC2231009930} {MAC=E001A63FB622}
需輸出
SN --> EC2231009930
MAC --> E001A63FB622


;# CODE get SN
;# ============
set scanner "EC2430001796"

set patternSN {EC([0-9A-Z]{10})}
regexp -line $patternSN $scanner SN
set SN

輸出: EC2430001796


;# CODE get MAC
;# ============
set scanner "A01AE3F90050"

set patternMAC {(A01AE3|649D99)([0-9A-F]{6})}
regexp -line $patternMAC $scanner MAC
set MAC

輸出: A01AE3F90050
