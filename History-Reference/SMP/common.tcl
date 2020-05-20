#################################################################################
# 2012/08/10 by Kevin                                                           #
# 01. add video and audio test spec value in setup.ini file.                    #
#                                                                               #
#################################################################################



package require twapi
package require txmbox

set ENVPATH [file dirname [info script]]
set gpib_daq [ ::twapi::read_inifile_key "MOTOTECH" "gpib_daq" -inifile "$ENVPATH/setup.ini" -default 0]
set gpib_scope [ ::twapi::read_inifile_key "MOTOTECH" "gpib_scope" -inifile "$ENVPATH/setup.ini" -default 0]
set console_scope1 [ ::twapi::read_inifile_key "MOTOTECH" "console_scope1" -inifile "$ENVPATH/setup.ini" -default 0] 
set console_scope2 [ ::twapi::read_inifile_key "MOTOTECH" "console_scope2" -inifile "$ENVPATH/setup.ini" -default 0]
set console_port [ ::twapi::read_inifile_key "MOTOTECH" "console_port" -inifile "$ENVPATH/setup.ini" -default 0]
set diag_prompt [::twapi::read_inifile_key "MOTOTECH" "diag_prompt" -inifile "$ENVPATH/setup.ini" -default "#"]
set uboot_prompt [::twapi::read_inifile_key "MOTOTECH" "uboot_prompt" -inifile "$ENVPATH/setup.ini" -default "OMAP3 TA8120A #"]
set sn_prefix [::twapi::read_inifile_key "MOTOTECH" "sn_prefix" -inifile "$ENVPATH/setup.ini" -default 12]
set MSN_LENGTH_Main [::twapi::read_inifile_key "MOTOTECH" "MSN_LENGTH" -inifile "$ENVPATH/setup.ini" -default 9]
set MSN_LENGTH_Acc [::twapi::read_inifile_key "MOTOTECH" "MSN_LENGTH_ACC" -inifile "$ENVPATH/setup.ini" -default 9]
set SwVersion [::twapi::read_inifile_key "MOTOTECH" "SwVersion" -inifile "$ENVPATH/setup.ini" -default "0"]
 
set MAC_START [::twapi::read_inifile_key "MOTOTECH" "MAC_START" -inifile "$ENVPATH/setup.ini" -default "0017BE000001"]
set MAC_END [::twapi::read_inifile_key "MOTOTECH" "MAC_END" -inifile "$ENVPATH/setup.ini" -default "0017BEFFFFFF"]



set sfis_en [::twapi::read_inifile_key "SFIS" "SFIS" -inifile "$ENVPATH/setup.ini" -default 0]
set StationName [::twapi::read_inifile_key "SFIS" "StationName" -inifile "$ENVPATH/setup.ini"]
set ModelName [::twapi::read_inifile_key "SFIS" "ModelName" -inifile "$ENVPATH/setup.ini"]
set TEST_PC [::twapi::read_inifile_key "SFIS" "TEST_PC" -inifile "$ENVPATH/setup.ini"]
set DatabaseName [::twapi::read_inifile_key "SFIS" "DatabaseName" -inifile "$ENVPATH/setup.ini"]
set NVM_DatabaseName [::twapi::read_inifile_key "SFIS" "NVM_DatabaseName" -inifile "$ENVPATH/setup.ini"]
set Accton_SFIS [::twapi::read_inifile_key "SFIS" "Accton_SFIS" -inifile "$ENVPATH/setup.ini"]
set OP_UI [::twapi::read_inifile_key "SFIS" "OP_UI" -inifile "$ENVPATH/setup.ini"]
set TPVER [::twapi::read_inifile_key "SFIS" "TPVER" -inifile "$ENVPATH/setup.ini"]
set PN [::twapi::read_inifile_key "SFIS" "PN" -inifile "$ENVPATH/setup.ini"]
set demo [::twapi::read_inifile_key "SFIS" "demo" -inifile "$ENVPATH/setup.ini" -default 0]


