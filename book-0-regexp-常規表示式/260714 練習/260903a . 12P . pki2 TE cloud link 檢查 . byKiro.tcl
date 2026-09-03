00e00c2435fe.redirector.my-openwifi.cloud

set ec_pki "[string tolow [_f_vini_profilerd SFIS MAC]].redirector.my-openwifi.cloud"
...
;# 移除時間戳前綴 + 所有換行/空白, 統一小寫
set tmp [_f_getconsole]
set tmp [regsub -all -line {\d+:\d+:\d+:\d+\| } $tmp ""]
set tmp [regsub -all {[\r\n[:space:]]} $tmp ""]
set tmp [string tolower $tmp]

;# 用 string first 做字面比對 (避免 . 被當萬用字元)
if { [string first $ec_pki $tmp] >= 0 } {
    _f_termmsg_V2 "Check ec_pki \"$ec_pki\" ,PASS" "" = -nodisplaytime
    break
}

;# Step 1:
set mac "00E00C2435FE"
set ec_pki "[string tolow $mac].redirector.my-openwifi.cloud"

;# 輸出:
;# ===============================================================================
00e00c2435fe.redirector.my-openwifi.cloud
;# ===============================================================================

;# Step 2: 移除時間格式.
set tmp [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]

;# 輸出:
;# ===============================================================================
show ucentral redirector

Ucentral Redirector URL by Operational cert: 00e00c2435fe.redirector.my-openwifi

.cloud

Console#
;# ===============================================================================



;# ===============================================================
set get_info {
show ucentral redirector
08:20:09:759| 
08:20:09:759| Ucentral Redirector URL by Operational cert: 00e00c2435fe.redirector.my-openwifi
08:20:09:759| 
08:20:09:759| .cloud
08:20:09:759| 
08:20:09:759| Console#
}
