encoding system utf-8
;############################################################################
;# ?ΩÁ??∞Ê≠§Ë°åÂ?,‰Ω†Á?Á∑®ËºØ?çÊòØÊ≠?¢∫??
;# ?ΩÁ??∞Ê≠§Ë°åÂ?Ôºå‰??ÑÁ?ËæëÊ??ØÊ≠£Á°ÆÁ???
;# ?ô„??ì„Å®?å„Åß?ç„Åæ?ô„??ÆË??íÂ??ß„??¶„??†„??Ñ„ÄÅ„??™„??ØÁ∑®?Ü„?Ê≠???Ñ„Åß?ô„Ä?
;# C√≥ th·ª?nh√¨n th·∫•y d√≤ng n?y, b·∫°n ch·ªânh s·ª≠a l? ch√≠nh x√°c.
;############################################################################
set AccWS.tbc {Author:Midas,Alan
0.2.1-20111220 (1)_f_MesShopFlowUploadResultLog Support TMO ??XT?πÊ?Ê¨Ñ‰? , this is deal with MIS from $::other_field.
               (2)ÁßªÈô§_f_sini_profilerd , _f_sini_profilewr 
			   (3)Â∞éÂÖ•?®Êñ∞??c:\tmp\MES log ‰øùÁ? 72Hr . Â§ßÊñº 72Hr ?xá™?ïÁßª??
0.2.0-20111128 (1)Support WebService DLLV2.0 Format
               (2)Drop All DLLV2.0 and None-Used Function
               (3)Update INI ??Keywords ?øÈ? XML ??wording. <>@* .... as DLLV2.0 Format.
0.1.3-20110927 (1)?∂MES FAIL ???∞Âá∫ $::MesReturn
0.1.2-20110805 (1)Fix Syc Time Bug . change use open "cmd /c ..." from "::twapi::create_process"
			   (2)WebService Âæ?60 sec ?πÊ? 5 ?ÜÈ?.
0.1.2-20110717 (1)Â¢ûÂ? ?™Â∑±?¥Êñ∞ PC system datetime via Server
0.1.1-20110711 (1)fix ??inifile Ë®≠Â?ftp log disable ?∫Áèæ?ÑÈåØË™?--<ALAN>
0.1.0-20110628 (1)?†‰??≤Â? . When Server Reply abnormal UID. ??show errormsg ?≤ÂÖ• vwait
               (2)?¥Êñ∞ACCHttpLibX.dll
0.0.9-20110624 (1)Fix When No MAC Condidion
			   (2)?†‰? ModelName from "_f_vini_profilerd MYSQL MODELNAME"
0.0.8-20110623 (1)?∞Â? ?≤Â? when WebService No Reply PASS contidion.
			   (2)‰ΩøÁî® profilewr/profilerd => c:\tmp\MES_%d.ini fix regsub bug.
0.0.7-20110622 (1)?∞Â? LOG_PATH_FN ??MES ??TestResult , ?π‰æø MIS ÂæåÁ? FTP LOG Ë∑ØÂ??ÑÈ?Âª?
0.0.6-20110610 (1)_f_MesShopFlowCheckIn ?∞Â??vï∏ -NoVerControl
0.0.5-20110523 (1)fix _f_sini_profilerd Â§ö‰?‰∏Ä??0x0d ?ÑÂ?È°?<?çÂ??ÆÂ? Mes return 0x0d,0x0a?∫Á?Â∞?
0.0.4-20110520 (1)add _f_Mes_Reg_TestResult for additional test result need to be address-in MES database.
               (2)add MainConfig.ini [WebService]->Activate ?ØË®≠ÂÆ?ENABLE/DISABLE.
0.0.3-20110323 (1)fix bug Â¢ûÂ? "Content="   ==> append ::MesResult_Log "\nContent=\n$logbox" , Ëß?±∫ Send Log ?èÈ?.
0.0.2-20110322 (1)fix bug _f_sini_profilewr have simulator "key" , ex:  only "d" will take wrong location into "abc_d".
               (2)Suppport Version control , since MIS update the code. "ex: PN=S0P9J46490052,PASS," in [CheckIn] return.
                  ‰∏¶Â??? ??shopfloor = Enable ?? ?vé°?ñÁ?Âºè‰∏≠Ê≠?.
0.0.1-20110320 first release
}


#if { [ string first n [profilerd MainConfig.ini sfis sfis] ] == -1} {
	if {![info exist ::wsobj]} {
		set ::wsobj [::tcom::ref createobject "ACCHttpLibX.TACCHttpLibXClass"]
		set ::WEB_SERVICE 1
	}