#audio ,video and spdif define
set volt_level_hi_3V3 [::twapi::read_inifile_key "Scope1" "volt_level_hi_3V3" -inifile "$ENVPATH/setup.ini" -default 0]
set volt_level_low_3V3 [::twapi::read_inifile_key "Scope1" "volt_level_low_3V3" -inifile "$ENVPATH/setup.ini" -default 0]
set volt_level_hi_4V3 [::twapi::read_inifile_key "Scope1" "volt_level_hi_4V3" -inifile "$ENVPATH/setup.ini" -default 0]
set volt_level_low_4V3 [::twapi::read_inifile_key "Scope1" "volt_level_low_4V3" -inifile "$ENVPATH/setup.ini" -default 0]



set DebugLine1 "===================Debug Message===================="
set DebugLine2 "====================================================\n"

set ModelNameList [list ESM1014]

switch $ModelName {
	ESM1014 { set StationNameList [list PT ]; \
					 set StationCodeList [list  0x00 ] }
}


# error code for non test item
set errNum [list T101 T102 T103]

# error code for test item
set errNum_item [list E120 E019 E003 E098 E065 \
											E061 E121 E122 E123 E119 \
											E124 E125 E126 E127 E128 \
                      E094 E096 E095 E117 E082 \
                      E118 E016 E100 E017 E129 \
                      E103 E106 E107 E109 E110 \
                      E001 E111 E112 E113 E114 \
                      E097 E005 E037 E036 E006 \
                      E033 E071 E072 E115 E116 \
                      E117 E118 E119 E141 E142 \
                      E021 E130]                        
                      
for {set i 0} {$i < [llength $errNum_item]} {incr i} {
	lappend errNum [lindex $errNum_item $i]
}


# error code value for non test item
set errVariable [list Console ADB WIFI_ADB]

# error code value for test item
set errVariable_item [list SW_Burn Volt UART Param_Setup SerialNumber_Check \
													 MacID_Check ProductName_Check BrandName_Check ModelName_Check BoardName_Check \
													 DeviceName_Check DisplayID_Check HardwareName_Check BuildID_Check ManufacturerName_Check \
                           ButtonPower ButtonVolUp ButtonVolDown ButtonReset LED \
                           SystemDetection EthernetPort AVPlay memory FlashBlockTest \
                           SDCard CustomName_Check DefaultLang_Check ManufacturingDate_Check ResetFactory \
                           RemoteControl PowerStandbyMode USBPort_a USBPort_b USBPort_c \
                           HDMI_I2C HDMIoutput HDMIpnp RCAoutput SPDIFoutput \
                           SyncToBar Audio_Vrms_Left Audio_Vrms_Right Audio_Frequency_Left Audio_Frequency_Right \
                           Upgrade_Version_Check Active_LED Data_LED I2C_scan SPI_Flash \
                           Volt_3V3 Volt_4V3]
                           
for {set i 0} {$i < [llength $errVariable_item]} {incr i} {
	lappend errVariable [lindex $errVariable_item $i]
}                           

#combine error code variable and number

#for {set i 0} {$i < [llength $StationNameList]} {incr i} {
#	for {set j 0} {$j < [llength [set errCode_[lindex $StationNameList $i]]]} {incr j} {
#		array set errCode [list [lindex [set errVariable_[lindex $StationNameList $i]] $j] \
#		                  [lindex [set errCode_[lindex $StationNameList $i]] $j]]
#	}
#}	
#ft2
#for {set i 0} {$i < [llength errCode_FT2]} {incr i} {
#	array set errCode [list [lindex $errVariable_FT2 $i] [lindex $errCode_FT2 $i]]
#}
for {set i 0} {$i < [llength $errNum]} {incr i} {
	array set errCode [list [lindex $errVariable $i] [lindex $errNum $i]]
#	puts "errCode([lindex $errVariable $i]) = [set errCode([lindex $errVariable $i])]"
}


