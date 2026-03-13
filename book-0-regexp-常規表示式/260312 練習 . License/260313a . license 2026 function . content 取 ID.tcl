set ::lic_function 				"L3 Premium"

set get_info {
Console#show license file
ID Expired Date Feature
-- ------------ ------------------------------------------------
 1 2026-05-25   L3 Premium
 2 2026-05-24   Essential, cloud-m

Input ID to show detail: Console#
}

;# ===================================
;# Step 1: 取得 profile 所在的 ID.
set pattern {[0-9]+\s+[0-9]{4}-[0-9]{2}-[0-9]{2}\s+[a-zA-Z\+,]+\s[a-z-]+}

set aaa [regexp -all -inline -- $pattern $get_info]
if {[regexp $::lic_profile $aaa]} {
    if {[regexp -linestop .*$::lic_profile $aaa]} {
       set id_tmp [lindex $aaa 0] ;# 輸出: 1 2026-05-24   Essential, cloud-m
       regexp -linestop .*$::lic_profile $id_tmp tmp
       set id [lindex $tmp 0]  ;# 輸出: 1
    }
} else {
   return 0
}
    

;# REGEXP 解說:
;# ===================================
[0-9]+ --> 取得 ID --> 1
\s+ --> 空一格
[0-9]{4}-[0-9]{2}-[0-9]{2} --> 取得日期 --> 2026-05-24
\s+ --> 空白
[a-zA-Z\+,]+ --> 取得 包含大小寫的英文字母, 和 (加號 +) 和 (逗號 ,) --> Essential,
\s+ --> 空白
[a-z-]+ --> 取得 包含小寫的英文字母, 和 (減號 -) --> cloud-m
