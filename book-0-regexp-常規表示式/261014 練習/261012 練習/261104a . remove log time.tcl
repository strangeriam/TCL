Remove format "14:30:42:429| "

regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""

;# 輸出:
ls -l /overlay/upper/ | wc -l
2
admin@EAP104:~#


;# ============================
set get_info {
ls -l /overlay/upper/ | wc -l
09:02:32:349| 2
09:02:32:349| admin@EAP104:~# 
}
