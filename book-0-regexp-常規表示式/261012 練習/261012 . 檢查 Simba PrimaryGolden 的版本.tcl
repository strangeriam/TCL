Step 1: 移除產測產測的 Log time.
;# ============================
set get_info2 [regsub -all -line {\d+:\d+:\d+:\d+\| } $get_info ""]
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
set get_info {
show version
14:40:38:110| 
14:40:38:110| Unit 1
14:40:38:121| 
14:40:38:121|  Serial Number          : EC2332000362
14:40:38:121| 
14:40:38:121|  Hardware Version       : R0B
14:40:38:121| 
14:40:38:121|  EPLD Version           : 01.04
14:40:38:121| 
14:40:38:121|  Number of Ports        : 48
14:40:38:131| 
14:40:38:131|  Main Power Status      : Up
14:40:38:131| 
14:40:38:131|  Role                   : Master
14:40:38:131| 
14:40:38:131|  Linux Kernel Version   : 4.14.76-19.0.0
14:40:38:143| 
14:40:38:143|  Loader Type            : Primary
14:40:38:158| 
14:40:38:158|  Operation Code Type    : Primary
14:40:38:158| 
14:40:38:158| Primary
14:40:38:158| 
14:40:38:158|  Loader Version         : 0.0.1.5
14:40:38:158| 
14:40:38:158|  Operation Code Version : 1.1.0.11
14:40:38:158| 
14:40:38:158| Golden
14:40:38:158| 
14:40:38:158|  Loader Version         : 0.0.1.5
14:40:38:174| 
14:40:38:174|  Operation Code Version : 1.1.0.11
14:40:38:174| 
14:40:38:174| 
14:40:38:174| 
14:40:38:174| Console#
}

set get_info {
Console#show version
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
