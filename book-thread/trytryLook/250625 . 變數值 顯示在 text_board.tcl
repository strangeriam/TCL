package require Thread

console show

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

proc termout {key keycode} {
}

proc _f_fillin_textboard {} {
	global w

	while 1 {
		if {[info exist ::txtboard]} {
			if { [string length $::txtboard] != 0} {
				$w.t insert end $::txtboard
				$w.t see end
			}

			unset ::txtboard
		}
		vwait_mseconds 200 ; update
	}
}


ui_text_board

tsv::set share mainTid [thread::id]

set tid2 [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list _f_fillin_textboard]
}]