set os21_bootcmd "run bootcmd_diag"

set running 0
set start_time [clock seconds]
set winTitle "ESM1014 $StationName"
set mts_ver "0.0.1"
set mts_date "2012/11/20"
set ProjectName "ESM1014"

set msn_input ""
set total_pass 0
set total_fail 0
set console_log ""
set time_log ""

proc time_str { {str ""} } {
  if {$str == ""} {set str [clock seconds]}
  return [clock format $str -format "%Y-%m-%d %H:%M:%S"]
}

proc show_time {} {
  global statustime_text
  set statustime_text [time_str]
  after 500 show_time
}

proc vwait_seconds {sec} {

	set vwait_flag 0
	after [expr $sec*1000] { set vwait_flag 1 }
	vwait vwait_flag
}

proc vwait_mseconds {msec} {

	set vwait_flag 0
	after [expr $msec] { set vwait_flag 1 }
	vwait vwait_flag
}


proc promptwait {consoleid writein waitfor { wait_time 20 } { newline 1 } } {	
  
	catch {
	  ConsoleRead $consoleid
	  ConsoleWrite $consoleid $writein
	}


  return [WaitForString $consoleid $waitfor $wait_time]
}

proc promptwaits {consoleid writein waitfor { wait_time 20 } { newline 1 } } {	
  
	catch {
	  ConsoleRead $consoleid
	  ConsoleWrite $consoleid $writein
	}

  return [WaitForStrings $consoleid $waitfor $wait_time]
}

proc save_log { SerialNumber } {
	global ENVPATH console_log StationName StationNameList
	
	if {[string compare $StationName [lindex $StationNameList 0]] == 0 } {
		set DIR [string range $SerialNumber 0 2]
		set tmpmsg_path "$ENVPATH/msglog/$StationName/$DIR/tmp"
		set msg_path "$ENVPATH/msglog/$StationName/$DIR"
		set console_path "$ENVPATH/consolelog/$StationName/$DIR"		
		
		if { ![file isdirectory $msg_path] } {
			file mkdir $msg_path
		}
			
		set Msg_fd [open "$msg_path/[string range $SerialNumber 3 end].[clock format [clock seconds] -format %m%d%H%M].msglog" w+]
	} else {
		set DIR [string range $SerialNumber 0 5]
		set tmpmsg_path "$ENVPATH/msglog/$StationName/$DIR/tmp"
		set msg_path "$ENVPATH/msglog/$StationName/$DIR"
		set console_path "$ENVPATH/consolelog/$StationName/$DIR"
		
		if { ![file isdirectory $msg_path] } {
			file mkdir $msg_path
		}
		
		set Msg_fd [open "$msg_path/[string range $SerialNumber 6 end].[clock format [clock seconds] -format %m%d%H%M].msglog" w+]
	}
	
	if { ![file isdirectory $console_path ] } {
		file mkdir $console_path
	}
	
#	if { ![file isdirectory $msg_path] } {
#		file mkdir $msg_path
#	}
	
	if {![file isdirectory $tmpmsg_path]} {  
		txmbox::messageBox -type ok -icon warning \
    	-title "Message Log File Fail" \
      -message "Message Temp file doesn't exist."\
      -force true -grab true -font {"Consolas" 20 normal bold} \
      -beep true -resize false -showtime true -timeout 10 -wait false
   }
   
  if {![file exists $tmpmsg_path/$SerialNumber.tmp.log]} {
  	txmbox::messageBox -type ok -icon warning \
    	-title "Message Log File Fail" \
      -message "Message Temp file doesn't exist."\
      -force true -grab true -font {"Consolas" 20 normal bold} \
      -beep true -resize false -showtime true -timeout 10 -wait false 	
    }
   
  if {![file isdirectory $msg_path]} {   
  	txmbox::messageBox -type ok -icon warning \
    	-title "Message Log File Fail" \
      -message "Can't save log file."\
      -force true -grab true -font {"Consolas" 20 normal bold} \
      -beep true -resize false -showtime true -timeout 10 -wait false
   }
   
   if {![file isdirectory $console_path]} {
		txmbox::messageBox -type ok -icon warning \
    	-title "Console Log File Fail" \
      -message "Can't save log file."\
      -force true -grab true -font {"Consolas" 20 normal bold} \
      -beep true -resize false -showtime true -timeout 10 -wait false
   }

	
   
# save msg log
   set tmpmsg_fd [open "$tmpmsg_path/$SerialNumber.tmp.log" r]
#   set Msg_fd [open "$msg_path/[string range $SerialNumber 6 end].[clock format [clock seconds] -format %m%d%H%M].msglog" w+]

# used for cycle time measured
#	  set Msg_fd [open "$msg_path/[string range $SerialNumber 6 end].log" w+]
   
   while {![eof $tmpmsg_fd]} {
   	set line [read $tmpmsg_fd]
   	puts $Msg_fd $line
  }
  
  close $tmpmsg_fd
  close $Msg_fd
  
  file delete -force "$tmpmsg_path/$SerialNumber.tmp.log"
# save msg log end
  
# save console log 
	set Console_fd [open "$console_path/[string range $SerialNumber 6 end].[clock format [clock seconds] -format %m%d%H%M].consolelog" w+]
	puts $Console_fd "console log:"
	puts $Console_fd $console_log
	close $Console_fd
  set console_log ""  
# save console log end  
}

