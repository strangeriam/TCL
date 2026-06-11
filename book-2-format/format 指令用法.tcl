與C語言中的printf十分相似的指令，format指令依據指定的格式將字串格式化。

    format spec value1 value2 …


其中spec的參數包含了文字或是任何字元。而一般定義的關鍵字包含了六大部份：
位置指示(position specifier)
旗標(flags)
欄寬(field width)
精確度(precision)
字元長度(word length)
轉換字元(conversion character)

由於在格式定義的時候常會有空白夾雜其中，切記要使用雙引號或大括號將定義內容群組(Grouping)起來。

d	帶正負號整數(Signed integer)
u	無正負號整數(Unsigned interger)
i	帶正負號整數。表示成為hex(0x)或octal(0)
o	無正負號的八進位數值。(Unsigned octal)
x or X	無正負號的十六進位數值。(Unsigned hexadecimal)，x表示為輸出小寫的結果。
c	把數字對映成為ASCII 字元
s	字串
f	浮點數，格式為a.b
e or E	浮點數，格式為科學符號，a.bE+-c
g or G	浮點數，格式為%f或%e，依實際長度取短的表示
位置指示的表示方法為i$，意思是直接取得第i個參數的值。參數的計數是從1開始。底下的範例透過位置指示直接取用 format 第二個參數的內容：

% format {%2$s} one two three
=>two

因為在 TCL 中，$ 符號有特殊意義，上列指令以大括號抑制了格式化字串中 $ 符號的變數置換作用，所以 i$ 的功能得以正常演出。但如果格式化字串是以雙引號來做群組 (grouping)，我們必須利用反斜線仰制 $ 符號的變數置換：

% format “%2\$s” one two there
=>two


格式化旗標
-	靠左對齊
+	顯示數值的正、負符號
space	
0	以0 補滿
#	遇到octal將字首填入『0』，遇到Hex時字首填入『0x』
