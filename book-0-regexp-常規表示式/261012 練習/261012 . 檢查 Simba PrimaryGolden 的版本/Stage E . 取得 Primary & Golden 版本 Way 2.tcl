;# 取得以下
Primary
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Golden
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11

;# ========================================
set ::Uboot_ver 0.0.1.5 --> PASS
set ::Uboot_ver 0.0.1.4 --> FAIL

set ::OP_Version [string trim "V1.1.0.11" V] --> PASS
set ::OP_Version [string trim "V1.1.0.10" V] --> FAIL

;# Check Primary uBoot + OP Ver
set pattern_primary "Primary\n Loader Version\\s+: $::Uboot_ver\n Operation Code Version\\s+: $::OP_Version"
if { ![regexp -line $pattern_primary $get_info3]} {
    puts "FAIL <-- Primary . Loader Version $::Uboot_ver . Operation Code Version $::OP_Version"
} else {
    puts "PASS <-- Primary . Loader Version $::Uboot_ver . Operation Code Version $::OP_Version"
}

;# Check Golden uBoot + OP Ver
set pattern_golden "Golden\n Loader Version\\s+: $::Uboot_ver\n Operation Code Version\\s+: $::OP_Version"
if { ![regexp -line $pattern_golden $get_info3]} {
    puts "FAIL <-- Golden . Loader Version $::Uboot_ver . Operation Code Version $::OP_Version"
} else {
    puts "PASS <-- Golden . Loader Version $::Uboot_ver . Operation Code Version $::OP_Version"
}


;# =================================================
set get_info3 {
show version
Unit 1
 Serial Number          : EC2332000362
 Hardware Version       : R0B
 EPLD Version           : 01.04
 Number of Ports        : 48
 Main Power Status      : Up
 Role                   : Master
 Linux Kernel Version   : 4.14.76-19.0.0
 Loader Type            : Primary
 Operation Code Type    : Primary
Primary
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Golden
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Console#
}
