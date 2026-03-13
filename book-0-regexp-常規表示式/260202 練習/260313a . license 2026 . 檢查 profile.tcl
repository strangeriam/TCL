目的: 取出 Current Image Profile: 是否是 "Essential, cloud-m"

set ::lic_profile 				"Essential, cloud-m"

set get_info {
Console#show license
Current Image Profile:
  Essential, cloud-m
Active functions:
  
Inactive functions:
  L3 Premium
Console#
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