proc com_open { port } {

  set com_fd [open "COM$port:" r+]
	fconfigure $com_fd -blocking 0 -buffering line -mode 115200,n,8,1 -translation cr
	return $com_fd
}

proc com_open_uboot { port } {
	global uboot_prompt


  set com_fd [open "COM$port:" r+]
	fconfigure $com_fd -blocking 0 -buffering line -mode 115200,n,8,1 -translation cr
	WaitForString $com_fd "Hit any key to stop autoboot"
	promptwait $com_fd "" $uboot_prompt
	return $com_fd
}

proc com_open_os21 { port } {
	global os21_prompt

  set com_fd [open "COM$port:" r+]
	fconfigure $com_fd -blocking 0 -buffering line -mode 115200,n,8,1 -translation cr
	WaitForString $com_fd $os21_prompt	
	return $com_fd
}

proc com_close { consoleid } {

  catch {close $consoleid}
  set consoleid 0
}


proc ConsoleWrite {consoleid str { newline 1 }} {
#  global console_log

  if {$newline==0} {
    catch {puts -nonewline $consoleid $str}
  } else {
    catch {puts $consoleid $str}
  }

  #append console_log $str
  #puts -nonewline $str

}

proc ConsoleRead {consoleid} {
  global console_log
  set str ""
  catch {set str [read $consoleid]}

  if {[string length $str]>0} {
    lappend console_log $str
    puts -nonewline $str
  }
  
  return $str
}

# 0->timeout, 1-> find string
proc WaitForString {consoleid waitfor { wait_time 20 }} {

	set line ""
	set start [clock seconds]


	while { 1 } {
		if { [clock seconds] - $start > $wait_time } {
			return 0
		}
    set tempchar [ConsoleRead $consoleid]

		if { [string length $tempchar]==0 } {
			vwait_mseconds 200
			update
		} else {
			#puts -nonewline $tempchar
			append line $tempchar

		  if {[string first $waitfor $line] >= 0 } {
		  	return [list 1 $line]
		  }
		}
	}
}

