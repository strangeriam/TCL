練習 A, Model name 後面有許多空格, 只取 Model name.

set infile "MLTG-CN         "
regexp -all -inline {[A-Z-]+} $infile
## OUTPUT: MLTG-CN

解析
[A-Z-]  --> 取 MLTG- . 留大寫 & 減號 -

set infile "AAA MLTG-CN BBB"
regexp -all -inline {AAA [A-Z-]+ BBB} $infile