#} else {
#	set ::WEB_SERVICE 0
#}
;############################################################################
;# PROCEDURE NAME - _f_WebServiceSini_V2 {sinibox feedback}
;#-------------------------------------------------------------------------Ver:0V
;# DESCRIPTION: ?ïÁ? WebService ?ÑÂ?‰Ω? ?∂‰∏≠ sinibox Â≠ó‰∏≤?∫Â∑±?ïÁ???
;#              Á¨¶Â? Accton MIS ?ÄÂÆöÁæ©‰πãÊ†ºÂº?likes inifile format>
;#              feedback ??WebService Server ?ûÂÇ≥‰πãÂ?‰∏≤ÂÖßÂÆ? ‰∫¶Â???SebService Spec.
;# EXAMPLE : _f_WebServiceSini_V2 $::MesChkInIniBox ::MesReturn
;# RETURN: None
;############################################################################
proc _f_WebServiceSini_V2 { sinibox feedback } {
	upvar $feedback wsfeedback
	set sinibox [string map {"\n" "\r\n"} $sinibox]
	puts "\n=======================\n$sinibox\n========================\n"

	
	#Set Web service url
#	$::wsobj SetWebServiceUrl [_f_vini_profilerd WebService WebServiceUrl]
	set Basic Authentication
#	$::wsobj  SetBasicCredential "[_f_vini_profilerd WebService WebServiceAuthUid]" "[_f_vini_profilerd WebService WebServiceAuthPwd]"
	#Set TimeOut
	$::wsobj ConnectionTimeOut 300000
	$::wsobj SendTimeOut 300000
	$::wsobj ReceiveTimeOut 300000

	
#	$::wsobj GroupName [_f_vini_profilerd SFIS ws_id]
#	$::wsobj Operator  [_f_vini_profilerd SFIS operator_id]
#	$::wsobj LineNo   [_f_vini_profilerd SFIS line]
#	$::wsobj ShiftNo  [_f_vini_profilerd SFIS shift]
	
	
	#Call Service

	$::wsobj CallWSMethod2 $sinibox wsfeedback
	#puts $wsfeedback
	set wsfeedback [string map {"\r\n" "\n" "\n\r" "\n"} $wsfeedback]

	if {$wsfeedback == ""} {
		set err [$::wsobj ErrorMsg] 
		puts <ERRMSG:$err>
		#errormsg "Thread:<$::DUT_Num> with MES Send Fail . \nPlease ask MFG.TE or PPE or RD.TA or MIS to check debug console\n$err"
		#set ::s0 $err
		append wsfeedback "\n<$err>"
		#vwait xxx
		return 0
	} else {
		return 1
	}	
	
}
;############################################################################
;# PROCEDURE NAME - _f_MesShopFlowCheckIn {args}
;#-------------------------------------------------------------------------Ver:0W
;# DESCRIPTION: ?èÈ? webservice ?ïÁ? CheckIn ?ÑÂ?‰Ω?
;#              ?∂Âü∑Ë°åÊ≠§ function , Á®ãÂ??yÄèÈ? ?∫Êú¨ ??sfis Ë≥áÊ?. Â≠òÊîæ??visual ini Ë£?
;#              ?≤Ë? È°û‰ººinifile?ÑÂ?‰∏≤Ë????çÈÄèÈ? Accton MIS ?ê‰? ??COM ?tª∂.?≤Ë?,Ë≥áË?‰∫§Ê?.
;#              $args : ?∂ÂÇ≥?•Â???-NoVerControl ?á‰??u?Ê∏¨Ë©¶Á®ãÂ??àÊú¨?ßÁÆ°
;# EXAMPLE : _f_MesShopFlowCheckIn
;#           _f_MesShopFlowCheckIn -NoVerControl
;# RETURN: None
;############################################################################
proc _f_MesShopFlowCheckIn {args} {
	global var_sn STARTTIME FINISHTIME TPVER StationName
	global demo TEST_PC


	#Accton SFIS Kevin
	set ::MES_CHKIN_CLIENT_FN "[pwd]/tmp/Ccheckin.ini"
	set ::MES_CHKIN_SERVER_FN "[pwd]/tmp/Scheckin.ini"
	set ::MES_RESULT_CLIENT_FN "[pwd]/tmp/CResult.ini"
	set ::MES_RESULT_SERVER_FN "[pwd]/tmp/SResult.ini"

	file delete $::MES_CHKIN_CLIENT_FN
	file delete $::MES_CHKIN_SERVER_FN
	file delete $::MES_RESULT_CLIENT_FN
	file delete $::MES_RESULT_SERVER_FN
	
#	if {0} {
#		$::wsobj GroupName [_f_vini_profilerd SFIS ws_id]
#		$::wsobj Operator [_f_vini_profilerd SFIS operator_id]
#		$::wsobj LineNo [_f_vini_profilerd SFIS line]
#	}



#	set ::MesTestResultAddIn "" ;# Ê≠§Ë??∏ÁÇ∫‰∏ÄÂ∑®È??á‰ª§ , ??Basedata of TestResult ÂÆåÊ???, ?v??∂Â??ÑÂ±¨‰π?data ?óÂÖ• ‰∏äÂÇ≥ MES database Ê∏ÖÂñÆ.
# Ê≠?∏∏?®Ê????çÂ? _f_Mes_Reg_TestResult Â¢ûÂ?‰∏äÂÇ≥Ë≥áÊ?.
#	set ::MesReturn ""
	unset -nocomplain -- ::ThisUID
	;#=====================================================================================================================
	profilewr $::MES_CHKIN_CLIENT_FN 	SyncData	TYPE 			Check-In
	profilewr $::MES_CHKIN_CLIENT_FN 	SyncData	DunsNo 		[$::wsobj DunsNo]
	profilewr $::MES_CHKIN_CLIENT_FN 	SyncData	MFGSITE 	[$::wsobj MFGSite]
	profilewr $::MES_CHKIN_CLIENT_FN 	SyncData	SIM 			OFF
	;#=====================================================================================================================


	if { $demo == 1} {
		puts "test"
		profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  SN 				"0162122010004532"
		set temp_StationName "P/T"
	} else {
		puts "test2"
		profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  SN 				$var_sn
		set temp_StationName $StationName 
	}
	
#	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  SN 				$var_sn
		
#	if {[string len [_f_vini_profilerd SFIS MAC]] > 0} {
#		;;# ?≤Â? check MAC ?ÑÁ¢∫??12 Byte ?∑Â∫¶ & 16 ?≤Âà∂ .
#		if {([string len [_f_vini_profilerd SFIS MAC]] != 12) || ([string is xdigit [_f_vini_profilerd SFIS MAC]]==0)} {
#			usermsg "mac address len != 12 <[_f_vini_profilerd SFIS MAC]>. please ask TA team for check" ;
#			vwait xxx ;
#		}
#		profilewr $::MES_CHKIN_CLIENT_FN 	 CheckIn  MAC_START		[_f_vini_profilerd SFIS MAC]
#		#profilewr $::MES_CHKIN_CLIENT_FN CheckIn  MAC_END	[Output_Mac_convstr_JmpNo [_f_vini_profilerd SFIS MAC] "" [expr [_f_vini_profilerd SFIS mac_qty]-1]]
#	}



	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	PN    			$::PN ;#F0OML8120000A
	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	OP 					[$::wsobj Operator]
	if { $StationName  == "FT" } {
		profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	WSID				"F/T"; #[$::wsobj GroupName]
	} else {
		profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	WSID				"$temp_StationName"; #[$::wsobj GroupName]
	}
	#profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	WSID				"$temp_StationName"; #[$::wsobj GroupName]

	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	LINE				[$::wsobj LineNo]
	#	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn		RACK_ID	   	aaa
	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn		TEST_PC	   	$::TEST_PC
	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn		TEST_PC_IP 	[string map { " " + } [lsearch -all -inline -not -exact [::twapi::get_ip_addresses] 127.0.0.1]]
	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	TPVER				$::TPVER
	#kevin
	if { $::StationName == "PT3" && $::Accton_SFIS == 1 } { 
		profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	MAC_START				$::MAC_START
		profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	MAC_END				$::MAC_END
		profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn  	MAC_ID				$::var_mac
	}
	
	profilewr $::MES_CHKIN_CLIENT_FN 	CheckIn		TIMESYNC		[clock format [clock sec] -format "%Y%m%d%H%M%S"]
	;#=====================================================================================================================
	#profilewr $::MES_CHKIN_CLIENT_FN Fixture  TBD				NA
		
	#	set ::MES_CHKIN_CLIENT_FN "[pwd]/tmp/Ccheckin1.ini"
	set ch [open $::MES_CHKIN_CLIENT_FN r]
	fconfigure $ch -encoding big5
	set ::MesChkInIniBox [read $ch]
	close $ch


	puts $::MesChkInIniBox
	
	
	;#=====================================================================================================================
	if { [_f_WebServiceSini_V2 $::MesChkInIniBox ::MesReturn] ==0 } {
		#_f_Client_SelectUI "WebService Server Err\n<RetryAgain>\n$::MesReturn" PassOnly
		;# Â∞±Â? Shop Floor ‰∏ÄÊ®?. Return 0 ?ûÂà∞ ‰∏ªÁ?Âº?ËÆ?User ?Ø‰ª•?çÂà∑ ??check-in.
		puts "step1"
		return 0;
	}

	;#=====================================================================================================================
	set ch [open $::MES_CHKIN_SERVER_FN w]
	fconfigure $ch -encoding big5
	puts $ch $::MesReturn
	close $ch
	;#=====================================================================================================================
	#_f_termmsg_V1 $::MesReturn
	puts $::MesReturn
	;##=================================================================
	;##	?àÊ™¢?•Áî¢Ê∏¨Á?ÂºèÁ???
	;##=================================================================
#	if { $ChkVer } {
#		set TPVER [profilerd $::MES_CHKIN_SERVER_FN CheckIn TPVER]
#		if { [string first PASS "[lindex [split $TPVER ,] 1]"] == -1} {
#			catch {
#				set sopcode [profilerd $::MES_CHKIN_SERVER_FN CheckIn sopcode]
#				if {$sopcode == ""} {set sopcode N/A}
#				$::wsobj CallUIException "DUT::$::DUT_Num\n$::MesReturn" $sopcode [$::wsobj DunsNo]
#			}
#			#_f_Client_SelectUI "TPVER is invalided with database <$TPVER>,Please Check With System or RD-TA Engineer" PassOnly
#			;# ??shop = Enable , ?vé°?ñÁ?Âºè‰∏≠Ê≠?.
#			if {[_f_vini_profilerd SFIS shop_floor]} {exit}
#			_f_termmsg_V1 "Test Program Ver is invalided,that can't be found in server\n<$TPVER>\nNow is Debug Mode\nLet Test Program Keep going. \nWhen Shop Floor Enable , test program will be terminated before this message"
#		} else {
#			_f_termmsg_V1 "Test Program Ver is valided, that had sync with server\n<$TPVER>"
#		}
#	}
	;##=================================================================
	;##	Ê™¢Êü• SN , MAC_START , PN , OP , WSID , LINE , and Final STATUS == PASS
	;##=================================================================
	foreach keychk {SN,1 MAC_START,0 PN,1 OP,1 WSID,1 LINE,1 STATUS,1} {
		set index_split [lindex [split $keychk ,] 1]
		set keychk [lindex [split $keychk ,] 0]
		set keyvalue [profilerd $::MES_CHKIN_SERVER_FN CheckIn $keychk]
		if { [string first PASS "[lindex [split $keyvalue ,] $index_split]"] == -1} {
			if {[profilerd "[pwd]\\setup.ini" SFIS shop_floor] == "1"} {
			#	catch {
			#		set sopcode [profilerd $::MES_CHKIN_SERVER_FN CheckIn sopcode]
			#		if {$sopcode == ""} {set sopcode N/A}
			#		$::wsobj CallUIException "DUT::$::DUT_Num\n$::MesReturn" $sopcode [$::wsobj DunsNo]
			#	}
				#	_f_termmsg_V1 "$keychk Check-In Fail <$keyvalue>"
				#	_f_Client_SelectUI "$keychk Check-In Fail <$keyvalue>" PassOnly
				return 0
			} else {
				#	_f_termmsg_V1 "$keychk Check-In Fail <$keyvalue>\nNow is Debug Mode,<SFIS=0>..bypass checking"
				#	_f_Client_SelectUI "$keychk Check-In Fail <$keyvalue>" PassOnly
			}
		}
	}
	

	
	if {[profilerd "[pwd]\\setup.ini" SFIS shop_floor] == "1"} {
		#	_f_termmsg_V1 "All SN , MAC_START , PN , OP , WSID , LINE , and Final STATUS Check-In .....PASS"
	}
	set ::ThisUID [profilerd $::MES_CHKIN_SERVER_FN SyncData UID]
	puts "ThisUID =$::ThisUID"
	if {[string len $::ThisUID]<36} {
		puts "check in debug.. 1"
		#	errormsg "Server Feedback UID len < 36\n"
		vwait xxx
	}
	puts "==========================================================================================================="
	puts "Get UID:$::ThisUID"
	puts "Get TIMESYNC:[profilerd $::MES_CHKIN_SERVER_FN CheckIn	TIMESYNC]"
	puts "==========================================================================================================="
	#	_f_termmsg_V1 "Get UID:$::ThisUID\nGet TIMESYNC:[profilerd $::MES_CHKIN_SERVER_FN CheckIn	TIMESYNC]"
	set ServerTime [regsub {(....)(..)(..)(..)(..)(..)} [profilerd $::MES_CHKIN_SERVER_FN CheckIn	TIMESYNC] {\1/\2/\3 \4:\5:\6}]
	#	set diffsec [expr abs([_f_date_time_diff $ServerTime])]
	if { 0 } {
		if { $::DUT_Num ==1 &&  $diffsec > 10} {
			puts "Time Diff ($diffsec) more then 10 sec"
			set p1 [open "|cmd /c date [lindex $ServerTime 0] " r+]
			close $p1
			sleep 500
			set p1 [open "|cmd /c time [lindex $ServerTime 1] " r+]
			close $p1
			#::twapi::create_process c:/tmp/cmd.exe -cmdline [list /C time [lindex $ServerTime 1]]
			#::twapi::create_process c:/tmp/cmd.exe -cmdline [list /C date [lindex $ServerTime 0]]
			set hhmmss [lindex $ServerTime 1]
			#usermsg "hhmmss=$hhmmss"
			if {[regexp {23:59:5\d} $hhmmss]} {
				;# ?•Ê??ìÊñº 23:59:5x . ?∫ÈÅø??. CPU loading Âª∂ÈÅ≤ Â∞éËá¥ 23:59:59 Ë®≠Â? ?•Ê???. ?Ä?†Ê????∞Â∏∏ . Â∞???10 Áß?Ë¶ñÁÇ∫ . Á¶ÅÂ?.
				;# ?•ÈÄ≤ÂÖ•?∞Á??Ä . ?áÁ?ÂºèËá™?ïÈÄ≤ÂÖ• ?ûÂ? Ê®°Â? . ?¥Âà∞ . ?øÈ?Ê≠§Â?ÊÆ?Á¶ÅÂ?.
				return [_f_MesShopFlowCheckIn $args]
			}
			usermsg "Time Diff more then 10 sec , Had been Set to $ServerTime Already"
		}
	}


	return 1
}
;############################################################################
;# PROCEDURE NAME - _f_MesShopFlowUploadResultLog {}
;#-------------------------------------------------------------------------Ver:0U
;# DESCRIPTION: ?èÈ? webservice ?ïÁ? CheckIn ÂæåÁ?,Ë≥áÊ?‰∏äÂÇ≥ ?ï‰?.
;#              ?∂Âü∑Ë°åÊ≠§ function , Á®ãÂ??yÄèÈ? ?∫Êú¨ ??sfis Ë≥áÊ?. Â≠òÊîæ??visual ini Ë£?
;#              ?≤Ë? È°û‰ººinifile?ÑÂ?‰∏≤Ë????çÈÄèÈ? Accton MIS ?ê‰? ??COM ?tª∂.?≤Ë?,Ë≥áË?‰∏äÂÇ≥.
;# EXAMPLE : _f_MesShopFlowUploadResultLog
;# RETURN: None
;############################################################################
proc _f_MesShopFlowUploadResultLog {sResult} {
	global AccWS_log_path TEST_PC var_Zmac StationName
	set ::capturefilename $AccWS_log_path
	
	if {$::WEB_SERVICE == 0} {return 1}
	set ::MesReturn ""
	if {[profilerd "[pwd]\\setup.ini" SFIS shop_floor] == "1"} {set sfis Y} else {set sfis N}
	#set ::MES_RESULT_CLIENT_FN "c:/tmp/[_f_vini_profilerd SFIS SN]_[string map { / "" " " "" : "" } [_f_vini_profilerd SFIS start_time]]_$::DUT_Num\_$sfis\_\(Result_Client).ini"
	#set ::MES_RESULT_SERVER_FN "c:/tmp/[_f_vini_profilerd SFIS SN]_[string map { / "" " " "" : "" } [_f_vini_profilerd SFIS start_time]]_$::DUT_Num\_$sfis\_\(Result_Server).ini"
	set ::MES_RESULT_CLIENT_FN "[pwd]/tmp/CResult.ini"
	set ::MES_RESULT_SERVER_FN "[pwd]/tmp/SResult.ini"

	;#=====================================================================================================================

	profilewr $::MES_RESULT_CLIENT_FN SyncData		TYPE 		TestResult/TestLog 
	#profilewr $::MES_RESULT_CLIENT_FN SyncData		ID			[_f_vini_profilerd WebService ID]
	#profilewr $::MES_RESULT_CLIENT_FN SyncData 	PWD 		[_f_vini_profilerd WebService PWD]
	profilewr $::MES_RESULT_CLIENT_FN SyncData 		DunsNo 	[$::wsobj DunsNo]
	profilewr $::MES_RESULT_CLIENT_FN SyncData 		MFGSITE [$::wsobj DunsNo]
	profilewr $::MES_RESULT_CLIENT_FN SyncData 		SIM 		OFF
	profilewr $::MES_RESULT_CLIENT_FN SyncData 		UID 		$::ThisUID
	
	;#=====================================================================================================================
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	SN 					[_f_vini_profilerd CheckIn SN]
	if {[string len [_f_vini_profilerd SFIS MAC]] > 0} {
		#profilewr $::MES_RESULT_CLIENT_FN TestResult  	MAC_START	[_f_vini_profilerd CheckIn MAC]
		#profilewr $::MES_RESULT_CLIENT_FN TestResult  	MAC_END		[Output_Mac_convstr_JmpNo [_f_vini_profilerd SFIS MAC] "" [expr [_f_vini_profilerd SFIS mac_qty]-1]]
	}
	#profilewr $::MES_RESULT_CLIENT_FN TestResult  	BOARD_PN    [_f_vini_profilerd SFIS part_no]
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	PN    			$::PN ;#"NI2D88632002E"
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	MODEL_NAME  "AcctonTestAutomation" ;#	[_f_vini_profilerd MYSQL MODELNAME]
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	MODELNO  		"AcctonTestAutomation" ;#[_f_vini_profilerd MYSQL MODELNAME]
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	OP 					[$::wsobj Operator]

	profilewr $::MES_RESULT_CLIENT_FN TestResult  	LINE	    	[$::wsobj LineNo]
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	SHIFT	    	[$::wsobj ShiftNo]
	#profilewr $::MES_RESULT_CLIENT_FN TestResult 	DUT_NUM			$::DUT_Num
	
	#puts "ServerÁ´ØËá™?ïÊõ¥??
	profilewr $::MES_RESULT_CLIENT_FN TestResult		UPDATETIME			"ServerAutoUpdate"
	profilewr $::MES_RESULT_CLIENT_FN TestResult		CREATEDATETIME	"ServerAutoUpdate"
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	TEST_PC	   			$::TEST_PC
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	TEST_PC_IP			[string map { " " + } [lsearch -all -inline -not -exact [::twapi::get_ip_addresses] 127.0.0.1]]
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	TPVER						$::TPVER
	if { $::StationName == "PT1" } {
	 profilewr $::MES_RESULT_CLIENT_FN TestResult  	_TMOEXT2        $::var_Zmac
	}
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	STARTTIME				$::STARTTIME 
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	FINISHTIME			$::FINISHTIME
#		profilewr $::MES_RESULT_CLIENT_FN TestResult  	RACK_ID	   			[_f_vini_profilerd SFIS rack_id]
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	SFIS	    			"1"
#[_f_vini_profilerd SFIS shop_floor]
	$::wsobj SFISFlag [_f_vini_profilerd SFIS shop_floor]
	#profilewr $::MES_RESULT_CLIENT_FN TestResult  	WSID	    			[$::wsobj GroupName]
	if { $StationName  == "FT" } {
		profilewr $::MES_RESULT_CLIENT_FN TestResult  	WSID	    			"F/T"
	} else {
		profilewr $::MES_RESULT_CLIENT_FN TestResult  	WSID	    			[$::wsobj GroupName]
	}
	profilewr $::MES_RESULT_CLIENT_FN TestResult  	RESULT					"$sResult" ;
	
	if 	{ "[_f_vini_profilerd SFIS result]" != "PASS" } {
#		profilewr $::MES_RESULT_CLIENT_FN TestResult  	ERR_DESC		[string map {\r * \n * , * \t *} $::s0]
#		profilewr $::MES_RESULT_CLIENT_FN TestResult  	ERR_ID	    $::ErrorCode
	}
	profilewr $::MES_RESULT_CLIENT_FN TestResult	LOGFILENAME		[file tail $::capturefilename]
#	profilewr $::MES_RESULT_CLIENT_FN TestResult  	LOG_PATH_FN		[_f_get_ftp_log]
	#profilewr $::MES_RESULT_CLIENT_FN TestResult  	LOT_NO	    	[_f_vini_profilerd SFIS lot_no]
	#profilewr $::MES_RESULT_CLIENT_FN TestResult  	OPERATOR_ID	    [_f_vini_profilerd SFIS operator_id]

	#profilewr $::MES_RESULT_CLIENT_FN TestResult 	MINOR_VER		[_f_RetMinorChangeVerDetail]
	#profilewr $::MES_RESULT_CLIENT_FN TestResult 	VER_HISTORY		[_f_ModifiedUser]

	;# ?∫Ë? TMO ?ÑÁâπÊÆäÊ?‰Ω?, ?ΩÁπºÁ∫åÂÇ≥???πÂà•??MIS Deal Â•? Â∞?::other_field ?ÜÂà•?ÅÂá∫.
	#foreach ext [split $::other_field ,] {
	#	incr ext_i
	#	if {[string length $ext] >= 1} {
	#		profilewr $::MES_RESULT_CLIENT_FN TestResult _TMOEXT$ext_i	$ext
	#		puts "_TMOEXT$ext_i=$ext"
	#	}
	#}
	
#		eval $::MesTestResultAddIn
	;#=====================================================================================================================
	;#?àÊ? Log ËÆÄ??
	;#=====================================================================================================================

	set logch [open "$::capturefilename" r]
	set logbox [read $logch]
	close $logch
	profilewr $::MES_RESULT_CLIENT_FN TestLog  		BYTES		[string len $logbox]
	;#=====================================================================================================================
	;#Â∞?Log Â°ûÂà∞ INIFILE ?ÑÊ?ÂæåÊÆµ
	;#=====================================================================================================================
	set ch [open $::MES_RESULT_CLIENT_FN r+]
	fconfigure $ch -encoding big5
	read $ch
	puts $ch "\nContent=\n$logbox"
	close $ch
	;#=====================================================================================================================
	;#?çÊ¨°??Ê™îÊ?ËÆÄ??::MesResult_Log
	;#=====================================================================================================================
	#Kevin
	#set ::MES_RESULT_CLIENT_FN "[pwd]/tmp/CResult1.ini"
	set ch [open $::MES_RESULT_CLIENT_FN r]
	fconfigure $ch -encoding big5
	set ::MesResult_Log [read $ch]
	close $ch
	;#=====================================================================================================================
	puts "==========================================================================================================="
	puts $::MesResult_Log
	puts "==========================================================================================================="
	
	if { [_f_WebServiceSini_V2 $::MesResult_Log ::MesReturn] == 0 } {
	#	errormsg "_f_MesShopFlowUploadResultLog System Fail"
		vwait xxx
		return 0
	}
	;#=====================================================================================================================
	;#?äServer ?ûÊ? ::MesReturn ÂØ´ÂÖ• Á°¨Ë? C:/tmp ::MesResult_Log
	;#=====================================================================================================================
	set ch [open $::MES_RESULT_SERVER_FN w]
	fconfigure $ch -encoding big5
	puts $ch $::MesReturn
	close $ch
	;#=====================================================================================================================		
	puts <<$::MesReturn>>
	if {[_f_vini_profilerd SFIS shop_floor]} {
	if { [string first PASS [profilerd $::MES_RESULT_SERVER_FN "TestResult" STATUS]] < 0 } {
			catch {
				set sopcode [profilerd $::MES_RESULT_SERVER_FN TestResult sopcode]
				if {$sopcode == ""} {set sopcode N/A}
				$::wsobj CallUIException "DUT::$::DUT_Num\n$::MesReturn" $sopcode [$::wsobj DunsNo]
			}		
			errormsg "_f_MesShopFlowUploadResultLog No PASS Detect\n$::MesReturn"
			vwait xxx
			return 0
		}
		if { [string first PASS [profilerd $::MES_RESULT_SERVER_FN "TestLog" STATUS]] < 0 } {
			catch {
				set sopcode [profilerd $::MES_RESULT_SERVER_FN TestLog sopcode]
				if {$sopcode == ""} {set sopcode N/A}
				$::wsobj CallUIException "DUT::$::DUT_Num\n$::MesReturn" $sopcode [$::wsobj DunsNo]
			}		
		errormsg "_f_MesShopFlowUploadResultLog No PASS Detect\n$::MesReturn"
		vwait xxx
		return 0
	}
	}
	puts "==========================================================================================================="
	puts "Send Result&Log"
	puts "==========================================================================================================="
#		_f_termmsg_V1 "Send MES Result&Log..Finish"
	
	;#=====================================================================================================================
	;#Â∞?>72 Hr ?ÑË?Ê™??ΩÁ???
	;#=====================================================================================================================

#		set mesfnlist [glob c:/tmp/*.ini]
#		foreach fl $mesfnlist {
#			set fctime [file mtime $fl]
#			set fctgap [expr [clock seconds]-$fctime]
#			;#?äÊ?Ë∂ÖÈ?72Hr ?¥Êé•?ç‰?.
#			if {$fctgap > [expr 72 * 60 * 60]} { 
#				catch {file delete -force -- $fl}
#			}
#		}
	return 1
		
}
	
