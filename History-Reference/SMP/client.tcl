#!/bin/sh
# the next line restarts using wish\
exec wish "$0" "$@" 

if {![info exists vTcl(sourcing)]} {

    package require Tk
    switch $tcl_platform(platform) {
	windows {
            option add *Button.padY 0
	}
	default {
            option add *Scrollbar.width 10
            option add *Scrollbar.highlightThickness 0
            option add *Scrollbar.elementBorderWidth 2
            option add *Scrollbar.borderWidth 2
	}
    }
    
}

#############################################################################
# Visual Tcl v1.60 Project
#


#############################################################################
# vTcl Code to Load Stock Fonts


if {![info exist vTcl(sourcing)]} {
set vTcl(fonts,counter) 0
#############################################################################
## Procedure:  vTcl:font:add_font

proc ::vTcl:font:add_font {font_descr font_type {newkey {}}} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    if {[info exists ::vTcl(fonts,$font_descr,object)]} {
        ## cool, it already exists
        return $::vTcl(fonts,$font_descr,object)
    }

     incr ::vTcl(fonts,counter)
     set newfont [eval font create $font_descr]
     lappend ::vTcl(fonts,objects) $newfont

     ## each font has its unique key so that when a project is
     ## reloaded, the key is used to find the font description
     if {$newkey == ""} {
          set newkey vTcl:font$::vTcl(fonts,counter)

          ## let's find an unused font key
          while {[vTcl:font:get_font $newkey] != ""} {
             incr ::vTcl(fonts,counter)
             set newkey vTcl:font$::vTcl(fonts,counter)
          }
     }

     set ::vTcl(fonts,$newfont,type)       $font_type
     set ::vTcl(fonts,$newfont,key)        $newkey
     set ::vTcl(fonts,$newfont,font_descr) $font_descr
     set ::vTcl(fonts,$font_descr,object)  $newfont
     set ::vTcl(fonts,$newkey,object)      $newfont

     lappend ::vTcl(fonts,$font_type) $newfont

     ## in case caller needs it
     return $newfont
}

#############################################################################
## Procedure:  vTcl:font:getFontFromDescr

proc ::vTcl:font:getFontFromDescr {font_descr} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    if {[info exists ::vTcl(fonts,$font_descr,object)]} {
        return $::vTcl(fonts,$font_descr,object)
    } else {
        return ""
    }
}

vTcl:font:add_font \
    "-family helvetica -size 12 -weight bold" \
    stock \
    vTcl:font5
vTcl:font:add_font \
    "-family times -size 12 -weight bold" \
    stock \
    vTcl:font7
}
#################################
# VTCL LIBRARY PROCEDURES
#

if {![info exists vTcl(sourcing)]} {
#############################################################################
## Library Procedure:  Window

proc ::Window {args} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    global vTcl
    foreach {cmd name newname} [lrange $args 0 2] {}
    set rest    [lrange $args 3 end]
    if {$name == "" || $cmd == ""} { return }
    if {$newname == ""} { set newname $name }
    if {$name == "."} { wm withdraw $name; return }
    set exists [winfo exists $newname]
    switch $cmd {
        show {
            if {$exists} {
                wm deiconify $newname
            } elseif {[info procs vTclWindow$name] != ""} {
                eval "vTclWindow$name $newname $rest"
            }
            if {[winfo exists $newname] && [wm state $newname] == "normal"} {
                vTcl:FireEvent $newname <<Show>>
            }
        }
        hide    {
            if {$exists} {
                wm withdraw $newname
                vTcl:FireEvent $newname <<Hide>>
                return}
        }
        iconify { if $exists {wm iconify $newname; return} }
        destroy { if $exists {destroy $newname; return} }
    }
}
#############################################################################
## Library Procedure:  vTcl::widgets::core::megawidget::cgetProc

namespace eval vTcl::widgets::core::megawidget {
proc cgetProc {w args} {
        ## This procedure may be used free of restrictions.
        ##    Exception added by Christian Gavin on 08/08/02.
        ## Other packages and widget toolkits have different licensing requirements.
        ##    Please read their license agreements for details.

        upvar ::${w}::widgetProc  widgetProc

        set option [lindex $args 0]
        switch -- $option {
            -class         {return MegaWidget}
            -widgetProc    {return $widgetProc}
            default        {error "unknown option $option"}
        }
    }
}
#############################################################################
## Library Procedure:  vTcl::widgets::core::megawidget::configureProc

namespace eval vTcl::widgets::core::megawidget {
proc configureProc {w args} {
        ## This procedure may be used free of restrictions.
        ##    Exception added by Christian Gavin on 08/08/02.
        ## Other packages and widget toolkits have different licensing requirements.
        ##    Please read their license agreements for details.

        upvar ::${w}::widgetProc  widgetProc

        if {[lempty $args]} {
            return [concat [configureProc $w -class]  [configureProc $w -widgetProc]]
        }
        if {[llength $args] == 1} {
            set option [lindex $args 0]
            switch -- $option {
                -class {
                    return [list "-class class Class Frame MegaWidget"]
                }
                -widgetProc {
                    return [list "-widgetProc widgetproc WidgetProc {} [list $widgetProc]"]
                }
                default {
                    error "unknown option $option"
                }
            }
        }

        foreach {option value} $args {
            if {$option == "-widgetProc"} {
                set widgetProc $value
            }
        }
    }
}
#############################################################################
## Library Procedure:  vTcl::widgets::core::megawidget::createCmd

namespace eval vTcl::widgets::core::megawidget {
proc createCmd {path args} {
        ## This procedure may be used free of restrictions.
        ##    Exception added by Christian Gavin on 08/08/02.
        ## Other packages and widget toolkits have different licensing requirements.
        ##    Please read their license agreements for details.

        frame $path -class MegaWidget
        namespace eval ::$path "set widgetProc {}"

        ## change the widget procedure
        rename ::$path ::_$path
        proc ::$path {command args}  "eval ::vTcl::widgets::core::megawidget::widgetProc $path \$command \$args"

        ## widgetProc specified ? if so, store it
        if {[llength $args] == 2 && [lindex $args 0] == "-widgetProc"} {
            upvar ::${path}::widgetProc  widgetProc
            set widgetProc [lindex $args 1]
        }
        
        return $path
    }
}
#############################################################################
## Library Procedure:  vTcl::widgets::core::megawidget::widgetProc

namespace eval vTcl::widgets::core::megawidget {
proc widgetProc {w args} {
        ## This procedure may be used free of restrictions.
        ##    Exception added by Christian Gavin on 08/08/02.
        ## Other packages and widget toolkits have different licensing requirements.
        ##    Please read their license agreements for details.

        if {[llength $args] == 0} {
            ## If no arguments, returns the path the alias points to
            return $w
        }

        set command [lindex $args 0]
        set args [lrange $args 1 end]
        switch $command {
            configure {
                return [eval configureProc $w $args]
            }
            cget {
                return [eval cgetProc $w $args]
            }
            widget {
                ## this calls the custom widgetProc
                upvar ::${w}::widgetProc  widgetProc
                return [eval $widgetProc $w $args]
            }
            default {
                ## we have renamed the default widgetProc _<widgetpath>
                uplevel _$w $command $args
            }
        }
    }
}
#############################################################################
## Library Procedure:  vTcl:DefineAlias

proc ::vTcl:DefineAlias {target alias widgetProc top_or_alias cmdalias} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    global widget
    set widget($alias) $target
    set widget(rev,$target) $alias
    if {$cmdalias} {
        interp alias {} $alias {} $widgetProc $target
    }
    if {$top_or_alias != ""} {
        set widget($top_or_alias,$alias) $target
        if {$cmdalias} {
            interp alias {} $top_or_alias.$alias {} $widgetProc $target
        }
    }
}
#############################################################################
## Library Procedure:  vTcl:DoCmdOption

proc ::vTcl:DoCmdOption {target cmd} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    ## menus are considered toplevel windows
    set parent $target
    while {[winfo class $parent] == "Menu"} {
        set parent [winfo parent $parent]
    }

    regsub -all {\%widget} $cmd $target cmd
    regsub -all {\%top} $cmd [winfo toplevel $parent] cmd

    uplevel #0 [list eval $cmd]
}
#############################################################################
## Library Procedure:  vTcl:FireEvent

proc ::vTcl:FireEvent {target event {params {}}} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    ## The window may have disappeared
    if {![winfo exists $target]} return
    ## Process each binding tag, looking for the event
    foreach bindtag [bindtags $target] {
        set tag_events [bind $bindtag]
        set stop_processing 0
        foreach tag_event $tag_events {
            if {$tag_event == $event} {
                set bind_code [bind $bindtag $tag_event]
                foreach rep "\{%W $target\} $params" {
                    regsub -all [lindex $rep 0] $bind_code [lindex $rep 1] bind_code
                }
                set result [catch {uplevel #0 $bind_code} errortext]
                if {$result == 3} {
                    ## break exception, stop processing
                    set stop_processing 1
                } elseif {$result != 0} {
                    bgerror $errortext
                }
                break
            }
        }
        if {$stop_processing} {break}
    }
}
#############################################################################
## Library Procedure:  vTcl:Toplevel:WidgetProc

proc ::vTcl:Toplevel:WidgetProc {w args} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    if {[llength $args] == 0} {
        ## If no arguments, returns the path the alias points to
        return $w
    }
    set command [lindex $args 0]
    set args [lrange $args 1 end]
    switch -- [string tolower $command] {
        "setvar" {
            foreach {varname value} $args {}
            if {$value == ""} {
                return [set ::${w}::${varname}]
            } else {
                return [set ::${w}::${varname} $value]
            }
        }
        "hide" - "show" {
            Window [string tolower $command] $w
        }
        "showmodal" {
            ## modal dialog ends when window is destroyed
            Window show $w; raise $w
            grab $w; tkwait window $w; grab release $w
        }
        "startmodal" {
            ## ends when endmodal called
            Window show $w; raise $w
            set ::${w}::_modal 1
            grab $w; tkwait variable ::${w}::_modal; grab release $w
        }
        "endmodal" {
            ## ends modal dialog started with startmodal, argument is var name
            set ::${w}::_modal 0
            Window hide $w
        }
        default {
            uplevel $w $command $args
        }
    }
}
#############################################################################
## Library Procedure:  vTcl:WidgetProc

proc ::vTcl:WidgetProc {w args} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    if {[llength $args] == 0} {
        ## If no arguments, returns the path the alias points to
        return $w
    }

    set command [lindex $args 0]
    set args [lrange $args 1 end]
    uplevel $w $command $args
}
#############################################################################
## Library Procedure:  vTcl:toplevel

proc ::vTcl:toplevel {args} {
    ## This procedure may be used free of restrictions.
    ##    Exception added by Christian Gavin on 08/08/02.
    ## Other packages and widget toolkits have different licensing requirements.
    ##    Please read their license agreements for details.

    uplevel #0 eval toplevel $args
    set target [lindex $args 0]
    namespace eval ::$target {set _modal 0}
}
}


if {[info exists vTcl(sourcing)]} {

proc vTcl:project:info {} {
    set base .top73
    namespace eval ::widgets::$base {
        set set,origin 1
        set set,size 1
        set runvisible 1
    }
    set site_3_0 $base.fra77
    set site_3_0 $base.fra87
    namespace eval ::widgets_bindings {
        set tagslist _TopLevel
    }
    namespace eval ::vTcl::modules::main {
        set procs {
            init
            main
            check
            check_barcode
            Check_STB
            Input_RootPw
            AVplay
            vm700init
            FRONT_PANEL
            IR
            MEM_Check
            HD
            USB
            M_Ethernet
            Eth_init
            CSM
            CSMAC
            Scompare
            TF
            checkS
            checkSS
            clock_now
            close_exit
            dtdelay
            ok_dialog
            ok_dialog1
            serial_closeCmd
            serial_closeLog
            serial_configCmd
            serial_configLog
            serial_openCmd
            serial_openLog
            serial_sendLog
            test_result
            test_resultF
            test_resultS
            test_resultNC
            test_resultZ2
            test_resultZ3
            CSIM
            restart
            CHECK_SMART_CARD
            Check_key
            Check_key1
            Check_key2
            Check_key_long
            Check_key_Eth
            private_send_exp_reader
            private_send_exp_reader1
            private_send_exp_reader2
            STB_RESTART
            NVM_INIT
            print_securemicro
            MEM_TEST
            print_FW
            FW_BL_Ver
            HW_ID
            GET_MAC
            gpibw2
            gpibr2
            gpib_open
            gpib_close
            gpib_cmd
            gpib_cmd_read
            FindString
            FindString1
            FindString2
            FindString3
            FindString2_1
            FindString2_2
            convert
            LoadData
            LoadData1
            print_instruction
            print_instruction2
            TunerScan_96Ch
            gain_flatness
            CM_SNMAC
            checkCM
            Read_CM
            Spurious
            Gain_96_864
            em8634_function
            em8654_function
            Check_DRAM
            Get_Barcode
            Get_Version
            record
            Check_USB
            Check_LED
            Check_IR
            Check_Ethernet
            Check_Flash
            GPRS_Init
            Video_Level_Measure
            Audio_Level_Measure
            Check_LAudio_Level
            Check_RAudio_Level
            Check_Video_Level
            Check_SVideo_Level
            Check_YPbPr_Level
            FW_Ver_Compare
            SNMAC_Compare
            Check_Summary
            xls_write
            Fail_Msg_Log
            selsql
            Check_Boot
            Write_SN_MAC
            FWV_Check
            USB_Check
            SATA_Check
            LED_Check
            Button_Check
            IR_Check
            Flash_Check
            Ethernet_Check
            Tuner_Check
            Tuner_Lock_870M_256Q
            Tuner_870M_256Q_BER
            Tuner_Lock_111M_256Q
            Tuner_Lock_543M_256Q
            Ini_GDS2104
            Ini_GDS21040
            ConnectSFIS
            ConnectSFIS2
            ConnectSFIS3
            WriteLog
        }
        set compounds {
        }
        set projectType single
    }
}
}

#################################
# USER DEFINED PROCEDURES
#
#############################################################################
## Procedure:  main

proc ::main {argc argv} {uplevel {
		global id
		global cts
		global id_ip
		global serialCmd
		global fh
		global portCmd_stb
		set id 1
		#set id [lindex $argv 0]
		after [ expr $id * 100 ]
		#set portCmd_stb [expr $id + 1]
		set portCmd_stb [expr $id + 0]
		set id_ip 192.168.100.[expr $id+100]

		if { [catch { set cts [socket 127.0.0.1 5999] } re] } {
				puts "socket connect to server failed. $re"
				exit
			}
				fconfigure $cts -buffering line
				puts $cts "ID $id"
				flush $cts
				fileevent $cts readable check
}}
#############################################################################
## Procedure:  check

proc ::check {} { uplevel {
		global gpibCmd
  	global dbresult
  	global dbresult1
  	global BarCode4
  	global Cal_data_result
  	global DRAM
  	global Total_Time
  	global SFISresult
  	global UnitReport
  	
  	global Accton_SFIS var_sn STARTTIME FINISHTIME time_log StartTime
 		set var_sn $BarCode1
 		;#Accton sfis STARTTIME kevin
		set ::STARTTIME [clock format [clock seconds] -format {%Y%m%d%H%M%S} ]
	
  	set runtime [clock_now]
  	set result ""
  	set TestTime ""
  	set SFISresult ""
  	set UnitReport ""
  	
  	
  	
  	#set Start_time [clock format [clock sec] -format %Y%m%d] 
	
		if { [catch { set data [gets $cts line]}] } {
				return
			}
	
		if { $data <= 0} {return}
				flush $cts
				puts $line
				set items [split $line ]
				set command [lindex $items 0 ]
				switch -- $command {
			
			"Test" {	
				if { ![catch {set serialCmd  [open com$portCmd_stb r+]} result] } {
						fconfigure $serialCmd  -blocking 0 -mode 115200,n,8,1		 	
	        	
	        	puts [lrange $items 1 end]	 
			    	set Start_time [clock seconds]
			    	set Cmd [lrange $items 1 end]	                          
    				set TestTime [open $filelogT "a"]
    				set StartTime [clock seconds]
    				set logStartTime [clock seconds]
    				
						puts $TestTime "**********************************************"
						puts $TestTime "SN : $BarCode1"
						puts $TestTime ""
						flush $TestTime    
						lappend time_log "**********************************************"
						lappend time_log "SN : $BarCode1"
						lappend time_log "" 
            
            .top73.fra87.cpd88 configure -state normal
  					.top73.fra87.cpd91 configure -state normal
  					
  					set Test_item "Write SN_MAC & Booting" 		   				 								
            if {[Check_STB]} {                          
    		    	  print_instruction "Ready to Test" 
    		    	  .top73.fra87.cpd88 configure -state active
    						.top73.fra87.cpd91 configure -state disable 
    						append SFISresult "T000_$BarCode4;T101_PASS;"   
            		append UnitReport "RS232 connect : Pass\n" 
            		lappend time_log "T101 RS232 connect : Pass\n"
            		
            		set BootEnd [clock seconds]
								set BootEnd [expr $BootEnd - $StartTime]
								puts $TestTime "Boot Time       : $BootEnd  sec."
								flush $TestTime
								lappend time_log "Boot Time       : $BootEnd  sec."								
 							
######################################################################  									
 							if {[em8654_function]} {
									.top73.fra87.but99  configure -state disable
    							.top73.fra87.but100  configure -state disable
    							.top73.fra87.cpd88 configure -state active
    							.top73.fra87.cpd91 configure -state disable
    							print_instruction "SMP8654_function Test ALL Pass"    									
			    	      puts $cts "Success $Start_time em8654_function $dbresult"
	            	  flush $cts		                        									   									
									test_resultS "$result"
									WriteLog OK OK $UnitReport
			    				ConnectSFIS3 OK $SFISresult	
			    				after 1000
									set Test_item "SMP8654_ST2 Test Finish" 
							} else {
    							.top73.fra87.but99  configure -state disable
    							.top73.fra87.but100  configure -state disable
    							.top73.fra87.cpd88 configure -state disable
    							.top73.fra87.cpd91 configure -state active
    							#print_instruction "SMP8654_function Test Fail"
    							puts $cts "FAIL $id $Start_time em8654_function Test Fail $dbresult"
		        	    flush $cts	  		                   				
							}									
								
									set EndTime [clock seconds]
									set EndTime [expr $EndTime - $StartTime]
									puts $TestTime "=============================================="
									puts $TestTime "SMP8654_Station 2 total    : $EndTime  sec."
									puts $TestTime "=============================================="
									flush $TestTime				
		        	
		        	} else {
			    	  	puts $cts "FAIL $id $Start_time Rs232 not ready"
			    	    flush $cts
			    	    set SFISresult "T101_FAIL;"   
            		append UnitReport "T101 RS232 connect : Fail\n"
            		lappend time_log "T101 RS232 connect : Fail\n"
            		ConnectSFIS3 T101 $SFISresult
            		WriteLog T101 FAIL $UnitReport
            		set Test_item "T101 fail"
			    		}
			    		
			    			close $serialCmd
			    			set $serialCmd 0
			   				set test_go 1
								set restart_go 1
                .top73.fra87.cpd96 configure -state active 
            	
            	} else {  
								print_instruction "Rs232 Fail because $result"
								set test_go 1
								set restart_go 1  
							}	              
				}	       			
		
		"EXIT" {
				puts $cts "EXIT"
				flush $cts
				after 1000
				exit
		}
	}
}}
#############################################################################
## Procedure:  check_barcode

proc ::check_barcode {} { uplevel {
		global serialCmd 
		global BarCode1 
		global BarCode2 
		global BarCode3 
		       
    set B1 [expr [string length $BarCode1]]
    set B2 [expr [string length $BarCode2]]
    set B3 [expr [string length $BarCode3]]       
		
		if {$B1!=16}  {
    		print_instruction "The length of S/N must be 16 Please input again!.\n"			  							              
        set $BarCode1 {}              				              
        return 0
    	}
    
		if {$B2!=12}  {
    		print_instruction "The length of Mac-1 must be 12 Please input again!.\n"			  							              
        set $BarCode2 {}             
        return 0
    	} 
    	
    if {$B3!=12}  {
    		print_instruction "The length of Mac-2 must be 12 Please input again!.\n"			  							              
        set $BarCode2 {}             
        return 0
    	} 	
    	
		print_instruction "DUT$id SN=$BarCode1 MAC-1=$BarCode2 MAC-2=$BarCode3"					 
		return 1   
}}
#############################################################################
## Procedure:  Check_STB

