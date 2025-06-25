package require Thread

console show

proc com_open { port } {
	set fd [open \\\\.\\COM$port r+]
	fconfigure $fd -blocking 0 -buffering line -mode 115200,n,8,1 -translation cr
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
		}
	}
}

proc vwait_mseconds {msec} {
	set vwait_flag 0
	after [expr $msec] { set vwait_flag 1 }
	vwait vwait_flag
}

proc ui_text_board {} {
	global w

	set w .gui[incr counter]
	toplevel $w
	wm title $w "Lu's new project."

	text $w.t -yscrollcommand [list .scrolly set] -setgrid 0 -height 40 -maxundo 3 -autoseparators 0 -undo false -bg blue4 -fg white -autosep 1
	::ttk::scrollbar .scrolly -orient vertical -command [list $w.t yview]

	pack .scrolly -side right -fill y
	pack $w.t -side left -fill both -expand 1
	bind $w.t <Any-Key> [list termout %A %k]
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

proc read_text_board {} {
	global w

	while 1 {
		set resp [read $::com_fd]
		if { [string length $resp] == 0} {
			vwait_mseconds 200 ; update
		} else {
			$w.t insert end $resp
			$w.t see end
		}
	}
}

ui_text_board

set ::com_fd [com_open 12]

tsv::set share mainTid [thread::id]

set tid2 [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list read_text_board]
}]


# _f_transmit $::com_fd "ls -la"
