_f_list_serial_ports

輸出:
COM19 COM20 COM4 COM8 COM9 COM3


;#---------------------------------------------------------------------------
;# 掃描系統目前存在的 COM 埠 (讀註冊表 SERIALCOMM)
;# 回傳 COM 埠清單, 例: {COM8 COM3}
;#---------------------------------------------------------------------------
proc _f_list_serial_ports {} {
    set ports {}
    ;# 方法 1: registry 套件 (Windows 內建於 ActiveTcl/Magicsplat)
    if {![catch {package require registry}]} {
        set key "HKEY_LOCAL_MACHINE\\HARDWARE\\DEVICEMAP\\SERIALCOMM"
        if {![catch {registry values $key} vals]} {
            foreach v $vals {
                if {![catch {registry get $key $v} portname]} {
                    lappend ports $portname
                }
            }
        }
        return $ports
    }

    ;# 方法 2: 沒有 registry 套件 -> 用 reg.exe 命令列 fallback
    if {![catch {exec reg query "HKLM\\HARDWARE\\DEVICEMAP\\SERIALCOMM"} out]} {
        foreach line [split $out \n] {
            ;# 每行格式: <裝置路徑>    REG_SZ    COMx
            if {[regexp {REG_SZ\s+(COM\d+)} $line -> p]} {
                lappend ports $p
            }
        }
    }
    return $ports
}
