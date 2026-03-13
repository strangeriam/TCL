目的: 查出字串 "L3 Premium" 前的 Item 是否為 "Active functions:"

set ::lic_profile 				"Essential, cloud-m"

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
;# regsub -all -line {(?:^[ \t]*|//.*)(?:\n|\Z)} $get_info ""
set pattern_eraseTime {[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{3}\|}
set aaa [regsub -all -line $pattern_eraseTime $get_info ""]


set pattern {Current Image Profile:\n\s+[a-zA-Z\+,]+\s[a-z-]+}

;# Step 1: 取出
Current Image Profile:
  Essential, cloud-m

set bbb [regexp -all -inline -- $pattern $aaa]
;# 輸出: 
Current Image Profile:
  Essential, cloud-m

if {[regexp $::lic_profile $bbb]} {
    return 1
} else {
    return 0
}
