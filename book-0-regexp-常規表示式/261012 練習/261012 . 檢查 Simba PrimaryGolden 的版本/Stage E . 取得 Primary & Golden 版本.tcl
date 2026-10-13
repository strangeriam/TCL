;# 取得以下
Primary
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Golden
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11

 
set ::Uboot_ver 0.0.1.5
set ::Uboot_ver 0.0.1.4

set ::OP_Version [string trim "V1.1.0.11" V]
set ::OP_Version [string trim "V1.1.0.10" V]


set pattern_pri_uboot "Primary\n Loader Version\\s+: $::Uboot_ver"
if { ![regexp -line $pattern_pri_uboot $get_info3]} {
    puts "FAIL <-- Primary . Loader Version . $::Uboot_ver"
} else {
    puts "PASS <-- Primary . Loader Version . $::Uboot_ver"
}



set pattern_pri_op "Primary\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"

set pattern_god_uboot "Golden\n Loader Version\\s+: $::Uboot_ver"
set pattern_god_op "Golden\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"

if { ![regexp -line $pattern_pri_uboot $get_info3]} {
    puts "FAIL <-- Primary . Loader Version . $::Uboot_ver"
} else {
    puts "PASS <-- Primary . Loader Version . $::Uboot_ver"
}

if { ![regexp -line $pattern_pri_op $get_info3]} {
    puts "FAIL <-- Primary . Operation Code Version . $::OP_Version"
} else {
    puts "PASS <-- Primary . Operation Code Version . $::OP_Version"
}



set pattern_pri_uboot "Primary\n Loader Version\\s+: $::Uboot_ver"
set pattern_pri_op "Primary\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"

set pattern_god_uboot "Golden\n Loader Version\\s+: $::Uboot_ver"
set pattern_god_op "Golden\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"


set listtype [list Primary Golden]
set listitem [list "Loader Version" "Operation Code Version"]
set listvalue [list $::Uboot_ver $::OP_Version]










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
