## ==============================
proc getline {chan} {
    global done

    gets $chan line

    if { ! [eof $chan] } {
        puts ">> $line"
    } else {
        close $chan
        set done 1
    }
}

#if 0 {
set program1 [open "|tclsh test/test1.tcl" r]
fileevent $program1 readable [list getline $program1]
fconfigure $program1 -buffering line
#}

set program2 [open "|tclsh test/test2.tcl" r]
fileevent $program2 readable [list getline $program2]
fconfigure $program2 -buffering line

vwait done
