proc show_a_list {args} {
    set n 0
    foreach arg $args {
        puts "Argument $n: $arg"
        incr n
    }
}

show_a_list A B C D
puts ""
show_a_list E F

## OUTPUT
Argument 0: A
Argument 1: B
Argument 2: C
Argument 3: D

Argument 0: E
Argument 1: F

## ====================
## proc (+uplevel).
## uplevel
## - 裡頭所使用或新增的變數, 可直接供上層程式使用, 不需 global.
## - 上層程式的變數也可直接供 uplevel 裡的程式使用.

proc bar {} { uplevel {
}}