proc Check_STB {} {
		global portCmd_stb
		global serialCmd 
		global send_exp
		global regexp
		global TestTime
		global cts
		global id
		global time_log
  
  	set BootStart [clock seconds]
		set Test_item "Check_Boot Status"                    
		print_instruction "SMP8654 Booting ..."								
		if {![Check_Boot]} {		 
				.top73.fra87.but99  configure -state disable
  	  	.top73.fra87.but100  configure -state disable
  	  	.top73.fra87.cpd88 configure -state disable
  	  	.top73.fra87.cpd91 configure -state active
  	  	print_instruction "Boot up Fail" 
				test_resultZ2 "Check Boot up Fail"
  	  	#puts $cts "Show $id Check Boot up FAIL"
  	  	#flush $cts 
				return 0  
  	  }
    
    if {[Input_RootPw]} {            		
    	print_instruction "Input root & password Pass"
    } else {
    	if {[Check_Boot]} {
        	if {[Input_RootPw]} {            		
    			print_instruction "Input root & password Pass"
    		} else {
    			print_instruction "Input root & password Fail" 
				return 0
    		}
    	} else {
    		print_instruction "Boot up Fail;"
			return 0
    	}           					
    }
    
    	set BootEnd [clock seconds]
			set BootEnd [expr $BootEnd - $BootStart]
			puts $TestTime "Boot Time       : $BootEnd  sec."
			flush $TestTime
			lappend time_log "Boot Time       : $BootEnd  sec."
			
    set WriteSNMACStart [clock seconds]
    if {![Write_SN_MAC]} {				
  			.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		print_instruction "Write SN & MAC Fail" 
				test_resultZ2 "Write SN & MAC Fail"
    		#puts $cts "Show $id Write SN & MAC FAIL"
    		#flush $cts 
				return 0  		
    }
    	set WriteSNMACEnd [clock seconds]
			set WriteSNMACEnd [expr $WriteSNMACEnd - $WriteSNMACStart]
			puts $TestTime "Write SN & MAC Time       : $WriteSNMACEnd  sec."
			flush $TestTime
			lappend time_log "Write SN & MAC Time       : $WriteSNMACEnd  sec."
			return 1
}
#############################################################################
## Procedure:  Input_RootPw

proc Input_RootPw {} {
		global serialCmd      
	
		#after 500		    
    puts $serialCmd "root"
    flush $serialCmd
    after 100
    
    if {[Check_key2 "v3.7.1.7 tango3" 1000]!= 1 } {                               
				puts "Login fail"
				return 0
    }
         			  		
#    puts $serialCmd "\n"
#    flush $serialCmd
#    after 100	   			
#		
#		if {[Check_key2 "uclibc" 1000]!= 1 } {                               
#		puts "uclibc string fail"
#		return 0
#    }     			  		
#    puts $serialCmd "export PS1='\\u\\$'"
#    flush $serialCmd	
#    after 100
    return 1    
}
#############################################################################
## Procedure:  Scompare

proc ::Scompare {str1 str2} {
	if {[string compare $str1 $str2] != 0} {
	   #ok_dialog "$str1 $str2 not match! out= 1"
	   return 1
	} else {
	   #ok_dialog "$str1 $str2 match! out= 0"
	           return 0
	} 
}
#############################################################################
## Procedure:  checkS

proc ::checkS {} {
global BarCode1
global BarCode2
global Snbuff
global Macbuff
if {[expr [Scompare $BarCode1 $Snbuff ] || [Scompare $BarCode2 $Macbuff ]] == 1} {
   if {[Scompare $BarCode1 $Snbuff]} {
     print_instruction1 "S/N not match"
     print_instruction "The S/N=$Snbuff reading form STB /n not Match Scaning S/N=$BarCode1"
     return 0 
   }
   if {[Scompare $BarCode2 $Macbuff]} {
     print_instruction1 "MAC not match"
     print_instruction "The MAC=$Macbuff reading form STB /n not Match  Scaning Mac=$BarCode2"                 
     return 0
   } 
 } else {
 return 1
 }            
}
#############################################################################
## Procedure:  clock_now

proc ::clock_now {} {
	clock format [clock sec] -format %Y%m%d/%H:%M:%S
}
#############################################################################
## Procedure:  close_exit

proc ::close_exit {} {
    global serialCmd
    global serialLog
    global chan
   # global chanLog
    global chanLogS
    global chanLogF
    global chanLog1
    serial_closeCmd
    serial_closeLog
    close $chanLog1
   # close $chanLog
    close $chanLogS
    close $chanLogF
    exit 0
}
#############################################################################
## Procedure:  dtdelay

proc ::dtdelay {dttime} {
set cur_time [clock seconds]
    while { $dttime >= [expr {[clock seconds] - $cur_time }] } {
    }
}
#############################################################################
## Procedure:  ok_dialog

proc ::ok_dialog {string} {
	set w [toplevel .ok_dialog]
	wm resizable $w 0 0
	wm title $w "INFORMATION"
	label  $w.l -font {Helvetica 30 bold} -fg red -wraplength 800 -text "\n$string\n"
	focus $w
	bind $w <KeyRelease-Return> {set done 1}
	button $w.ok -font {Helvetica 36 bold} -text OK -command {set done 1}
	
	grid $w.l -sticky news
	grid $w.ok -sticky news
	wm geometry $w 800x400+112+100
	after 100 {
    grab -global .
	}
	vwait done
	grab release .
	destroy $w
}
#############################################################################
## Procedure:  ok_dialog1

proc ::ok_dialog1 {string} {
	set w [toplevel .ok_dialog]
	wm resizable $w 0 0
	wm title $w "INFORMATION"
	label  $w.l -font {Helvetica 30 bold} -fg red -wraplength 800 -text "\n$string\n"
	focus $w
	bind $w <KeyRelease-Return> {set done 1}
	after 500
	button $w.ok -font {Helvetica 36 bold} -text OK -command {set done 1}
	
	grid $w.l -sticky news
	grid $w.ok -sticky news
	wm geometry $w 800x400+112+100
	after 100 {
    grab -global .
	}
	vwait done
	grab release .
	destroy $w
}
#############################################################################
## Procedure:  serial_closeCmd

proc ::serial_closeCmd {} {
    global serialCmd
    if {$serialCmd!=0} {
        close $serialCmd
        set serialCmd 0
    }
}
#############################################################################
## Procedure:  serial_closeLog

proc ::serial_closeLog {} {
    global serialLog

    if {$serialLog!=0} {
        close $serialLog
        set serialLog 0
    }
}
#############################################################################
## Procedure:  serial_configCmd

proc ::serial_configCmd {} {
    global portCmd_stb

    if ![winfo exists .bbox] {
        toplevel .bbox
        frame .bbox.buttons
        label .bbox.label -justify left -text  "Please click Open button after you specify the proper port number."
        pack .bbox.buttons .bbox.label -side bottom -expand 1
        button .bbox.buttons.open -text "Open" -command  {serial_openCmd $portCmd_stb; destroy .bbox; after idle {grab -global .p}}
        button .bbox.buttons.return -text Exit  -default active -command {destroy .bbox; after idle {grab -global .p}}
        pack .bbox.buttons.open .bbox.buttons.return -side left -expand 1 -padx 10 -pady 5
        frame .bbox.frame
        pack  .bbox.frame -expand yes -fill both -padx 1 -pady 1
        spinbox .bbox.frame.s -from 1 -to 10 -width 10 -validate key  -vcmd {string is integer %P} -command {set portCmd_stb %s}

        pack .bbox.frame.s -side top -expand 1 -pady 3
    } else {
        wm deiconify .bbox
        raise .bbox
    }

    .bbox.frame.s set $portCmd_stb
    wm title .bbox "Configure Command Port "
    wm iconname .bbox Configure
}
#############################################################################
## Procedure:  serial_configLog

proc ::serial_configLog {} {
    global portLog

    if ![winfo exists .bbox2] {
        toplevel .bbox2
        frame .bbox2.buttons
        label .bbox2.label -justify left -text  "Select port number for message logging"
        pack .bbox2.buttons .bbox2.label -side bottom -expand 1
        button .bbox2.buttons.open -text "Open" -command  {serial_openLog $portLog; destroy .bbox2; after idle {grab -global .p}}
        button .bbox2.buttons.return -text Exit  -default active -command {destroy .bbox2; after idle {grab -global .p}}
        pack .bbox2.buttons.open .bbox2.buttons.return -side left -expand 1 -padx 10 -pady 5

        frame .bbox2.frame
        pack  .bbox2.frame -expand yes -fill both -padx 1 -pady 1
        spinbox .bbox2.frame.s -from 1 -to 10 -width 10 -validate key  -vcmd {string is integer %P} -command {set portLog %s}

        pack .bbox2.frame.s -side top -expand 1 -pady 3
    } else {
        wm deiconify .bbox2
        raise .bbox2
    }

    .bbox2.frame.s set $portLog
    wm title .bbox2 "Configure Serial Port "
    wm iconname .bbox2 Configure
}
#############################################################################
## Procedure:  serial_openCmd

proc ::serial_openCmd {port} {
    global serialCmd
    global cmdport
    global teststatus

    if {$serialCmd!=0} {
        close $serialCmd
        set cmdport "STB:N/A"
        set teststatus "Port not open"
    }

    catch {set serialCmd [open COM$port: RDWR]} id
 		if {[string compare -length 4 $id "file"]==0} {
    catch {fconfigure $serialCmd -blocking 0 -buffering none -mode "115200,n,8,1" -encoding binary  -translation lf -handshake trscts}
    			set cmdport "STB:COM$port"
    			set teststatus "Ready"
        	.top73.fra87.cpd88 configure -state active
        	.top73.fra87.cpd91 configure -state disable
        	update    
     			after 500
       		close $serialCmd
       		set serialCmd 0
    		} else {
    			set serialCmd 0
    			print_instruction "Open Command Port FAILED!\nCOM$port Can Not Open"
        	set cmdport "STB:N/A"
        	set teststatus "Port not open"
        	.top73.fra87.cpd88 configure -state disable
        	.top73.fra87.cpd91 configure -state active
        	update
    		}
}
#############################################################################
## Procedure:  serial_openLog

proc ::serial_openLog {port} {
    global serialLog
    global logport

    if {$serialLog!=0} {
        close $serialLog
        set logport "LOG:N/A"
    }

    catch {set serialLog [open COM$port: RDWR]} id
    if {[string compare -length 4 $id "file"]==0} {
    catch {fconfigure $serialLog -blocking 0 -buffering none -mode "9600,n,8,1" -encoding binary  -translation lf -handshake trscts}
    set logport "LOG:COM$port"
    } else {
    	set serialLog 0
    	ok_dialog "Open Log Port FAILED!\nCOM$port Can Not Open"    
    }
}
#############################################################################
## Procedure:  serial_sendLog

proc ::serial_sendLog {msg} {
    global serialLog
    global BarCode
    global Station

    if {$serialLog!=0} {
       puts $serialLog   "$BarCode,$Station,$msg\r"
    }
}
#############################################################################
## Procedure:  test_result

proc ::test_result {stat} {
	global filename
	global chanLog
	set chan [open $filename "a"]
	puts $chan "$stat;"
	flush $chan			
	puts $chanLog "[clock_now] $stat;"
	flush $chanLog
}
#############################################################################
## Procedure:  test_resultF

proc ::test_resultF {stat ercode} {
	global filenameF
	global chanLogF
  global BarCode1
        
	set chan [open $filenameF "a"]
	puts $chan "[clock_now] ##SN:$BarCode1## The $stat  is Fail , Error_Code:$ercode;"
	flush $chan	
	close $chan	
	
}
#############################################################################
## Procedure:  test_resultS

proc ::test_resultS {stat} {
	global filenameS
	global chanLogS
  global BarCode1
  global BarCode2

	set chan [open $filenameS "a"]
	puts $chan "[clock_now] ##SN:$BarCode1 MAC:$BarCode2## The $stat fuction is success;"
	flush $chan	
	close $chan	
	
}
#############################################################################
## Procedure:  test_resultNC

proc ::test_resultNC {stat} {
global filename
global fileLogNC
set chan [open $fileLogNC "a"]
puts $chan "[clock_now];$stat"
flush $chan 
close $chan
}
#############################################################################
## Procedure:  test_resultZ2

proc ::test_resultZ2 {stat} {
	global filename
	global filenameZ2
  global BarCode1

	set chan [open $filenameZ2 "a"]
	puts $chan "[clock_now];$stat"
	flush $chan	
	close $chan	
}
#############################################################################
## Procedure:  test_resultZ3

proc ::test_resultZ3 {stat} {
	global filename
	global fileLogZ3
  global BarCode1

	set chan [open $fileLogZ3 "a"]
	puts $chan "[clock_now];$stat"
	flush $chan	
	close $chan		
}
#############################################################################
## Procedure:  Check_key

proc ::Check_key {key_word} {
	global portCmd_stb
	global serialCmd 
	global send_exp
	global regexp
	
	set fh $serialCmd
	set send_exp($fh.matched)   0
	
	set regexp $key_word
	
	if {![info exists send_exp($fh.buffer)]} {
	    set send_exp($fh.buffer) {}
	}
	# set up our Read handler before outputting the string.
	#if {![info exists send_exp($fh.setReader)]} {
	    fileevent $fh readable [list private_send_exp_reader $fh]
	#    set send_exp($fh.setReader) 1
	#}
	
	# set up a timer so that we wait a limited amt of seconds,5000
	#set afterId [after 10000 [list set send_exp($fh.matched) 0]]
	set afterId [after 20000 [list set send_exp($fh.matched) 0]]
	vwait send_exp($fh.matched)
	set matched $send_exp($fh.matched)
	unset send_exp($fh.matched)
	catch [list after cancel $afterId]
	
	set send_exp($fh.buffer) {}		
	
	if {$matched == 0} {
	    return 0
	}
	
	
	return 1
}
#############################################################################
## Procedure:  Check_key1

proc ::Check_key1 {key_word wait_time} {
		global portCmd_stb
		global serialCmd 
		global send_exp
		global regexp

		set fh $serialCmd
		set send_exp($fh.matched)   0
		
		set regexp $key_word
		
		if {![info exists send_exp($fh.buffer)]} {
    		set send_exp($fh.buffer) {}
		}
		# set up our Read handler before outputting the string.
		#if {![info exists send_exp($fh.setReader)]} {
		 		fileevent $fh readable [list private_send_exp_reader $fh]
		#    set send_exp($fh.setReader) 1
		#}

		# set up a timer so that we wait a limited amt of seconds,5000
		set afterId [after $wait_time [list set send_exp($fh.matched) 0]]
		vwait send_exp($fh.matched)
		set matched $send_exp($fh.matched)
		unset send_exp($fh.matched)
		catch [list after cancel $afterId]

		set send_exp($fh.buffer) {}		
		
		if {$matched == 0} {
		    return 0
		}
		
		return 1
}
#############################################################################
## Procedure:  Check_key2

proc ::Check_key2 {key_word waiting} {
	global portCmd_stb
	global serialCmd 
	global send_exp
	global regexp
	
	set fh $serialCmd
	set send_exp($fh.matched)   0
	
	set regexp $key_word
	
	if {![info exists send_exp($fh.buffer)]} {
	    set send_exp($fh.buffer) {}
	}
	# set up our Read handler before outputting the string.
	#if {![info exists send_exp($fh.setReader)]} {
	    fileevent $fh readable [list private_send_exp_reader $fh]
	#    set send_exp($fh.setReader) 1
	#}
	
	# set up a timer so that we wait a limited amt of seconds,5000
	set afterId [after $waiting [list set send_exp($fh.matched) 0]]
	vwait send_exp($fh.matched)
	after 2000
	set matched $send_exp($fh.matched)

	unset send_exp($fh.matched)
	catch [list after cancel $afterId]
	
	set send_exp($fh.buffer) {}		
	
	if {$matched == 0} {
	    return 0
	}
	
	return 1
}
#############################################################################
## Procedure:  Check_key_long

proc ::Check_key_long {key_word} {
	global portCmd_stb
	global serialCmd 
	global send_exp
	global regexp
	
	set fh $serialCmd
	set send_exp($fh.matched)   0
	
	set regexp $key_word
	
	if {![info exists send_exp($fh.buffer)]} {
	    set send_exp($fh.buffer) {}
	}
	# set up our Read handler before outputting the string.
	#if {![info exists send_exp($fh.setReader)]} {
	    fileevent $fh readable [list private_send_exp_reader $fh]
	#    set send_exp($fh.setReader) 1
	#}
	
	# set up a timer so that we wait a limited amt of seconds,5000
	set afterId [after 75000 [list set send_exp($fh.matched) 0]]
	vwait send_exp($fh.matched)
	set matched $send_exp($fh.matched)
	unset send_exp($fh.matched)
	catch [list after cancel $afterId]
	
	set send_exp($fh.buffer) {}		
	
	if {$matched == 0} {
	    return 0
	}
	
	
	return 1
}
#############################################################################
## Procedure:  Check_key_Eth

proc ::Check_key_Eth {key_word} {
	
	global telnetCmd 
	global send_exp
	global regexp
	
	set fh $telnetCmd
	set send_exp($fh.matched)   0
	
	set regexp $key_word
	
	if {![info exists send_exp($fh.buffer)]} {
	    set send_exp($fh.buffer) {}
	}
	# set up our Read handler before outputting the string.
	#if {![info exists send_exp($fh.setReader)]} {
	    fileevent $fh readable [list private_send_exp_reader $fh]
	#    set send_exp($fh.setReader) 1
	#}
	
	# set up a timer so that we wait a limited amt of seconds,5000
	#set afterId [after 10000 [list set send_exp($fh.matched) 0]]
	set afterId [after 20000 [list set send_exp($fh.matched) 0]]
	vwait send_exp($fh.matched)
	set matched $send_exp($fh.matched)
	unset send_exp($fh.matched)
	catch [list after cancel $afterId]
	
	set send_exp($fh.buffer) {}		
	
	if {$matched == 0} {
	    return 0
	}
	
	
	return 1
}
#############################################################################
## Procedure:  private_send_exp_reader

proc ::private_send_exp_reader {fh} {
		global send_exp
		global regexp
 
    if {[eof $fh]} {
    	    close $fh
    	    set send_exp($fh.matched) 0
    	    #return
    }
    
   if {[catch {read $fh} str]==0} {
   	     append send_exp($fh.buffer) $str
             if {[regexp $regexp $send_exp($fh.buffer)]} {                
               		set send_exp($fh.matched) 1
                  }
		
    }
}
#############################################################################
## Procedure:  private_send_exp_reader1

proc ::private_send_exp_reader1 {fh} {
	global send_exp
	global regexp
 
   if {[eof $fh]} {
    	    close $fh
    	    set send_exp($fh.matched) 0
    	    #return
    }
   
   if {[catch {read $fh} str]==0} {
   	    after 1000
   	    append send_exp($fh.buffer) $str
        puts "matttt == $send_exp($fh.buffer)"
        puts "regexp == $regexp"  
        puts "fh == $send_exp($fh.buffer)"  
        
        if {[regexp $regexp $send_exp($fh.buffer)]} { 
          #puts $fh root 
          #flush $fh 
          #after 100
           
    		#if {[Check_key2 "Password:" 5000]!= 1 } {                               
				#		print_instruction "Password fail"
				#		return 0
        #	}     			  		
    		#	puts $fh "\n"
        #	flush $fh
        #	after 100	   		
                          
          set send_exp($fh.matched) 1
            }
    }
}
#############################################################################
## Procedure:  private_send_exp_reader2

proc private_send_exp_reader2 {fh} {
	global send_exp
	global regexp
	global serialCmd
    
    if {[eof $fh]} {
    	close $fh
    	set send_exp($fh.matched) 0
    	#return
   	}
    
  	
  	if {[catch {read $fh} str] == 0} {
  		after 100
    	append send_exp($fh.buffer) $str
    	puts "regexp == $regexp"  
        puts "fuckxxh == $send_exp($fh.buffer)"  
        
        if {[regexp $regexp $send_exp($fh.buffer)]} {                  
            set send_exp($fh.matched) 1
        }
	}
}
#############################################################################
## Procedure:  gpibw2

proc gpibw2 {gpibHandle stat} {
	gpib clear -device $gpibHandle
	gpib write -device $gpibHandle -message "$stat"
	after 500
}
#############################################################################
## Procedure:  gpibr2

