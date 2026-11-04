Remove format "14:30:42:429| "

set get_info2 [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]
puts $get_info2



set get_info {
ls -l /overlay/upper/ | wc -l
09:02:32:349| 2
09:02:32:349| admin@EAP104:~# 
}
