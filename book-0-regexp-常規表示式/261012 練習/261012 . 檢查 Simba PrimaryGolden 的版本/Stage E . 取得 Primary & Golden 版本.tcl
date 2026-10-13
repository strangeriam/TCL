;# 取得以下
Primary
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Golden
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11

 
set ::Uboot_ver 0.0.1.5
set ::OP_Version [string trim "V1.1.0.11" V]

set pattern_pri_uboot "Primary\n Loader Version\\s+: $::Uboot_ver"
set pattern_pri_op "Primary\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"

set pattern_god_uboot "Golden\n Loader Version\\s+: $::Uboot_ver"
set pattern_god_op "Golden\n Loader Version\\s+: .+\n Operation Code Version\\s+: $::OP_Version"

set itemlist [list "Loader Version" "Operation Code Version"]




regexp -line $pattern_god_op $get_info3





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
