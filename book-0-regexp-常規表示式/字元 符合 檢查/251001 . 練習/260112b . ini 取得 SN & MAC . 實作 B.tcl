- 實作 B -
[DutScanSpec]
01_2D=^2D;SN1;EC([0-9A-Z]{10});MAC1;(A01AE3|A01AE3)([0-9A-F]{6})$
輸入: 2D=2D;SN1;EC2430001796;MAC1;A01AE3F90050
需輸出
SN --> EC2430001796
MAC --> A01AE3F90050

;# CODE get SN
;# ============
set scanner "2D=2D;SN1;EC2430001796;MAC1;A01AE3F90050"

set patternSN {EC([0-9A-Z]{10})}
regexp -line $patternSN $scanner SN
set SN

輸出: EC2430001796
