



=========================================
The concept of scope refers to the region or portion of code where a variable, function, 
or other named entiry is defines and can be accessed.
It defines the visivility and lifetime of variables and determines which parts of the code can reference or modify them.
The scope determines the cisivility and accessibility of variables within different parts of a TCL program.

TCL has 2 main types of scopes

Global Scope:
Variables defined at the top-level of a TCL script can be declared as global using the flobal command have global scope.
This allows these variables to be accessible from anywhere within the program, 
including within procedures, namespaces, or script blocks.

Local Scope:
Variable defined within a procedure, script block, or loop have local scope.
They are only accessible within the block of code in which thry are defined.
Once the block finishes executing, the local variables are destroyed, and their values are no longer accessible.

===============================
Main script
Global scope

set x 20

proc foo {} {
    Local scope
    set x 10
    double $x
}

proc double {x} {
    return [expr 2*$x]
}