proc gpibr2 {} {
	global gpibCmd
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
#############################################################################
## Procedure:  FindString2

proc FindString2 {SCmd Sstring1 Slength} {  
	global serialCmd 
	global send_exp
	global regexp
	global fh
	global Qtmp
	global Q3
	
	set Q3 $Slength
	set Qtmp ""
	set regexp $Sstring1
	puts "serialCmd=$serialCmd"
	set fh $serialCmd
	puts "fh = $fh"
	puts "Command =$SCmd"
	puts $fh "$SCmd"
	flush $fh
	set send_exp($fh.matched) 0
	set send_exp($fh.buffer) {}
	if {![info exists send_exp($fh.buffer)]} {
	    set send_exp($fh.buffer) {}
	}
	
	# set up our Read handler before outputting the string.
	#if {![info exists send_exp($fh.setReader)]} {
	catch {fileevent $fh readable [list Findstring3 $fh $Q3]} result
	puts "1.result==$result"
	if {[string first "can not find channel named \" 0 \"" $result] != -1} {
		fileevent $fh readable [list Findstring3 $fh $Q3]
	}
	#    set send_exp($fh.setReader) 1
	#}
	#puts $fh "$SCmd"
	#flush $fh
	set afterId [after 15000 [list set send_exp($fh.matched) 0]]
	vwait send_exp($fh.matched)
	set matched $send_exp($fh.matched)
	unset send_exp($fh.matched)
	unset Q3
	catch [list after cancel $afterId]
	set send_exp($fh.buffer) 
	if {$matched==1} {
		puts "test ok,length == [string length $Qtmp]"			
		return $Qtmp
	}			
	return 9999    
}
#############################################################################
## Procedure:  FindString2_1

proc FindString2_1 {SCmd Sstring1 Slength} {  
	global serialCmd 
	global send_exp
	global regexp
	global fh
	global Qtmp
	global Q3
	
	set Q3 $Slength
	set Qtmp ""
	set regexp $Sstring1
	puts "serialCmd=$serialCmd"
	set fh $serialCmd
	puts "fh = $fh"
	puts "Command =$SCmd"
	puts $fh "$SCmd"
	flush $fh
	set send_exp($fh.matched) 0
	set send_exp($fh.buffer) {}
	if {![info exists send_exp($fh.buffer)]} {
	    set send_exp($fh.buffer) {}
	}
	
	# set up our Read handler before outputting the string.
	#if {![info exists send_exp($fh.setReader)]} {
	catch {fileevent $fh readable [list Findstring3 $fh $Q3]} result
	puts "1.result==$result"
	if {[string first "can not find channel named \" 0 \"" $result] != -1} {
		fileevent $fh readable [list Findstring3 $fh $Q3]
	}
	#    set send_exp($fh.setReader) 1
	#}
	#puts $fh "$SCmd"
	#flush $fh
	set afterId [after 1500 [list set send_exp($fh.matched) 0]]
	vwait send_exp($fh.matched)
	set matched $send_exp($fh.matched)
	unset send_exp($fh.matched)
	unset Q3
	catch [list after cancel $afterId]
	set send_exp($fh.buffer) 
	if {$matched==1} {
		puts "test ok,length == [string length $Qtmp]"			
		return $Qtmp
	}			
	return 9999    
}
#############################################################################
## Procedure:  FindString2_2

proc FindString2_2 {SCmd Sstring1 Slength} {  
	global serialCmd 
	global send_exp
	global regexp
	global fh
	global Qtmp
	global Q3
	
	set Q3 $Slength
	set Qtmp ""
	set regexp $Sstring1
	puts "serialCmd=$serialCmd"
	set fh $serialCmd
	puts "fh = $fh"
	puts "Command =$SCmd"
	puts $fh "$SCmd"
	flush $fh
	set send_exp($fh.matched) 0
	set send_exp($fh.buffer) {}
	if {![info exists send_exp($fh.buffer)]} {
	    set send_exp($fh.buffer) {}
	}
	
	# set up our Read handler before outputting the string.
	#if {![info exists send_exp($fh.setReader)]} { 
	catch {fileevent $fh readable [list Findstring3 $fh $Q3]} result
	puts "1.result==$result"
	if {[string first "can not find channel named \" 0 \"" $result] != -1} {
		fileevent $fh readable [list Findstring3 $fh $Q3]
	}
	#    set send_exp($fh.setReader) 1
	#}
	#puts $fh "$SCmd"
	#flush $fh
	set afterId [after 10000 [list set send_exp($fh.matched) 0]]
	vwait send_exp($fh.matched)
	set matched $send_exp($fh.matched)
	unset send_exp($fh.matched)
	unset Q3
	catch [list after cancel $afterId]
	set send_exp($fh.buffer) 
	if {$matched==1} {
		puts "test ok,length == [string length $Qtmp]"			
		return $Qtmp
	}			
	return 9999    
}

############################################################################
## Findstring3

proc Findstring3 {fh Slength} {
		global send_exp
		global regexp
		global Qtmp
	
		#puts "Qth=$Qth" 
		if {[eof $fh]} {
			close $fh
		    set send_exp($fh.matched) 0
		}
		
		set str ""  
		if {[catch {read $fh} str]==0} { 
				append send_exp($fh.buffer) $str  
	   		after 500 
	    	if {[string last $regexp $send_exp($fh.buffer)]!= -1} {                 
				set qline $send_exp($fh.buffer)
				puts "4.qline=$qline"
				set target_first [string last $regexp $qline]
				#ok_dialog "target_first = $target_first"
	      puts "target_first=$target_first"
	      set target_end [expr $target_first + $Slength - 1 ]  
	      #ok_dialog "target_end == $target_end"
	      puts "target_end=$target_end"
				set qline [string range $qline $target_first $target_end]
				puts "$Slength == [string length $qline]"
				puts "5.qline==$qline"
				set Qtmp $qline      					 
	      set send_exp($fh.matched) 1
	    }           
		
	}
}


#############################################################################
## Procedure:  convert

proc ::convert {stat} {
set stat [format "%2.2f" [string range $stat 0 end-1]]
return $stat
}
#############################################################################
## Procedure:  LoadData

proc ::LoadData {} {
  	global BarCode0
  	global BarCode1
  	global BarCode2
  	global BarCode3
  	global BarCode4
		global TXT_ManufactureDate

		if {![file exists "matt.txt"]} {
  	    return 0 
		}
	
		set chan [open "matt.txt" "r"]  
		while {[gets $chan line] >= 0} {
			regsub -all " " $line "" line
		 	if { [regexp $BarCode0 $line] == 1} {
  				set line [split $line ";"]
					scan $line "%s %s %s %s %s" lowlabel sn mac mac1 hilabel
					set TXT_ManufactureDate [clock format [clock sec] -format %m-%d-%y]				
  	 			close $chan
  	 			set BarCode0 $lowlabel
  	 			set BarCode1 $sn
  	 			set BarCode2 $mac
  	 			set BarCode3 $mac1
  	 			set BarCode4 $hilabel			
  	  		return 1
			}                                      
  	}
  		close $chan
  		return 0   
}
#############################################################################
## Procedure:  LoadData1

proc ::LoadData1 {} {
		
  	global BarCode1
  	global BarCode2
  	global BarCode3
  	global BarCode4
  	global sn
		global mac
		global devicesn
		global mac
		global boardsn
		global TXT_ManufactureDate
		set sn ""
		set mac ""
		set boardsn ""
		
    
	if {![file exists "em8635snmac1.txt"]} {
			#ok_dialog "pass"
			print_instruction "Can't find em8635snmac1.txt"
      return 0 
	}
	
	#set chan [open "gvp080825_notitle.txt" "r"]
	set chan [open "em8635snmac1.txt" "r"]
	while {[gets $chan line] >= 0} {
			regsub -all " " $line "" line
	 		if { [regexp $BarCode1 $line] == 1} {
  				set line [split $line ";"]
					scan $line "%s %s" sn1 mac1 
					set TXT_ManufactureDate [clock format [clock sec] -format %m-%d-%y]				
   				close $chan
   				set BarCode3 $sn1
   				set BarCode4 $mac1
    			return 1
		  }
  }
  #print_instruction "SN Number : $BarCode1\n Not exist!!"
  
  close $chan
  return 0   
}
#############################################################################
## Procedure:  print_instruction

proc ::print_instruction {action} {
 	.top73.mes86 config -text "$action" 	 	
    update
}
#############################################################################
## Procedure:  print_instruction2

proc ::print_instruction2 {action1 action2} {
 	.top73.fra87.cpd88 config -text "$action1"			;#Pass
 	.top73.fra87.cpd91 config -text "$action2" 	 		;#Fail
    update
}
#############################################################################
## Procedure:  em8654_function

proc em8654_function {} {uplevel {
		global serialCmd
		global cts	
		global SM
		global SIM_CARD
		global gpibCmd
		global addrnum_vm700
		global id
		global result
		global table_name
		global BarCode0
		global BarCode1
		global BarCode2
		global BarCode3
		global BarCode4
		global BarCode2_1
		global BarCode11
		global BarCode33
		global barcodescan  
		global a_serial
		global a_eth_mac
		global ip_1
		set BarCode2_1 ""
		set test_go 1
		set restart_go 1
		global TestTime	
		global SFISresult
  	global UnitReport
  	global apt_tmp
  	global time_log
		
		focus -force  .top73.fra87.but99
		set now_time [clock format [clock sec] -format %Y%m%d] 
		set runtime [clock_now]
		set dbresult "'$BarCode0','$BarCode1','$BarCode2','$BarCode3','$BarCode4','$runtime','PASS'" 	   
		
		puts $serialCmd "setxenv 0 a.pt 00"				;#set DUT Flow control default value 00
		flush $serialCmd
		after 100

#############################################################################

	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "Get_Version"
	set GetVersionStart [clock seconds]
	if {![Get_Version]} {
			.top73.fra87.but99  configure -state disable
    	.top73.fra87.but100  configure -state disable
    	.top73.fra87.cpd88 configure -state disable
    	.top73.fra87.cpd91 configure -state active
    	#print_instruction "Check Version Fail;"  
    	test_resultZ2 "Check Version Fail"
    	puts $cts "Show $id Get Version Test Fail"
    	flush $cts 
    	append SFISresult "T680_FAIL;"   
      append UnitReport "Check Firmware Version : Fail\n"
      lappend time_log "T680 Check Firmware Version : Fail\n"
      ConnectSFIS3 FAIL $SFISresult
      after 1000
      WriteLog T680 FAIL $UnitReport
      set Test_item "T680 fail"
   		return 0
	}	
		
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "Check Version Pass"
    append dbresult ",'$ver'"
    append result "Check_Version PASS;"
    puts $cts "Show $id Get Version Test Pass"
    flush $cts
    append SFISresult "T680_$ver;"   
 		append UnitReport "Get Firmware Version : Pass\n" 
 		lappend time_log "T680 Get Firmware Version : Pass\n"    
   
    set GetVersionEnd [clock seconds]
		set GetVersionEnd [expr $GetVersionEnd - $GetVersionStart]
		puts $TestTime "Get Version         : $GetVersionEnd  sec."
		flush $TestTime
		lappend time_log "T680 Get Version         : $GetVersionEnd  sec."
 
#############################################################################
	
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "USB_Test"
	set USBStart [clock seconds]
	if {![USB_Check]} {
		if {![USB_Check]} {
				.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		print_instruction "USB Check Fail;"  
    		test_resultZ2 "USB Check Fail"
    		puts $cts "Show $id USB Check Fail"
    		flush $cts
    		append SFISresult "T1361_FAIL;"   
      	append UnitReport "USB Check : Fail\n"
      	lappend time_log "T1361 USB Check : Fail\n"
      	ConnectSFIS3 FAIL $SFISresult
      	after 1000
      	WriteLog T1361 FAIL $UnitReport
      	set Test_item "T1361 fail"
   			return 0
		}
	}	
		
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "USB Check Pass"
    append dbresult ",'PASS'"
    append result "USB Check PASS;"
    puts $cts "Show $id USB Check Pass"
    flush $cts    
    after 100
    append SFISresult "T1361_PASS;"   
 		append UnitReport "USB_Check : Pass\n"
 		lappend time_log "T1361 USB_Check : Pass\n"  
    
    set USBEnd [clock seconds]
		set USBEnd [expr $USBEnd - $USBStart]
		puts $TestTime "USB Check      : $USBEnd  sec."
		flush $TestTime
		lappend time_log "T1361 USB Check      : $USBEnd  sec."
 

#############################################################################
#	.top73.fra87.but99  configure -state disable
#	.top73.fra87.but100  configure -state disable
#	.top73.fra87.cpd88 configure -state disable
#	.top73.fra87.cpd91 configure -state disable
#    
#	set Test_item "Flash Test"
#	set FlashStart [clock seconds]
#	if {![Flash_Check]} {
#		if {![Flash_Check]} {
#			.top73.fra87.but99  configure -state disable
#    		.top73.fra87.but100  configure -state disable
#    		.top73.fra87.cpd88 configure -state disable
#    		.top73.fra87.cpd91 configure -state active
#    		print_instruction "Flash Check Fail;"  
#    		test_resultZ2 "Flash Check Fail" 
#    		puts $cts "Show $id Flash Check Test Fail"
#    		flush $cts
#    		set SFISresult "T104_FAIL;"   
#      	append UnitReport "Flash Check : Fail\n"
#      	ConnectSFIS3 M104 $SFISresult
#      	WriteLog M104 FAIL $UnitReport
#      	set Test_item "M104 fail"
#   			return 0
#		}
#	}	
#			
#		.top73.fra87.but99  configure -state disable
#    .top73.fra87.but100  configure -state disable
#    .top73.fra87.cpd88 configure -state active
#    .top73.fra87.cpd91 configure -state disable
#    print_instruction "Flash Check Pass"
#    append dbresult ",'PASS'"
#    append result "Flash Check PASS;"
#    puts $cts "Show $id Flash Check Pass"
#    flush $cts  
#    append SFISresult "T104_PASS;"   
# 		append UnitReport "Flash_Check : Pass\n"   
#   
#    set FlashEnd [clock seconds]
#		set FlashEnd [expr $FlashEnd - $FlashStart]
#		puts $TestTime "Flash Check         : $FlashEnd  sec."
#		flush $TestTime  

#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "Ethernet Test"
	set EthernetStart [clock seconds]
	if {![Ethernet_Check]} {
		if {![Ethernet_Check]} {
				.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		#print_instruction "Ethernet Check Fail;"  
    		test_resultZ2 "Ethernet Check Fail" 
    		puts $cts "Show $id Ethernet Check Test Fail"
    		flush $cts
    		append SFISresult "T453_FAIL;"   
      	append UnitReport "Ethernet Check : Fail\n"
      	lappend time_log "T453 Ethernet Check : Fail\n"
      	ConnectSFIS3 FAIL $SFISresult
      	after 1000
      	WriteLog T453 FAIL $UnitReport
      	set Test_item "T453 fail"
   			return 0
		}
	}	
			
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "Ethernet Check Pass"
    append dbresult ",'PASS'"
    append result "Ethernet Check PASS;"
    puts $cts "Show $id Ethernet Check Pass"
    flush $cts  
    append SFISresult "T453_PASS;"   
 		append UnitReport "Ethernet_Check : Pass\n" 
 		lappend time_log "T453 Ethernet_Check : Pass\n" 
   
    set EthernetEnd [clock seconds]
		set EthernetEnd [expr $EthernetEnd - $EthernetStart]
		puts $TestTime "Ethernet Check         : $EthernetEnd sec."
		flush $TestTime 
		lappend time_log "T453 Ethernet Check         : $EthernetEnd sec."


#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
 
	set Test_item "FW Version Compare"
	set FWverStart [clock seconds]
	if {![FW_Ver_Compare]} {
			.top73.fra87.but99  configure -state disable
    	.top73.fra87.but100  configure -state disable
    	.top73.fra87.cpd88 configure -state disable
    	.top73.fra87.cpd91 configure -state active 
    	test_resultZ2 "FW Version Compare Fail"
    	puts $cts "Show $id FW Version Compare Test Fail"
    	flush $cts
   		return 0
	}	
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "FW Version Compare Pass"
    append result "FW Version Compare PASS;"
    puts $cts "Show $id FW Version Compare Test Pass"
    flush $cts                 
    
    set FWverEnd [clock seconds]
		set FWverEnd [expr $FWverEnd - $FWverStart]
		puts $TestTime "Compare FW Version    		 : $FWverEnd  sec."
		flush $TestTime 
		lappend time_log "Compare FW Version    		 : $FWverEnd  sec."		

#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "SN_MAC Compare"
	set SNMACStart [clock seconds]
	if {![SNMAC_Compare]} {
			.top73.fra87.but99  configure -state disable
    	.top73.fra87.but100  configure -state disable
    	.top73.fra87.cpd88 configure -state disable
    	.top73.fra87.cpd91 configure -state active
    	test_resultZ2 "SN_MAC Compare Fail"
    	puts $cts "Show $id SN_MAC Compare Test Fail"
    	flush $cts 
   		return 0
	}
		
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "SN_MAC Compare Pass"
    append result "SN_MAC Compare PASS;"
    puts $cts "Show $id SN_MAC Compare Test Pass"
    flush $cts          
   	
   	set SNMACEnd [clock seconds]
		set SNMACEnd [expr $SNMACEnd - $SNMACStart]
		puts $TestTime "SN_MAC Compare            : $SNMACEnd  sec."
		flush $TestTime
		lappend time_log "SN_MAC Compare            : $SNMACEnd  sec."		
		
#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "RCA Video Level Test"
	set RCAVideoStart [clock seconds]
	if {![Check_Video_Level 1]} { 
		if {![Check_Video_Level 1]} {
				.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		print_instruction "Check Video_level Fail;"  
    		test_resultZ2 "Check Video_level Fail"
    		puts $cts "Show $id Check Video_level Test Fail"
    		flush $cts
    		append SFISresult "T1195_FAIL;"   
      	append UnitReport "RCA Video Level Check : Fail\n"
      	lappend time_log "T1195 RCA Video Level Check : Fail\n"
      	ConnectSFIS3 FAIL $SFISresult
      	after 1000
      	WriteLog T1195 FAIL $UnitReport
      	set Test_item "T1195 fail"
   			return 0
		}
	}	
	
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "Check Video_level Pass"
    append dbresult ",'$Video_level'"
    append result "Check Video_level PASS;"
    puts $cts "Show $id Check Video_level Test Pass"
    flush $cts 
    append SFISresult "T1195_$Video_level;"   
 		append UnitReport "RCA Video Level Check : Pass\n" 
 		lappend time_log "T1195 RCA Video Level Check : Pass\n"
    
    set RCAVideoEnd [clock seconds]
		set RCAVideoEnd [expr $RCAVideoEnd - $RCAVideoStart]
		puts $TestTime "RCA Video Level     : $RCAVideoEnd  sec."
		flush $TestTime  
		lappend time_log "T1195 RCA Video Level     : $RCAVideoEnd  sec."

#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "RCA LAudio Level Test"
	set LAudioStart [clock seconds]
	if {![Check_LAudio_Level 2]} { 
		if {![Check_LAudio_Level 2]} {
				.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		print_instruction "Check LAudio Level Fail;"  
    		test_resultZ2 "Check LAudio Level Fail"
    		puts $cts "Show $id Check LAudio Level Test Fail"
    		flush $cts
    		append SFISresult "T1194_FAIL;"   
      	append UnitReport "RCA Left Audio Level Check : Fail\n"
      	lappend time_log "T1194 RCA Left Audio Level Check : Fail\n"
      	ConnectSFIS3 FAIL $SFISresult
      	after 1000
      	WriteLog T1194 FAIL $UnitReport
      	set Test_item "T1194 fail"
   			return 0
		}
	}	
	
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "Check LAudio Level Pass"
    append dbresult ",'$LAudio'"
    append result "Check LAudio Level PASS;"
    puts $cts "Show $id Check LAudio Level Test Pass"
    flush $cts 
    append SFISresult "T1194_$LAudio;"   
 		append UnitReport "RCA Left Audio Level Check : Pass\n" 
 		lappend time_log "T1194 RCA Left Audio Level Check : Pass\n"
    
    set LAudioEnd [clock seconds]
		set LAudioEnd [expr $LAudioEnd - $LAudioStart]
		puts $TestTime "RCA LAudio Level     : $LAudioEnd  sec."
		flush $TestTime
		lappend time_log "T1194 RCA LAudio Level     : $LAudioEnd  sec." 
		
#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "RCA RAudio Level Test"
	set RAudioStart [clock seconds]
	if {![Check_RAudio_Level 3]} { 
		if {![Check_RAudio_Level 3]} {
				.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		print_instruction "Check RAudio Level Fail;"  
    		test_resultZ2 "Check RAudio Level Fail"
    		puts $cts "Show $id Check RAudio Level Test Fail"
    		flush $cts
    		append SFISresult "T1168_FAIL;"   
      	append UnitReport "RCA Right Audio Level Check : Fail\n"
      	lappend time_log "T1168 RCA Right Audio Level Check : Fail\n"
      	ConnectSFIS3 FAIL $SFISresult
      	after 1000
      	WriteLog T1168 FAIL $UnitReport
      	set Test_item "T1168 fail"
   			return 0
		}
	}	
	
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "Check RAudio Level Pass"
    append dbresult ",'$RAudio'"
    append result "Check RAudio Level PASS;"
    puts $cts "Show $id Check RAudio Level Test Pass"
    flush $cts
    append SFISresult "T1168_$RAudio;"   
 		append UnitReport "RCA Right Audio Level Check : Pass\n" 
 		lappend time_log "T1168 RCA Right Audio Level Check : Pass\n"
	
		set RAudioEnd [clock seconds]
		set RAudioEnd [expr $RAudioEnd - $RAudioStart]
		puts $TestTime "RCA RAudio Level     : $RAudioEnd  sec."
		flush $TestTime 	
		lappend time_log "T1168 RCA RAudio Level     : $RAudioEnd  sec."

#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "YPbPr Video Level Test"
	set YPbPrVideoStart [clock seconds]
	if {![Check_YPbPr_Level 1]} { 
		if {![Check_YPbPr_Level 1]} {
				.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		print_instruction "Check YPbPr_level Fail;"  
    		test_resultZ2 "Check YPbPr_level Fail"
    		puts $cts "Show $id Check YPbPr_level Test Fail"
    		flush $cts
    		append SFISresult "T1174_FAIL;"   
      	append UnitReport "Y Sync Level Check : Fail\n"
      	lappend time_log "T1174 Y Sync Level Check : Fail\n"
      	ConnectSFIS3 FAIL $SFISresult
      	after 1000
      	WriteLog T1174 FAIL $UnitReport
      	set Test_item "T1174 fail"
   			return 0
		}
	}	
	
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "Check YPbPr_level Pass"
    append dbresult ",'$YPbPr_level'"
    append result "Check YPbPr_level PASS;"
    puts $cts "Show $id Check YPbPr_level Test Pass"
    flush $cts 
    append SFISresult "T1174_$YPbPr_level;"   
 		append UnitReport "Y Sync Level Check : Pass\n" 
 		lappend time_log "T1174 Y Sync Level Check : Pass\n" 
    
    set YPbPrVideoEnd [clock seconds]
		set YPbPrVideoEnd [expr $YPbPrVideoEnd - $YPbPrVideoStart]
		puts $TestTime "YPbPr Video Level     : $YPbPrVideoEnd  sec."
		flush $TestTime 
		lappend time_log "T1174 YPbPr Video Level     : $YPbPrVideoEnd  sec."	
		
#############################################################################
	.top73.fra87.but99  configure -state disable
	.top73.fra87.but100  configure -state disable
	.top73.fra87.cpd88 configure -state disable
	.top73.fra87.cpd91 configure -state disable
    
	set Test_item "S_Video Level Test"
	set SVideoStart [clock seconds]
	if {![Check_SVideo_Level 2]} { 
		if {![Check_SVideo_Level 2]} {
				.top73.fra87.but99  configure -state disable
    		.top73.fra87.but100  configure -state disable
    		.top73.fra87.cpd88 configure -state disable
    		.top73.fra87.cpd91 configure -state active
    		print_instruction "Check SVideo_level Fail;"  
    		test_resultZ2 "Check SVideo_level Fail"
    		puts $cts "Show $id Check SVideo_level Test Fail"
    		flush $cts
    		append SFISresult "T110_FAIL;"   
      	append UnitReport "SVideo Level Check : Fail\n"
      	lappend time_log "T110 SVideo Level Check : Fail\n"
      	ConnectSFIS3 FAIL $SFISresult
      	after 1000
      	WriteLog M110 FAIL $UnitReport
      	set Test_item "M110 fail"
   			return 0
		}
	}	
	
		.top73.fra87.but99  configure -state disable
    .top73.fra87.but100  configure -state disable
    .top73.fra87.cpd88 configure -state active
    .top73.fra87.cpd91 configure -state disable
    print_instruction "Check SVideo_level Pass"
    append dbresult ",'$SVideo_level'"
    append result "Check SVideo_level PASS;"
    puts $cts "Show $id Check SVideo_level Test Pass"
    flush $cts 
    append SFISresult "T110_$SVideo_level;"   
 		append UnitReport "SVideo Level Check : Pass\n" 
 		lappend time_log "T110 SVideo Level Check : Pass\n"
 		
 		set SVideoEnd [clock seconds]
		set SVideoEnd [expr $SVideoEnd - $SVideoStart]
		puts $TestTime "S_Video Level     : $SVideoEnd  sec."
		flush $TestTime 
		lappend time_log "T110 S_Video Level     : $SVideoEnd  sec."
 		
 		puts -nonewline $serialCmd "q"	
		flush $serialCmd
		after 500
		
		puts -nonewline $serialCmd "\n"	
		flush $serialCmd
		after 200
		
		for { set i 0 } { $i < 10 } {incr i } { 	
				puts $serialCmd "setxenv 0 a.pt 20"
   			flush $serialCmd	
   			after 300
			
				set Cmd "setxenv 0 a.pt"    
				set Cmdtmpfirst "2 a.pt" 
				set apt [FindString2 $Cmd $Cmdtmpfirst 16]
				puts $apt
				set apt [string range $apt 14 15]
				regsub -all " " $apt "" apt
				
				if {[string length $apt] == 2} {
						if {[regexp $apt_tmp $apt] == 1} {
								print_instruction "DUT Flow Control == $apt"  
								return 1
	  				}		
				}			
				print_instruction "DUT Flow Control == $apt"    
				after 100
		}   
    return 0	
			
}}

#############################################################################
## Procedure:  Get_Version

proc Get_Version {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global ver
		global TestTime	
		global ver_tmp
		
		puts $serialCmd "cat /etc/mipsutils_version"
		flush $serialCmd 
		after 100
		
		print_instruction "Get Version ..."	
		for { set i 0 } { $i < 5 } {incr i } { 	
				set Cmd "cat /etc/mipsutils_version"    
				set Cmdtmpfirst "3." 
				set ver1 [FindString2 $Cmd $Cmdtmpfirst 8]
				puts $ver1
				set ver [string range $ver1 0 6]
				regsub -all " " $ver "" ver
				
				if {[string length $ver] == 7} {
						if {[regexp $ver_tmp $ver] == 1} {
								print_instruction "FW Version == $ver Pass"  
								return 1
	  				}		
				}
						
				print_instruction "FW Version == $ver Fail"    
				after 100
		}   
		return 0	
}

#############################################################################
## Procedure:  Check_USB

proc ::Check_USB {} {
	global serialCmd
	global cts	
	global id
	global result
	global BarCode1
	global usb_test
	global TestTime
 	print_instruction "Check USB Device ..."	
	#set runtime [clock_now]
	puts $serialCmd "mount -t vfat /dev/sda1 /mnt/usb/usb1"
	flush $serialCmd 
	after 100
   	if {[Check_key "Device or resource busy"]!=1} { 
  		ok_dialog "USB Check Fail"
  		return 0
  	}
  	return 1
}
#############################################################################
## Procedure:  Check_LED

proc ::Check_LED {} {
	global serialCmd
	global cts	
	global id
	global result
	global BarCode1
	global led_test
	global pass1
	global TestTime
  
   	print_instruction "Check LED ..."	
	puts $serialCmd "cd /mnt/usb/usb1"    
  	flush $serialCmd
  	after 100  	
  	puts $serialCmd "./MFG_led &"
	flush $serialCmd
  	after 500
  	puts $serialCmd ""
  	flush $serialCmd 
  	print_instruction "Check LEDs & Color"	
  	.top73.fra87.cpd88 configure -state normal
  	.top73.fra87.cpd91 configure -state normal
  	
  	focus -force .top73.fra87.but99
  	set pass1 0
	print_instruction "Check LEDs & Color\n1.If OK Press \"Enter\" key\n2.If Bad or Retry again Press \"n\" key"
	vwait pass1
  	
	
  	if {$pass1 == 0} {
  		.top73.fra87.cpd88 configure -state disable
  	  	.top73.fra87.cpd91 configure -state active
  		ok_dialog "LEDs Check Fail"
  		return 0
  	} else {
  		.top73.fra87.cpd88 configure -state active
  		.top73.fra87.cpd91 configure -state disable
  		return 1
  	}
}
#############################################################################
## Procedure:  Check_IR

proc ::Check_IR {} {
	global serialCmd
	global cts	
	global id
	global result
	global BarCode1
	global ir_test
	global TestTime

  	print_instruction "Please input IR <OK>"  	
	puts $serialCmd "B"				;#B is IR Command
	flush $serialCmd             
    after 100
	if {[Check_key "OK"]!= 1 } {
		ok_dialog "IR Check Fail"		
		return 0
	}		
    return 1
}
#############################################################################
## Procedure:  Check_Ethernet

proc ::Check_Ethernet {} {
	global serialCmd
	global cts	
	global id
	global result
	global BarCode1
	global ethnet_test
	global TestTime
	global ip_1 		
	##if {[catch {exec ping.exe 192.168.1.1 -n 4} resultIP] != 0} {  ;# Ping DHCP Server
	##	print_instruction "Ethernet FAIL"
	##    return 0
	##} else {					
	##	puts $resultIP
	##	if { [string first "Lost = 0" $resultIP] != -1 } {
    ##     	print_instruction "PC Ping DHCP OK"         	
    ##	} else {
    ##     	ok_dialog "IP Unstable and Try again!!"
    ##     	set resultIP ""
    ##   		if {[catch {exec ping.exe 192.168.1.1 -n 4} resultIP] != 0} { ;# Ping DHCP Server
	##			print_instruction "Ethernet FAIL"
	##    		return 0
	##		}
	##		if { [string first "Lost = 0" $resultIP] != -1 } {
    ##     		print_instruction "Ping DHCP Server OK"
    ##		} else {  
    ##     		return 0
    ##   		}
    ##  	}
    ##}
    #########Find Em8634 IP##############
    set Cmd "ifconfig eth0"
    set Cmdtmpfirst "inet addr:"
    set ip [FindString2 $Cmd $Cmdtmpfirst 62]
    if {$ip == 9999} {
    	set ip [FindString2 $Cmd $Cmdtmpfirst 62]
    	if {$ip == 9999} {
    		return 0
    	}
    }		
    puts "IP_tmp = $ip"    
    set ip_1 [string range $ip 10 22]
    puts $ip_1 
	if {[catch {exec ping.exe $ip_1 -n 1} resultIP] != 0} {  ;# Ping PC
		print_instruction "Ethernet FAIL"
	    return 0
	} else {					
		puts $resultIP
		if { [string first "Lost = 0" $resultIP] != -1 } {
         	print_instruction "Ping DUT IP OK"
         	return 1
    	} else {
         	ok_dialog "IP Unstable and Try again!!"
         	set resultIP ""
       		if {[catch {exec ping.exe $ip_1 -n 1} resultIP] != 0} { ;# Ping PC
				print_instruction "Ethernet FAIL"
	    		return 0
			}
			if { [string first "Lost = 0" $resultIP] != -1 } {
         		print_instruction "Ping DUT IP OK"
    		} else {  
         		return 0
       		}
      	}
    }      	
       
}
#############################################################################
## Procedure:  Check_Flash

proc ::Check_Flash {} {
	global serialCmd
	global cts	
	global id
	global result
	global BarCode1
	global flash_test
	global TestTime 
	puts $serialCmd "D"				;#B is IR Command
	flush $serialCmd             
    print_instruction "Check Flash ..."
    after 100
	if {[Check_key "OK"]!= 1 } {
		ok_dialog "Check Flash Fail"
		return 0
	}
	#puts $serialCmd "X"				;#B is IR Command
	#flush $serialCmd
  
	#if {[Check_key "uclibc\[usb1\]"]!= 1 } {
	#	ok_dialog "Check uclibc\[usb1\] Fail"
	#	return 0
	#}
 		
	return 1
}
#############################################################################
## Procedure:  GPRS_Init

proc ::GPRS_Init {} {
global serialCmd
global cts	
global id
global result
global BarCode1
 
		puts $serialCmd "E"				;#E is GPRS_Init Command
		flush $serialCmd             
    print_instruction "Check GPRS_Init ..."
    after 7000
				
		if {[Check_key "OK"]!= 1 } {
				print_instruction "Check GPRS_Init Fail"			
			  set gprs_test FAIL
			  return 0
				}		
    		set gprs_test PASS
    		return 1
	}
#############################################################################
## Procedure:  Video_Level_Measure

proc Video_Level_Measure {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global gpibCmd
		global video_level_hi 
		global video_level_low 
		global Video
		global Y_Video
		global S_Video
		global addrnum_scope	
		global TestTime
		set gpibCmd  [gpib open -address $addrnum_scope]
		print_instruction "Check Video_Level ..."	 
  	
		gpibw2 $gpibCmd ":TIMebase:SCALe 25e-6"
		gpibw2 $gpibCmd ":TRIGger:SOURce 0"								;#select trigger Source -> 0:CH1 1:CH2
		gpibw2 $gpibCmd ":TRIGger:TYPe 1"									;#select trigger type -> 0:Edge 1:Video					
		gpibw2 $gpibCmd ":MEASure:SOURce 1"								;#select Measure source -> 1.CH1 2,CH2 ...
		gpibw2 $gpibCmd ":MEASure:VPP?"															
    
    set vid_level [gpibr2]   
		;#1.070E+00
		;#9.920E-01
	 	after 100
		
		if { $vid_level == "?" || $vid_level == "chanoff" || $vid_level == ""} {
				gpibw2 $gpibCmd ":MEASure:VPP?"
				after 100
				set vid_level [gpibr2]
		
				if {$vid_level == "?" || $vid_level == "chanoff" || $vid_level == "" } {
						set vid_level "N/A"
						print_instruction "Get Channel Fail"
						ok_dialog "Get Channel FAIL"
						return 0
	   		}
		}
		
		set vid_level [string range $vid_level 0 3]
		if {$vid_level > 2 } { 														;#due to unit different so it need to transfer data form MV -> V
   			set Video [expr $vid_level/10]								;#get data unit is mv
		} else {  
				set Video $vid_level													;#get data unit is V
		}

    set x 0
    while { $x < 3} {
		if { $Video <= $video_level_hi && $Video >= $video_level_low } {
			break
		} else {
			gpibw2 $gpibCmd ":MEASure:VPP?"	
			after 500
			set Video [gpibr2]
			set Video [string range $Video 0 3]	
			if {$Video > 2 } { 											;# due to unit different so it need to transfer data form MV -> V
				set Video [expr $Video/10]						;#get data unit is mv
			} else {  
				set Video $Video						  				;#get data unit is V
			}	
			incr x 1	
		}
	}		;#while loop end	

	for { set i 0 } { $i < 5 } {incr i } { 
		if { $Video <= $video_level_hi && $Video >= $video_level_low } { 
			print_instruction "Video == $Video Vp-p"
			break
		#return 1	
		} else {
			ok_dialog "Get Video Level: $Video Vp-p over spec. 0.9V ~ 1.1V"
			gpibw2 $gpibCmd ":MEASure:VPP?"	
			after 500
			set Video [gpibr2]
			set Video [string range $Video 0 3]	
			if {$Video > 2 } { 											;#due to unit different so it need to transfer data form MV -> V
		    	set Video [expr $Video/10]					;#get data unit is mv
		    } else {  
		    	set Video $Video										;#get data unit is V
		    }	
		    if { $Video <= $video_level_hi && $Video >= $video_level_low } { 
				print_instruction "Video == $Video Vp-p"
				#break
			} else {	
				print_instruction "Check RCA Video_Level Fail"
				ok_dialog "Check RCA Video_Level Fail"	
				return 0
			}				
		}
	}		
	
	print_instruction "Check YPbPr Video_Level ..."	 														
	gpibw2 $gpibCmd ":MEASure:SOURce 2"										;#measure CH2						
	gpibw2 $gpibCmd ":MEASure:VPP?"												;#measure CH2 Vp-p V			
	after 2000
	
	set Y_level [gpibr2]
	;#1.070E+00
	;#9.920E-01
	if { $Y_level == "?" || $Y_level == "chanoff" || $Y_level == ""} {
			gpibw2 $gpibCmd ":MEASure:VPP?"
			set Y_level [gpibr2]
			
			if {$Y_level == "?" || $Y_level == "chanoff" || $Y_level == "" } {
					set Y_level "N/A"
					print_instruction "Get Channel Fail"
					ok_dialog "Get Channel Fail"
					return 0
			}
	 }    
   
   	set Y_level [string range $Y_level 0 3]
    if {$Y_level > 2 } { 																;# due to unit different so it need to transfer data form MV -> V
   		set Y_Video [expr $Y_level/10]										;#get data unit is mv
   	} else {                                        		
   		set Y_Video $Y_level															;#get data unit is V
   	}
   	
	set x 0
	while { $x < 3} {
		if { $Y_Video <= $video_level_hi && $Y_Video >= $video_level_low } {
			break
		} else {
			gpibw2 $gpibCmd ":MEASure:VPP?"	
			after 500
			set Y_Video [gpibr2]
			set Y_Video [string range $Y_Video 0 3]	
			if {$Y_Video > 2 } { 													;#due to unit different so it need to transfer data form MV -> V
				set Y_Video [expr $Y_Video/10]							;#get data unit is mv
			} else {  
		  		set Y_Video $Y_Video											;#get data unit is V
			}	
			incr x 1	
		}
	}		;#while loop end 
	
	for { set i 0 } { $i < 5 } {incr i } { 
   		if { $Y_Video <= $video_level_hi && $Y_Video >= $video_level_low } { 
			puts "st2 == $Y_Video"
			print_instruction "Y_Video == $Y_Video Vp-p"
			break
			#return 1
		} else {
			ok_dialog "Get Y_Video Level: $Y_Video Vp-p over spec. 0.9V ~ 1.1V"		   					
			gpibw2 $gpibCmd ":MEASure:VPP?"	
			after 500
			set Y_Video [gpibr2]
			set Y_Video [string range $Y_Video 0 3]	
			
			if {$Y_Video > 2 } { 												;#due to unit different so it need to transfer data form MV -> V
				set Y_Video [expr $Y_Video/10]						;#get data unit is mv
			} else {  
				set Y_Video $Y_Video											;#get data unit is V
			}	
			
			if { $Y_Video <= $video_level_hi && $Y_Video >= $video_level_low } { 
				print_instruction "Y_Video == $Y_Video Vp-p"
				#break
				#return 1 
			} else {
				print_instruction "Check YPbPr Video_Level Fail"
				ok_dialog "Check YPbPr Video_Level Fail"	
			  	return 0
			} 						 			 
		}
	}
	
	print_instruction "Check S_Video_Level ..."	 															
	gpibw2 $gpibCmd ":MEASure:SOURce 3"										;#measure CH3						
	gpibw2 $gpibCmd ":MEASure:VPP?"												;#measure CH3 Vp-p Voltage			
	after 2000
	set S_level [gpibr2]
	;#1.070E+00
	;#9.920E-01
  
  if { $S_level == "?" || $S_level == "chanoff" || $S_level == ""} {
			gpibw2 $gpibCmd ":MEASure:VPP?"
			set S_level [gpibr2]
    	
    	if {$S_level == "?" || $S_level == "chanoff" || $S_level == "" } {
					set S_level "N/A"
					print_instruction "Get Channel Fail"
					ok_dialog "Get Channel Fail"
					return 0
			}
	}    
  
   set S_level [string range $S_level 0 3]
   if {$S_level > 2 } { 														;#due to unit different so it need to transfer data form MV -> V
			set S_Video [expr $S_level/10]									;#get data unit is mv
		} else {  
			set S_Video $S_level														;#get data unit is V
   	}
	
	 set x 0
	 while { $x < 3} {
		if { $S_Video <= $video_level_hi && $S_Video >= $video_level_low } {
				break
			} else {
				gpibw2 $gpibCmd ":MEASure:VPP?"	
				after 500
				set S_Video [gpibr2]
				set S_Video [string range $S_Video 0 3]	
				if {$S_Video > 2 } { 												;#due to unit different so it need to transfer data form MV -> V
						set S_Video [expr $S_Video/10]					;#get data unit is mv
				} else {  
		    		set S_Video $S_Video										;#get data unit is V
		    }	
				incr x 1	
		}			
	}		;#while loop end
		
	for { set i 0 } { $i < 5 } {incr i } { 
		if { $S_Video <= $video_level_hi && $S_Video >= $video_level_low } { 
			print_instruction "S_Video == $S_Video Vp-p"
			return 1
		} else {
			ok_dialog "Get S_Video Level: $S_Video Vp-p over spec. 0.9V ~ 1.1V"
			gpibw2 $gpibCmd ":MEASure:VPP?"	
			after 500
			set S_Video [gpibr2]
			set S_Video [string range $S_Video 0 3]	
			
			if {$S_Video > 2 } { 												;#due to unit different so it need to transfer data form MV -> V
				set S_Video [expr $S_Video/10]						;#get data unit is mv
		    } else {  
		    	set S_Video $S_Video										;#get data unit is V
		    }
		    
		    if { $S_Video <= $video_level_hi && $S_Video >= $video_level_low } { 
						print_instruction "S_Video == $S_Video Vp-p"
						return 1
		    } else {
		    		print_instruction "Check S_Video Level Fail"
						ok_dialog "Check S_Video Level Fail"	
						return 0
		    }		   							
		}		
	}
}
#############################################################################
## Procedure:  Audio_Level_Measure

proc ::Audio_Level_Measure {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global gpibCmd
		global audio_level_hi
		global audio_level_low
		global LAudio
		global RAudio
		global TestTime
	
		#AVSwitch 1
		#after 2000	
		
		print_instruction "Check LAudio_Level ..."	 
		gpibw2 $gpibCmd ":TIMebase:SCALe 250e-6"											;#set horizontal timebase scale per division -> 250us	
		gpibw2 $gpibCmd ":TRIGger:SOURce 3"														;#select trigger source -> CH4
		gpibw2 $gpibCmd ":CHANnel4:SCALe 1.00E+0"											;#set desired  gain value in volts per division CH4 -> 1V 
		
		gpibw2 $gpibCmd ":MEASure:SOURce 4"														;#measure CH4
		gpibw2 $gpibCmd ":MEASure:VPP?"																;#get CH4 Vpp value
		after 3000
		set LAud_level [gpibr2]
		;#6.240E+00
		if { $LAud_level == "?" || $LAud_level == "chanoff" || $LAud_level == ""} {
			gpibw2 $gpibCmd ":MEASure:VPP?"
			after 500
			set LAud_level [gpibr2]
			#regsub -all " " $LAud_level "" LAud_level
			if { $LAud_level == "?" || $LAud_level == "chanoff" || $LAud_level == ""} {
				set LAud_level "N/A"
				print_instruction "Get Channel Fail"
				ok_dialog "Get Channel Fail"
				return 0
			}
		}    
	set LAudio [string range $LAud_level 0 3]												
	set x 0
	for { set i 0 } { $i < 5 } {incr i } { 
		if { $LAudio <= $audio_level_hi && $LAudio >= $audio_level_low } {	
			print_instruction "LAudio == $LAudio Vp-p"	 
			break
			#return 1
		} else {	
			gpibw2 $gpibCmd ":MEASure:VPP?"	
			after 100
			set LAudio [gpibr2]
			set LAudio [string range $LAudio 0 3]	
			if { $LAudio <= $audio_level_hi && $LAudio >= $audio_level_low } {
				break
				#return 1
	 		} else {
				ok_dialog "LAudio == $LAudio Vp-p over spec. 6.28V ~ 6.53V"
				return 0
			}
 		}			
 		after 500	
	} ;#for loop end
  
	#ok_dialog "Please Select AV Switch 2"
	AVSwitch 2
	after 2000
	#gpibw2 $gpibCmd ":CHANnel$scope_channel:DISPlay 3"						;#set CH3 of scope
	#gpibw2 $gpibCmd ":CHANnel2:SCALe 1.00E+0"										;#set desired  gain value in volts per division CH3 -> 1V                                   
	#gpibw2 $gpibCmd ":CHANnel$scope_channel:SCALe 1.00E+0"				;#set desired  value of CH3 -> 1V
	#gpibw2 $gpibCmd ":TRIGger:TYPe 0"														;#select trigger type -> Edge
	#gpibw2 $gpibCmd ":TRIGger:COUPle 1"													;#set trigger coupling -> DC
	#gpibw2 $gpibCmd ":TRIGger:MODe 2"														;#select trigger mode -> Normal level	
	#set TrigSource [expr $scope_channel - 1]
	#gpibw2 $gpibCmd ":TRIGger:SOURce $TrigSource"								;#select trigger source CH2
	gpibw2 $gpibCmd ":MEASure:SOURce 4"														;#measure CH4
	gpibw2 $gpibCmd ":MEASure:VPP?"																;#get CH4 Vpp value
	after 100
	set RAud_level [gpibr2]
	if { $RAud_level == "?" || $RAud_level == "chanoff" || $RAud_level == ""} {
		gpibw2 $gpibCmd ":MEASure:VPP?"
		after 500
		set RAud_level [gpibr2]
		#regsub -all " " $RAud_level "" LAud_level
		if { $RAud_level == "?" || $RAud_level == "chanoff" || $RAud_level == ""} {
			set RAud_level "N/A"
			print_instruction "Get Channel Fail"	 
			ok_dialog "Get Channel Fail"
			return 0
		}
	}	
    set RAudio [string range $RAud_level 0 3]				
	set x 0
	for { set i 0 } { $i < 5 } {incr i } { 
		if { $RAudio <= $audio_level_hi && $RAudio >= $audio_level_low } {	
			print_instruction "RAudio == $RAudio Vp-p"	 
		   	#gpibw2 $gpibCmd ":CHANnel4:DISPlay 0"													;#disable CH4 of scope	
		   	return 1
		} else {	
			gpibw2 $gpibCmd ":MEASure:VPP?"	
			after 500
			set RAudio [gpibr2]
			set RAudio [string range $RAudio 0 3]	
			if { $RAudio <= $audio_level_hi && $RAudio >= $audio_level_low } {
				#gpibw2 $gpibCmd ":CHANnel4:DISPlay 0"													;#disable CH4 of scope	
				return 1
			} else {
				ok_dialog "RAudio == $RAudio Vp-p over spec. 6.28V ~ 6.53V"
				return 0
			}
 		}		
 		after 500		
	}		;#while loop end							
}
#############################################################################
## Procedure:  Check_LAudio_Level

proc ::Check_LAudio_Level {scope_channel} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global gpibCmd
		global audio_level_hi
		global audio_level_low
		global LAudio
		global TestTime
		global Audio_offset
	
		print_instruction "Check LAudio_Level ..."	 
		gpibw2 $gpibCmd ":TRIGger:TYPe 0"															;#set video type 0:edge 1: video 
		gpibw2 $gpibCmd ":TRIGger:SOURce 1"														;#select trigger source -> CH2
		gpibw2 $gpibCmd ":TIMebase:SCALe 250e-6"											;#set horizontal timebase scale per division -> 250us	
		gpibw2 $gpibCmd ":MEASure:SOURce $scope_channel"							;#measure CH2
		gpibw2 $gpibCmd ":MEASure:VPP?"																;#get CH2 Vpp value
	  after 300
	  
		set LAud_level [gpibr2]
		
		if { $LAud_level == "?" || $LAud_level == "chanoff" || $LAud_level == ""} {
				gpibw2 $gpibCmd ":MEASure:VPP?"
				after 500
				set LAud_level [gpibr2]
				#regsub -all " " $LAud_level "" LAud_level
				
				if { $LAud_level == "?" || $LAud_level == "chanoff" || $LAud_level == ""} {
						set LAud_level "N/A"
						ok_dialog "Get Channel Fail"
						return 0
			  }
		}    
		
		set LAudio [string range $LAud_level 0 3]										
		set x 0
   	for { set i 0 } { $i < 5 } {incr i } { 
			if { $LAudio <= $audio_level_hi && $LAudio >= $audio_level_low } {	
					print_instruction "LAudio == $LAudio Vp-p"	 
				  return 1
			} else {	
					gpibw2 $gpibCmd ":MEASure:VPP?"	
			  	after 100
					set LAudio [gpibr2]
					set LAudio [string range $LAudio 0 3]	
					set LAudio [expr $LAudio - $Audio_offset]
				
					if { $LAudio <= $audio_level_hi && $LAudio >= $audio_level_low } {
							puts "Left Audio == $LAudio"
							return 1
					} 
 					after 500
 			}				
		}	;#for loop end
				
		ok_dialog "LAudio == $LAudio Vp-p over spec. 5.9V ~ 6.53V"
		return 0
}
#############################################################################
## Procedure:  Check_RAudio_Level

