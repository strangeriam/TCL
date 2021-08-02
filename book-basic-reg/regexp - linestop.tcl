
regexp -linestop {condition.*} $source newVar ;# 取條件後面字串.
regexp -linestop {.*condition} $source newVar ;# 取條件前面字串.

## This example.
set readOS_tmp {
	[root@master-0 vesbkp]# cat /run/user/2205/aaa.tmp
	Operating System: CentOS Linux 7.2006.9 (Core)
	[root@master-0 vesbkp]#
}

set readOS ""
regexp -linestop {Operating System.*} $readOS_tmp readOS
puts "==>$readOS<=="

## OUTPUT: ==>Operating System: CentOS Linux 7.2006.9 (Core)<==



