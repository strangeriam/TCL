
	if { ! [regexp -line {OpCode.*Y} $get_info opcode] } {
		_f_termmsg_V1 "Check \"OpCode  Y\" ,FAIL"
		set ::s0 "Opcode status check fail!"
		set ::ErrorCode "T74"
		return 0
	}



set get_info {
dir
14:43:29:823| 
14:43:29:823| File Name                      Type    Startup Modified Time       Size (bytes)
14:43:29:823| 
14:43:29:823| ------------------------------ ------- ------- ------------------- ------------
14:43:29:823| 
14:43:29:823|  Unit 1:
14:43:29:823| 
14:43:29:823| ECIS4510_V1.2.0.9.bix          OpCode  Y       2026-08-14 10:07:27   19,195,707
14:43:29:823| 
14:43:29:823| Factory_Default_Config.cfg     Config  N       2026-08-14 10:00:05          414
14:43:29:823| 
14:43:29:823| startup1.cfg                   Config  Y       2026-08-14 10:00:09        1,043
14:43:29:823| 
14:43:29:823| -------------------------------------------------------------------------------
14:43:29:823| 
14:43:29:823|                                    Free space for user config files:  2,619,983
14:43:29:823| 
14:43:29:823|                                                         Total space: 536,870,912
14:43:29:823| 
14:43:29:823| Console#
}
