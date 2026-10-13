;# 取得以下
Primary
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Golden
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11

 
set ::Uboot_ver 0.0.1.5
set ::OP_Version [string trim "V1.1.0.11" V]


regexp -line {Primary\n\sLoader Version} $get_info


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
