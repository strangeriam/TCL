set employeeDB [dict create]

proc saveDB {filename} {
	global employeeDB
    set file [open $filename w]
    
    dict for {id employee} $employeeDB {
        set details [join [dict values $employee] ","]
        puts $file "$id,$details"
    }
    
    close $file
    puts "Employee database saved successfully."
}

proc loadDB {filename} {
	global employeeDB
    set file [open $filename r]
    
    while {[gets $file line] != -1} {
        set fields [split $line ","]
        set id [lindex $fields 0]
        set details [lrange $fields 1 end]
        set employee [dict create name [lindex $details 0] age [lindex $details 1] position [lindex $details 2] salary [lindex $details 3] status [lindex $details 4]]
        
        dict set employeeDB $id $employee
    }
    
    close $file
    puts "Employee database loaded successfully."
}

proc addEmployee {} {
	global employeeDB
    puts "Enter employee name:"
    set name [gets stdin]
    puts "Enter employee age:"
    set age [gets stdin]
    puts "Enter employee position:"
    set position [gets stdin]
    puts "Enter employee salary:"
    set salary [gets stdin]
    
    set id [format "%05d" [dict size $employeeDB]]
    set employee [dict create name $name age $age position $position salary $salary status ""]
    
    dict set employeeDB $id $employee
    puts "Employee added successfully. ID: $id"
}

proc getEmployee {} {
	global employeeDB
    puts "Enter employee ID or name:"
    set input [gets stdin]
    
    if {[string is integer -strict $input]} {
        set employee [dict get $employeeDB $input]
    } else {
        set id [lsearch -inline -all -index 1 -exact [dict values $employeeDB] $input]
        if {[llength $id] == 1} {
            set employee [dict get $employeeDB [lindex $id 0]]
        } else {
            puts "Employee not found."
            return
        }
    }
    
    puts "Employee Details:"
    dict for {key value} $employee {
        puts "$key: $value"
    }
}

proc updateEmployee {} {
	global employeeDB
    puts "Enter employee ID:"
    set id [gets stdin]
    
    set employee [dict get $employeeDB $id]
    
    if {[info exists employee]} {
        puts "Enter employee age (leave blank to keep current value):"
        set age [gets stdin]
        if {$age ne ""} {
            dict set employee age $age
        }
        
        puts "Enter employee position (leave blank to keep current value):"
        set position [gets stdin]
        if {$position ne ""} {
            dict set employee position $position
        }
        
        puts "Enter employee salary (leave blank to keep current value):"
        set salary [gets stdin]
        if {$salary ne ""} {
            dict set employee salary $salary
        }
        
        puts "Employee details updated successfully."
    } else {
        puts "Employee not found."
    }
}

proc deleteEmployee {} {
	global employeeDB
    puts "Enter employee ID:"
    set id [gets stdin]
    
    set employee [dict get $employeeDB $id]
    
    if {[info exists employee]} {
        set status [dict get $employee status]
        
        switch $status {
            "fired" {
                puts "Employee is already fired."
            }

			"retired" {
				puts "Employee is already retired."
			}
			"resigned" {
				puts "Employee has already resigned."
			}
			default {
				dict set employee status "fired"
				puts "Employee status updated to 'fired'."
			}
		}
	} else {
		puts "Employee not found."
	}
}

proc listEmployees {{filter ""} {attributes {id name}}} {
	global employeeDB
	if {$filter ne ""} {
		set filteredDB [dict filter $employeeDB command [list dict match -nocase -glob $filter]]
	} else {
		set filteredDB $employeeDB
	}
	dict for {id employee} $filteredDB {
		puts "--- Employee $id ---"
		dict for {key value} $employee {
			#if {$key in $attributes} {
				puts "$key: $value"
			#}
		}
	}
}

proc calculateSalarySum {} {
	global employeeDB
	set sum 0
	dict for {id employee} $employeeDB {
		set salary [dict get $employee salary]
		incr sum $salary
	}

	puts "Total salary sum: $sum"
}

proc getEmployeeID {name} {
	global employeeDB
    set matchingIDs {}
    
    dict for {id employee} $employeeDB {
        set employeeName [dict get $employee name]
        
        if {$name eq $employeeName } {
            lappend matchingIDs $id
        }
    }
    
    if {[llength $matchingIDs] > 0} {
        puts "Matching employee IDs:"
        puts [join $matchingIDs ", "]
    } else {
        puts "No employees found with the given name."
    }
}

proc showMenu {} {
	puts "Employee Database Management System"
	puts "---------------------------------"
	puts "1. Save Database"
	puts "2. Load Database"
	puts "3. Add Employee"
	puts "4. Get Employee ID"
	puts "5. Get Employee info"
	puts "6. Update Employee Details"
	puts "7. Delete Employee"
	puts "8. List Employees"
	puts "9. Calculate Salary Sum"
	puts "0. Exit"
	puts "---------------------------------"
	puts "Enter your choice (1-9):"

}


#
# Main program
#

while {1} {
	showMenu
	set choice [gets stdin]
	switch $choice {
		1 {
			puts "Enter filename to save:"
			set filename [gets stdin]
			saveDB $filename
		}
		2 {
			puts "Enter filename to load:"
			set filename [gets stdin]
			loadDB $filename
		}
		3 {
			addEmployee
		}
        4 {
            puts "Enter employee name or last name:"
            set name [gets stdin]
            getEmployeeID $name
        }
        5 {
            getEmployee
        }
		6 {
			updateEmployee
		}
		7 {
			deleteEmployee
		}
		8 {
			puts "Enter filter expression (leave blank for all employees):"
			set filter [gets stdin]
			puts "Enter attributes to display (separated by spaces, default: id name):"
			set attributes [split [gets stdin]]
			listEmployees $filter $attributes
		}
		9 {
			calculateSalarySum
		}
		0 {
			puts "Exiting program..."
			break
		}
		default {
			puts "Invalid choice. Please try again."
		}
	}
}
