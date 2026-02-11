




=================================================
# mathops/pkgIndex.tcl

;# Folder 'mathops' shall be in a location where TCL can find it, 
;# this is the TCL library or a path specified by the auto_path variable.
package provide mathops 1.0

namespace eval ::mathops {
    proc add { a b } {
        return [expr {$a + $b}]
    }

    proc subtract { a b } {
        return [expr {$a - $b}]
    }

    proc multiply { a b } {
        return [expr {$a * $b}]
    }

    proc devide { a b } {
        return [expr {$a / $b}]
    }
}

% echo $auto_path
"C:/ActieveTcl/lib/tcl8.6 C:/ActiveTcl/lib"

# main.tcl
package require mathops

puts [mathops::add 10 5]         ;# Output: 15
puts [mathops::subtract 10 5]    ;# Output: 5
puts [mathops::multiply 10 5]    ;# Output: 50
puts [mathops::divide 10 5]      ;# Output: 2
