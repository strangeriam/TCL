## 只取 0~9.
## =========

set input "123 456 ab cd"
set getNumber ""
regexp {[0-9]+} [string map {" " ""} $input] getNumber
puts $getNumber
## OUTPUT: 123456


## "MLTG-CN         " 只取英文和 "-".
## =================================

set input "MLTG-CN         "
set getModel ""
regexp -all -inline {[A-Z-]+} $getModel
puts $getModel
## OUTPUT: MLTG-CN
