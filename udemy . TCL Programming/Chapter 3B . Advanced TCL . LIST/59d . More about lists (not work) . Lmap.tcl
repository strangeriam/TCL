lambda 匿名函數

================================================
This is a command that allows programmer to apply a given script or lambda expression to all the elements in a list,
return a list containing the result.

Syntax: lmap varName list script

Example:
set numbers {1 2 3 4 5}
set doubled [lmap n $numbers {expr {$n * 2}}]
puts $doubled

;# Output: 2 4 6 8 10
