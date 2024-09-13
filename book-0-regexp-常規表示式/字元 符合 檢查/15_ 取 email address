
set infile "AAA lu_lin@accton.com BBB CCC"
regexp -all -inline -- {[0-9a-zA-Z_]+@{1,1}[0-9a-z]*\.+[a-z]*} $infile

輸出:
lu_lin@accton.com

分析
A: 取 lu_lin
[0-9a-zA-Z_]
1, 0-9  -->  包含 0~9 的數字.
2, a-z  -->  包含字母小寫.
3, A-Z  -->  包含字母大寫.
4, _  --> 包含底線 _

B: 取 @
+@{1,1}
1, +  --> 出現一次或多次 . 字串延續
2, @  -->  還要包含 @
3, {1,1}  -->  只能有ㄧ個 @

C: 取 accton
[0-9a-z]*
1, 0-9  -->  包含 0~9 的數字
2, a-z  -->  包含字母小寫
3, *  --> 未出現或出現多次

D: 取 .com
\.+[a-z]*
1, \.  -->  取小數點 .
2, +  -->  出現一次或多次 . 字串延續
3, [a-z] -->  包含字母小寫
4, *  -->  未出現或出現多次



## Sample Text
AAA lu_lin@accton.com BBB CCC
