proc foo {} {
    set x 10
    uplevel 1 {
        puts "x is $x"
    }
}

set x 5
foo

Output will be:
x is 5