;############################################################################
;# PROCEDURE NAME - _f_Mes_Reg_TestResult {key value}
;#-------------------------------------------------------------------------Ver:0U
;# DESCRIPTION: ?èÈ? _f_Mes_Reg_TestResult ??unction,‰æÜÂ?Áæ©È?Â§??ÑË???
;#              ?∂Âü∑Ë°å_f_MesShopFlowUploadResultLog???v??ô‰?È°çÂ??ÑË??Ø‰?‰ΩµÈÄÅ‰? MES server.
;# EXAMPLE : _f_Mes_Reg_TestResult
;# RETURN: None
;############################################################################
proc _f_Mes_Reg_TestResult {key value} {
	append ::MesTestResultAddIn "\r\nprofilewr \$::MES_RESULT_CLIENT_FN TestResult \{$key\} \{$value\}"
}
;############################################################################
;# PROCEDURE NAME - _f_RetMinorChangeVerDetail {}
;#-------------------------------------------------------------------------Ver:0U
;# DESCRIPTION: ?ûÂÇ≥‰∏ÄÂ≠ó‰∏≤,?∫[Fool Proof] Ë£°Ê??çÊé®?ûÂéª??hecksumÂª∫Á??ÇÈ?Ë≥áË?.
;# EXAMPLE : _f_Mes_Reg_TestResult
;# RETURN: ?ûÂÇ≥‰∏ÄÂ≠ó‰∏≤,?∫[Fool Proof] Ë£°Ê??çÊé®?ûÂéª??hecksumÂª∫Á??ÇÈ?Ë≥áË?.
;############################################################################
proc _f_RetMinorChangeVerDetail {} {
	set 62box "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	set MinorChangeVer [_f_vini_profilerd FoolProof MinorChangeVer]
	set year [expr [string first [string index $MinorChangeVer	0] $62box] + 2010]
	set week [expr [string first [string index $MinorChangeVer	1] $62box]]
	set Date [expr [string first [string index $MinorChangeVer	2] $62box]]
	set Hour [format %02d [expr [string first [string index $MinorChangeVer	3] $62box]]]
	set Min [format %02d [expr [string first [string index $MinorChangeVer	4] $62box]]]
	switch $Date {
		"1" {set Date1 "Mon"}
		"2" {set Date1 "Tue"}
		"3" {set Date1 "Wed"}
		"4" {set Date1 "Thu"}
		"5" {set Date1 "Fri"}
		"6" {set Date1 "Sat"}
		"0" {set Date1 "Sun"}
		default {set Date1 "Unknow"}
	}
	return "<$MinorChangeVer>$year@$week\(Weeks\).on.$Date1.$Hour:$Min"
}
;############################################################################
;# PROCEDURE NAME - _f_ModifiedUser {}
;#-------------------------------------------------------------------------Ver:0U
;# DESCRIPTION: ?ûÂÇ≥‰∏ÄÂ≠ó‰∏≤,?∫[Fool Proof] Ë£°Ê??âË¢´‰øùË≠∑??nifile section,‰ΩúËÄÖË???
;# EXAMPLE : _f_ModifiedUser
;# RETURN: ?ûÂÇ≥‰∏ÄÂ≠ó‰∏≤,?∫[Fool Proof] Ë£°Ê??âË¢´‰øùË≠∑??nifile section,‰ΩúËÄÖË???
;############################################################################
proc _f_ModifiedUser {} {
	set secauther ""
	foreach section [linsert [split [_f_vini_profilerd FoolProof EditSection] ,] end [split [_f_vini_profilerd FoolProof FreezeSection] ,] ] {
		if {"$section"==""} {continue;}
		append secauther <[_f_vini_profilerd $section Auther]\[$section\]>
	}
	return $secauther
}


