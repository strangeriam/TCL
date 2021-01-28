## Perform substitutions based on regular expression pattern matching.
    -all
    -expanded
    -line
    -linestop
    -lineanchor
    -nocase
    -start index

## Example:

set sample "Where there is a will, There is a way." 

## -all 字串取代
## 將所有含 “is a” 都置換為 “are”, 並將取代後的整句存入新變數 $sample2.
## 此例有兩個 “is a” 都被改為 “are”.
## OUTPUT: Where there are will, There are way.

regsub -all "is a" $sample "are" sample2
puts $sample2

## 如果沒有指定 “-all”, 則只會是第一筆被取代.
## way 改為 lawsuit, 並將取代後的整句存入新變數 $sample2.
## OUTPUT: Where there is a will, There is a lawsuit.

regsub "way" $sample "lawsuit" sample2
puts $sample2
