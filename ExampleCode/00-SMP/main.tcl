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
    set base .top87
    namespace eval ::widgets::$base {
        set set,origin 1
        set set,size 1
        set runvisible 1
    }
    namespace eval ::widgets_bindings {
        set tagslist _TopLevel
    }
    namespace eval ::vTcl::modules::main {
        set procs {
            init
            main
            rsql
            test_print
            test_resultZ2
            now_short
            on_connect
            handleInput
            go_exit
            go_run_Loop
            go_run_Once
            gpibw2
            gpibr2
            gpib_openCmd
            gpib_closeCmd 
            ok_dialog 
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
## Procedure:  main						;#mattmain

proc ::main {argc argv} {uplevel {
global number
global testok
global addrnum_rfswitch_2port
global addrnum_scope      
set count 1
set testok 0
set previous 0

socket -server on_connect -myaddr 127.0.0.1 5999
after 100
set number 1
set defile "defmain.h"
source $defile
source scpi.tcl		
global gpibCmd
global addrnum_scope
global dbresult

set gpibCmd  [gpib open -address $addrnum_scope]

for { set i 1 } { $i <= $count} { incr i } {
		test_print "[now_short] Creating one uut Client $i Com[expr $i]"
		catch { exec tclsh "client.tcl" $i &} err
		#catch { exec "client.exe" $i &} err
	}
		puts $err
		puts $number
		
		while { $number < $count} {
			vwait number
		}
		 
test_print "[now_short] Server_Client Initialization Finished"
package ifneeded sqlite3 3.2.8  [list load [file join ./ sqlite328.dll] Sqlite3]
package require sqlite3

sqlite db em8654_ST2.db
catch {
	db eval {
     CREATE TABLE em8654_function (
        	SN TEXT PRIMARY KEY,
        	SN1 TEXT,
        	MAC1 TEXT,
        	MAC2 TEXT,
        	PCB_SN TEXT,
        	DATE TEXT,
        	RS232 TEXT,        	
        	Get_Version TEXT,        	
          USB_Test TEXT,
          Ethernet_Test TEXT,  
          RCA_Video_Level TEXT, 
          RCA_LAudio_Level TEXT,
          RCA_RAudio_Level TEXT, 
          YPbPr_Check TEXT,
					SVideo_Check TEXT, 
        	Run_Time TEXT                
    			)
				}
		}  
		
}}

#############################################################################
#  if Serial Number has not in DataBase , then return 1
#  elsee return 0
proc selsql {} {
    sqlite db em8654_ST2.db
    global SN
    
    puts "SN==$SN,length==[string length $SN]"		
		set chk_barcode [db eval "SELECT * FROM em8654_function WHERE SN = '$SN'"]
		puts "Data ===$chk_barcode" 
		
		if {[string length $chk_barcode]==0} {
				return 1
			} else {
				return 0
			}		
}


#############################################################################
## Procedure:  rsql

proc rsql {table_name} {
		global dbresult
		global Run_time
		
		#append dbresult ",'$Run_time'"
		puts "rsql == $dbresult"
    #db eval "INSERT INTO fuction VALUES($dbresult)"
		catch {set result [db eval "INSERT INTO $table_name VALUES($dbresult)"]} result1
		puts $result1
		if { $result1 == "" } {
				return 1
		} elseif { $result1 == "column SN is not unique" } {
				#ok_dialog "Write to database fail! => SN not unique!!"
				set result1 ""
				return 0
		} 				
				#ok_dialog "Write to database fail! => unknown reason!!"
				set result1 ""
				return -1
		}
	
		
#}

#############################################################################
## Procedure:  test_resultZ2

proc ::test_resultZ2 {stat} {
	global filename
	global fileLogZ2
  global BarCode1

	set chan [open $fileLogZ2 "a"]
	puts $chan "[clock_now];$stat"
	flush $chan	
	close $chan	
}
#############################################################################
## Procedure:  test_print

proc ::test_print {status} {
.top87.tex107 insert end "$status.\n"
.top87.tex107 see end
update
}
#############################################################################
## Procedure:  now_short

proc ::now_short {} {
return [clock format [clock seconds] -format "%Y%m%d-%H%M%S"]
}
#############################################################################
## Procedure:  on_connect

proc ::on_connect {newsock clientAddress clientPort} {
fconfigure $newsock -blocking 0 -buffering line
fileevent  $newsock readable [list handleInput $newsock]
}
#############################################################################
## Procedure:  handleInput

proc ::handleInput {f} {
global number
global Agent_Socket
global Socket_Agent
global last_status
global Start_time
global TIME0
global TIME1
global TIME2
global test1
global test2
global test3
global go_through
global previous
global dbresult
global Caldata
global passA
global passB
global testok
global table_name
global Run_time
global SN


	# Delete the handler if the input was exhausted.
	if {[eof $f]} {
		fileevent $f readable {}
		close $f
		return
	}
# Read and handle the incoming information. Here we just log it to stdout.
	if { [gets $f line] < 0} {return}	
	set items [split $line ]
	set command [lindex $items 0 ]
	switch $command {
		"ID" {
			set id [lindex $items 1]
			set Agent_Socket($id) $f
			set Socket_Agent($f) $id	
			switch $id {
			1 {
			.top87.cpd102   configure -state active			
			#set CA1 "Client $id Com[expr $id+2]"
			.top87.cpd92   configure -state disable
			.top87.but91   configure -state disable
			} 2 {			
			.top87.cpd103   configure -state active
			#set CA2 "Client $id Com[expr $id+2]"
			.top87.cpd82   configure -state disable
			.top87.but81   configure -state disable
			} 3 {			
			.top87.cpd104   configure -state active
			#set CA3 "Client $id Com[expr $id+2]"
			.top87.cpd72   configure -state disable
			.top87.but71   configure -state disable
			} default {
			}
			}				
			incr number
		}
		"Show" {
			set id $Socket_Agent($f)
			test_print "$id :[lrange $items 2 end]"			
		}
		"Sql" {
		  set id $Socket_Agent($f)
		  set dbresult [lrange $items 3 end]
		  set table_name [lindex $items 2]
		 	set WriteDatabase [rsql $table_name]
			if { $WriteDatabase != 1 } {
    			if { $WriteDatabase == 0 } {
    				test_print "$id Write to database fail => SN not unique"
    			} elseif { $WriteDatabase == -1 } {
    				test_print "$id Write to database fail => unknown reason"
    			}
			}		
		}		
		"EXIT" {
			incr number			
		}
		"Ready" {
			set id [lindex $items 1]				
			switch $id {
			1 {
			.top87.cpd102   configure -state active			
			 set test1 "[lindex $items 2 ]"			 
			 set TIME0 ""
			.top87.cpd92   configure -state disable
			.top87.but91   configure -state disable
			if {[string length [lrange $items 2 end]]> 1 } {
			 test_print "[now_short] Client $id SN: [lindex $items 2] MAC-1: [lindex $items 3] MAC-2: [lindex $items 4]"					  
			 set go_through 1
			 set number 1
			 set passA  1
			 incr testok
			 }
			} 2 {			
			.top87.cpd103   configure -state active
			set test2 "[lindex $items 2 ]"			
			set TIME1 ""
			.top87.cpd82   configure -state disable
			.top87.but81   configure -state disable
			if {[string length [lrange $items 2 end]]> 1 } {
			 test_print "[now_short] Client $id SN: [lindex $items 2] MAC: [lindex $items 3]"		 				 
			 set go_through 1
       		set number 2
       		set passB  1
       		incr testok
			 }
			} 3 {			
			.top87.cpd104   configure -state active
			set test3 "[lindex $items 2 ]"			
			set TIME2 ""
			.top87.cpd72   configure -state disable
			.top87.but71   configure -state disable
			if {[string length [lrange $items 2 end]]> 1 } {
			 test_print "[now_short] Client $id SN: [lindex $items 2] MAC-1: [lindex $items 3] "
		  	set go_through 1
		  	incr testok
			 }
			} default {
			}
			}		   
		  #incr number
		}
		"Success" {		                      
			set id $Socket_Agent($f)
			#set id [lindex $items 1]
			#test_print "id = $id"			
			switch $id {
			1 {
			puts "id1 success"
			.top87.but91   configure -state active
			set Start_time [lindex $items 1 ]
			puts $Start_time
			set table_name [lindex $items 2]
			set dbresult [lrange $items 3 end]
			#puts "1....[string length $dbresult]"			
			set End_time [clock seconds]	
			set TIME0 "[expr $End_time-$Start_time]Sec"	
			set Run_time $TIME0				
			#set go_through1 1	
			#set passA 1		
			} 2 {
			puts "id2 success"			
			.top87.but81   configure -state active
			set Start_time [lindex $items 1 ]			
			puts $Start_time	
			set dbresult [lrange $items 3 end]
			set End_time [clock seconds]
			set TIME1 "[expr $End_time-$Start_time]Sec"
			set Run_time $TIME1					
			#set go_through1 1
			#set passB 1					
			} 3 {			
			.top87.but71   configure -state active	
			set Start_time [lindex $items 1 ]			
			puts $Start_time	
			set dbresult [lrange $items 3 end]
			set End_time [clock seconds]
			set TIME2 "[expr $End_time-$Start_time]Sec"		
			set Run_time $TIME2
			set go_through1 1			
			} default {
			}
			}

test_print "[now_short] Client $id Finish $Run_time"	 
#####SQL##########################################################	
#if {0==1} {		
			#append dbresult [lrange $items 3 end]		
			append dbresult ",'$Run_time'"		
		  set SN [split $dbresult ","]		  	
		  regsub -all "'" $SN "" SN
		  set SN [lindex $SN 0]		
			set WriteDatabase [rsql $table_name]
			
			if { $WriteDatabase != 1 } {
    			if { $WriteDatabase == 0 } {
    				test_print "$id Write to database fail => SN not unique"
    			} elseif { $WriteDatabase == -1 } {
    				test_print "$id Write to database fail => unknown reason"
    			}
			}
			
			if {[selsql]} {
          ok_dialog "$SN doesn't write to DB,Please Check!!!"	 
        } else {
          test_print "$id SN=$SN Write to database PASS"
        } 	
#}		
#####SQL##########################################################		
	
			update
			#incr number
		}		
		"FAIL" {		 
		 set id [lindex $items 1]	
		 #set id $Socket_Agent($f)	 
		 set Agent_Socket($id) $f
		 set Socket_Agent($f) $id
		 #set id $Socket_Agent($f)
		 switch $id {
			1 {
			set Start_time [lindex $items 2]				
			puts $Start_time			
			set table_name [lindex $items 3]	
			set Fail_message [lrange $items 4 5]
			set dbresult [lrange $items 6 end]						
			test_print $Fail_message	
			set End_time [clock seconds]	
			.top87.cpd92   configure -state active	
			set TIME0 "[expr $End_time-$Start_time]Sec"	
			set Run_time $TIME0				
			#set go_through 1
			#set passA 1		
			} 2 {		
			set Start_time [lindex $items 2 ]		
			puts $Start_time	
			set Fail_message [lrange $items 3 4]
			test_print $Fail_message
			set End_time [clock seconds]	
			.top87.cpd82   configure -state active
      set TIME1 "[expr $End_time-$Start_time]Sec"
			set Run_time $TIME1							
			#set go_through 1
			#set passB 1
			} 3 {			
			set Start_time [lindex $items 1 ]			
			puts $Start_time	
			set Fail_message [lrange $items 2 4]
			test_print $Fail_message
			set End_time [clock seconds]
			.top87.cpd72   configure -state active	
			set TIME2 "[expr $End_time-$Start_time]Sec"		
			set Run_time $TIME2						
			set go_through 1
			} default {
			}
			}
		test_print "[now_short] Client $id [lindex $items 3] FAIL!" 
#####SQL##########################################################
if {0==1} {			
		  #append dbresult [lrange $items 6 end]	
		  append dbresult ",'$Run_time'"			  			
			#set WriteDatabase [rsql Z800Fuction]
			set WriteDatabase [rsql $table_name]
			if { $WriteDatabase != 1 } {
    		if { $WriteDatabase == 0 } {
    				test_print "$id Write to database fail => SN not unique"
    				} elseif { $WriteDatabase == -1 } {
    									test_print "$id Write to database fail => unknown reason"
    									}
						}
}		
###################################################################				

  	 #incr number
		}
	}
}
#############################################################################
## Procedure:  go_exit

proc ::go_exit {} {
uplevel {
	set number 0
	for { set uut 1 } { $uut <= $count } {incr uut } {
		puts $Agent_Socket($uut) "EXIT"
		flush $Agent_Socket($uut)
		update
	}
	while { $number < $count } {
		vwait number
	}
	exit
}
}
#############################################################################
## Procedure:  go_run_Loop

proc ::go_run_Loop {} {
uplevel {
global Start_time
global go_through 
global previous
vwait go_through 
global passA
global passB
global testok
set i 0
set testok 0
puts "number===$number"
while {1} { 
  #while {$number <= $count} {
  after 2000   	 	
  switch $number {
			1 {		
			#set TIME0 "Time"
			#vwait previous 
			
      if {$go_through == 1} {       
			puts "number=$number"				      
      incr i
			puts "1 =$i"
			.top87.cpd102   configure -state active
			.top87.cpd103   configure -state disable			
			set CA1 "Client $number Com[expr $number+2]"
			.top87.cpd92   configure -state disable
			.top87.but91   configure -state disable	      	
      set Start_time [clock seconds]		
	  	puts $Agent_Socket($number) "Test ver"
	  	flush $Agent_Socket($number)
	  	set number 0
	  	update
	  	set go_through "0"
	  	#vwait passA
	  	incr testok 
	  	puts "11111"
	  	}			
	  	
	  	#vwait go_through 			
			} 2 {		
		  puts "number2=$number"
			#set TIME1 "Time"			 
			#vwait previous						
      if {$go_through == 1} { 
      
			.top87.cpd102   configure -state disable
			.top87.cpd103   configure -state active			
			set CA2 "Client $number Com[expr $number+2]"
			.top87.cpd82   configure -state disable
			.top87.but81   configure -state disable
			incr i
			puts "2 =$i"	
			puts "number2=$number"
			      	
      set Start_time [clock seconds]		
	  	puts $Agent_Socket($number) "Test ver"
	  	flush $Agent_Socket($number)
	  	set number 0
	  	update
	  	set go_through "0"
	  	#vwait passB
      puts "2222"
      incr testok
	  	}			
      
	  	#vwait go_through	  			
			} default {
			}
			}			
	#}
	puts "finish"
	if {$number == 0} {
	vwait testok	
	}
	#set number [expr $number -$count]	
	
}	
}
}
#############################################################################
## Procedure:  go_run_Loop_for_cal

proc ::go_run_Loop_for_cal {} {
uplevel {
global Start_time
global go_through 
global previous
vwait go_through 
global passA
global passB
global testok
set i 0
set testok 0
while {1} { 
  #while {$number <= $count} {
  after 2000   	 	
  switch $number {
			1 {		
			#set TIME0 "Time"
			#vwait previous 
			puts "number1=$number"
      if {$go_through == 1} {       
			puts "number=$number"
				      
      incr i
			puts "1 =$i"
			.top87.cpd102   configure -state active
			.top87.cpd103   configure -state disable			
			set CA1 "Client $number Com[expr $number+2]"
			.top87.cpd92   configure -state disable
			.top87.but91   configure -state disable	      	
      set Start_time [clock seconds]		
	  	puts $Agent_Socket($number) "Test ver"
	  	flush $Agent_Socket($number)
	  	set number 0
	  	update
	  	set go_through "0"
	  	vwait passA
	  	incr testok 
	  	puts "11111"
	  	}			
	  	
	  	#vwait go_through 			
			} 2 {		
		  puts "number2=$number"
			#set TIME1 "Time"			 
			#vwait previous						
      if {$go_through == 1} { 
      
			.top87.cpd102   configure -state disable
			.top87.cpd103   configure -state active			
			set CA2 "Client $number Com[expr $number+2]"
			.top87.cpd82   configure -state disable
			.top87.but81   configure -state disable
			incr i
			puts "2 =$i"	
			puts "number2=$number"
			      	
      set Start_time [clock seconds]		
	  	puts $Agent_Socket($number) "Test ver"
	  	flush $Agent_Socket($number)
	  	set number 0
	  	update
	  	set go_through "0"
	  	vwait passB
      puts "2222"
      incr testok
	  	}			
      
	  	#vwait go_through	  			
			} default {
			}
			}			
	#}
	puts "finish"
	if {$number == 0} {
	vwait testok	
	}
	#set number [expr $number -$count]	
	
}	
}
}
#############################################################################
## Procedure:  go_run_Once

proc ::go_run_Once {} {
uplevel {
 set number 1
  while {$number <= $count} {
	  	puts $Agent_Socket($number) "Test $msn_input"
	  	flush $Agent_Socket($number)
	  	update			
	  	vwait number		  	
	}
	puts "finish"
	set msn_input ""	
}
}

#############################################################################
## Procedure:  gpibw2

proc ::gpibw2 {gpibHandle stat} {
gpib clear -device $gpibHandle
gpib write -device $gpibHandle -message "$stat;*OPC"
after 500
}

#############################################################################
## Procedure:  gpibr2

proc ::gpibr2 {} {
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
## Procedure:  gpib_openCmd

proc ::gpib_openCmd {addrnum} {
    global gpibCmd
    global gpibport
    global teststatus

    if {$gpibCmd!=0} {
        close $gpibCmd
        set gpibport "GPIB:N/A"
        set teststatus "Port not open"
    }

    catch {set gpibCmd [gpib open -address $addrnum]} id
 	  if {[string length $id ]!=0} {
    		catch {fconfigure $gpibCmd open -address $addrnum}
    		set gpibport "GPIB:$addrnum"
    		set teststatus "Ready"
        #.top73.but83 configure -state disable
        #.top73.but84 configure -state disable
        after 500
    } else {
    		set gbipCmd 0
    		print_instruction1 "Can't open GPIB port $addrnum\nPlease check instriment setting"
        set gbipport "GPIB:N/A"
        set teststatus "Port not open"
        #.top73.but83 configure -state disable
        #.top73.but84 configure -state active
    }
}

#############################################################################
## Procedure:  gpib_closeCmd

proc ::gpib_closeCmd {} {
global gpibCmd

    if {$gpibCmd!=0} {
        gpib close -device all
        set gpibCmd 0
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
    wm geometry $top 200x200+66+87; update
    wm maxsize $top 1284 1002
    wm minsize $top 111 1
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

proc vTclWindow.top87 {base} {
    if {$base == ""} {
        set base .top87
    }
    if {[winfo exists $base]} {
        wm deiconify $base; return
    }
    set top $base
    ###################
    # CREATING WIDGETS
    ###################
    vTcl:toplevel $top -class Toplevel \
        -menu "$top.m96" 
    wm focusmodel $top passive
    wm geometry $top 561x443+364+61; update
    wm maxsize $top 640 760
    wm minsize $top 111 1
    wm overrideredirect $top 0
    wm resizable $top 1 1
    wm deiconify $top
    wm title $top "SMP8654_Server v1.5 20100907"
    vTcl:DefineAlias "$top" "Toplevel1" vTcl:Toplevel:WidgetProc "" 1
    bindtags $top "$top Toplevel all _TopLevel"
    vTcl:FireEvent $top <<Create>>
    wm protocol $top WM_DELETE_WINDOW "vTcl:FireEvent $top <<DeleteWindow>>"

    button $top.but91 \
        -activebackground {#00ff00} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -pady 0 -relief ridge -state disabled -text OK 
    vTcl:DefineAlias "$top.but91" "Button1" vTcl:WidgetProc "Toplevel1" 1
    button $top.cpd92 \
        -activebackground {#ff0000} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -pady 0 -relief ridge -state disabled -text FAIL 
    vTcl:DefineAlias "$top.cpd92" "Button2" vTcl:WidgetProc "Toplevel1" 1
    label $top.cpd93 \
        -background {#ffff00} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -relief ridge -text Time -textvariable TIME0 
    vTcl:DefineAlias "$top.cpd93" "Label2" vTcl:WidgetProc "Toplevel1" 1
    button $top.cpd94 \
        -command go_run_Loop \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -text Start 
    vTcl:DefineAlias "$top.cpd94" "Button3" vTcl:WidgetProc "Toplevel1" 1
    button $top.cpd95 \
        -command {go_exit
exit} \
        -font [vTcl:font:getFontFromDescr "-family helvetica -size 12 -weight bold"] \
        -pady 0 -text Exit 
    vTcl:DefineAlias "$top.cpd95" "Button4" vTcl:WidgetProc "Toplevel1" 1
    bind $top.cpd95 <Key-F10> {
        go_exit
exit
    }
    button $top.but81 \
        -activebackground {#00ff00} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -pady 0 -relief ridge -state disabled -text OK 
    vTcl:DefineAlias "$top.but81" "Button1" vTcl:WidgetProc "Toplevel1" 1
    button $top.cpd82 \
        -activebackground {#ff0000} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -pady 0 -relief ridge -state disabled -text FAIL 
    vTcl:DefineAlias "$top.cpd82" "Button2" vTcl:WidgetProc "Toplevel1" 1
    label $top.cpd83 \
        -background {#ffff00} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -relief ridge -text Time -textvariable TIME1 
    vTcl:DefineAlias "$top.cpd83" "Label2" vTcl:WidgetProc "Toplevel1" 1
    menu $top.m96 \
        -activeborderwidth 1 -borderwidth 1 -cursor {} -font {?s??¨²?¨¦ 9} 
    button $top.cpd102 \
        -activebackground {#00ffff} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -pady 0 -relief ridge -state active -text Client-Com \
        -textvariable test1 
    vTcl:DefineAlias "$top.cpd102" "Button5" vTcl:WidgetProc "Toplevel1" 1
    button $top.cpd103 \
        -activebackground {#ff00ff} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -pady 0 -relief ridge -state active -text Client-Com \
        -textvariable test2 
    vTcl:DefineAlias "$top.cpd103" "Button6" vTcl:WidgetProc "Toplevel1" 1
    text $top.tex107 \
        -background {#000000} \
        -font [vTcl:font:getFontFromDescr "-family times -size 12 -weight bold"] \
        -foreground {#ffffff} -highlightcolor {#000000} \
        -insertbackground {#000000} -relief ridge 
    vTcl:DefineAlias "$top.tex107" "Text1" vTcl:WidgetProc "Toplevel1" 1
    ###################
    # SETTING GEOMETRY
    ###################
    place $top.but91 \
        -in $top -x 200 -y 80 -width 60 -height 30 -anchor nw \
        -bordermode ignore 
    place $top.cpd92 \
        -in $top -x 285 -y 80 -width 60 -height 30 -anchor nw \
        -bordermode inside 
    place $top.cpd93 \
        -in $top -x 380 -y 80 -width 160 -height 30 -anchor nw \
        -bordermode inside 
    place $top.cpd94 \
        -in $top -x 120 -y 20 -width 100 -height 30 -anchor nw \
        -bordermode inside 
    place $top.cpd95 \
        -in $top -x 360 -y 20 -width 100 -height 30 -anchor nw \
        -bordermode inside 
    place $top.but81 \
        -in $top -x 200 -y 160 -width 60 -height 30 -anchor nw \
        -bordermode ignore 
    place $top.cpd82 \
        -in $top -x 285 -y 160 -width 60 -height 30 -anchor nw \
        -bordermode inside 
    place $top.cpd83 \
        -in $top -x 380 -y 160 -width 160 -height 30 -anchor nw \
        -bordermode inside 
    place $top.cpd102 \
        -in $top -x 20 -y 80 -width 150 -height 30 -anchor nw \
        -bordermode inside 
    place $top.cpd103 \
        -in $top -x 20 -y 160 -width 150 -height 30 -anchor nw \
        -bordermode inside 
    place $top.tex107 \
        -in $top -x 20 -y 230 -width 529 -height 198 -anchor nw \
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
Window show .top87

main $argc $argv
