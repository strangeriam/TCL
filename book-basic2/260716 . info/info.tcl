info 命令列表

該命令使用的匹配式規則和 string match 一致, 並且如果不適用匹配式, 返回所有的項.

序號  命令  描述
1	info commands ?pattern?	返回匹配的命令列表
2	info exists varName	變數存在返回1，否則返回0
3	info globals?pattern?	返回全域性變數列表
4	info locals? pattern?	返回區域性變數列表
5	info procs?pattern?	返回過程列表
6	info vars?pattern?	返回變數列表

## info exists
## 檢查變數是否存在.
## 例如 incr 指令使用時, 變數必須先建立才能為變數進行加法運算.

if {![info exists counter]} {
    set counter 0
} else {
    incr counter     ;# counter 加 1
}

## info global
## TCL 在執行時會建立一些全域變數, 可以利用 info global 列出有哪些全域變數.

argv argv0 tcl_version tcl_interactive var auto_oldpath errorCode auto_path errorInfo unknown_handlers unknown_handler_order auto_index env tcl_patchLevel argc tcl_libPath _ tcl_platform tcl_library

argc 存放程式的命令列參數個數
argv0 是目前執行的 TCL Script 名稱
argv 則是存放所有命令列參數的 list
env 陣列存放系統的環境變數
tcl_version 會告訴你目前的 TCL 版本

