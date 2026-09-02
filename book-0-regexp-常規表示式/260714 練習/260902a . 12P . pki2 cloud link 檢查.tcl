
set ec_pki "00e00c2435fe.redirector.my-openwifi.cloud"

set get_info2 [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]
puts $get_info2

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
