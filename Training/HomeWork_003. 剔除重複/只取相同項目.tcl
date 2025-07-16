set list1 "AAA AAA BBB CCC CCC CCC"

if {[info exists appendL]} {
	unset appendL
}

foreach item $list1 {
	if {[regexp $item $list1]} {
		append appendL "$item "
		set list1 [string map "$item \"\"" $list1]
	}
}

## 移除 appendL 最後的空白.
set appendL [string trim $appendL]

## OUTPUT: AAA BBB CCC
