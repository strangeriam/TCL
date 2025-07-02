
set get_info {
Vnet4624T#dir
File Name                      Type    Startup Modified Time       Size (bytes)
------------------------------ ------- ------- ------------------- ------------
 Unit 1:
Vnet4624T_V1.2.0.13.bix        OpCode  Y       2024-08-08 01:24:23   36,383,447
Factory_Default_Config.cfg     Config  N       2024-08-08 01:23:48          455
startup1.cfg                   Config  Y       2024-08-08 01:23:53        1,544
-------------------------------------------------------------------------------
                     Free space for compressed user config files:   124,678,144
                                                     Total space:   165,584,896
Vnet4624T#
}

;# 當值符合
set ::PKG_SIMBA 	Vnet4624T_V1.2.0.13.bix

regexp -line "${::PKG_SIMBA}.*OpCode.*Y" $get_info opcode

輸出:
1
(12-Office-Sync-Switch) 52 % set opcode
Vnet4624T_V1.2.0.13.bix        OpCode  Y
(12-Office-Sync-Switch) 53 % 

;# 當值不符合
set ::PKG_SIMBA 	Vnet4624T_V1.2.0.12.bix

regexp -line "${::PKG_SIMBA}.*OpCode.*Y" $get_info opcode

輸出:
0
(12-Office-Sync-Switch) 55 % set opcode
Vnet4624T_V1.2.0.13.bix        OpCode  Y
(12-Office-Sync-Switch) 56 % 




