#; TCL 變數的可以隨時建立不用事先宣告, 變數名稱的取法也沒有任何限制,
#; 所以可以使用任何字元來為變數命名, 甚至變數名跟指令名稱相同也沒問題.

#; 使用時只有一點要注意的, 就是 TCL 是大小寫有別的語言.
#; 通常, 我們以 set 指令來設定變數值.

set x 5
set y 6
set PI 3.14
set PI*2 6.28   ;# 注意！變數名稱是 PI*2
puts $PI*2
set PI

#; TCL 的 set 指令除了設定變數值的用途外, 也可以用來取出變數的內容,
#; 如上列程式最後一行使用 set 指令取出 PI 的值 (注意！這邊不用在變數名稱前加上 $ 符號).

#; unset 指令用來刪除一個或多個變數, 來釋放記憶體空間.
unset x y PI

#; example:
set PI 3.14
puts $PI   ;# output 3.14

unset PI
puts $PI   ;# output "can't read "PI": no such variable"
