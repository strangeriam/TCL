




=====================================
You are tasked with creating a TCL program to manage a library system using namespace.
The program should allow users to add books to the library, retrieve book information, update book details,
and delete books from the library.
Each book should have a uniue ISBN (International Standard Book Number) as its identifier.

Implement the following procedures within the appropeiate namespaces:

library::addBook:
Prompt the user to enter the book's title, author, and ISBN.
Create a new entry for the book within the library namespace, storing the book details as variables.

library::getBook:
Prompt the user to enter the ISBN of a book.
Retrieve and display the title, author, and ISBN of the book from the library namespace.

library::updateBook:
Prompt the user to enter the ISBN of a book.
Allow the user to update any of the book's details (title, author, or ISBN).
Update the book's variables within the library namespace with the new details.

library::deleteBook:
Prompt the user to enter the ISBN of a book.
Delete the book's variables from the library namespace.


Implement the following namespace commands:

namespace eval library:
Create the library namespace to encapsulate the book-related procedurces and variables.

namespace export library::*:
Export all the procedures within the library namespace to make them accessible from outside the namespace.

namespace import library::*:
Import all the procedures from the library namespace to make them accessible within the current namespace.

namespace unknow library::unknownCmd:
Implement a custom handler for unknown commands within the library namespace, 
which provides a user-friendly error message for unknown commands.


