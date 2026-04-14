目的: 從 2 種 Log, 取得 ID.
測試用 (有 Expired time,有效期) --> 2 2026-07-13   Essential, cloud-u
正式用 (是 Permanent, 無時間限制) --> 2 Permanent    Essential, cloud-u
;# ===================================

;# 測試用
set content {
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

;# 正式出貨用
set content {
Console#show license file
13:43:19:815| 
13:43:19:815| ID Expired Date Feature
13:43:19:815| 
13:43:19:815| -- ------------ ------------------------------------------------
13:43:19:815| 
13:43:19:815|  1 Permanent    L3 Premium
13:43:19:815| 
13:43:19:815|  2 Permanent    Essential, cloud-u
13:43:19:815| 
13:43:19:815| 
13:43:19:815| 
13:43:19:815| Input ID to show detail: 
}

;# ===================================
;# Step 1: 取得 profile 所在的 ID
set lic	"Essential, cloud-m"
set lic	"Essential, cloud-u" ;# $id 輸出 2
set lic	"L3 Premium" ;# $id 輸出 1

if {$lic == "Essential, cloud-u" || $lic == "Essential, cloud-m"} {
    set pattern {[1-9] .* *Essential, cloud-[mu]}
} else {
    set pattern {[1-9] .* *[a-zA-Z3] [a-zA-Z]+}
}

if { [regexp -line $pattern $content] } {
    regexp -line $pattern $content tmp
    set id [lindex $tmp 0] ;# 輸出: 1
    return $id
} else {
    return 0
}
