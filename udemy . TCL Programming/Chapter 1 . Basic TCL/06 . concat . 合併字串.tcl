單字: subtituting 替代 . 

concat "Hello " "Joe" ;#--> Hello Joe

set name Joe
concat "Hello " $name ;#-->  Hello Joe

set greeting [concat "Hello " $name ", it is " [expr 2 + 1] "pm"] ;#--> Hello Joe , it is 3 pm
puts $greeting ;#--> Hello Joe , it is 3 pm
