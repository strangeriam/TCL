# Create a top-level namespace
namespace eval myapp {
    # Create sub-namespaces
    namespace eval myapp::moduld1 {
        # Define commands and variables within the module1 namespace
        variable data1 "Module 1 Data"
        proc greet {} {
            puts "Hello from Module1"
        }
    }

    namespace eval myapp::module2 {
        # Define commands and variables within the modules namespace
        variable data2 "Module 2 Data"
        proc greet {} {
            puts "Hello from Module 2"
        }
    }
}

# Access and use commands and variable within the namespace
puts $myapp::module1::data1   ;# Output: Module 1 Data
myapp::module1::greet         ;# Output: Hello from Module 1

puts $myapp::module2::data2   ;# Output: Module 2 Data
myapp::module2::greet         ;# Output: Hello from Module 2
