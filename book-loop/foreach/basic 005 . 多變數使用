set list1 "AAA BBB CCC"
set list2 "aaa bbb ccc"

foreach line1 $list1 line2 $list2 {
	puts "line1: $line1"
	puts "line2: $line2"
}

## OUTPUT:
line1: AAA
line2: aaa
line1: BBB
line2: bbb
line1: CCC
line2: ccc

## ====================================
## 應用, 如果 list1 已為空值, 則離開程式, 只取到 BBB bbb.

set list1 "AAA BBB"
set list2 "aaa bbb ccc"

foreach line1 $list1 line2 $list2 {
	if {$line1 == ""} { break }
	puts "line1: $line1"
	puts "line2: $line2"
}

## OUTPUT:
line1: AAA
line2: aaa
line1: BBB
line2: bbb
