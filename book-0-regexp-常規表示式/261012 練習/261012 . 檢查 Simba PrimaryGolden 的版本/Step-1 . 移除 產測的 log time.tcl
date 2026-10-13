


Step 2: 
取得以下:
Loader Type            : Primary
Operation Code Type    : Primary
Primary
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11
Golden
 Loader Version         : 0.0.1.5
 Operation Code Version : 1.1.0.11

 
set ::Uboot_ver 0.0.1.5
set ::OP_Version [string trim "V1.1.0.11" V]





Step 1:
移除產測產測的 Log time.
;# ============================
set get_info2 [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]

輸出:
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





;# ==========================================================================

