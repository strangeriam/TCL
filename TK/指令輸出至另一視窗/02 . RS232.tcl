
proc UI_ShowLog {} {
	global w

	set w .gui[incr counter]
	toplevel $w
	wm title $w "Lu's new project."

	text $w.t -yscrollcommand [list .scrolly set] -setgrid 0 -height 40 -maxundo 3 -autoseparators 0 -undo false -bg blue4 -fg white -autosep 1
	::ttk::scrollbar .scrolly -orient vertical -command [list $w.t yview]

	pack .scrolly -side right -fill y
	pack $w.t -side left -fill both -expand 1
	bind $w.t <Any-Key> [list _f_ShowLog_termout %A %k]
}

proc termread { comportid } {
	global w

	catch {set resp [read $comportid]}
	if { [info exists resp] } {
		$w.t insert end $resp
		$w.t see end
	}
}

proc termout {key keycode} {
}

;# ===========================================================
proc com_open { port } {
	set msgTitle "Check RS232 Console !!!"
	set msgEnglish "\b\b\bStep 1: Disconnect TeraTerm or SecureCRT.\n\b\b\bStep 2: Click OK."

	for {set i 1} { $i <= 3 } {incr i} {
		if { [catch { set fd [open \\\\.\\COM$port r+] } result] } {
			tk_messageBox -type ok -message "$msgTitle\n\n\n$msgEnglish" -icon warning -detail ""
		} else {
			fconfigure $fd -blocking 0 -buffering line -mode 115200,n,8,1 -translation cr
			break
		}
	}

	return $fd
}

proc com_close { consoleid } {
	catch {close $consoleid}
	set consoleid 0
}

proc _f_transmit { consoleid str { newline 1 }} {
	if { $newline == 0 } {
		catch {puts -nonewline $consoleid $str}
	} else {
		catch {
			puts $consoleid $str
			vwait_mseconds 200 ; update
			termread $consoleid
		}
	}
}

;# ===========================================================
package require Tk

UI_ShowLog

set ::console_port 12
com_open $::console_port

puts $::fd dir
termread $::fd


;# 移除 此 uI
destroy $w
