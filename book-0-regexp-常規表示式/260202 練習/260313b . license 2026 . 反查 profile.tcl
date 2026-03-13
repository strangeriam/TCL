目的: 查出字串 "Essential, cloud-m" 前的 Item 是否為 "Current Image Profile:"

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
set pattern {Current Image Profile:\n\s+[a-zA-Z\+,]+\s[a-z-]+}

;# Step 1: 取出
Current Image Profile:
  Essential, cloud-m

set aaa [regexp -all -inline -- $pattern $get_info]
;# 輸出: 
Current Image Profile:
  Essential, cloud-m

if {[regexp $::lic_profile $aaa]} {
    return 1
} else {
    return 0
}