# 0->timeout,  1~n->index of "waitfor"
proc WaitForStrings {consoleid waitfor { wait_time 20 }} {

	set line ""
	set start [clock seconds]
	set str "pnp_fail"


	while { 1 } {
		if { [clock seconds] - $start > $wait_time } {
			return [list 0 $str]
		}
		set tempchar [ConsoleRead $consoleid]

		if { [string length $tempchar]==0 } {
			vwait_mseconds 200
			update
		} else {
			#puts -nonewline $tempchar
			append line $tempchar
      set findall 1
      	puts "line = $line"

       
      foreach str $waitfor {
      	puts "str = $str"
  		  if {[string first $str $line] < 0 } {
  		    set findall 0
  		    break
  		  }
      }
      if {$findall==1} {
        return [list 1 $line]
      }
		}
	}
}

# 0->timeout,  1->find all strings
proc WaitForAllStrings {consoleid waitfor { wait_time 20 }} {

	set line ""
	set start [clock seconds]


	while { 1 } {
		if { [clock seconds] - $start > $wait_time } {
			return 0
		}
		set tempchar [ConsoleRead $consoleid]

		if { [string length $tempchar]==0 } {
			vwait_mseconds 200
			update
		} else {

			append line $tempchar
      set findall 1
      
      foreach str $waitfor {
  		  if {[string first $str $line] < 0 } {
  		    set findall 0
  		    break
  		  }
      }
      if {$findall==1} {
        return [list 1 $line]
      }
		}
	}
}


proc cal_date { sec } {
	set C_sec 0
	set C_hour 0
	set C_min 0
	set days 0
	set C_sec [expr $sec%60]
	set mins [expr $sec/60]
	if { $mins > 0 } {
		set C_min [expr $mins%60]
		set hours [expr $mins/60]
		if { $hours > 0 } {
			set C_hour [expr $hours%24]
			set days [expr $hours/24]
		}
	}

	set ret [format "%02d Sec" $C_sec]
	if { $days > 0 } {
		set ret [format "%d Day %02d Hour %02d Min %s" $days $C_hour $C_min $ret]
	} else {
		if { $C_hour > 0} {
			set ret [format "%02d Hour %02d Min %s" $C_hour $C_min $ret]
		} else {
			if {$C_min > 0 } {
				set ret [format "%02d Min %s" $C_min $ret]
			}
		}
	}
	return $ret
}



proc go_stats { } {
  global label_pass label_fail label_yield label_rate
  global total_pass total_fail start_time

  $label_pass configure -text "Pass:\t$total_pass"
  $label_fail configure -text "Fail:\t$total_fail"
  if { $total_pass || $total_fail } {
  	set yield [expr round($total_pass*10000.0/($total_pass + $total_fail))/100.0]
  } else {
  	set yield 0
  }
  $label_yield configure -text "Yield:\t$yield %"
  set rate [expr round($total_pass*3600.0/([clock seconds] - $start_time +1))]
  $label_rate configure -text "Rate:\t$rate/hr"
	update
}



proc cal_date { sec } {
	set C_sec 0
	set C_hour 0
	set C_min 0
	set days 0
	set C_sec [expr $sec%60]
	set mins [expr $sec/60]
	if { $mins > 0 } {
		set C_min [expr $mins%60]
		set hours [expr $mins/60]
		if { $hours > 0 } {
			set C_hour [expr $hours%24]
			set days [expr $hours/24]
		}
	}
	set ret ""
	set ret [format "%02d Sec" $C_sec]
	if { $days > 0 } {
		set ret [format "%d Day %02d Hour %02d Min %s" $days $C_hour $C_min $ret]
	} else {
		if { $C_hour > 0} {
			set ret [format "%02d Hour %02d Min %s" $C_hour $C_min $ret]
		} else {
			if {$C_min > 0 } {
				set ret [format "%02d Min %s" $C_min $ret]
			}
		}
	}
	return $ret
}


proc close_gpib {device} {
  
  catch {
    foreach addr $device {
      if {$addr > 0} {
        gpib close -device $addr
      }
    }
  }

}

