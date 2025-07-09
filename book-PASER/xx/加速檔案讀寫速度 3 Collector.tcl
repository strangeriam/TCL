encoding system utf-8
source c:/tcl/bin/tkcon.tcl
tkcon show

proc _f_ReadFile { fname } {
	if { [file exists $fname] } {
		set fd [open $fname r]
		set data [read $fd]
		close $fd
		return $data
	} else {
		return ""
	}
}

proc _f_WriteFile { fname access data } {
	if { [catch {
		set fd [open $fname $access]
		puts -nonewline $fd $data
		close $fd
	} retmsg] } {
		return 0
	} else {
		return 1
	}
}

proc sleep {time} {
	update
	after $time set end 1
	vwait end
	update
}

file mkdir Result
set maclist {}
foreach {thisfile} [glob -no *.csv] {
	set filename [file tail $thisfile]
	puts $filename
	# sleep 10
	set data [_f_ReadFile $thisfile]
	set datalist [regexp -all -inline -- {[^\n]+} $data]
	if { [string first _power_ $filename] > 0 } {
		foreach dd $datalist {
			if { [string first PW_INDEX $dd] >= 0 } { continue }
			set dlist [split $dd ,]
			set CU_INDEX [lindex $dlist 0]
			set PW_VOLT1 [lindex $dlist 3]
			set PW_CURRENT1 [lindex $dlist 4]
			set PW_VOLT($CU_INDEX) $PW_VOLT1
			set PW_CURRENT($CU_INDEX) $PW_CURRENT1
		}
	} elseif { [string first _current_ $filename] > 0 } {
		lappend maclist [lindex [split $filename _] 3]
		foreach dd $datalist {
			if { [string first CU_INDEX $dd] >= 0 } { continue }
			set dlist [split $dd ,]
			set CU_INDEX [lindex $dlist 0]
			set CU_DATE [lindex $dlist 1]
			set CU_TIME [lindex $dlist 2]
			set CU_MAC [lindex $dlist 3]
			set CU_WDO [lindex $dlist 4]
			set CU_CURRENT1 [lindex $dlist 5]
			set DATE($CU_MAC,$CU_INDEX) $CU_DATE
			set TIME($CU_MAC,$CU_INDEX) $CU_TIME
			set WDO($CU_MAC,$CU_INDEX) $CU_WDO
			set CU_CURRENT($CU_MAC,$CU_INDEX) $CU_CURRENT1
		}
	} elseif { [string first _sys_ $filename] > 0 } {
		foreach dd $datalist {
			if { [string first SYS_INDEX $dd] >= 0 } { continue }
			set dlist [split $dd ,]
			set SYS_INDEX [lindex $dlist 0]
			set SYS_MAC [lindex $dlist 3]
			set IP1 [string range $dd 44 end]
			set IP($SYS_MAC,$SYS_INDEX) $IP1
		}
	} elseif { [string first _iperf_ $filename] > 0 } {
		foreach dd $datalist {
			if { [string first IPERF_INDEX $dd] >= 0 } { continue }
			set dlist [split $dd ,]
			set IPERF_INDEX [lindex $dlist 0]
			set IPERF_MAC [lindex $dlist 3]
			# set IPERF_WDO [lindex $dlist 4]
			set IPERF_RESULT1 [lindex $dlist 5]
			set IPERF_TXRX1 [lindex $dlist 6]
			set IPERF_THROUGHPUT1 [lindex $dlist 7]
			
			set IPERF_RESULT($IPERF_MAC,$IPERF_INDEX) $IPERF_RESULT1
			set IPERF_TXRX($IPERF_MAC,$IPERF_INDEX) $IPERF_TXRX1
			set IPERF_THROUGHPUT($IPERF_MAC,$IPERF_INDEX) $IPERF_THROUGHPUT1
		}
	} elseif { [string first _mem_ $filename] > 0 } {
		set mac [lindex [split $filename _] 3]
		foreach dd $datalist {
			if { [string first MEM_INDEX $dd] >= 0 } { continue }
			set dlist [split $dd ,]
			set MEM_INDEX [lindex $dlist 0]
			set MEM_MAC [lindex $dlist 3]
			set MEM_RESULT1 [lindex $dlist 5]
			set MEM_RESULT($MEM_MAC,$MEM_INDEX) $MEM_RESULT1
		}			
	}
}

foreach {mac} $maclist {
	puts $mac
	set res {}
	append res "CU_INDEX,CU_DATE,CU_TIME,CU_MAC,CU_WDO,CU_CURRENT,PW_VOLT,PW_CURRENT,IP,CPU_IDLE_ALL,CPU_IDLE_CORE_0,CPU_IDLE_CORE_1,CPU_IDLE_CORE_2,CPU_IDLE_CORE_3,MEM_TOTAL,MEM_USED,MEM_FREE,PHYID1,PHYID2,CPU_TEMPERATURE_0,CPU_TEMPERATURE_1,CPU_TEMPERATURE_2,CPU_TEMPERATURE_3,CPU_TEMPERATURE_4,CPU_TEMPERATURE_5,CPU_TEMPERATURE_6,Q3244_TEMPERATURE,BASEBAND_TEMPERATURE,RADIO_TEMPERATURE,RF_CHANNEL,RX_BEAN_INDEX,TX_BEAN_INDEX,RSSI,MCS,TX_POWER,IPERF_RESULT,IPERF_TXRX,IPERF_THROUGHPUT,MEM_RESULT\n"
	foreach arrayindex [lsort [array name CU_CURRENT]] {
		if { [string first $mac $arrayindex] == -1 } { continue }
		set index [lindex [split $arrayindex ,] end]
		append res $index,$DATE($mac,$index),$TIME($mac,$index),$mac,$WDO($mac,$index),$CU_CURRENT($mac,$index),
		
		if { [info exists PW_VOLT($index)] } {
			append res $PW_VOLT($index),$PW_CURRENT($index),
		} else {
			append res ,,
		}
	
		if { [info exists IP($mac,$index)] } {
			append res $IP($mac,$index)
		} else {
			append res ,,,,,,,,,,,,,,,,,,,,,,,,,,,
		}

		if { [info exists IPERF_RESULT($mac,$index)] } {
			append res $IPERF_RESULT($mac,$index),$IPERF_TXRX($mac,$index),$IPERF_THROUGHPUT($mac,$index),
		} else {
			append res ,,,
		}
		if { [info exists MEM_RESULT($mac,$index)] } {
			append res $MEM_RESULT($mac,$index),
		} else {
			append res ,
		}		
		

		append res \n

	}

	_f_WriteFile ./Result/collector1_$mac\.csv w $res

}


# exit
