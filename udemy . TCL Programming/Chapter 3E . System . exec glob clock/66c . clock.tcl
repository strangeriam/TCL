manipulating 操縱
timestamps 時間戳
human-readable 人類可讀


==========================================
There is a clock command that provides functions for obtaining and manipulating the system time,
including date-related operations.
The clock command allows you to work with dates, times, and timestamps.

Command - Description - Example
================================

clock format . 
Formats a timestamp into a human-readable date string. - 
Example: set currentDate [clock format [clock seconds] -format "%Y-%m-%d"]

clock scan . 
Parses a date string and converts it into a timestamp. - 
Example: set timestamp [clock scan "2022-01-01" -format "%Y-%m-%d"]

clock seconds . 
Returns the current system time as a timestamp. - 
Example: set currentTime [clock seconds]

clock add . 
Adds or subtracts a specified amount of time from a timestamp. - 
Example: set futureTime [clock add $currentTime 1 day]

clock formatTZ . 
Formats a timestamp with a specitie timezone. - 
Example: set formattedTime [clock formatTZ $currentTime - timezone "America/New_York"]