proc ok_dialog { string { title "INFORMATION" } {color red}} {
  set w .dlg
  
  toplevel $w
  
  wm resizable $w 0 0
  wm title $w $title 
  label  $w.l -font {Helvetica 20 bold} -fg $color -text "\n$string\n" ;
  bind $w <KeyRelease-Return> "destroy $w"
  bind $w <KeyRelease-space> "destroy $w"
  button $w.ok -font {Verdana 16 bold} -text OK -command "destroy $w"
  grid $w.l -sticky news
  grid $w.ok -sticky news
  set window_width 1024
  set window_hight 600
  set screen_width [expr {([winfo screenwidth .] - $window_width)/2}]
  set screen_hight [expr {([winfo screenheight .] - $window_hight)/2}]
  wm geometry $w [set window_width]x[set window_hight]+$screen_width+$screen_hight

  grab $w
  focus $w
  wm transient $w .
  wm protocol $w WM_DELETE_WINDOW "grab release $w; destroy $w"
  raise $w
  tkwait window $w

}



proc random {{range 100}} {
    return [expr {int(rand()*$range)}]
}

proc save_msg { msg {Type "INFO"} } {
	global ENVPATH var_sn StationName StationNameList

	if {[string compare $StationName [lindex $StationNameList 0]] == 0 } {
		set DIR [string range $var_sn 0 2]
	} else {
		set DIR [string range $var_sn 0 5]
	}
	
  set PATH "$ENVPATH/msglog/$StationName/$DIR/tmp"
	if { ![file isdirectory $PATH ] } {
		file mkdir $PATH
	}

	set fd [open "$PATH/$var_sn.tmp.log" a]
	puts $fd "[time_str]: $msg"
	close $fd
	
	if { [string compare $Type "ERROR"] == 0 } { 
		txmbox::messageBox -type ok -icon warning \
      -title "Error" \
      -message "$msg" \
      -force true -grab true -font {"Consolas" 20 normal bold} \
      -beep true -resize false -showtime true 
	}
}

proc adb_open {} {
	global ENVPATH
	
	set adbPath "$ENVPATH/adbshell"
	if { [catch { set adb_fd [open "|$adbPath/adb shell" w+] } result] } {
#		save_msg "$result" ERROR
		return 0
	} else {
#		save_msg "open plink success."
		fconfigure $adb_fd -blocking 0 -buffering line
		return $adb_fd
	}
}



proc adb_open_over_ethernet {} {
	global ENVPATH
	global adb_DUT_ip
	
	set adbPath "$ENVPATH/adbshell"
	puts "|$adbPath/adb connect $adb_DUT_ip:5555"
	open "|$adbPath/adb connect $adb_DUT_ip:5555" w+
	if { [catch { set adb_fd [open "|$adbPath/adb shell" w+] } result] } {
#		save_msg "$result" ERROR
		return 0
	} else {
#		save_msg "open plink success."
		fconfigure $adb_fd -blocking 0 -buffering line
		return $adb_fd
	}
}

proc adb_close { adb } {
	
# close free adb handle	
	puts [lindex $adb 0] "\x03"
#puts [lindex $adb 0] "adb kill-server"	
#	get adb.exe pids 
	set adb_pids [twapi::get_process_ids -name adb.exe]
	
	
# end process of adb.exe
	for {set i 0} {$i < [expr {[llength $adb_pids] }]} {incr i} {
		catch { twapi::end_process [lindex $adb_pids [expr {$i + 1}]] } err
	}
}

proc file_open {filePath mode} {
	
	if {[catch {set fd [open $filePath $mode]} res]} {
		save_msg $res ERROR
		return
	} 
	
	return $fd
}

proc file_close {fd} {
	close $fd
}

