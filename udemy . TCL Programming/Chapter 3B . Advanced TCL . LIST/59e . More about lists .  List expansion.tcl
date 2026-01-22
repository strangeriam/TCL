context 情境 前後關系
arguments 論點
rather than 而不是
entity 實體



=================================================
In TCL,
list expansion refers to the process of expanding a list into individual elements,
usually in the context of command arguments or variable assignments.
It allows you to treat a list as separate elements rather than a single entity.

List expansion can be done using the {*} syntax, also know as the "list expansion operator".

Example:
set fruits {apple banana cherry}

# Expanding the list in a variable assignment
set fruitList [list {*}$fruits]
puts $fruitList
# Output: apple banana cherry
