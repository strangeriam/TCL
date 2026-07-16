#; 注意
#; 使用 switch -regexp -- $num {}, 判斷式不可超過 10 (含)筆.
#; 不然超過 10 (含)筆的判斷式, 將使用判斷式第一筆.

set num 3
switch $num {
              " 1 " { puts "Monday" }
              " 2 " { puts "Tuesday" }
              " 3 " { puts "Wednesday" }
              " 4 " { puts "Thursday" }
              " 5 " { puts "Friday" }
              " 6 " { puts "Saturday" }
              " 7 " { puts "Sunday" }
              " default " { puts "Wrong Value" }
}

# OUTPUT: Wednesday

## ======================
## OR
set num 2
switch -glob -- $num {
        "1" -
        "2" { puts "Monday & Tuesday are working days."}
        default { puts "Others" }
}

set num 2
switch -regexp -- $num {
   1|2      { puts "Monday & Tuesday are working days." }
   default  { puts "Others." }
}
