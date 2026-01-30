proc listFiles {directory} {
    set files [glob -type f $directory/*]
    if {[llength $files] == 0} {
        puts "No files found in the directory."
    } else {
        puts "Files in the directory:"
        foreach file $files {
            puts [file tail $file]
        }
    }
}

proc fileInfo {filePath} {
    if {![file exists $filePath]} {
        puts "File not found."
        return
    }

    set fileSize [file size $filePath]
    set filePermissions [exec icacls $filePath]
	regexp -line {:\s*(.*)$} $filePermissions -> filePermissions

	
    set lastModified [clock format [file mtime $filePath] -format "%Y-%m-%d %H:%M:%S"]

    puts "File Information:"
    puts "Path: $filePath"
    puts "Size: $fileSize bytes"
    puts "Permissions: $filePermissions"
    puts "Last Modified: $lastModified"
}

proc renameFiles {directory extension} {
    cd $directory
    set files [glob -type f *.$extension]
    if {[llength $files] == 0} {
        puts "No files with the specified extension found in the directory."
        return
    }

    set timestamp [clock format [clock seconds] -format "%Y%m%d%H%M%S"]

    foreach file $files {
        set newFilename [file tail [file rootname $file]]_$timestamp[file extension $file]
		puts "exec ren $file $newFilename"
		exec cmd.exe /c ren $file $newFilename
        puts "Renamed file $file to $newFilename"
    }

    puts "File renaming completed."
}

# Prompt user for directory and call listFiles procedure
puts "Enter a directory path:"
set directory [gets stdin]
listFiles $directory

# Prompt user for file path and call fileInfo procedure
puts "Enter a file path:"
set filePath [gets stdin]
fileInfo $filePath

# Prompt user for directory and file extension, and call renameFiles procedure
puts "Enter a directory path:"
set directory [gets stdin]
puts "Enter a file extension:"
set extension [gets stdin]
renameFiles $directory $extension
