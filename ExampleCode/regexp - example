# ==============
# Example code 2
# Actual command in my code.
# set uartRes [promptwait $com_fd "uname -v" $prompt_linux 2]

set verSW_1 "#48-Ubuntu SMP Tue Jan 29 16:28:13 UTC 2019"
set verSW_2 "#49-Ubuntu SMP 2"
set verSW_3 "#50-Ubuntu SMP 3"

set aaa "
1 {
uname -v
#48-Ubuntu SMP Tue Jan 29 16:28:13 UTC 2019
root@igw5000:~#}
"
set getVer [string trimleft [string trim [lindex $aaa 1]] "uname -v"]
set getVer [string trim [string trimright $getVer "root@igw5000:~#"]]

if { [regexp $verSW_1 $getVer] } {
             puts "this is code 1"
} elseif { [regexp $verSW_2 $getVer ] } {
             puts "this is code 2"
} elseif { [regexp $verSW_3 $getVer ] } {
             puts "this is code 3"
}

# Response: this is code 1

# ==============
# Example code 3
# 不能有空字元
# 比對的字串裡不能有空字元.
# 舉例: Boot loader 的 prompt 字串是 → (IPQ40xx) #, 將比對不出來, 出現結果為 “UNDEFINE”.
# 需將中間空白字元右邊的井號 移除即可運作.
  
set prompt_uboot     "(IPQ40xx) #"
ConsoleWrite $com_fd ""
set uartRes [ConsoleRead $com_fd]

if {[regexp $prompt_linux $uartRes]} {
            set osType "LINUX"
} elseif {[regexp $prompt_uboot $uartRes]} {
            set osType "BOOTLOADER"
} else {
            set osType "UNDEFINE"
}

fun_message usual "目前所在系統是 $osType..."
 
 
 
