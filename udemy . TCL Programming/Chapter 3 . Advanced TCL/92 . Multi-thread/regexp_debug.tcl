#
# regexp tester/viewer
#

set SubMatchColors {red blue magenta orange cyan purple green}

proc clear {} {
    # clear old info
    foreach t [.txt tag names] {.txt tag remove $t 1.0 end}
}

proc do_re {} {
    clear
    
    # get matches by index
    set cmd [list regexp -inline -indices]
    if {$::LINE} {lappend cmd -line}
    if {$::ALL} {lappend cmd -all}
    lappend cmd -- $::EXP [.txt get 1.0 end]
    set l [eval $cmd]
    
    if {[llength $l] > 0} {
        # mark range of entire match
        set i1 "1.0 + [lindex [lindex $l 0] 0] chars"
        set i2 "1.0 + [expr [lindex [lindex $l 0] 1] + 1] chars"           
        .txt tag add FullMatch $i1 $i2
        # mark any submatches
        set modval [llength $::SubMatchColors]
        set num 0
        set p2 -1
        foreach {match} [lrange $l 1 end] {
            if {[lindex $match 0] < $p2} {
                # previous match was really a full match when -all specified
                #   NOTE: this will also cause the outer set(s) of nested submatches
                #         to not be highlighted in any way - an enhancement would
                #         be to determine (by parsing the RE itself) how many subexpresions
                #         there are, then use that to determine the true "total match"
                #         instead of just looking for overlapping ranges, then any
                #         nested parens can be formatted (maybe by background, or underline,
                #         or italic, or bold, or size or ....) but you would need to
                #         determine a set of non-canceling highlights, then keep track
                #         of how many levels deep in a overlapping region of text you
                #         are in and use a set of mofiiers for each level
                #
                #          BUT that is too complicated for a simple little test tool
                #                (at least for now)
                #
                #   Additional NOTE: the -about flag may be of use in determine number of submatches
                #
                .txt tag add FullMatch "1.0 + $p1 chars" "1.0 + [expr $p2 + 1] chars"
                set num [expr ($num - 1) % $modval]
            }
            set i1 "1.0 + [lindex $match 0] chars"
            set i2 "1.0 + [expr [lindex $match 1] + 1] chars"
            .txt tag add SubMatch$num $i1 $i2
            set p1 [lindex $match 0]
            set p2 [lindex $match 1]
            set num [expr ($num + 1) % $modval]
        }
    } else {
        tk_messageBox -message "RE doesn't match!"
    }
}

wm title . "RE Checker"

label .lbl -text "Expression:"
entry .exp -textvar EXP
bind <Return> .exp do_re
set LINE 0
set ALL 0
frame .f
pack [label .f.label -text "options:"] -side left
pack [checkbutton .f.line -text "-line" -variable LINE] -side left
pack [checkbutton .f.all -text "-all" -variable ALL] -side left
pack [button .f.doit -text "Run regexp!" -command do_re] -side left -expand 1 -fill none
pack [button .f.clear -text "Reset Text" -command clear] -side left -expand 1 -fill none

text .txt -background grey25 -foreground white
.txt tag config FullMatch -background black -relief raised
set i 0
foreach clr $SubMatchColors {
    .txt tag config SubMatch$i -foreground $clr
    incr i
}

grid .lbl .exp -sticky ew
grid .f   -    -sticky ew -pady 5
grid .txt -    -sticky news

grid columnconfigure . 1 -weight 10
grid rowconfigure    . 2 -weight 10
