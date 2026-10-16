set list1 [list papa i love u]

foreach {item} $list1 {
    puts $item
    after 1000
}

;# iterations loop
set x {}
foreach {i j} {a b c d e f} {
	lappend x $j $i
}

set x
## OUTPUT: b a d c f e
