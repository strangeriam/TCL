reverse 反向


========================================================
The lreverse command is used to reverse the order of elements in a list.
Syntax: lreverse list
The command returns a new list with the elements in reverse order.

Example:
set numbers {1 2 3 4 5}
set reversed [lreverse $numbers]
puts $reversed
# Output: 5 4 3 2 1
