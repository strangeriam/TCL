目的: 查出字串 "L3 Premium" 前的 Item 是否為 "Active functions:"

set ::lic_function 				"L3 Premium"

set get_info {
14:15:53:975| Console#show license
14:15:54:020| 
14:15:54:020| Current Image Profile:
14:15:54:045| 
14:15:54:045|   Essential, cloud-m
14:15:54:045| 
14:15:54:045| Active functions:
14:15:54:045| 
14:15:54:045|   L3 Premium
14:15:54:045| 
14:15:54:045| Inactive functions:
14:15:54:045| 
14:15:54:045|   
14:15:54:045| 
14:15:54:045| Console#
}

;# ===================================
;# 刪除每行時間 "10:35:52:822" 和 "|"
set pattern_eraseTime {[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{3}\|}
set aaa [regsub -all -line $pattern_eraseTime $get_info ""]
;# 輸出:
 Console#show license
 
 Current Image Profile:
 
   Essential, cloud-m
 
 Active functions:
 
   L3 Premium
 
 Inactive functions:
 
   
 
 Console#
;# ===============================================

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