proc ::Check_RAudio_Level {scope_channel} {	
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global gpibCmd
		global audio_level_hi
		global audio_level_low
		global RAudio
		global TestTime
		global Audio_offset
		
		print_instruction "Check RAudio_Level ..."	                                
		gpibw2 $gpibCmd ":MEASure:SOURce $scope_channel"							;#measure CH2
		gpibw2 $gpibCmd ":MEASure:VPP?"																;#get CH2 Vpp value
		after 100
		
		set RAud_level [gpibr2]
		if { $RAud_level == "?" || $RAud_level == "chanoff" || $RAud_level == ""} {
				gpibw2 $gpibCmd ":MEASure:VPP?"
				after 500
				set RAud_level [gpibr2]
				#regsub -all " " $RAud_level "" LAud_level
	
				if { $RAud_level == "?" || $RAud_level == "chanoff" || $RAud_level == ""} {
						set RAud_level "N/A"
						ok_dialog "Get Channel Fail"
						return 0
			  }
		}    
		
		set RAudio [string range $RAud_level 0 3]				
		set x 0
    for { set i 0 } { $i < 5 } {incr i } { 
			if { $RAudio <= $audio_level_hi && $RAudio >= $audio_level_low } {	
					print_instruction "RAudio == $RAudio Vp-p"	 
		    	return 1
				} else {	
					gpibw2 $gpibCmd ":MEASure:VPP?"	
					after 500
					set RAudio [gpibr2]
					set RAudio [string range $RAudio 0 3]	
					set RAudio [expr $RAudio - $Audio_offset]
		
					if { $RAudio <= $audio_level_hi && $RAudio >= $audio_level_low } {
							puts "Right AUDIO == $RAudio"
							return 1
						} 
						after 500
 					}				
			}		;#while loop end	
		
		  ok_dialog "RAudio == $RAudio Vp-p over spec. 5.9V ~ 6.53V"
		  return 0
}
#############################################################################
## Procedure:  Check_Video_Level

