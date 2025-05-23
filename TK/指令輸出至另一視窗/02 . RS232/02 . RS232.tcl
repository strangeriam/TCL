package require Tk
UI_ShowLog
set ::console_port 12
set ::com_fd [com_open $::console_port]

_f_transmit $::com_fd "uname -a"

com_close $::com_fd


;# 移除 此 uI
destroy $w
