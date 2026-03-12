set ::lic_profile 				"Essential, cloud-m"
set ::lic_profiledigest 		"da407b2c4c92090ced9e3b9c5f8747ab"
set ::lic_projectname 			ECS5550

set get_info {
Console#show license file
ID Expired Date Feature
-- ------------ ------------------------------------------------
 1 2026-05-24   Essential, cloud-m

Input ID to show detail: 
}

;# ===================================

;# 取得 profile 所在的 ID.

set pattern {[0-9]+\s+[0-9]{4}-[0-9]{2}-[0-9]{2}\s+[a-zA-Z\+,]+\s[a-z]+-\D}
;# or
set pattern {[0-9]+\s+[0-9]{4}-[0-9]{2}-[0-9]{2}\s+[a-zA-Z\+,]+\s[a-z-]+}
set aaa [regexp -all -inline -- $pattern $get_info]
;# 輸出: {1 2026-05-24   Essential, cloud-m}

set bbb [lindex $aaa 0]
;# 輸出: {1 2026-05-24   Essential, cloud-m}

;# REGEXP 解說:
;# ===================================
[0-9]+ --> 取得 ID --> 1
\s+ --> 空一格
[0-9]{4}-[0-9]{2}-[0-9]{2} --> 取得日期 --> 2026-05-24
\s+ --> 空白
[a-zA-Z\+,]+ --> 取得 包含大小寫的英文字母, 和 (加號 +) 和 (逗號 ,) --> Essential,
\s+ --> 空白
[a-z-]+ --> 取得 包含小寫的英文字母, 和 (減號 -) --> cloud-m


