# Step 1: Prompt the user for input
puts "Enter a list of numbers (separated by spaces):"
set input [gets stdin]

set input "1 2 3 4"

# Step 2: Attempt to calculate the sum without eval (without list-based evaluation)
# This step intentionally causes errors or unexpected behavior

set op ""
foreach num [split $input] {
    append op " $num +"
}
regsub { \+$} $op "" op

puts "Sum of the numbers (without eval):"
puts [expr $op] ;# This line will cause an error or unexpected behavior

# Step 3: Observe the errors or unexpected behavior

# Step 4: Rewrite the code using eval (without list-based evaluation)
# This step intentionally avoids list-based evaluation

set command "expr $op"

puts "Sum of the numbers (using eval, without list-based evaluation):"
puts [eval $command] ;# This line will correctly evaluate the expression

# Step 5: Observe the improved behavior

# Step 6: Rewrite the code using list-based evaluation

set command [concat [list expr] [split $input]]
puts "Sum of the numbers (using eval and list-based evaluation):"
puts [eval $command] ;# This line will correctly evaluate the expression



# A typical issue:
set string "Hello, World!"

# We may think the following command will just print "hello world"
set cmd {puts $string}

# And it is true if we do that right now
eval $cmd

# But be aware of cases like this
unset string

eval $cmd ;# -> will error out


# Another problematic case:
set cmd "puts $string"

eval $cmd
# The problem is that $string was substituted on line 55
# The command we're trying to evaluate is puts Hello, World!

eval [list puts $string] ;# Works good.

