;# 目標: 取得正確字串 --> 00e00c2435fe.redirector.my-openwifi.cloud


;# ====================================
;# Step 4: 統一小寫.
set tmp [string tolower $tmp]

輸出:
showucentralredirectorucentralredirectorurlbyoperationalcert:00e00c2435fe.redirector.my-openwifi.cloudconsole#

;# Step 5: 用 string first 做字面比對 (避免 . 被當萬用字元)
if { [string first $ec_pki $tmp] >= 0 } {
    puts "Check ec_pki \"$ec_pki\" ,PASS"
}

輸出:
Check ec_pki "00e00c2435fe.redirector.my-openwifi.cloud" ,PASS


;# ====================================
;# Step 3: 所有換行/空白.
set tmp [regsub -all {[\r\n[:space:]]} $tmp ""]

輸出:
showucentralredirectorUcentralRedirectorURLbyOperationalcert:00e00c2435fe.redirector.my-openwifi.cloudConsole#


;# ====================================
;# Step 2: 移除時間戳前綴.
set tmp [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]

輸出:
show ucentral redirector

Ucentral Redirector URL by Operational cert: 00e00c2435fe.redirector.my-openwifi

.cloud

Console#


;# Step 1:
set mac "00E00C2435FE"
set ec_pki "[string tolow $mac].redirector.my-openwifi.cloud"

輸出:
00e00c2435fe.redirector.my-openwifi.cloud


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