proc Check_Video_Level {scope_channel} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global gpibCmd
		global video_level_hi 
		global video_level_low 
		global Video_level
		global TestTime
		global a_serial
		global BarCode2_1
		global BarCode3_1
		
		
		print_instruction "Check Video_Level ..."	 
  	puts $serialCmd "set_outports -audio_engine 0 -component -f  1080i50 -analog -f NTSC_M -I2StoSPDIF 1"
  	flush $serialCmd
  	after 100
  	puts $serialCmd "test_rmfp 1K_White_20090929.ts -l"
  	flush $serialCmd
  	after 300
		
		gpibw2 $gpibCmd ":TIMebase:SCALe 25e-6"											;#set horizontal timebase scale per division -> 250us	
		gpibw2 $gpibCmd ":TRIGger:SOURce 0"													;#select trigger source -> CH1
		gpibw2 $gpibCmd ":TRIGger:TYPe 1"														;#set video type 0:edge 1: video 
		gpibw2 $gpibCmd ":MEASure:SOURce $scope_channel"						;#measure CH2
		gpibw2 $gpibCmd ":MEASure:VPP?"															;#get CH2 Vpp value
	  
		set Video_level [gpibr2]
		set Video_level [expr double ($Video_level)]
		
		if { $Video_level == "?" || $Video_level == "chanoff" || $Video_level == ""} {
				gpibw2 $gpibCmd ":MEASure:VPP?"
				after 500
				set Video_level [gpibr2]
				#regsub -all " " $Video_level "" Video_level
				
				if { $Video_level == "?" || $Video_level == "chanoff" || $Video_level == ""} {
						set Video_level "N/A"
						ok_dialog "Get Channel Fail"
						return 0
			  }
		}    
		
		set Video_level [string range $Video_level 0 3]
		set Video_level [expr double ($Video_level)]											
		set x 0
   	for { set i 0 } { $i < 5 } {incr i } { 
			if { $Video_level <= $video_level_hi && $Video_level >= $video_level_low } {	
					print_instruction "Video_level == $Video_level Vp-p"	 
				  return 1
			} else {	
					gpibw2 $gpibCmd ":MEASure:VPP?"	
			  	after 100
					set Video_level [gpibr2]
					set Video_level [expr double ($Video_level)]
					set Video_level [string range $Video_level 0 3]	
				
					if { $Video_level <= $video_level_hi && $Video_level >= $video_level_low } {
							puts "Video == $Video_level"
							
							return 1
					} 
 					after 500
 			}				
		}	;#for loop end
				
		ok_dialog "Video_level == $Video_level Vp-p over spec. 0.9V ~ 1.1V"
		return 0
}
#############################################################################
## Procedure:  Check_SVideo_Level

proc Check_SVideo_Level {scope_channel} {
		global serialCmd
		global serialCmd5
		global cts	
		global id
		global result
		global BarCode1
		global gpibCmd
		global video_level_hi 
		global video_level_low 
		global SVideo_level
		global TestTime
		
		print_instruction "Check S_Video Level ..."		
		puts $serialCmd5 ":TIMebase:SCALe 25e-6"											;#set horizontal timebase scale per division -> 250us	
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":MEASure:SOURce $scope_channel"							;#measure CH2
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":MEASure:VPP?"															;#get CH2 Vpp value
	  flush $serialCmd5
	  after 700
	  
		set SVideo_level [read $serialCmd5]
		set SVideo_level [string range $SVideo_level 0 3]	
		
		if { $SVideo_level == "?" || $SVideo_level == "chanoff" || $SVideo_level == ""} {
				puts $serialCmd5 ":MEASure:VPP?"
				flush $serialCmd5
				after 700
				
				set SVideo_level [read $serialCmd5]
				set SVideo_level [string range $SVideo_level 0 3]	
				#regsub -all " " $SVideo_level "" SVideo_level
				
				if { $SVideo_level == "?" || $SVideo_level == "chanoff" || $SVideo_level == ""} {
						set SVideo_level "N/A"
						ok_dialog "Get Channel Fail"
						return 0
			  }
		}    
		
   	for { set i 0 } { $i < 5 } {incr i } { 
			if { $SVideo_level <= $video_level_hi && $SVideo_level >= $video_level_low } {	
					print_instruction "SVideo_level == $SVideo_level Vp-p"	
				  return 1
			} else {	
					puts $serialCmd5 ":MEASure:VPP?"	
					flush $serialCmd5
			  	after 700
					set SVideo_level [read $serialCmd5]
					set SVideo_level [string range $SVideo_level 0 3]	
				
					if { $SVideo_level <= $video_level_hi && $SVideo_level >= $video_level_low } {
							puts "SVideo_level == $SVideo_level"
							puts $serialCmd "setxenv 0 a.pt 20"
   						flush $serialCmd	
   						after 700
							return 1
					} 
 					after 700
 			}				
		}	;#for loop end
				
		ok_dialog "SVideo_level == $SVideo_level Vp-p over spec. 0.9V ~ 1.1V"
		return 0
}
#############################################################################
## Procedure:  Check_YPbPr_Level

proc Check_YPbPr_Level {scope_channel} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global gpibCmd
		global video_level_hi 
		global video_level_low 
		global YPbPr_level
		global TestTime
		global a_serial
		global BarCode2_1
		global BarCode3_1
		global portCmd_stb5
		global serialCmd5
		
		print_instruction "Check YPbPr Level ..."		 	  	 	
		puts $serialCmd5 ":TIMebase:SCALe 10e-6"											;#set horizontal timebase scale per division -> 250us	
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":TRIGger:SOURce 0"													;#select trigger source -> CH1
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":TRIGger:TYPe 1"														;#set video type 0:edge 1: video 
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":MEASure:SOURce $scope_channel"							;#measure CH2
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":DISPlay:WAVeform 0"												;#display type 0 : vector ; 1 : dot
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":MEASure:VPP?"															;#get CH2 Vpp value
	 	flush $serialCmd5
	 	after 700
	 
	 	set YPbPr_level [read $serialCmd5]
	 	set YPbPr_level [string range $YPbPr_level 0 3]	
		
		if { $YPbPr_level == "?" || $YPbPr_level == "chanoff" || $YPbPr_level == ""} {
				puts $serialCmd5 ":MEASure:VPP?"
				flush $serialCmd
				after 700

				set YPbPr_level [read $serialCmd5]
				set YPbPr_level [string range $YPbPr_level 0 3]	
				#regsub -all " " $YPbPr_level "" YPbPr_level
				
				if { $YPbPr_level == "?" || $YPbPr_level == "chanoff" || $YPbPr_level == ""} {
						set YPbPr_level "N/A"
						ok_dialog "Get Channel Fail"
						return 0
			  }
		}    
		
   	for { set i 0 } { $i < 5 } {incr i } { 
			if { $YPbPr_level <= $video_level_hi && $YPbPr_level >= $video_level_low } {	
					print_instruction "YPbPr_level == $YPbPr_level Vp-p"	 
				  return 1
			} else {	
					puts $serialCmd5 ":MEASure:VPP?"	
			  	flush $serialCmd5
			  	after 700
					
					set YPbPr_level [read $serialCmd5]
					set YPbPr_level [string range $YPbPr_level 0 3]	

					if { $YPbPr_level <= $video_level_hi && $YPbPr_level >= $video_level_low } {
							puts "YPbPr_level == $YPbPr_level"
							return 1
						} 
 				}				
		}	;#for loop end
				
		ok_dialog "YPbPr_level == $YPbPr_level Vp-p over spec. 0.9V ~ 1.1V"
		return 0
}
#############################################################################
## Procedure:  FW_Ver_Compare

proc ::FW_Ver_Compare {} {
		global serialCmd
		global cts	
		global id
		global result
		global ver
		global ver_tmp
		global TestTime

		print_instruction "	Check FW Version Compare ..."	
		if {[regexp $ver $ver_tmp] == 1} {
	   		print_instruction "FW Version check Pass\n$ver = $ver_tmp"    
    		return 1
			} 
			ok_dialog "FW Version Compare Fail\n$ver = $ver_tmp"
			return 0
}
#############################################################################
## Procedure:  SNMAC_Compare

proc ::SNMAC_Compare {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global BarCode2_1
		global BarCode3_1
		global a_serial
		global a_eth
		global a_eth1
		
		print_instruction "	Check SN_MAC Compare ..."	
		for { set i 0 } { $i < 5 } {incr i } { 	
			if {[regexp $BarCode1 $a_serial] == 1} {
					print_instruction "SN Compare Pass" 
					after 300
			}
			
			if {[regexp $BarCode2_1 $a_eth] == 1} {
	   		print_instruction "MAC-1 Compare Pass"
	   		after 300 
	   	}
	   	
	   	if {[regexp $BarCode3_1 $a_eth1] == 1} {
	   		print_instruction "MAC-2 Compare Pass" 
	   		after 300
	   		return 1
	   	}	
	   	after 1000
	 } 	
	   		
	 
    	 if { [regexp $a_serial $BarCode1] != 1} {
    	 			ok_dialog "Serial SN Compare FAIL"	
    	 			return 0
    	 	}
    	 	
    	 	if { [regexp $a_eth $BarCode2_1] != 1} {
    	 			ok_dialog "MAC-1 Compare FAIL"	
    	 			return 0
    	 	}
    	 	
    	 	if { [regexp $a_eth1 $BarCode3_1] != 1} {
    	 			ok_dialog "MAC-2 Compare FAIL"	
    	 			return 0
    	 	}
}
#############################################################################
## Procedure:  Check_Summary

proc ::Check_Summary {} {	
global serialCmd
global cts	
global id
global result
global BarCode1
global gpibCmd
global summary
global a
global b
global c
global d
global e
global f
global g
global h
global i
global j
global k
global l
	
		unset summary 
		set summary ""
		set summary [expr {$a+$b+$c+$d+$e+$f+$g+$h+$i+$j+$k+$l}]
		puts  "summary == $summary"
		if {$summary !=12} {
				set summary FAIL
				return 0
		}
		set summary PASS
		return 1
}
#############################################################################
## Procedure:  xls_write

