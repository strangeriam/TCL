目的: 從 2 種 Log, 取得 ID.
Log 1: 測試用 (有 Expired time,有效期)
Log 2: 正式用 (是 Permanent, 無時間限制).
;# ===================================

set ::lic_profile 				"Essential, cloud-m"

;# 測試用 Log 1
set get_info {
Console#show license file
13:43:19:815| 
13:43:19:815| ID Expired Date Feature
13:43:19:815| 
13:43:19:815| -- ------------ ------------------------------------------------
13:43:19:815| 
13:43:19:815|  1 2026-07-14   L3 Premium
13:43:19:815| 
13:43:19:815|  2 2026-07-13   Essential, cloud-u
13:43:19:815| 
13:43:19:815| 
13:43:19:815| 
13:43:19:815| Input ID to show detail: 
}

;# 正式出貨用 Log 2.
set get_info {
Console#show license file
ID Expired Date Feature
-- ------------ ------------------------------------------------
 1 Permanent    Essential, cloud-m
 2 Permanent    L3 Premium
Input ID to show detail:
Console#
}

;# ===================================
;# Step 1: 取得 profile 所在的 ID.
set pattern {[0-9]\s[0-9]{4}-[0-9]{2}-[0-9]{2}\s+[a-zA-Z\+,]+\s[a-z-]+}
set pattern {[0-9]\s.+\s+[a-zA-Z\+,]+\s[a-z-]+}

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
.+ --> 所有字元, 包含 Permanent & 2026-05-24
\s+ --> 空白
[a-zA-Z\+,]+ --> 取得 包含大小寫的英文字母, 和 (加號 +) 和 (逗號 ,) --> Essential,
\s+ --> 空白
[a-z-]+ --> 取得 包含小寫的英文字母, 和 (減號 -) --> cloud-m