proc save_time { result } {
	global ENVPATH StationName 
	global var_sn time_log AccWS_log_path
	
	set logPath "$ENVPATH/time_log/$StationName"
	set dataFolder "$logPath/[clock format [clock seconds] -format %Y%m%d]"
	set passFolder "$dataFolder/PASS"
	set failFolder "$dataFolder/FAIL"
	
	set line1 "=========================================================================================="
	set line2 "==============================================="
	
	if { ![file isdirectory $logPath] } {
		if { [catch {file mkdir $logPath} err] } {
			save_msg "\[$err\]: Can't create time log folder." ERROR
			return 
		}
	}
	
	if { ![file isdirectory $dataFolder] } {
		if { [catch {file mkdir $dataFolder} err] } {
			save_msg "\[$err\]: Can't create data folder." ERROR
			return 
		}
	}
	
	if { ![file isdirectory $passFolder] } {
		if { [catch {file mkdir $passFolder} err] } {
			save_msg "\[$err\]: Can't create time log pass folder." ERROR
			return 
		}
	}
	
	if { ![file isdirectory $failFolder] } {
		if { [catch {file mkdir $failFolder} err] } {
			save_msg "\[$err\]: Can't create time log fail folder." ERROR
			return 
		}
	}	

  puts "kevin ...debug  path: $logPath/tmp.txt "  
  catch {file delete -force "$logPath/tmp.txt"}
     
	# open temp file to save time log for handle the information
	set tmp_fd [file_open "$logPath/tmp.txt" w+]
	for {set i 0} {$i < [llength $time_log]} {incr i} {
		puts $tmp_fd [string trimright [string trimleft [lindex $time_log $i] "\{"] "\}"]
	}
	file_close $tmp_fd
	set time_log ""
	
	set tmp_fd [file_open "$logPath/tmp.txt" r+]
	
	switch $result {
		"0" { set fd [file_open "$failFolder/$var_sn.txt" a+] }
		"1" { set fd [file_open "$passFolder/$var_sn.txt" a+] }
	}
	
	puts $fd $line1
	puts $fd "Device SN    : $var_sn"
	puts $fd $line2
	
	gets $tmp_fd line
	while { [string first "Total Test Time" $line] < 0 } {
		puts $fd $line
		gets $tmp_fd line
	}
	
	puts $fd $line2
	puts $fd $line
	#Kevin Accton log file
	set AccWS_log_path "$logPath/tmp.txt"
	
	
	file_close $fd; file_close $tmp_fd
	
 #	catch {file delete -force "$logPath/tmp.txt"}                                 
			
}

proc test_time { start } {
	
	set stop [clock seconds]
	set test [expr {$stop - $start}]
	
	return $test
}

#############################################################################
## Procedure:  gpibw2

proc gpibw2 {gpibHandle stat} {
	gpib clear -device $gpibHandle
	gpib write -device $gpibHandle -message "$stat;*OPC"
	after 500
}
#############################################################################
## Procedure:  gpibr2

proc gpibr2 { gpibCmd } {
	global gpr

	set gpr [gpib read -device $gpibCmd -mode ascii]
	set cur_time [clock seconds]
	while { [expr {[clock seconds]- $cur_time}] <= 10 } {
		after 500
 		if { [string length $gpr] >= 1 } {
			return $gpr
 		}       
 		after 1000    
 		set gpr [gpib read -device $gpibCmd -mode ascii]
	}
	set $gpr -99999
	return $gpr
}

proc adb_retry { sec } {
	global diag_prompt DebugLine1 DebugLine2
	
	set adbRes [list 0]
	set adbRetry [clock seconds]
	while { ![lindex $adbRes 0] } {
	 	set adb_fd [adb_open_over_ethernet]
		set adbRes [promptwait $adb_fd " " $diag_prompt 1]
		if { [expr { [clock seconds] - $adbRetry }] > $sec } {
			puts "debug adb retry ....."
			#promptwait $adb_fd "adb kill-server" "" 1
			return 0
		}
		after 300
	}
	
	return $adb_fd
}