proc ::xls_write {} {

	global xls_cont
	global file_cont
	global BarCode1
	global BarCode2
	global dram_test
	global ver
	global usb_test
	global led_test
	global ir_test
	global ethnet_test
	global flash_test
	global Video
	global Y_Video
	global S_Video
	global LAudio
	global RAudio
	global summary
	global xls_station1
	global NewXFile1
	global model
	global Total_Time
   
	set now_day [clock format [clock seconds] -format "%Y%m%d"]
	set now_time [clock format [clock seconds] -format "%H\:%M\:%S"]
	
	if {$xls_cont == 4} {
	set application [::tcom::ref createobject "Excel.Application"]
	set workbooks [$application Workbooks]
	set workbook [$workbooks Open $xls_station1]
	set worksheets [$workbook Worksheets]
	set worksheet [$worksheets Item "Sheet1"]
	set cells [$worksheet Cells]
	$cells Item $xls_cont A "$BarCode1"
	$cells Item $xls_cont B "$BarCode2"			
	$cells Item $xls_cont C "$now_day"
	$cells Item $xls_cont D "$dram_test"	
	$cells Item $xls_cont E "$ver"	
	$cells Item $xls_cont F "$usb_test"	
	$cells Item $xls_cont G "$led_test"
	$cells Item $xls_cont H "$ir_test"	
	$cells Item $xls_cont I "$ethnet_test"						
	$cells Item $xls_cont J "$flash_test"
	$cells Item $xls_cont K "$Video"	
	$cells Item $xls_cont L "$Y_Video"	
	$cells Item $xls_cont M "$S_Video"
	$cells Item $xls_cont N "$LAudio"
	$cells Item $xls_cont O "$RAudio"	
	$cells Item $xls_cont P "$Total_Time"
	incr xls_cont
  $workbook SaveAs $NewXFile1
  $workbook Close	
  } else {
          set application [::tcom::ref createobject "Excel.Application"]
	        set workbooks [$application Workbooks]
	        set workbook [$workbooks Open $NewXFile1]
	        set worksheets [$workbook Worksheets]
	        set worksheet [$worksheets Item "Sheet1"]
	        set cells [$worksheet Cells]
          $cells Item $xls_cont A "$BarCode1"
					$cells Item $xls_cont B "$BarCode2"			
					$cells Item $xls_cont C "$now_day"
					$cells Item $xls_cont D "$dram_test"	
					$cells Item $xls_cont E "$ver"	
					$cells Item $xls_cont F "$usb_test"	
					$cells Item $xls_cont G "$led_test"
					$cells Item $xls_cont H "$ir_test"	
					$cells Item $xls_cont I "$ethnet_test"						
					$cells Item $xls_cont J "$flash_test"
					$cells Item $xls_cont K "$Video"	
					$cells Item $xls_cont L "$Y_Video"	
					$cells Item $xls_cont M "$S_Video"
					$cells Item $xls_cont N "$LAudio"
					$cells Item $xls_cont O "$RAudio"
					$cells Item $xls_cont P "$Total_Time"
	        incr xls_cont
          $workbook Save
          $workbook Close
         }	
}
#############################################################################
## Procedure:  Fail_Msg_Log

proc ::Fail_Msg_Log {Stat ErrCode Maximum Minimum T_Result var1} {

	global Fail_Msg_Log
  global BarCode1
  global BarCode2
  global chanLog
 		
	set chanLog [open $Fail_Msg_Log "a"]
	puts $chanLog "[clock_now] SN:$BarCode1 MAC:$BarCode2; The $Stat fuction is FAIL; ErrCode:$ErrCode; Maximum:$Maximum; Minimum:$Minimum; Test_result:$T_Result$var1"	
			
  #puts $chanLog ""
  #puts $chanLog ""    
		
	flush $chanLog
  close $chanLog
	
}
#############################################################################
## Procedure:  selsql

proc ::selsql {} {
    sqlite db em8654_ST2.db
    global BarCode1		
		
		set chk_barcode [db eval "SELECT * FROM em8654_function WHERE SN = '$BarCode1'"]
		if {[string length $chk_barcode]==0} {
				return 1
			} else {
				return 0
		}		
}
#############################################################################
## Procedure:  Check_Boot

proc Check_Boot {} { 
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global regexp
		global send_exp
		global TestTime
		
		
		puts $serialCmd ""
		flush $serialCmd	
		
		#set number 0	
		set fh $serialCmd
		set send_exp($fh.matched)   0
		
		set regexp "tango3 login:"
		    
		if {![info exists send_exp($fh.buffer)]} {
		    set send_exp($fh.buffer) {}
		}
		
		# set up our Read handler before outputting the string.
		#if {![info exists send_exp($fh.setReader)]} {
		    fileevent $fh readable [list private_send_exp_reader2 $fh]
		#    set send_exp($fh.setReader) 1
		#}
		
		# set up a timer so that we wait a limited amt of seconds,20000

		set afterId [after 22000 [list set send_exp($fh.matched) 0]]
		#while { $number < 3} {
		vwait send_exp($fh.matched)
		#incr number	
		#puts "number == $number" 
		#puts $serialCmd "\n"
		#flush $serialCmd
		#} 
		#puts "number == $number"
	
	
		set matched $send_exp($fh.matched)
		unset send_exp($fh.matched)
		catch [list after cancel $afterId]
		set send_exp($fh.buffer) {}		
		
		if {$matched == 0} {
		    return 0
		}			
		return 1
}
#############################################################################
## Procedure:  Write_SN_MAC

proc Write_SN_MAC {} { 
		global serialCmd
		global portCmd_stb
		global cts	
		global id
		global result
		global BarCode1
		global BarCode2
		global BarCode3 
		global BarCode2_1
		global BarCode3_1
		global regexp
		global send_exp
		global TestTime
		global a_serial
		global a_eth
		global a_eth1
		global MBOOT
		set BarCode2_1 {}
		set BarCode3_1 {}	
	  
   	print_instruction "Write SN ..."
   	puts $serialCmd "setxenv 0 a.serial \\\"$BarCode1\\\""
   	flush $serialCmd
   	
   	set Cmd "setxenv 0 a.serial" 
  	set Cmdtmpfirst "18 a.serial"
  	after 400 
  	set a_serial [FindString2 $Cmd $Cmdtmpfirst 86]
  	set a_serial [string range $a_serial 67 84]
  	regsub -all " " $a_serial "" a_serial
  	puts $a_serial   
  	
  	
  	print_instruction "Write MAC-1 ..."
 		set BarCode2_tmp1 [string range $BarCode2 0 1]
 		append BarCode2_tmp1 ":"
  	set BarCode2_tmp2 [string range $BarCode2 2 3]
 		append BarCode2_tmp2 ":"
  	set BarCode2_tmp3 [string range $BarCode2 4 5]
 		append BarCode2_tmp3 ":"
  	set BarCode2_tmp4 [string range $BarCode2 6 7]
 		append BarCode2_tmp4 ":"
 		set BarCode2_tmp5 [string range $BarCode2 8 9]
 		append BarCode2_tmp5 ":"
 		set BarCode2_tmp6 [string range $BarCode2 10 11]
  	lappend BarCode2_1 $BarCode2_tmp1$BarCode2_tmp2$BarCode2_tmp3$BarCode2_tmp4$BarCode2_tmp5$BarCode2_tmp6

   	puts $serialCmd "setxenv 0 a.eth_mac \\\"$BarCode2_1\\\""
   	flush $serialCmd
   	
   	set Cmd "setxenv 0 a.eth_mac"
   	set Cmdtmpfirst "19 a.eth_mac"
   	after 400
   	set a_eth [FindString2 $Cmd $Cmdtmpfirst 91] 
   	set a_eth [string range $a_eth 71 89]
   	regsub -all " " $a_eth "" a_eth
   	puts $a_eth


		print_instruction "Write MAC-2 ..."
  	set BarCode3_tmp1 [string range $BarCode3 0 1]
 		append BarCode3_tmp1 ":"
  	set BarCode3_tmp2 [string range $BarCode3 2 3]
 		append BarCode3_tmp2 ":"
  	set BarCode3_tmp3 [string range $BarCode3 4 5]
 		append BarCode3_tmp3 ":"
  	set BarCode3_tmp4 [string range $BarCode3 6 7]
 		append BarCode3_tmp4 ":"
 		set BarCode3_tmp5 [string range $BarCode3 8 9]
 		append BarCode3_tmp5 ":"
 		set BarCode3_tmp6 [string range $BarCode3 10 11]
  	lappend BarCode3_1 $BarCode3_tmp1$BarCode3_tmp2$BarCode3_tmp3$BarCode3_tmp4$BarCode3_tmp5$BarCode3_tmp6
   	
   	puts $serialCmd "setxenv 0 a.eth1_mac \\\"$BarCode3_1\\\""  
   	flush $serialCmd	
   	
   	set Cmd "setxenv 0 a.eth1_mac" 
  	set Cmdtmpfirst "19 a.eth1_mac" 
  	after 400
  	set a_eth1 [FindString2 $Cmd $Cmdtmpfirst 91]
  	set a_eth1 [string range $a_eth1 71 90]
    regsub -all " " $a_eth1 "" a_eth1
   	puts $a_eth1
   	
		return 1
}
#############################################################################
## Procedure:  USB_Check

proc USB_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global TestTime
 	
 		print_instruction "Check USB Device ..."
 		puts $serialCmd "cd /mnt/sda1"
  	flush $serialCmd
  	after 1000   
  	
  	puts $serialCmd "./em8654"
  	flush $serialCmd
  	after 1000
  	
  	set Cmd "G"     
    set Cmdtmpfirst "USB1\*"
		set USB [FindString2 $Cmd $Cmdtmpfirst 30]
		puts $USB
		
    set USB [string range $USB 5 7]
	  regsub -all " " $USB "" USB 
  	
  	if { [regexp {OK} $USB] != 1} {
  			ok_dialog "Can't find Rear Panel USB Device !! "
    		return 0
		}    
		
		         
  	puts $serialCmd "X"
		flush $serialCmd 
		after 200       
  	return 1
}
#############################################################################
## Procedure:  SATA_Check

proc ::SATA_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global usb_test
		global TestTime
 		
 		print_instruction "Check SATA Device ..."
		set Cmd "I"     
    set Cmdtmpfirst "SATA\*"
		set SATA1 [FindString2 $Cmd $Cmdtmpfirst 10]
		puts $SATA1
    set SATA1 [string range $SATA1 5 8]
	  regsub -all " " $SATA1 "" SATA1
	  after 1500
	   
		if { [regexp {OK} $SATA1] != 1} {
  			ok_dialog "Can't find SATA HDD Device !! "
    		return 0		
		}          
  			return 1
}
#############################################################################
## Procedure:  LED_Check

proc ::LED_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global led_test
		global pass1
		global TestTime
  
   	print_instruction "Check LEDs & Color"	
  	
  	puts $serialCmd "A"
		flush $serialCmd
  	after 100
  	
  	puts $serialCmd ""
  	flush $serialCmd 
  	
  	.top73.fra87.cpd88 configure -state normal
  	.top73.fra87.cpd91 configure -state normal
  	
  	focus -force .top73.fra87.but99
  	set pass1 0
		print_instruction "Check LEDs & Color\n1.If OK Press \"Enter\" key\n2.If Bad or Retry again Press \"n\" key"
		vwait pass1
  	
  	if {$pass1 == 0} {
  		.top73.fra87.cpd88 configure -state disable
  	  .top73.fra87.cpd91 configure -state active
  		ok_dialog "LEDs Check Fail"
  		puts "LED_FAIL"
  		return 0
  	} else {
  		.top73.fra87.cpd88 configure -state active
  		.top73.fra87.cpd91 configure -state disable
  		puts "LED_PASS"
  		return 1
  	}
}
#############################################################################
## Procedure:  Button_Check

proc ::Button_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global TestTime
		
		set cur_time [clock seconds]
  	print_instruction "Please input Front panel key ..."
		set a 0
		set b 0
		set c 0
		set d 0
		set e 0
		set f 0
		set g 0 
		set AB 0
		
		set B_UP "up\*ok"
		puts "UP=$B_UP"
		set B_DOWN "down\*ok"
		puts "B_DOWN=$B_DOWN"
		set B_LEFT "left\*ok"
		puts "B_LEFT=$B_LEFT"
		set B_RIGHT "right\*ok"
		puts "B_RIGHT=$B_RIGHT"
		set B_MENU "menu\*ok"
		puts "B_MENU=$B_MENU"
		set B_SEL "sel\*ok"
		puts "B_SEL=$B_SEL"
		set B_POWER "power\*ok"
		puts "B_POWER=$B_POWER"
		set temp1 ""
	  
	  puts $serialCmd "C"
		flush $serialCmd
		after 2000
			 
	 #gets $serialCmd line
	 #if {[Check_key2 "Release 2009" 2000]!= 1 } {                               
	 #	 	ok_dialog "FPK command input key Fail"
	 #		return 0
   #}
		
    while {$AB < 7 && [expr {[clock seconds]- $cur_time}] <= 20} {  	 
    	 #while { [gets $serialCmd line] >= 0 } { 			
        		gets $serialCmd line
        		set temp1 $line
        		set temp1 [string tolower $temp1]  
        		
        		if {[regexp {up\*ok} $temp1] || [regexp {down\*ok} $temp1] || [regexp {left\*ok} $temp1] || [regexp {right\*ok} $temp1] || [regexp {menu\*ok} $temp1] || [regexp {sel\*ok} $temp1] || [regexp {power\*ok} $temp1] == 1} {
    	 				if { [regexp {up\*ok} $temp1] == 1} {
    	 						set a 1
    	 				}

    	 				if { [regexp {down\*ok} $temp1] == 1} {
    	 						set b 1
    	 				}

    	 				if { [regexp {left\*ok} $temp1] == 1} {
    	 						set c 1
    	 				}

    	 				if { [regexp {right\*ok} $temp1] == 1} {
    	 						set d 1
    	 				}
    
    	 				if { [regexp {menu\*ok} $temp1] == 1} {
    	 						set e 1
    	 				}
    	 		
    	 				if { [regexp {sel\*ok} $temp1] == 1} {
    	 						set f 1
    	 				}
    	 		
    	 				if { [regexp {power\*ok} $temp1] == 1} {
    	 						set g 1
    	 				}
    	 				set AB [expr {$a+$b+$c+$d+$e+$f+$g}] 
							puts "AB=$AB"
    	 		 } else {
    	 		 		set AB [expr {$a+$b+$c+$d+$e+$f+$g}] 
							puts "AB=$AB"
    	 		 }	
    	 	#}
   } 	 				
    
    if {$AB != "7"} {
       
        if {$a == 0} { 
						ok_dialog "button UP Key not push" 
				}
				if {$b == 0} { 
						ok_dialog "button DOWN Key not push" 
				}
				if {$c == 0} { 
						ok_dialog "button LEFT Key not push" 
				}     
				if {$d == 0} { 
						ok_dialog "button RIGHT Key not push" 
				}     
				if {$e == 0} { 
						ok_dialog "button MENU Key not push" 
				}     
				if {$f == 0} { 
						ok_dialog "button SEL Key not push" 
				}     
				if {$g == 0} { 
						ok_dialog "button POWER Key not push" 
				}
			 	return 0       
    } else {
        return 1
    }
}
#############################################################################
## Procedure:  IR_Check

proc ::IR_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
    
   	print_instruction "Check IR ..."
		set Cmd "B"     
    set Cmdtmpfirst "IR\*"
		set IR [FindString2 $Cmd $Cmdtmpfirst 8]
		puts $IR
    set IR [string range $IR 3 7]
	  regsub -all " " $IR "" IR
	   
		if { [regexp {OK} $IR] != 1} {
  			ok_dialog "Check IR Fail !! "
    		return 0
		}           
  			puts $serialCmd "X"
				flush $serialCmd
  			return 1
}
#############################################################################
## Procedure:  Flash_Check

proc ::Flash_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
 	
  	print_instruction "Check Flash ..."
		set Cmd "F"     
    set Cmdtmpfirst "FLASH\*"
		set FLASH1 [FindString2 $Cmd $Cmdtmpfirst 11]
		puts $FLASH1
    set FLASH1 [string range $FLASH1 6 10]
	  regsub -all " " $FLASH1 "" FLASH1
	  after 600
	   
		if { [regexp {OK} $FLASH1] != 1} {
  			ok_dialog "CHECK FLASH FAIL !! "
    		return 0
		}     
				puts $serialCmd "X"
				flush $serialCmd 
				after 200     
  			return 1
}
#############################################################################
## Procedure:  Ethernet_Check

proc Ethernet_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global ethnet_test
		global TestTime
		global ip_1 			
    
  	print_instruction "Check Ethernet ..."
    set Cmd "ifconfig eth0"
    set Cmdtmpfirst "inet addr:"
    set ip_1 [FindString2_1 $Cmd $Cmdtmpfirst 62]
    if {$ip_1 == 9999} {
    	set ip_1 [FindString2_1 $Cmd $Cmdtmpfirst 62]
    	if {$ip_1 == 9999} {
    	  	print_instruction "Ethernet 1 Address not found !"
    			return 0
    	}
    }		
    puts "IP_tmp = $ip_1"    
    set ip_1 [string range $ip_1 10 24]
    puts $ip_1 
    #ok_dialog "ip1 == $ip_1 "
		
		if {[catch {exec ping.exe $ip_1 -n 1} resultIP] != 0} {  ;# Ping PC
				print_instruction "Ethernet 1 FAIL"
	    	return 0
	} else {					
		puts $resultIP
		if { [string first "Lost = 0" $resultIP] != -1 } {
         	print_instruction "Ping Ethernet 1 OK"
					after 300
    	} else {
         	ok_dialog "IP Unstable and Try again!!"
         	set resultIP ""
       		if {[catch {exec ping.exe $ip_1 -n 1} resultIP] != 0} { ;# Ping PC
							print_instruction "Ethernet 1 FAIL"
	    				return 0
			}
			if { [string first "Lost = 0" $resultIP] != -1 } {
         		print_instruction "Ping Ethernet 1 OK"
         		after 300
    		} else {  
         		print_instruction "Ethernet 1 FAIL"
         		return 0
       		}
      	}
    }   
    
    set Cmd "ifconfig eth1"
    set Cmdtmpfirst "inet addr:"
    set ip_2 [FindString2_1 $Cmd $Cmdtmpfirst 62]
    if {$ip_2 == 9999} {
    	set ip_2 [FindString2_1 $Cmd $Cmdtmpfirst 62]
    	if {$ip_2 == 9999} {
    	  print_instruction "Ethernet 2 Address not found !"
    		return 0
    	}
    }		  	
    
		puts "IP_tmp = $ip_2"    
    set ip_2 [string range $ip_2 10 24]
    puts $ip_2 
    #ok_dialog "ip2 == $ip_2 "
		
		if {[catch {exec ping.exe $ip_2 -n 1} resultIP] != 0} {  ;# Ping PC
				print_instruction "Ethernet 2 FAIL"
	    	return 0
	} else {					
		puts $resultIP
		if { [string first "Lost = 0" $resultIP] != -1 } {
         	print_instruction "Ping Ethernet 2 OK"
         	after 300
         	return 1
    	} else {
         	ok_dialog "IP Unstable and Try again!!"
         	set resultIP ""
       		if {[catch {exec ping.exe $ip_2 -n 1} resultIP] != 0} { ;# Ping PC
							print_instruction "Ethernet 2 FAIL"
	    				return 0
			}
			if { [string first "Lost = 0" $resultIP] != -1 } {
         		print_instruction "Ping Ethernet 2 OK"
         		after 300
         		return 1
    		} else {  
    				print_instruction "Ethernet 2 FAIL"
         		return 0
       		}
      	}
    }      


}
#############################################################################
## Procedure:  Tuner_Check

proc ::Tuner_Check {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global dbresult
		global tuner_version
		 
########### Tuner Version ##################	 	  
  	print_instruction "Tuner_Version ..."
		after 500
		set Cmd "./tuner_test"     
    set Cmdtmpfirst "\#\#\# Tuner_Test"
		set tuner_version [FindString2_2 $Cmd $Cmdtmpfirst 23]
		puts $tuner_version
    set tuner_version [string range $tuner_version 15 19]
	  regsub -all " " $tuner_version "" tuner_version

		if { [regexp {V0.17} $tuner_version] != 1} {
  			ok_dialog "Tuner version not V0.17 FAIL !! "
    		return 0
		}       

########### Tuner initiation ##################	
		
		print_instruction "Tuner_initiation Test ..." 
		set cur_time [clock seconds]
		while {[expr {[clock seconds]- $cur_time}] <= 10} {
			puts $serialCmd "I"
			flush $serialCmd
			after 6000
			
			if {[catch {read $serialCmd} str]==0} {
					set DEMOD_TUNER $str  
 
		  		if { [regexp {DEMOD0\*OK} $DEMOD_TUNER] != 1} {
  						ok_dialog "DEMOD0 FAIL !! "
							return 0
					}       
					
					if { [regexp {TUNER0\*OK} $DEMOD_TUNER] != 1} {
  						ok_dialog "TUNER0 FAIL !! "
							return 0
					}      
					
					if { [regexp {DEMOD1\*OK} $DEMOD_TUNER] != 1} {
  						ok_dialog "DEMOD1 FAIL !! "
							return 0
					}       
					
					if { [regexp {TUNER1\*OK} $DEMOD_TUNER] != 1} {
  						ok_dialog "TUNER1 FAIL !! "
							return 0
					}  
					
					if { [regexp {DEMOD2\*OK} $DEMOD_TUNER] != 1} {
  						ok_dialog "DEMOD2 FAIL !! "
							return 0
					}       
					
					if { [regexp {TUNER2\*OK} $DEMOD_TUNER] != 1} {
  						ok_dialog "TUNER2 FAIL !! "
							return 0
					}          
		   		return 1
			}
	 }
	 print_instruction "Tuner Check FAIL"
	 return 0
}
#############################################################################
## Procedure:  Tuner_Lock_870M_256Q

