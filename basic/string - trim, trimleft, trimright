# Syntax:
# → string trim      $str char → 刪除 $str 左右 char 字元.
# → string trim      $str      → 不指定, 則刪除空白無效字元 \t \r \n \s.
# → string trimleft  $str char → 刪除 $str 左邊含有 char 字元.
# → string trimright $str char → 刪除 $str 右邊含有 char 字元

set str "HelloWorld papa WorldHello"

string trim $str "Hello"
# output: World papa World

string trimleft $str "Hello"
# output: World papa WorldHello

string trimright $str "Hello"
# output: HelloWorld papa World

