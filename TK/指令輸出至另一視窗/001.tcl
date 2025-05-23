
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


package require Tk

set counter 0
UI_ShowLog

set ::fd [open "|cmd.exe" r+]
fconfigure $::fd -blocking 0 -buffering line


puts $::fd dir
termread $::fd


;# 移除 此 uI
destroy $w