;############################################################################
;# PROCEDURE NAME - _f_get_ftp_log {}
;#-------------------------------------------------------------------------Ver:0W
;# DESCRIPTION: ?ûÂÇ≥‰∏ÄÂ≠ó‰∏≤,?∫[Fool Proof] Ë£°Ê??âË¢´‰øùË≠∑??nifile section,‰ΩúËÄÖË???
;# EXAMPLE : _f_get_ftp_log
;# RETURN: ?ûÂÇ≥‰∏ÄÂ≠ó‰∏≤,?∫[Fool Proof] Ë£°Ê??âË¢´‰øùË≠∑??nifile section,‰ΩúËÄÖË???
;############################################################################
proc _f_get_ftp_log {{FTP_Server_tmp {1}}} {
	set FTP_Log_Tag ""
	set Local_logfile $::capturefilename
	while {1} {
		incr i		
		
		set FTP_Server_num [midtok $FTP_Server_tmp "," $i-1]

		if { [strlen $FTP_Server_num] == 0 } {
			break
			#set FTP_Server_num $i
		}
		
		set S8 [format %02d_Upload_FTP $FTP_Server_num]
		set S1 [format %02d_FTP_Address $FTP_Server_num]
		set S2 [format %02d_FTP_Username $FTP_Server_num]
		set S3 [format %02d_FTP_Password $FTP_Server_num]
		set S6 [format %02d_FTP_TYPE $FTP_Server_num]
		
		set FTP_Address [_f_vini_profilerd "FTP Log Server Setup" $S1]
		set FTP_username [base64::decode [_f_vini_profilerd "FTP Log Server Setup" $S2]]
		set FTP_password [base64::decode [_f_vini_profilerd "FTP Log Server Setup" $S3]]
		set FTP_TYPE [_f_vini_profilerd "FTP Log Server Setup" $S6]
		
		# ‰ª?°®Â∑≤Á??ØÊ?Âæå‰??∞server
		if {[strlen $FTP_Address]==0 && [strlen $FTP_username]==0 && [strlen $FTP_password]==0 && [strlen $FTP_TYPE]==0} {
			break;
		}
		
		# NÊ∏?Disable, by pass this FTP server
		if { [strfind [_f_vini_profilerd "SFIS" "shop_floor"] "0"] } {
			if { [strfind [_f_vini_profilerd "FTP Log Server Setup" $S8] "DISABLE"] } {
				
				continue;
			}
		}
		
		if { [strlen $FTP_Log_Tag] == 0 } {
			set S4 [format %02d_FTP_Log_path $FTP_Server_num]
			set S5 [format %02d_FTP_Log_filename $FTP_Server_num]
		} else {
			set S4 [format %02d_FTP_Log_path_<%s> $FTP_Server_num $FTP_Log_Tag]
			set S5 [format %02d_FTP_Log_filename_<%s> $FTP_Server_num $FTP_Log_Tag]
		}
		
	
		if { [strfind [_f_vini_profilerd "FTP Log Server Setup" $S4] "N/A"] } {
			continue;
		}
		
		set FTP_Log_path [modify_LogPath_for_FTP_use $S4 $FTP_Server_num]
		set _FTP_Log_name [modify_LogName_for_FTP_use $S5 $Local_logfile $FTP_Server_num]
	}
	if { [info exists _FTP_Log_name] } {
		set FTP_Log_name $_FTP_Log_name
		return "$FTP_TYPE://$FTP_Address/$FTP_Log_path/$FTP_Log_name"
	} else {
		return "FTP Log Disable"
	}
}
#============================ ‰ª•‰?  ?ÖÁÇ∫?´Â? ?™ÂØ¶??==================================================================================================================
;############################################################################
;# PROCEDURE NAME - _f_Mes_Query_Assy_Data {SN}
;#-------------------------------------------------------------------------Ver:0w
;# DESCRIPTION: ?èÈ? webservice ?ïÁ? ??SN ?æÂ? ?Ä?âÊõæÁ∂ìÈÄÅÈ???[TestResult]
;############################################################################
proc _f_DataQuerryTestResult {SN} {
	#set SN BB0211X46199
	$::wsobj QueryDataSelect [$::wsobj DunsNo] "Select a.* from sfism4.r_test_result_detail a, sfism4.r_test_result b where a.guid = b.guid and b.serial_number = '$SN'"
	for {set i 0} {$i<[$::wsobj GetCount]} {incr i} {
		set testitem [$::wsobj GetRecord $i TEST_ITEM]
		set testvalue [$::wsobj GetRecord $i TEST_VALUE]
		set guid [$::wsobj GetRecord $i GUID]
		puts $guid,$testitem,$testvalue
	}
}
;############################################################################
;# PROCEDURE NAME - _f_vini_sync_SN_via_MAC {PnList}
;#-------------------------------------------------------------------------Ver:0w
;# DESCRIPTION: 	?èÈ? _f_Mes_Query_SN_PN ?¥Êñ∞ vini Ë£°Èù¢??SN.
;#              	ÂøÖË?Ê¢ù‰ª∂ : vini SFIS Ë£°Èù¢??MAC ?Ä?∫Ê??õÂ∑±??
;# Param:
;#           $PnList : ?∫‰???List ?ÑË??ôÁ?Êß??ØÁÇ∫ ?ÆÊï∏?ñË??∏ÂÄã‰ª•‰∏??àhit?∞Á??∫Â°—??
;# EXAMPLE :  _f_vini_sync_SN_via_MAC "C0P9J4614001A C0P9J4614001B C0P9J4614001C"
;# RETURN: 0 -> Ë°®Á§∫ ?•Á?‰ªª‰?Ë≥áÊ?.
;#         1 -> Ë°®Á§∫ ?êÂ?ÁΩÆÊ? vini->[SFIS]->MAC
;############################################################################
proc _f_vini_sync_SN_via_MAC { PnList } {
	set mac [string toupper [_f_vini_profilerd SFIS MAC]]
	if {[string len $mac] != 12} {usermsg "vini SFIS MAC len != 12 , Please check RD-TA" ; vwait yyy ;}
	if {[_f_Mes_Query_SN_PN $mac DataQueryOutput]} {
		foreach {PN SN} $DataQueryOutput {
			if {[lsearch $PnList $PN] >=0} {
				_f_vini_profilewr SFIS SN $SN
				if {[string len $SN] < 1} {usermsg "SN len < 1" ; vwait yyy ;}
				puts "hit PN=$PN , SN=$SN , MAC=$mac"
				return 1
			}
		}
		
	} else {
		return 0
	}
}
;############################################################################
;# PROCEDURE NAME - _f_Mes_Query_SN_PN {MAC DQO}
;#-------------------------------------------------------------------------Ver:0w
;# DESCRIPTION: ?èÈ? webservice ?ïÁ? ??MAC ?æÂ? ?Ä?≥Ê??ÑÁ????ÖÂê´ PN & MAC
;#              Ë´ãÊ≥®?? ?•Áï∂ N = C  = P = F ??. S/N ?Ω‰??¥Ê? . ?ÖÊ??æÂà∞‰∏ÄÁµ?S/N.
;#              ??N   ?éÁ??üÂ?   ?ÆÂ?Ê≠?S/N Ê≠?•Ω??C ???áÊ??æÂà∞ (1)N?éPN & N?éSN (2)C?éPN & C?éSN (‰∏Ä?¨Áî¢Ê∏???SFIS=Y ?ΩÁÇ∫Ê≠§Ê?‰æ?
;# 		        ??N,C ?éÈMÁµêÊ?Âæ??ÆÂ?Ê≠?S/N Ê≠?•Ω??P ???áÊ??æÂà∞ (1)N?éPN & N?éSN (2)P?éPN & P?éSN (‰∏Ä?¨Áî¢Ê∏?È©óË??êÁ? S/N ,?Ä?y?Ë©≤Â????ÆÂ??ÑÊ?Á®ãÁÇ∫‰ΩïË?)
;# 	            $MAC : MAC address 12Bytes
;#              $DQO : ?∫‰??ãÂÇ≥?Ä?ÑË???, List ??Query Ë≥áÊ??êÂ?Âæ?.?tª• ‰∫åÂÄ??w? {PN} {SN} ?∫‰?Áµ?List ?ûÂÇ≥.
;# EXAMPLE : _f_Mes_Query_SN_PN
;#           _f_DataQuerry
;# RETURN: 0 -> Ë°®Á§∫ ?•Á?‰ªª‰?Ë≥áÊ?.
;#         1 -> Ë°®Á§∫ ?≥Â??â‰?ÁµÑ‰ª•‰∏äÁ?Ë≥áÊ?.
;############################################################################
proc _f_Mes_Query_SN_PN {MAC DQO} {
	upvar $DQO dataquery 
	#set MAC 78FE3D452940
	#set MAC 78FE3D4ABFC0
	set dataquery ""
	$::wsobj QueryDataSelect [$::wsobj DunsNo] "select serial_number,key_part_no from sfism4.r_wip_tracking_t where mac_id = '$MAC'"
	for {set i 0} {$i<[$::wsobj GetCount]} {incr i} {
		set serial_number [$::wsobj GetRecord $i serial_number]
		set key_part_no [$::wsobj GetRecord $i key_part_no]
		puts "$MAC Used by (PN=$key_part_no , SN=$serial_number)"
		lappend dataquery $key_part_no $serial_number
	}
	if {$i >=1} {return 1} else {return 0}
}
;############################################################################
;# PROCEDURE NAME - _f_Mes_Query_Assy_Data {SN DQO}
;#-------------------------------------------------------------------------Ver:0w
;# DESCRIPTION: ?èÈ? webservice ?ïÁ? ??C-??S/N ?æÂ? ?Ä????ÁµÑÁ??éÊÆµ ???Ä??S/N , P/N ??MAC
;# 	            $SN : MAC address 12Bytes
;#              $DQO : ?∫‰??ãÂÇ≥?Ä?ÑË???, List ??Query Ë≥áÊ??êÂ?Âæ?.?tª• ‰∏âÂÄ??w? {SN} {PN} {MAC}  ?∫‰?Áµ?List ?ûÂÇ≥.
;#                     ???°MAC ?∫Ê?‰ª?Â≠ó‰∏≤ "NO_MAC" ?ûÂÇ≥
;############################################################################
proc _f_Mes_Query_Assy_Data {SN DQO} {
	upvar $DQO dataquery
	#set SN 0162012011002792
	$::wsobj QueryDataSelect [$::wsobj DunsNo] "select serial_number,key_part_no,key_part_sn from SFISM4.r_wip_keyparts_t where serial_number='$SN'"
	set SNBOX ""
	for {set i 0} {$i<[$::wsobj GetCount]} {incr i} {
		#set serial_number [$::wsobj GetRecord $i serial_number]
		set key_part_no [$::wsobj GetRecord $i key_part_no]
		set key_part_sn [$::wsobj GetRecord $i key_part_sn]
		#puts "C.SN=$SN , N.PN=$key_part_no N.SN=$key_part_sn"
		lappend SNBOX $key_part_sn $key_part_no
	}
	foreach {sn pn} $SNBOX {
		$::wsobj QueryDataSelect [$::wsobj DunsNo] "select mac_id from sfism4.r_wip_tracking_t where serial_number = '$sn'"
		set mac_id NO_MAC
		if {[$::wsobj GetCount]==1} {
			set mac_id [$::wsobj GetRecord 0 mac_id]
		}		
		puts "rootSN=$SN, SubSN=$sn,PN=$pn,MAC=$mac_id"
		lappend dataquery $sn $pn $mac_id
	}
}
proc _f_DataQuerry {} {

	set batch_per_lot 100
	set cycle 0
	while {1} {
		incr cycle
		# $::wsobj QueryDataSelect [$::wsobj DunsNo] "
		# Select * from (
			   # select ROWNUM rno, a.* , b.serial_number from sfism4.r_test_result_detail a, sfism4.r_test_result b
			   # where a.guid = b.guid and a.TEST_ITEM like '_CPK_%' and b.PN = 'CIU9J3308006E'
		# )
		# where rno between 0 and 1000"	
		$::wsobj QueryDataSelect [$::wsobj DunsNo] "
			Select * from (
				select ROWNUM rno, a.* , b.serial_number from sfism4.r_test_result_detail a, sfism4.r_test_result b 
				where a.guid = b.guid and ( a.TEST_ITEM like '_CPK_%' or a.TEST_ITEM = 'RESULT' or a.TEST_ITEM ='LOGFILENAME' or a.TEST_ITEM ='LOG_PATH_FN')and b.PN = 'CIU9J3308006E' 
			)
			where rno between [expr $batch_per_lot * ($cycle-1)] and [expr ($batch_per_lot * $cycle)]"
		#$::wsobj QueryDataSelect [$::wsobj DunsNo] "Select a.* , b.serial_number from sfism4.r_test_result_detail a, sfism4.r_test_result b where a.guid = b.guid and a.TEST_ITEM like '_CPK_%' and b.PN = 'CIU9J3308006E'"
		for {set i 0} {$i<[$::wsobj GetCount]} {incr i} {
			set testitem [$::wsobj GetRecord $i TEST_ITEM]
			set testvalue [$::wsobj GetRecord $i TEST_VALUE]
			set serial_number [$::wsobj GetRecord $i serial_number]
			set GUID [$::wsobj GetRecord $i GUID]
			profilewr c:/report.ini $serial_number\_$GUID $testitem $testvalue
			lappend ::QueryBox([list $serial_number\_$GUID]) $testitem $testvalue
			#puts "\([expr (($cycle-1)*$batch_per_lot)+$i]\),$serial_number,$testitem,$testvalue"
		}
		if {$i < $batch_per_lot} {break;}
	}
}


