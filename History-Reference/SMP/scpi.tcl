 # scpi.tcl  --
 #
 #         This file implements routines built on top of the tcl-gpib
 #         library. It provides a simple interface to IEEE-488.2
 #         instruments that use the Standard Commands for Programmable
 #         Instruments (SCPI) language.
 #
 #  $Id: 14780,v 1.12 2005-12-22 07:00:30 jcw Exp $
 #
 # Change log:
 # $log$
 #
 package require gpib

 #
 package provide scpi 0.1

 # SCPI class of commands
 # Declare namespace.

 namespace eval scpi {
    namespace export *

    variable cpoll
    variable data
 }

 # scpi::cmd  --
 #
 # Send (write) a SCPI command to a IEEE-488 instrument
 # Arguments:
 #   id       The id handle for the instrument returned by the gpib open
 #            command.
 #   message  The SCPI or IEEE command string
 # Results:
 #   code  OK.
 #
 # Example:
 #            scp::cmdSend $id "*rst"  ; # Reset instrument
 #            scp::cmdSend $id "SYST:ERR?" ; # Get error from instr.
 #

 proc scpi::cmdSend { id message } {
     variable data
     gpib clear -device $id
     # Clear status, Set event register, flush OPC
     gpib write -device $id -message "*CLS;*ESE 61;*OPC?"
     set res [ gpib read -device $id ]
     # Write command+OPC.
     gpib write -device $id -message "$message;*OPC"
     set data($id,message) $message
     return -code ok
 }

 # scpi::cmdRead --
 #
 # Perform serialpolls until standard event or time-out.
 # on Time-out:
 #       Return error with errorInfo.
 # On standard event:
 #    Check for message in message buffer and read.
 #    Check for Error flags in standard event register
 #      if errors read syst:err? into buffer
 #         return error with errorInfo
 #      else
 #         return data if any.
 #
 # Arguments:
 #   id       The id handle for the instrument returned by the gpib open
 #            command
 #
 #   ?tlimit? Optional time limit on serialpoll operations.
 #   ?tpoll?  Optional time between serialpoll operations.
 #
 # Results:
 #      Code OK
 #         Value   data read from instrument if any.
 #      Code ERROR
 #         Value      null.
 #         errorInfo  Error message and command trace.

 proc scpi::cmdRead { id {tlimit 2000} {tpoll 100} } {
    variable cpoll
    variable data
    set cpoll(0) 0
    #  Wait for Standard event OPC
    set time 0
    set cpoll($id) 0
    while { ([set res [gpib serialpoll -device $id]] & 0x20 ) != 0x20 } {
 				# puts "Poll: $res"
 				if { $time < $tlimit} {
	  				# after $tpoll
	  		  	after $tpoll [list incr ::scpi::cpoll($id) ]
	  		    if {![info exists tk_version] } {
				 				vwait ::scpi::cpoll($id)
				 		} else {
 				 				tkwait variable ::scpi::cpoll($id)
 				 		}
	  		    incr time $tpoll
				} else {
	  				set result "Time-out after ${tlimit}ms waiting for Standard Event \
						(Operation complete or Error)"
						return $result
						#return -code error -errorinfo $result
				}
    }
    # Check Message AVailable (MAV) and read Message buffer
    set result {}
    while { ([set res [gpib serialpoll -device $id]] & 0x10 ) == 0x10 } {
	  		lappend result [ gpib read ]
    }
    # Check event register
    gpib write -device $id -message "*ESR?"
    set sevent [ gpib read -device $id ]
    # Check for error bits in Standard event register
    #
    if { ( $sevent & 60 ) != 0 } {
 	  		lappend result $sevent
	  		# Get system error
	 			gpib write -device $id -message "SYST:ERR?"
	 			set serror [ gpib read -device $id ]
	 			lappend result  $data($id,message) $serror
	 			return -code error -errorinfo $result
    }
    return -code ok $result
}

 # scpi::cmd --
 #
 #      Combines scpi::cmdSend and scpicmdRead in one call.
 #
 # Arguments:
 #   id       The id handle for the instrument returned by the gpib open
 #            command.
 #   message  The SCPI or IEEE command string
 #
 #   ?tlimit? Optional time limit on serialpoll operations.
 #   ?tpoll?  Optional time between serialpoll operations.
 #
 # Results:
 #      Code OK
 #         Value   data read from instrument if any.
 #      Code ERROR
 #         Value      null.
 #         errorInfo  Error message and command trace.

 proc scpi::cmd { id message {tlimit 2000} {tpoll 100} } {
     cmdSend $id $message
     cmdRead $id $tlimit $tpoll
 }

 # scpi::cmdList --
 #
 #      Execute a list of scpi commands on an instrument.
 #
 # Arguments:
 #   id       The id handle for the instrument returned by the gpib open
 #            command.
 #   mlist    A Tcl list of SCPI commands
 #
 #   ?tlimit? Optional time limit on serialpoll operations.
 #   ?tpoll?  Optional time between serialpoll operations.
 # Results:
 #      Code OK
 #         Value   list of data read from instrument if any.
 #      Code ERROR
 #         Value      null.
 #         errorInfo  Error message and command trace.

 proc scpi::cmdList { id lmess {tlimit 2000} {tpoll 100} } {
     global errorInfo
     set result {}
     foreach Cmd $lmess {
	       if {[catch {cmd $id $Cmd $tlimit $tpoll} val ] != 0} {
	       		set saveInfo  $errorInfo
	     			error {}  $saveInfo
	     			return -code error
	 			 } else {
	    			lappend result $val
	 			 }
     }
     return -code ok $result
 }
#Simple example of usage:-
#
# package require gpib
# package require scpi
# # open the GPIB device
# set dvm1 [gpib open -address 22 -sendeoi true ]
# # Request a measurement from the DVM.
# # Wait upto 2 seconds and poll for completion every 200ms.
# scpi::cmd $dvm1 "meas?" 2000 200
# # List of commands to configure DVM.
# set instrument(dvm1,conf) [list "*RST" \
#			       "*CLS" \
#			       "CONF:VOLT:AC DEF,DEF " \
#			       "DET:BAND 3" \
#			       "TRIG:SOUR IMM"] ;
# # execute list of commands.
# scpi::cmdList $dvm1 $instrument(dvm1,conf)
# more to add here, async usage.
# # close device
# gpib close -device $dvm1