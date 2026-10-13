;# 取得以下
Primary
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Golden
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11


;# Check Primary . Loader Version . $::Uboot_ver
set ::Uboot_ver 0.0.1.5 --> PASS
set ::Uboot_ver 0.0.1.4 --> FAIL

set pattern_pri_uboot "Primary\n Loader Version\\s+: $::Uboot_ver"
if { ![regexp -line $pattern_pri_uboot $get_info3]} {
    puts "FAIL <-- Primary . Loader Version . $::Uboot_ver"
} else {
    puts "PASS <-- Primary . Loader Version . $::Uboot_ver"
}

;# Check Primary . Operation Code Version . $::OP_Version
set ::OP_Version [string trim "V1.1.0.11" V] --> PASS
set ::OP_Version [string trim "V1.1.0.10" V] --> FAIL

set pattern_pri_op "Primary\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"
if { ![regexp -line $pattern_pri_op $get_info3]} {
    puts "FAIL <-- Primary . Operation Code Version . $::OP_Version"
} else {
    puts "PASS <-- Primary . Operation Code Version . $::OP_Version"
}

;# =================================================================
;# Check Golden . Loader Version . $::Uboot_ver
set ::Uboot_ver 0.0.1.5 --> PASS
set ::Uboot_ver 0.0.1.4 --> FAIL

set pattern_god_uboot "Golden\n Loader Version\\s+: $::Uboot_ver"
if { ![regexp -line $pattern_god_uboot $get_info3]} {
    puts "FAIL <-- Golden . Loader Version . $::Uboot_ver"
} else {
    puts "PASS <-- Golden . Loader Version . $::Uboot_ver"
}

;# Check Golden . Operation Code Version . $::OP_Version
set ::OP_Version [string trim "V1.1.0.11" V] --> PASS
set ::OP_Version [string trim "V1.1.0.10" V] --> FAIL

set pattern_god_op "Golden\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"
if { ![regexp -line $pattern_god_op $get_info3]} {
    puts "FAIL <-- Golden . Operation Code Version . $::OP_Version"
} else {
    puts "PASS <-- Golden . Operation Code Version . $::OP_Version"
}

