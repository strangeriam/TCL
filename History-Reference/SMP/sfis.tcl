package require sqlite3

if { $::Accton_SFIS == 1 } {
	package require tcom
	source AccWS.tcl
	
}


set infoField [list]
set infoValue [list]

proc OpenDatabase { DatabaseName NVM_DatabaseName } {
  global sfis_en ModelName

  if {$sfis_en==0} {return}

  if {![file exist $DatabaseName]} {
    puts "$DatabaseName not exist"
    if {[catch {sqlite db $DatabaseName} res]} {
      tk_messageBox -icon error -type ok \
                	-title "ESM1014" \
                	-message "$DatabaseName open error."
      exit
    }

#   This is used to prevent database is locked when two process is accessed 
#   at the same time. 
    db timeout 500    
    
    switch $ModelName {
    	ESM1014 { source Tdatabase.tcl }
    }

  } else {
    sqlite db $DatabaseName
  }
  
  #for Accton SFIS
  if { 0 } {
  	if {[file exist $NVM_DatabaseName]} {
    	puts "$NVM_DatabaseName exist"
	    if {[catch {sqlite nvm_db $NVM_DatabaseName} res]} {
  	    tk_messageBox -icon error -type ok \
    	            	-title "ESM1014" \
      	          	-message "$DatabaseName open error."
	      exit
  	  }
	  } else {
  	  tk_messageBox -icon error -type ok \
    	          	-title "ESM1014" \
      	        	-message "NVM Data File error."
	    exit
  	}
	}

}
proc ConnectSFIS {SerialNumber StationName} {
  global StationNameList StationCodeList sfis_en m_product

  if {$sfis_en==0} {
    save_msg "SFIS is CLOSED" WARNING
    return [list 1 "001122334455" "" "THI"]
  }
  
#  if { ![string compare $StationName "FT2"] } {
#  	set SerialNumber [db eval "SELECT SerialNumber FROM TestInfo WHERE ACC_SN = '$SerialNumber'"]
#  }
  
	#remove nvram database
  if { 0 } {
#  	if { [nvm_db exist "select 1 FROM NVM_Data WHERE SN='$SerialNumber'"] == 0} {
#	    return [list 0 "Not found this SN->$SerialNumber in NVM DB."]
#  	}
#  
	  set StationListID [lsearch $StationNameList $StationName]
  	if { $StationListID == -1 } {
    	error "ConnectSFIS Station Name error: $StationName."
	    return [list 0 "ConnectSFIS Station Name error: $StationName."]
  	}
	  set StationCode [lindex $StationCodeList $StationListID]

  	if {![db exists "SELECT 1 FROM TestInfo WHERE SerialNumber='$SerialNumber'"]} {
    	db eval "INSERT INTO TestInfo(SerialNumber,TestStatus,UpdateDateTime) values('$SerialNumber',0,'[time_str]')"
  	}

	  set TestStatus [db eval "SELECT TestStatus FROM TestInfo WHERE SerialNumber='$SerialNumber'"]
  	puts "SELECT TestStatus FROM TestInfo WHERE SerialNumber='$SerialNumber'"

	  #check this station pass ?
  	puts "StationListID $StationListID"
	  puts "TestStatus $TestStatus"
  	puts "StationCode $StationCode"
	  if {[expr $TestStatus & $StationCode] != 0} {
  		 return [list 0 "Already Test in this Staion."]
  	}


	  #PT1 no need check pre-station  
  	if { $StationListID != 0 && $StationListID != 1} {

    	set PreStationCode [lindex $StationCodeList [expr $StationListID - 1]]
	    #check pre station pass ?
  	  if {[expr $TestStatus & $PreStationCode] == 0} {
    	  return [list 0 "Not Test in Pre-Staion."]
	    }
  	}
  	#ok, get MAC, HDCP Key, ...etc data
  
  	#set nvm_list [nvm_db eval "select WiFi_MAC FROM NVM_Data WHERE SN='$SerialNumber'"]
	  #set ethaddr [lindex $nvm_list 0]
  
  	#return [list 1 $ethaddr]
  	               
  	set nvm_list [nvm_db eval "select product,brand,model,board,device,display,id,manufacturer,hardware,UpgradeVersion FROM NVM_Data WHERE device='ESM1014'"]
 
  	set product [lindex $nvm_list 0]
  	set brand [lindex $nvm_list 1]
  	set model [lindex $nvm_list 2]
  	set board [lindex $nvm_list 3]
  	set device [lindex $nvm_list 4]
  	set display [lindex $nvm_list 5]
  	set id [lindex $nvm_list 6]
  	set manufacturer [lindex $nvm_list 7]
  	set hardware [lindex $nvm_list 8]
  	set UpgradeVersion [lindex $nvm_list 9]  
  	puts "sfis ... debug"
	  puts "product:$product"                   
	  puts "brand:$brand"             
	  puts "model:$model"       
	  puts "board:$board"                   
	  puts "device:$device"             
	  puts "display:$display"  
	  puts "id:$id"                   
	  puts "manufacturer:$manufacturer"             
	  puts "hardware:$hardware" 
	  puts "UpgradeVersion:$UpgradeVersion" 	
  
  	return [list 1 $product $brand $model $board $device $display $id $manufacturer $hardware $UpgradeVersion]
	}
	#remove nvram database end
	
	set StationListID [lsearch $StationNameList $StationName]
  if { $StationListID == -1 } {
   	error "ConnectSFIS Station Name error: $StationName."
	  return [list 0 "ConnectSFIS Station Name error: $StationName."]
  }
	set StationCode [lindex $StationCodeList $StationListID]
	
 	if {![db exists "SELECT 1 FROM TestInfo WHERE SerialNumber='$SerialNumber'"]} {
   	db eval "INSERT INTO TestInfo(SerialNumber,TestStatus,UpdateDateTime) values('$SerialNumber',0,'[time_str]')"
 	}

  set TestStatus [db eval "SELECT TestStatus FROM TestInfo WHERE SerialNumber='$SerialNumber'"]
 	puts "SELECT TestStatus FROM TestInfo WHERE SerialNumber='$SerialNumber'"

  #check this station pass ?
 	puts "StationListID $StationListID"
  puts "TestStatus $TestStatus"
 	puts "StationCode $StationCode"
  if {[expr $TestStatus & $StationCode] != 0} {
 		 return [list 0 "Already Test in this Staion."]
 	}	
  	
  #PT1 no need check pre-station  

		puts " PreStationCode = [lindex $StationCodeList [expr $StationListID - 1]] ,TestStatus =$TestStatus "
   	set PreStationCode [lindex $StationCodeList [expr $StationListID - 1]]
   	if { $PreStationCode != ""} {
    #check pre station pass ?
 	  if {[expr $TestStatus & $PreStationCode] == 0} {
   	  return [list 0 "Not Test in Pre-Staion."]
    }
 	}  	
	
	return 1
}


