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
set pattern {}

set aaa [regexp -all -inline -- $pattern $get_info]

