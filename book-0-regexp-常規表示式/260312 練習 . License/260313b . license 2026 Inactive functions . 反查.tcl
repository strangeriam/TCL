目的: 查出字串 "L3 Premium" 前的 Item 是否為 "Inactive functions:"

set ::lic_function 				"L3 Premium"

set get_info {
10:35:52:748| Console#show license
10:35:52:822| 
10:35:52:822| Current Image Profile:
10:35:52:822| 
10:35:52:822|   Essential, cloud-m
10:35:52:822| 
10:35:52:822| Active functions:
10:35:52:822| 
10:35:52:822|   
10:35:52:822| 
10:35:52:822| Inactive functions:
10:35:52:822| 
10:35:52:822|   L3 Premium
10:35:52:822| 
10:35:52:822| Console#
}

;# ===================================
;# 刪除每行時間 "10:35:52:822" 和 "|"
set pattern_eraseTime {[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{3}\|}
set aaa [regsub -all -line $pattern_eraseTime $get_info ""]

set pattern {Inactive functions:\n\s+[A-Z3]+\s[a-zA-Z]+}

;# Step 1: 取出
 Inactive functions:
 
   L3 Premium

set bbb [lindex [regexp -all -inline -- $pattern $aaa] 0]
;# 輸出: 
Inactive functions:
   L3 Premium

if {[regexp $::lic_function $bbb]} {
    return 1
} else {
    return 0
}