proc ResultSFIS {SerialNumber StationName result} {
  global infoField infoValue StationNameList StationCodeList sfis_en Accton_SFIS

  if {$sfis_en==0} {
    save_msg "SFIS is CLOSED" WARNING
    return 1
  }
  
  save_msg "ResultSFIS:"
  save_msg "SerialNumber = $SerialNumber"
  save_msg "StationName = $StationName"
  save_msg "result = $result"

  if { $result == 1 } {
    set TestResult PASS
  } else {
    set TestResult FAIL 
  }
  
  #kevin test result send to accton sfis #
  if { $Accton_SFIS == 1 } {
 		_f_MesShopFlowUploadResultLog $TestResult
	}
  
  set StationListID [lsearch $StationNameList $StationName]
  if { $StationListID == -1 } {
    error "ConnectSFIS Station Name error: $StationName."
    return [list 0 "ConnectSFIS Station Name error: $StationName."]
  }
  set StationCode [lindex $StationCodeList $StationListID]

  if {[db exists "SELECT SerialNumber FROM $StationName WHERE SerialNumber = '$SerialNumber'"]} {
    #exist in station
    db eval "DELETE FROM $StationName WHERE SerialNumber='$SerialNumber'"
  }

  puts "infoField: $infoField"
  puts "infoValue: $infoValue"
  
  puts "======================================================"
  puts "infoField length = [llength $infoField]"
  puts "infoValue length = [llength $infoValue]"
  puts "======================================================"

#  set query "INSERT INTO $StationName (SerialNumber,TestResult,TestDateTime,[join $infoField ,])"
	set query "INSERT INTO $StationName (SerialNumber,TestResult,TestDateTime"
	for {set i 0} { $i <= [llength $infoField]} {incr i} {
				if {$i == [llength $infoField]} {
					append query ") "
					break
				} else {
					append query ", [lindex $infoField $i]"
				}
			}
				
#  append query "VALUES ('$SerialNumber','$TestResult','[time_str]','[join $infoValue ',']') "
  append query "VALUES ('$SerialNumber','$TestResult','[time_str]'"
  for {set i 0} { $i <= [llength $infoValue]} {incr i} {
		if {$i == [llength $infoValue]} {
			append query ")"
			break
		} else {
			append query ", '[lindex $infoValue $i]'"
		}
	}
  puts $query
  db eval $query
  #kevin add mac address
#  set query "UPDATE TestInfo SET WiFi_MAC = '$WiFi_MAC',"
#  append query " UpdateDateTime = '[time_str]' WHERE SerialNumber = '$SerialNumber'"
#  puts $query
#  db eval $query

  if { $result == 1 } {
    set query "UPDATE TestInfo SET TestStatus = TestStatus | [format "%d" $StationCode],"
    append query " UpdateDateTime = '[time_str]' WHERE SerialNumber = '$SerialNumber'"
    puts $query
    db eval $query
  }
  return 1
}


# 1->ok,   0-> Duplicate
proc CheckMacDuplicate { ethaddr } {
  global sfis_en

  if {$sfis_en==0} {
    return 1
  }
  
  
  if {![db exists "SELECT WiFi_MAC FROM PT3 WHERE WiFi_MAC='$ethaddr' AND TestResult='PASS'"]} {    
    return 1
  }
  
#  show_status "MAC Address Duplicate with these S/N'" ERROR
	save_msg "WiFi MAC Address Duplicate with these S/N'" ERROR
  db eval {
    SELECT SerialNumber FROM PT3 WHERE WiFi_MAC='$ethaddr' AND TestResult='PASS'
  } {
#    show_status "SerialNumber = $SerialNumber" ERROR    
		save_msg show_status "SerialNumber = $SerialNumber"
  }
  
  return 0
}