proc ::Tuner_Lock_870M_256Q {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global dbresult
		
		print_instruction "Tuner Lock 870M/256Q Test ..."
		set cur_time [clock seconds]
		while {[expr {[clock seconds]- $cur_time}] <= 10} {
			puts $serialCmd "F 3 870000 6900 256"
			flush $serialCmd
			after 5000
			
			if {[catch {read $serialCmd} str]==0} {
					set TUNER_LOCK $str  
 
		  		if { [regexp {DEMOD0LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD0LOCK 870M/256Q FAIL !! "
							return 0
					}     
					
					if { [regexp {DEMOD1LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD1LOCK 870M/256Q FAIL !! "
							return 0
					}        
					
					if { [regexp {DEMOD2LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD2LOCK 870M/256Q FAIL !! "
							return 0
					}  
					return 1
			 }	
		}		
			print_instruction "Tuner Lock 870M/256Q FAIL"
	 		return 0	
}
#############################################################################
## Procedure:  Tuner_870M_256Q_BER

proc ::Tuner_870M_256Q_BER {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global dbresult
		set line ""
		global BER_870M_256Q_TUN1
		global BER_870M_256Q_TUN2
		global BER_870M_256Q_TUN3
			
		print_instruction "Tuner BER 870M/256Q Test ..."
		set Cmd "S 3 1"   
    set Cmdtmpfirst "DEMOD0BER\*BER\:"
		set BER_870M_256Q_TUN1 [FindString2_2 $Cmd $Cmdtmpfirst 21]
		puts $BER_870M_256Q_TUN1
    set BER_870M_256Q_TUN1 [string range $BER_870M_256Q_TUN1 14 23]
	  regsub -all " " $BER_870M_256Q_TUN1 "" BER_870M_256Q_TUN1
	  set BER_870M_256Q_TUN1 [expr double($BER_870M_256Q_TUN1)]
    set BER_870M_256Q_TUN1 [format "%1.1f" $BER_870M_256Q_TUN1]
    #ok_dialog "1.$BER_870M_256Q_TUN1" 
	   
		if { [regexp {0\.0} $BER_870M_256Q_TUN1] != 1} {
  			ok_dialog "BER_870M_256Q_Tuner1 FAIL !! "
    		return 0
		} 
		
		set Cmdtmpfirst "DEMOD1BER\*BER\:"
		set BER_870M_256Q_TUN2 [FindString2_2 $Cmd $Cmdtmpfirst 21]
		puts $BER_870M_256Q_TUN2
    set BER_870M_256Q_TUN2 [string range $BER_870M_256Q_TUN2 14 21]
	  regsub -all " " $BER_870M_256Q_TUN2 "" BER_870M_256Q_TUN2
	  set BER_870M_256Q_TUN2 [expr double($BER_870M_256Q_TUN2)]
    set BER_870M_256Q_TUN2 [format "%1.1f" $BER_870M_256Q_TUN2]
	  #ok_dialog "2.$BER_870M_256Q_TUN2" 
	   
		if { [regexp {0\.0} $BER_870M_256Q_TUN2] != 1} {
  			ok_dialog "BER_870M_256Q_Tuner2 FAIL !! "
    		return 0
		} 
		
		set Cmdtmpfirst "DEMOD2BER\*BER\:"
		set BER_870M_256Q_TUN3 [FindString2_2 $Cmd $Cmdtmpfirst 21]
		puts $BER_870M_256Q_TUN3
    set BER_870M_256Q_TUN3 [string range $BER_870M_256Q_TUN3 14 21]
	  regsub -all " " $BER_870M_256Q_TUN3 "" BER_870M_256Q_TUN3
	  set BER_870M_256Q_TUN3 [expr double($BER_870M_256Q_TUN3)]
    set BER_870M_256Q_TUN3 [format "%1.1f" $BER_870M_256Q_TUN3]
    #ok_dialog "3.$BER_870M_256Q_TUN3" 
	   
		if { [regexp {0\.0} $BER_870M_256Q_TUN3] != 1} {
  			ok_dialog "BER_870M_256Q_Tuner3 FAIL !! "
    		return 0
		} 	
		return 1
}
#############################################################################
## Procedure:  Tuner_Lock_111M_256Q

proc ::Tuner_Lock_111M_256Q {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global dbresult
		
		print_instruction "Tuner Lock 111M/256Q Test ..."
		vwait pass1
		set cur_time [clock seconds]
		while {[expr {[clock seconds]- $cur_time}] <= 10} {
			puts $serialCmd "F 3 111000 6900 256"
			flush $serialCmd
			after 5000
			
			if {[catch {read $serialCmd} str]==0} {
					set TUNER_LOCK $str  
 
		  		if { [regexp {DEMOD0LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD0LOCK 111M/256Q FAIL !! "
							return 0
					}     
					
					if { [regexp {DEMOD1LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD1LOCK 111M/256Q FAIL !! "
							return 0
					}        
					
					if { [regexp {DEMOD2LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD2LOCK 111M/256Q FAIL !! "
							return 0
					}  
					return 1
			 }	
		}		
			print_instruction "Tuner Lock 111M/256Q FAIL"
	 		return 0	
}
#############################################################################
## Procedure:  Tuner_Lock_543M_256Q

proc ::Tuner_Lock_543M_256Q {} {
		global serialCmd
		global cts	
		global id
		global result
		global BarCode1
		global dbresult
		
		print_instruction "Tuner Lock 543M/256Q Test ..."
		vwait pass1
		set cur_time [clock seconds]
		while {[expr {[clock seconds]- $cur_time}] <= 10} {
			puts $serialCmd "F 3 543000 6900 256"
			flush $serialCmd
			after 5000
			
			if {[catch {read $serialCmd} str]==0} {
					set TUNER_LOCK $str  
 
		  		if { [regexp {DEMOD0LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD0LOCK 543M/256Q FAIL !! "
							return 0
					}     
					
					if { [regexp {DEMOD1LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD1LOCK 543M/256Q FAIL !! "
							return 0
					}        
					
					if { [regexp {DEMOD2LOCK\*OK} $TUNER_LOCK] != 1} {
  						ok_dialog "DEMOD2LOCK 543M/256Q FAIL !! "
							return 0
					} 
					puts $serialCmd "Q"
					flush $serialCmd 
					after 100 
					puts $serialCmd "set_outports -audio_engine 0 -Volume 0 -component -f 1080p50 -digital -f HDMI_1080p50 -analog -f PAL_BG -I2StoSPDIF 1"
					flush $serialCmd
					after 100
					puts $serialCmd "test_rmfp -app psfdemux -ssi 2"
					flush $serialCmd
					after 100
					return 1
			 }	
		}		
			print_instruction "Tuner Lock 543M/256Q FAIL"   
	 		return 0	
}
#############################################################################
## Procedure:  Ini_GDS2104

proc Ini_GDS2104 {} {
		global gpibCmd
		global addrnum_scope
		
		set gpibCmd  [gpib open -address $addrnum_scope]
		gpibw2 $gpibCmd ":CHANnel1:SCALe 2.00E-1"						;#set desired gain value in volts per division CH1 -> 200mV
		gpibw2 $gpibCmd ":CHANnel2:SCALe 1.00E+0"						;#set desired gain value in volts per division CH2 -> 1V
		gpibw2 $gpibCmd ":CHANnel3:SCALe 1.00E+0"						;#set desired gain value in volts per division CH3 -> 1V	
		
		gpibw2 $gpibCmd ":TRIGger:MODe 0"										;#select trigger mode -> Auto level
		gpibw2 $gpibCmd ":TRIGger:VIDeo:TYPe 0"
		gpibw2 $gpibCmd ":TRIGger:VIDeo:POLarity 1"
		gpibw2 $gpibCmd ":TRIGger:VIDeo:FIELd 1"
		
		gpibw2 $gpibCmd ":CHANnel1:COUPling 1"
		gpibw2 $gpibCmd ":CHANnel2:COUPling 1"
		gpibw2 $gpibCmd ":CHANnel3:COUPling 1"

		gpibw2 $gpibCmd ":CHANnel1:PROBe 0"
		gpibw2 $gpibCmd ":CHANnel2:PROBe 0"
		gpibw2 $gpibCmd ":CHANnel3:PROBe 0"
		
		return 1		 

}
#############################################################################
## Procedure:  Ini_GDS21040

proc Ini_GDS21040 {} {
		global gpibCmd5
		global serialCmd5
		global addrnum_scope
		global portCmd_stb5
		
		set serialCmd5 [open com$portCmd_stb5 r+]
		fconfigure $serialCmd5  -blocking 0 -mode 38400,n,8,1	
		
		puts $serialCmd5 ":CHANnel1:SCALe 2.00E-1"						;#set desired gain value in volts per division CH1 -> 200mV
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":CHANnel2:SCALe 2.00E-1"						;#set desired gain value in volts per division CH2 -> 1V
		flush $serialCmd5		
		after 700
		puts $serialCmd5 ":TRIGger:MODe 0"										;#select trigger mode -> Auto level
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":TRIGger:VIDeo:TYPe 0"
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":TRIGger:VIDeo:POLarity 1"
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":TRIGger:VIDeo:FIELd 0"
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":CHANnel1:COUPling 1"
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":CHANnel2:COUPling 1"
    flush $serialCmd5
    after 700
		puts $serialCmd5 ":CHANnel1:PROBe 0"
		flush $serialCmd5
		after 700
		puts $serialCmd5 ":CHANnel2:PROBe 0"
		flush $serialCmd5
		after 700
		
		return 1		 

}
#############################################################################
## Procedure:  ConnectSFIS

proc ConnectSFIS {} {
		global BarCode0
		global BarCode1
		global BarCode2 
		global BarCode3
		global portCmd_stb
		global item2
		global item3
		global HDCPKEY 
		global SATAHDDSN1 
		global SATAHDDSN2

      global Enable_SFI
      
      if { $Enable_SFI != 1} {
	      print_instruction "Disable ConnectSFIS Shop flow !!"
	      return 1
      }

		if {[file exists "c:\\MESLOG\\SEG$portCmd_stb.txt"]} {
				file delete "c:\\MESLOG\\SEG$portCmd_stb.txt"
		}

		set SFIS_handle [open "sfis_$portCmd_stb.bat" "a"]
		puts $SFIS_handle "c:\\3D\\Project1_receive.exe $BarCode0 S2"
		flush $SFIS_handle
		close $SFIS_handle
		after 200
		
		catch {exec "sfis_$portCmd_stb.bat"} result
		set cur_time [clock seconds]
		after 500

		file delete "sfis_$portCmd_stb.bat"
		
		while { [expr {[clock seconds]- $cur_time}] <= 10} {
				if {[file exists "c:\\MESLOG\\SEG$portCmd_stb.txt"]} {
						set input [open "c:\\MESLOG\\SEG$portCmd_stb.txt" r]
						set AAA [read $input]
						close $input
						set BBB [split $AAA ";"]
						set BBB [regsub -all "\{" $BBB ""]
						set BBB [regsub -all "\}" $BBB ""]
						scan $BBB "%s %s %s %s %s" temp1 BarCode0 BarCode1 BarCode2 BarCode3
						
						regsub -all " " $BarCode0 ""
						regsub -all " " $BarCode1 ""
						regsub -all " " $BarCode2 ""
						regsub -all " " $BarCode3 ""

				
						if { $temp1 == "A01" } {
								print_instruction "DUT $BarCode0 Not test yet!!(A01)" 
								unset temp1
								return 1
						} elseif { $temp1 == "A02" } {
						    print_instruction "DUT $BarCode0 test failed, try again!!(A02)" 
						    unset temp1
						    return 1 
						} elseif { $temp1 == "A21" } {
						    print_instruction "DUT $BarCode0 Station Error!!(A21)" 
						    unset temp1
						    return 0           
						} elseif { $temp1 == "A22" } {
						    print_instruction "There is a $BarCode0 in database.(A22)" 
						    unset temp1
						    return 0     
						} elseif { $temp1 == "A03" } {
								print_instruction "DUT $BarCode0 test failed.(A03)" 
								unset temp1
								return 0
						} else {
								print_instruction "DUT $BarCode0 get value failed.(A10)" 
								unset temp1
								return 0	
					 }		
				}
				after 1000		
		}
		print_instruction "Shop flow not response!!"
		return 0 
}

#############################################################################
## Procedure:  ConnectSFIS2

proc ConnectSFIS2 {} {
		global ChipID
		global portCmd_stb
		global SOC_Public_ID
		global SOC_Pairing_Data
		global BarCode1
		
		if {[file exists "c:\\MESLOG\\Chip$portCmd_stb.txt"]} {
				file delete "c:\\MESLOG\\Chip$portCmd_stb.txt"
		}
		
		set SOC_Pairing_Data ""
		set SFIS_handle [open "sfis2_$portCmd_stb.bat" "a"]
		puts $SFIS_handle "z:\\kinpo\\production\\ChipID_cda210.exe $SOC_Public_ID;CD-PT1;Chip$portCmd_stb;$BarCode1;"
		flush $SFIS_handle
		close $SFIS_handle
		after 200
		
		catch {exec "sfis2_$portCmd_stb.bat"} result
		set cur_time [clock seconds]
		after 500
		
		file delete "sfis2_$portCmd_stb.bat"
		while { [expr {[clock seconds]- $cur_time}] <= 10} {
				if {[file exists "c:\\MESLOG\\Chip$portCmd_stb.txt"]} {
						set input [open "c:\\MESLOG\\Chip$portCmd_stb.txt" r]
						set AAA [read $input]
						close $input
						set BBB [split $AAA ";"]
						scan $BBB "%s %s %s" temp1 temp2 SOC_Pairing_Data					
						set length [string length $SOC_Pairing_Data]
						
						if { $length != 128 } {
								ok_dialog "SOC pairing data length wrong!!\n $length != 128"
								return 0		
							}
							unset temp1
							unset temp2
							#file delete "c:\\MESLOG\\Chip$portCmd_stb.txt"
							return 1
					}
					after 1000		
			}
			return 0 
}
#############################################################################
## Procedure:  ConnectSFIS3

proc ConnectSFIS3 {OKorNG test_result} {
		global BarCode0
		global BarCode1
		global BarCode2
		global BarCode3
		global item1
		global item2
		global item3
		global item4
		global item6
		global portCmd_stb
		global SFISControl

	   global Enable_SFI
      
      if { $Enable_SFI != 1} {
	      print_instruction "Disable ConnectSFIS3 Shop flow !!"
	      return 0
      }
      				
		if {[file exists "C:\\MESLOG\\result$portCmd_stb.txt"]} {
				file delete "C:\\MESLOG\\result$portCmd_stb.txt"
		}
		
		if {[file exists sfis3_$portCmd_stb.bat]} {
				file delete sfis3_$portCmd_stb.bat
		}
		
		if { $OKorNG != "OK" } {
				#print_instruction "Fail,please retest"
				#return 1
		}
		
		set SFIS_handle [open "sfis3_$portCmd_stb.bat" "a"]
		set SFIS_handle1 [open "Database_backup$portCmd_stb.txt" "a"]
		puts $SFIS_handle "c:\\3D\\Project1_receive.exe $BarCode0 S2 $OKorNG $test_result"
		flush $SFIS_handle
		close $SFIS_handle
		puts $SFIS_handle1 "c:\\3D\\Project1_receive.exe $BarCode0 S2 $OKorNG $test_result"
		flush $SFIS_handle1
		close $SFIS_handle1
		after 500
		
		catch {exec "sfis3_$portCmd_stb.bat"} result
		set cur_time [clock seconds]
		after 500
		
		#file delete "sfis3_$portCmd_stb.bat"
		while { [expr {[clock seconds]- $cur_time}] <= 10} {
				if {[file exists "c:\\MESLOG\\RESULT$portCmd_stb.txt"]} {
						set input [open "c:\\MESLOG\\RESULT$portCmd_stb.txt" r]
						set AAA [read $input]
						close $input
						set BBB [split $AAA ";"]
						set BBB [regsub -all "\{" $BBB ""]
						scan $BBB "%s" temp1
						after 500
						
						#file delete "c:\\MESLOG\\result$portCmd_stb.txt"
						if { $temp1 == "OK" } { 
								print_instruction "Write to database PASS"
								return 1
						} else {
								print_instruction "Write to database fail"
								after 1000
								return 0
						}
				}
				after 500		
		}
		print_instruction "Shop flow not response"
		return 0 
}

#############################################################################
## Procedure:  WriteLog

proc WriteLog {errcode OkNg testreport} {
		global BarCode0
		global BarCode1
		global BarCode2
		global BarCode3
		global SM
		global hdcp_ksv
		global SOC_Public_ID
		global logStartTime
		global Accton_SFIS FINISHTIME time_log StartTime
		
	#Accton SFIS parameter
	set ::FINISHTIME [clock format [clock seconds] -format {%Y%m%d%H%M%S} ]
		
	set EndTime [clock seconds]
	set EndTime [expr $EndTime - $StartTime]
	lappend time_log "=============================================="
	lappend time_log "Total Test Time    : $EndTime  sec."
		
		
	if { $OkNg == "OK" } {
  	set TestResult PASS
  	save_time "1"
	} else {
  	set TestResult FAIL 
  	save_time "0"
	}

  #kevin test result send to accton sfis #
  if { $Accton_SFIS == 1 } {
 		_f_MesShopFlowUploadResultLog $TestResult
	} 

		global Enable_SFI
      
      if { $Enable_SFI != 1} {
	      print_instruction "Disable WriteLog !!"
	      return 0
      }
		
		set testtime [expr {[clock seconds]- $logStartTime}]
		if { $OkNg == "OK" } {
				set logfile [open "C:\\3D\\Log\\$BarCode1.txt" "a"]
		 		puts $logfile "=========================================================================================="
		 		puts $logfile "Main SN    	: $BarCode0"
		 		puts $logfile "Device SN    : $BarCode1"
		 		puts $logfile "STB MAC-1    : $BarCode2"
		 		puts $logfile "STB MAC-2    : $BarCode3"
		 		#puts $logfile "Secure Micro : $SM"
		 		#puts $logfile "CPU Chip ID  : $SOC_Public_ID"
		 		#puts $logfile "HDCP KSV     : $hdcp_ksv"
		 		puts $logfile ""
		 		puts $logfile "$testreport"
		 		puts $logfile "==============================================="
				puts $logfile "total test time   : $testtime  sec."
				puts $logfile ""
				flush $logfile
				close $logfile
		 	
		} else {
				set logfile [open "C:\\3D\\Log\\NG_$BarCode1.txt" "a"]
		 		puts $logfile "=========================================================================================="
		 		puts $logfile "Main SN    	: $BarCode0"
		 		puts $logfile "Device SN    : $BarCode1"
		 		puts $logfile "STB MAC-1    : $BarCode2"
		 		puts $logfile "STB MAC-2    : $BarCode3"
		 		#puts $logfile "Secure Micro : $SM"
		 		puts $logfile ""
		 		puts $logfile "$testreport"
		 		puts $logfile "==============================================="
				puts $logfile "total test time   : $testtime  sec."
				puts $logfile ""
				flush $logfile
				close $logfile
		}
		return 1
}

#############################################################################
## Initialization Procedure:  init

proc ::init {argc argv} {

}

init $argc $argv

#################################
# VTCL GENERATED GUI PROCEDURES
#

proc vTclWindow. {base} {
    if {$base == ""} {
        set base .
    }
    ###################
    # CREATING WIDGETS
    ###################
    wm focusmodel $top passive
    wm geometry $top 200x200+88+156; update
    wm maxsize $top 1444 868
    wm minsize $top 141 1
    wm overrideredirect $top 0
    wm resizable $top 1 1
    wm withdraw $top
    wm title $top "vtcl"
    bindtags $top "$top Vtcl all"
    vTcl:FireEvent $top <<Create>>
    wm protocol $top WM_DELETE_WINDOW "vTcl:FireEvent $top <<DeleteWindow>>"

    ###################
    # SETTING GEOMETRY
    ###################

    vTcl:FireEvent $base <<Ready>>
}

proc vTclWindow.top73 {base} {
    if {$base == ""} {
        set base .top73
    }
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    set top $base
    ###################
    # CREATING WIDGETS
    ###################
    vTcl:toplevel $top -class Toplevel \
        -menu "$top.m82" -relief raised 
    wm focusmodel $top passive
    wm geometry $top 622x411+400+247; update
    wm maxsize $top 1028 746
    wm minsize $top 141 1
    wm overrideredirect $top 0
    wm resizable $top 1 1
    wm deiconify $top
    wm title $top "SMP8654_ST2 v1.5 20100907"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    bindtags $top "$top Toplevel all _TopLevel"
    bind $top <Key-F10> {
        exit
    }
    vTcl:FireEvent $top <<Create>>
    wm protocol $top WM_DELETE_WINDOW "vTcl:FireEvent $top <<DeleteWindow>>"

    frame $top.fra77 \
        -borderwidth 2 -height 65 -width 295 
    vTcl:DefineAlias "$top.fra77" "Frame2" vTcl:WidgetProc "Toplevel1" 1
    bind $top.fra77 <Configure> {
        # TODO: your event handler here
    }
    set site_3_0 $top.fra77
    label $site_3_0.lab89 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -relief ridge -text STB:COM1 -textvariable cmdport 
    vTcl:DefineAlias "$site_3_0.lab89" "Label5" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but74 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -relief ridge -takefocus 0 -text Ready \
        -textvariable teststatus 
    vTcl:DefineAlias "$site_3_0.but74" "Button3" vTcl:WidgetProc "Toplevel1" 1
    place $site_3_0.lab89 \
        -in $site_3_0 -x 20 -y 15 -width 128 -height 39 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but74 \
        -in $site_3_0 -x 155 -y 15 -width 128 -height 39 -anchor nw \
        -bordermode ignore 
    menu $top.m82 \
        -activeborderwidth 1 -borderwidth 1 -cursor {} -font {?s??¨²?¨¦ 9} \
        -tearoff 0 
    label $top.lab94 \
        \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -text SMP8654-Station2 
    vTcl:DefineAlias "$top.lab94" "Label4" vTcl:WidgetProc "Toplevel1" 1
    vTcl::widgets::core::megawidget::createCmd $top.meg97 \
        -widgetProc ::lupin::myWidgetProc 
    vTcl:DefineAlias "$top.meg97" "MegaWidget2" vTcl::widgets::core::megawidget::widgetProc "Toplevel1" 1
    frame $top.fra87 \
        -borderwidth 2 -height 240 -width 665 
    vTcl:DefineAlias "$top.fra87" "Frame1" vTcl:WidgetProc "Toplevel1" 1
    bind $top.fra87 <Configure> {
      set defile "defmain.h"
			source $defile
			#set Counter 0
			Ini_GDS2104
			Ini_GDS21040
			serial_openCmd $portCmd_stb
			serial_closeCmd 
			source scpi.tcl
			source common.tcl
			if { $::Accton_SFIS == 1 } {
				package require tcom
				source AccWS.tcl
				if { $::OP_UI == 1 } { 
					configStation
				}
			}
			global cts
			
		set repeat 1
		while {$repeat==1} {
					set restart 1 
					set retest 1
					set restart_go 1
   		
   		if {$restart_go==1} {
       		set restart_go 0
       		set BarCode0 {}
       		set BarCode1 {}
       		set BarCode2 {}
       		set BarCode3 {}
       		set BarCode4 {}
       	}
		
		while {$retest==1} {
   		if {$restart_go==1} {
       		set restart_go 0
       		set BarCode0 {}
       		set BarCode1 {}
       		set BarCode2 {}
       		set BarCode3 {}
       		set BarCode4 {}
        }
  			set pass1 -1
				set pass2 -1
				set test_go -1
			 
			 %W.cpd101 configure -state normal 
			 %W.cpd99 configure -state disable        
       %W.cpd89 configure -state disable
       %W.cpd90 configure -state disable
       %W.cpd95 configure -state disable
       %W.cpd96 configure -state disable
       %W.but99 configure -state disable
       %W.but100 configure -state disable
       focus -force %W.cpd101
       vwait test_go
       set B4 [expr [string length $BarCode4]]
       
          	 
    	 %W.cpd99 configure -state normal 
			 %W.cpd101 configure -state disable        
       %W.cpd89 configure -state disable
       %W.cpd90 configure -state disable
       %W.cpd95 configure -state disable
       %W.cpd96 configure -state disable
       %W.but99 configure -state disable
       %W.but100 configure -state disable
       focus -force %W.cpd99
       vwait test_go
       set B0 [expr [string length $BarCode0]]  
    	 
    	 #if {![LoadData]} {
       #		print_instruction "Can not find data match $BarCode1"  	 		 
    	 #		break
    	 #} 
    	 
    	 if {[ConnectSFIS] != 1} {
    	 		 #print_instruction "There is a $BarCode1 in DataBase (A22) or DUT $BarCode1 test fail (A03)"
           #after 100	
    	 		break
    	 } 
    	 
    	 	###Kevin accton sfis start --> check in####
						if { $Accton_SFIS == 1 } {
							print_instruction "MesShopFlowCheckIn"
							set temp [_f_MesShopFlowCheckIn]
							if { $temp != 1 } {
								puts "kevin ... debug12  temp=$temp"
								.top73.fra87.but99  configure -state disable
						    .top73.fra87.but100  configure -state disable
						    .top73.fra87.cpd88 configure -state disable
						    .top73.fra87.cpd91 configure -state active
						    print_instruction "Shop floor checkin Fail;"  
						  	test_resultZ2 "Shop floor checkin fail"
						  	puts $cts "Show $id Shop floor checkin Fail"
						  	flush $cts 
						  	set BRPOINT 0
						  	return
							}
					 
						}
    	  	 
    	 
    if { $Enable_SFI != 1} {
	      if {![LoadData]} {
      		 print_instruction "Can not find data match $BarCode1"  	 		 
    	 		break
    	   } 
      }
    	 
    	 
#    	 %W.cpd89 configure -state disable
#       %W.cpd90 configure -state disable
#       %W.cpd95 configure -state disable
#       %W.cpd96 configure -state disable
#       %W.but99 configure -state disable
#       %W.but100 configure -state disable
#       focus -force %W.cpd89
#       vwait test_go
#       set B1 [expr [string length $BarCode1]]
    	       
#       %W.cpd88 configure -state disable        
#       %W.cpd89 configure -state disable
#       %W.cpd90 configure -state normal 
#       %W.cpd95 configure -state disable
#       %W.cpd96 configure -state disable
#       %W.but99 configure -state disable
#       %W.but100 configure -state disable       
#       focus -force %W.cpd90
#       vwait test_go
#       set B2 [expr [string length $BarCode2]]		 
#    	 
#    	 
#    	 %W.cpd88 configure -state disable        
#       %W.cpd89 configure -state disable
#       %W.cpd90 configure -state disable 
#       %W.cpd95 configure -state normal
#       %W.cpd96 configure -state disable
#       %W.but99 configure -state disable
#       %W.but100 configure -state disable       
#       focus -force %W.cpd95
#       vwait test_go
#       set B3 [expr [string length $BarCode3]]	
#       
#       if {$BarCode3 == $BarCode2} {
#					print_instruction " BarCode3 == $BarCode3 Scan wrong!"
#					break
#			}   
              
      print_instruction "Enter to Start Test "
      %W.cpd96 configure -state normal 
      %W.cpd99 configure -state disable
      # %W.cpd88 configure -state disable
      %W.cpd89 configure -state disable
      %W.cpd89 configure -state disable
      %W.cpd90 configure -state disable
      %W.cpd95 configure -state disable 
      %W.but99 configure -state disable
      %W.but100 configure -state disable      
      focus -force %W.cpd96
      vwait test_go       
    }
  }
    }
    set site_3_0 $top.fra87
    entry $site_3_0.cpd89 \
        -background white \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -relief ridge -takefocus 0 -textvariable BarCode1 
    vTcl:DefineAlias "$site_3_0.cpd89" "Entry5" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd89 <Key-Return> {
        set B1 [expr [string length $BarCode1]]
				set BarCode1 [string toupper $BarCode1 0 [expr $B1-1]]  

				#if {![selsql]} {
        #     ok_dialog1 "There is a $BarCode1 in DataBase"	 
        #     set $BarCode1 {}
        #     %W delete [tk::EntryPreviousWord %W insert] inser
        #     break
        #    } 
           
				if {$B1!=16}  {
             print_instruction "The length of S/N must be 16 Please input  again!"
             set $BarCode1 {}
             %W delete [tk::EntryPreviousWord %W insert] inser
             break
           } else {
     		     print_instruction " The S/N = $BarCode1 "
           }
						
					set BB  "S/N = $BarCode1" 
					print_instruction "$BB"
 					set test_go 1
    }
    entry $site_3_0.cpd90 \
        -background white \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -relief ridge -takefocus 0 -textvariable BarCode2 
    vTcl:DefineAlias "$site_3_0.cpd90" "Entry6" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd90 <Key-Return> {
        set B2 [expr [string length $BarCode2]]
        set BarCode2 [string toupper $BarCode2 0 [expr $B2-1]]  
				
				if {$B2!=12} {
            print_instruction " The length of MAC must be 12 Please input again !"
            set $BarCode2 {}
            %W delete [tk::EntryPreviousWord %W insert] insert
            break
          } else {
            print_instruction " The MAC = $BarCode2 "
          } 
					set CC  "MAC-1 = $BarCode2" 
					print_instruction "\n$BB\n$CC"
					set test_go 1
    }
    entry $site_3_0.cpd95 \
        -background white \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -relief ridge -takefocus 0 -textvariable BarCode3 
    vTcl:DefineAlias "$site_3_0.cpd95" "Entry7" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd95 <Key-Return> {
        set B3 [expr [string length $BarCode3]]
        set BarCode3 [string toupper $BarCode3 0 [expr $B3-1]]  
				
				if {$B3!=12} {
            print_instruction " The length of MAC-2 must be 12 Please input again !"
            set $BarCode3 {}
            %W delete [tk::EntryPreviousWord %W insert] insert
            break
          } else {
            print_instruction " The MAC-2= $BarCode3"
          } 
				
					set CC  "MAC-2 = $BarCode3" 
					set DD  "$BB\n$CC"
					print_instruction "\n$BB\n$CC"
					set test_go 1
    }
    label $site_3_0.cpd93 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -text DeviceSN 
    vTcl:DefineAlias "$site_3_0.cpd93" "Label8" vTcl:WidgetProc "Toplevel1" 1
    label $site_3_0.cpd94 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -text {Mac addr 1} 
    vTcl:DefineAlias "$site_3_0.cpd94" "Label9" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.cpd96 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -takefocus 0 -text Start 
    vTcl:DefineAlias "$site_3_0.cpd96" "Button8" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd96 <Key-Return> {
        %W configure -state disable  
	puts $cts "Ready $id $BarCode1 $BarCode2 $BarCode3"
	flush $cts
	focus -force  .top73.fra87.but99
    }
    button $site_3_0.cpd97 \
        -command exit \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -takefocus 0 -text Exit 
    vTcl:DefineAlias "$site_3_0.cpd97" "Button9" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.but99 \
        \
        -command {set pass1 1
			.top73.fra87.cpd88 configure -state active
			.top73.fra87.cpd91 configure -state disable
			update} \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -takefocus 0 -text Next 
    vTcl:DefineAlias "$site_3_0.but99" "Button1" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.but99 <Key-Return> {
        set pass1 1
			.top73.fra87.cpd88 configure -state active
			.top73.fra87.cpd91 configure -state disable
    }
    bind $site_3_0.but99 N {
        set pass1 0
			.top73.fra87.cpd88 configure -state disable
			.top73.fra87.cpd91 configure -state active
    }
    bind $site_3_0.but99 n {
        set pass1 0
			.top73.fra87.cpd88 configure -state disable
			.top73.fra87.cpd91 configure -state active
    }
    button $site_3_0.but100 \
        \
        -command {set n -1
			.top73.fra87.cpd88 configure -state disable
			.top73.fra87.cpd91 configure -state active
			update} \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -takefocus 0 -text Stop 
    vTcl:DefineAlias "$site_3_0.but100" "Button2" vTcl:WidgetProc "Toplevel1" 1
    message $site_3_0.cpd76 \
        -background {#000000} \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -foreground {#ff0000} -relief ridge -text {Firmware Version} \
        -width 186 
    vTcl:DefineAlias "$site_3_0.cpd76" "Message6" vTcl:WidgetProc "Toplevel1" 1
    label $site_3_0.cpd78 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -text Firmware 
    vTcl:DefineAlias "$site_3_0.cpd78" "Label12" vTcl:WidgetProc "Toplevel1" 1
    message $site_3_0.cpd86 \
        -background {#000000} \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -foreground {#ffff00} -relief ridge -text {Firmware Version} \
        -textvariable Test_item -width 200 
    vTcl:DefineAlias "$site_3_0.cpd86" "Message7" vTcl:WidgetProc "Toplevel1" 1
    label $site_3_0.cpd87 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -text {Test Item} 
    vTcl:DefineAlias "$site_3_0.cpd87" "Label10" vTcl:WidgetProc "Toplevel1" 1
    button $site_3_0.cpd88 \
        -activebackground {#00ff00} \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -relief groove -state active -takefocus 0 -text PASS 
    vTcl:DefineAlias "$site_3_0.cpd88" "Button10" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd88 y {
        # TODO: your event handler here
        puts "step 2"
    		set pass1 1
    }
    button $site_3_0.cpd91 \
        -activebackground {#ff0000} \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -relief ridge -state disabled -takefocus 0 -text FAIL 
    vTcl:DefineAlias "$site_3_0.cpd91" "Button11" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd91 n {
        # TODO: your event handler here
    		puts "step 3"
    		set pass1 2
    }
    label $site_3_0.cpd92 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -text {Mac addr 2} 
    vTcl:DefineAlias "$site_3_0.cpd92" "Label11" vTcl:WidgetProc "Toplevel1" 1
    label $site_3_0.cpd98 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -text {Main SN} 
    vTcl:DefineAlias "$site_3_0.cpd98" "Label13" vTcl:WidgetProc "Toplevel1" 1
    entry $site_3_0.cpd99 \
        -background white \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -relief ridge -takefocus 0 -textvariable BarCode0 
    vTcl:DefineAlias "$site_3_0.cpd99" "Entry8" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd99 <Key-Return> {
        set B0 [expr [string length $BarCode0]]
				set BarCode0 [string toupper $BarCode0 0 [expr $B0-1]]  

				#if {![selsql]} {
        #     ok_dialog1 "There is a $BarCode1 in DataBase"	 
        #     set $BarCode1 {}
        #     %W delete [tk::EntryPreviousWord %W insert] insert
        #     break
        #    } 
           
				if {$B0!=11}  {
             print_instruction "The length of S/N must be 11 digits Please input again!"
             set $BarCode0 {}
             %W delete [tk::EntryPreviousWord %W insert] insert
             break
           } else {
     		     print_instruction " The S/N = $BarCode0 "
           }
						
					set BB  "S/N = $BarCode0" 
					print_instruction "$BB"
 					set test_go 1
    }
    label $site_3_0.cpd100 \
        \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -text {PCB SN} 
    vTcl:DefineAlias "$site_3_0.cpd100" "Label14" vTcl:WidgetProc "Toplevel1" 1
    entry $site_3_0.cpd101 \
        -background white \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -relief ridge -takefocus 0 -textvariable BarCode4 
    vTcl:DefineAlias "$site_3_0.cpd101" "Entry9" vTcl:WidgetProc "Toplevel1" 1
    bind $site_3_0.cpd101 <Key-Return> {
        set B4 [expr [string length $BarCode4]]
				set BarCode4 [string toupper $BarCode4  0 [expr $B4-1]]  

				#if {![selsql]} {
        #     ok_dialog1 "There is a $BarCode1 in DataBase"	 
        #     set $BarCode1 {}
        #     %W delete [tk::EntryPreviousWord %W insert] insert
        #     break
        #    } 
           
				if {$B4!=9}  {
             print_instruction "The length of S/N must be 9 digits Please input again!"
             set $BarCode4 {}
             %W delete [tk::EntryPreviousWord %W insert] insert
             break
           } else {
     		     print_instruction " The S/N = $BarCode4 "
           }
						
					set BB  "S/N = $BarCode4" 
					print_instruction "$BB"
 					set test_go 1
    }
    place $site_3_0.cpd89 \
        -in $site_3_0 -x 100 -y 115 -width 200 -height 35 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd90 \
        -in $site_3_0 -x 100 -y 155 -width 200 -height 35 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd95 \
        -in $site_3_0 -x 100 -y 200 -width 199 -height 33 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd93 \
        -in $site_3_0 -x 0 -y 120 -anchor nw -bordermode inside 
    place $site_3_0.cpd94 \
        -in $site_3_0 -x -15 -y 160 -width 109 -height 22 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd96 \
        -in $site_3_0 -x 342 -y 17 -width 95 -height 30 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd97 \
        -in $site_3_0 -x 475 -y 15 -width 95 -height 30 -anchor nw \
        -bordermode inside 
    place $site_3_0.but99 \
        -in $site_3_0 -x 345 -y 60 -width 95 -height 30 -anchor nw \
        -bordermode ignore 
    place $site_3_0.but100 \
        -in $site_3_0 -x 480 -y 60 -width 95 -height 30 -anchor nw \
        -bordermode ignore 
    place $site_3_0.cpd76 \
        -in $site_3_0 -x 100 -y 0 -width 200 -height 30 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd78 \
        -in $site_3_0 -x 0 -y 0 -anchor nw -bordermode inside 
    place $site_3_0.cpd86 \
        -in $site_3_0 -x 385 -y 155 -width 200 -height 35 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd87 \
        -in $site_3_0 -x 305 -y 160 -anchor nw -bordermode inside 
    place $site_3_0.cpd88 \
        -in $site_3_0 -x 345 -y 105 -width 90 -height 30 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd91 \
        -in $site_3_0 -x 480 -y 105 -width 90 -height 30 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd92 \
        -in $site_3_0 -x 0 -y 205 -anchor nw -bordermode inside 
    place $site_3_0.cpd98 \
        -in $site_3_0 -x 0 -y 80 -anchor nw -bordermode inside 
    place $site_3_0.cpd99 \
        -in $site_3_0 -x 100 -y 75 -width 199 -height 33 -anchor nw \
        -bordermode inside 
    place $site_3_0.cpd100 \
        -in $site_3_0 -x 0 -y 40 -anchor nw -bordermode inside 
    place $site_3_0.cpd101 \
        -in $site_3_0 -x 100 -y 35 -width 199 -height 33 -anchor nw \
        -bordermode inside 
    message $top.mes86 \
        -background {#000000} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -foreground {#ffffff} -relief ridge -text message -width 575 
    vTcl:DefineAlias "$top.mes86" "Message1" vTcl:WidgetProc "Toplevel1" 1
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.fra77 \
        -in $top -x 320 -y -5 -width 295 -height 65 -anchor nw \
        -bordermode ignore 
    place $top.lab94 \
        -in $top -x 70 -y 15 -width 208 -height 24 -anchor nw \
        -bordermode ignore 
    place $top.meg97 \
        -in $top -x 76 -y 335 -anchor nw -bordermode ignore 
    place $top.fra87 \
        -in $top -x 20 -y 60 -width 665 -height 240 -anchor nw \
        -bordermode ignore 
    place $top.mes86 \
        -in $top -x 25 -y 325 -width 575 -height 68 -anchor nw \
        -bordermode ignore 

    vTcl:FireEvent $base <<Ready>>
}

#############################################################################
## Binding tag:  _TopLevel

bind "_TopLevel" <<Create>> {
    if {![info exists _topcount]} {set _topcount 0}; incr _topcount
}
bind "_TopLevel" <<DeleteWindow>> {
    if {[set ::%W::_modal]} {
                vTcl:Toplevel:WidgetProc %W endmodal
            } else {
                destroy %W; if {$_topcount == 0} {exit}
            }
}
bind "_TopLevel" <Destroy> {
    if {[winfo toplevel %W] == "%W"} {incr _topcount -1}
}

Window show .
Window show .top73

main $argc $argv
