namespace eval MyMath {
    # Create a variable inside the namespace
    variable myResult

    # Define a procedure inside the namespace
    proc Add {a b} {
        return [expr {$a + $b}]
    }

    # Export the Add command
    namespace ecport Add
}

# Import the Add command from the MyMath namespace
namespace import MyMath::Add

# Use the Add command directly
puts [Add 10 30]
