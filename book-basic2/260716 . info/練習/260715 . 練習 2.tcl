#; 秀出 set inLine {aaa bbb ccc ddd} 裡的四個值.
% aaa
% bbb
% ccc
% ddd


for {set i 0} {$i <= 3} {incr i} {
	set zz_$i ""
}

set inLine {aaa bbb ccc ddd}
puts "=====\n"


for {set ii 0} {$ii <= 3} {incr ii} {
		set zz_$ii [list [lindex $inLine $ii]]

		puts "zz_0 : $zz_0"
		puts "zz_1 : $zz_1"
		puts "zz_2 : $zz_2"
		puts "zz_3 : $zz_3"
}


#; OUTPUT:
(12-Office-Sync-MTS) 108 %
zz_0 : aaa
zz_1 : 
zz_2 : 
zz_3 : 
zz_0 : aaa
zz_1 : bbb
zz_2 : 
zz_3 : 
zz_0 : aaa
zz_1 : bbb
zz_2 : ccc
zz_3 : 
zz_0 : aaa
zz_1 : bbb
zz_2 : ccc
zz_3 : ddd
(12-Office-Sync-MTS) 109 % 