#proc _f_vini_profilerd {file_path ini_section ini_var} {  
#
##	set ::ENVPATH [file dirname [info script]]                                                                
#
#	set buf_temp [ ::twapi::read_inifile_key "$ini_section" "$ini_var" -inifile "$::file_path.ini" -default 0]
#  return $buf_temp
#  
#}

proc profilewr {file_path ini_section ini_var var_val } {
	puts "debug message ...  ini_var =$ini_var ,  var_val =$var_val"                                                          
	set buf_temp [ ::twapi::write_inifile_key "$ini_section" "$ini_var" "$var_val" -inifile "$file_path"]
}

proc _f_vini_profilerd {ini_section ini_var } {

	set buf_temp1 [ ::twapi::read_inifile_key "$ini_section" "$ini_var" -inifile "$::MES_CHKIN_CLIENT_FN" -default 0]
	return $buf_temp1
}

proc profilerd {file_path ini_section ini_var } {

	set buf_temp1 [ ::twapi::read_inifile_key "$ini_section" "$ini_var" -inifile "$file_path" -default 0]
	return $buf_temp1
}


proc _f_date_time_diff {stime } {
	
	set time_temp [expr [clock seconds]-$stime]
	return $time_temp
}




proc configStation {} {
	$::wsobj ConfigStation "Station"
	if {[$::wsobj ErrorMsg] != "" } { 
		set err [$::wsobj ErrorMsg]
		puts $err	
	
	}
}

