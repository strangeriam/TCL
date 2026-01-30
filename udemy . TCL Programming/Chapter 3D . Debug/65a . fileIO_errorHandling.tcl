set csvFile "Electric_Vehicle_Population_Data.csv"
set stateFile "state.txt"
set makeFile "make.txt"

# Check if the CSV file exists and is readable
if {![file exists $csvFile] || ![file readable $csvFile]} {
    puts "Error: The CSV file '$csvFile' does not exist or is not readable."
    exit
}

# Check if the script has write permissions to create text files
if {![file writable .]} {
    puts "Error: Insufficient permissions to create text files."
    exit
}

try {
	# Open the CSV file for reading
	set fileHandle [open $csvFile r]

	# Read the header line and split it into field names
	set header [gets $fileHandle]
	set fieldNames [split $header ","]

	# Define dictionaries to store distributions
	array unset stateDistribution
	array unset makeDistribution
	array set stateDistribution {}
	array set makeDistribution {}

	# Count the total number of rows in the CSV file
	set rowCount 0
	set maxRange 0
	set maxRange_make ""
	set maxRange_model ""

	# Process each line in the CSV file
	while {[gets $fileHandle line] != -1} {

		incr rowCount

		set fields [split $line ","]

		# Extract State
		set state [lindex $fields 3]

		# Extract Make
		set make [lindex $fields 6]

		# Extract Model
		set model [lindex $fields 7]

		# Extract range
		set range [lindex $fields 10]

		# Update state distribution
		if {![info exists stateDistribution($state)]} {
			set stateDistribution($state) 1
		} else {
			set stateDistribution($state) [expr {$stateDistribution($state) + 1}]
		}

		# Update make distribution
		if {![info exists makeDistribution($make)]} {
			set makeDistribution($make) 1
		} else {
			set makeDistribution($make) [expr {$makeDistribution($make) + 1}]
		}
		
		# Update maxRange
		if {$range > $maxRange} {
			set maxRange $range
			set maxRange_make $make
			set maxRange_model $model
		}
	}

} finally {
	# Close the file
	puts "Closing the file"
	close $fileHandle
}




#Sort state distribution in descending order
set stateKeyValueList [list]
foreach {key value} [array get stateDistribution] {
	lappend stateKeyValueList [list $key $value]
}

set sortedStates [lsort -decreasing -int -index 1 $stateKeyValueList]

try {
	# Write state distribution to file
	set stateFileHandle [open $stateFile w]
	puts $stateFileHandle "State\tDistribution\tPerc"
	foreach entry $sortedStates {
		set state [lindex $entry 0]
		set qty   [lindex $entry 1]
		puts $stateFileHandle "$state\t$qty\t[expr round($qty*1.0/$rowCount*100) ] %"
	}

} finally {
	close $stateFileHandle
}




#Sort make distribution in descending order
set makeKeyValueList [list]
foreach {key value} [array get makeDistribution] {
	lappend makeKeyValueList [list $key $value]
}

set sortedMakes [lsort -decreasing -int -index 1 $makeKeyValueList]

try {
	# Write state distribution to file
	set makeFileHandle [open $makeFile w]
	puts $makeFileHandle "Make\tDistribution\tPerc"
	foreach entry $sortedMakes {
		set make [lindex $entry 0]
		set qty   [lindex $entry 1]
		puts $makeFileHandle "$make\t$qty\t[expr round($qty*1.0/$rowCount*100) ] %"
	}

} finally {
	close $makeFileHandle
}

puts "Model with greatest range: $maxRange_make $maxRange_model ($maxRange Km)"
