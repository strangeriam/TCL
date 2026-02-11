package require library_management

# Main program
proc main {} {
    while {1} {
        puts "Enter your choice: "
        puts "1. Add a book"
        puts "2. Get book information"
        puts "3. Update book details"
        puts "4. Delete a book"
        puts "5. Quit"

        set choice [gets stdin]
        switch -- $choice {
            1 {
                library_management::addBook
            }
            2 {
                library_management::getBook
            }
            3 {
                library_management::updateBook
            }
            4 {
                library_management::deleteBook
            }
            5 {
                break
            }
            default {
                puts "Invalid choice."
            }
        }
        puts ""
    }
}

# Run the main program
main

