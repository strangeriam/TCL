
;# 準備
set ec_pki "00e00c2435fe.redirector.my-openwifi.cloud"

;# ==============================================================
;# Step 3: 判斷結果 --> ec_pki.
regexp -all $ec_pki $tmp

輸出: 1

;# ==============================================================
;# Step 2: 拿掉 跳行 \n.
set tmp [regsub -all -line \n $tmp ""]

輸出:
show ucentral redirectorUcentral Redirector URL by Operational cert: 00e00c2435fe.redirector.my-openwifi.cloudConsole#

;# ==============================================================
;# Step 1: 拿掉 log 產生的時間, eg. "08:20:09:759|"
set tmp [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]

輸出:
show ucentral redirector

Ucentral Redirector URL by Operational cert: 00e00c2435fe.redirector.my-openwifi

.cloud

Console#


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
