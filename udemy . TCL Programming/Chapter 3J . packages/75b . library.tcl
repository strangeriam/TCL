# Create the library namespace
namespace eval library {

    # Export the library procedures
    namespace export addBook
    namespace export getBook
    namespace export updateBook
    namespace export deleteBook


    # Create a variable to store book information
    variable books [dict create]
    
    # Procedure to add a book
    proc addBook {} {
        variable books
        set title [readInput "Enter the book's title: "]
        set author [readInput "Enter the book's author: "]
        set isbn [readInput "Enter the book's ISBN: "]
        
        dict set books $isbn [list title $title author $author isbn $isbn]
        
        puts "Book added successfully."
    }
    
    # Procedure to retrieve book information
    proc getBook {} {
        variable books
        set isbn [readInput "Enter the ISBN of the book: "]
        
        set book [dict get $books $isbn]
        if {$book ne ""} {
            puts "Title: [lindex $book 1]"
            puts "Author: [lindex $book 3]"
            puts "ISBN: [lindex $book 5]"
        } else {
            puts "Book not found."
        }
    }
    
    # Procedure to update book details
    proc updateBook {} {
        set isbn [readInput "Enter the ISBN of the book: "]
        
        set book [dict get $books $isbn]
        if {$book ne ""} {
            set title [readInput "Enter the updated title: "]
            set author [readInput "Enter the updated author: "]
            
            dict set books $isbn [list title $title author $author isbn $isbn]
            
            puts "Book details updated successfully."
        } else {
            puts "Book not found."
        }
    }
    
    # Procedure to delete a book
    proc deleteBook {} {
        set isbn [readInput "Enter the ISBN of the book to delete: "]
        
        set book [dict get $books $isbn]
        if {$book ne ""} {
            dict unset books $isbn
            
            puts "Book deleted successfully."
        } else {
            puts "Book not found."
        }
    }
    
    # Custom handler for unknown commands
    proc unknownCmd {args} {
        puts "Unknown command: [lindex $args 0]."
    }
    
    # Helper procedure to read user input
    proc readInput {prompt} {
        puts -nonewline $prompt
        flush stdout
        gets stdin input
        return $input
    }
}


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
                library::addBook
            }
            2 {
                library::getBook
            }
            3 {
                library::updateBook
            }
            4 {
                library::deleteBook
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

