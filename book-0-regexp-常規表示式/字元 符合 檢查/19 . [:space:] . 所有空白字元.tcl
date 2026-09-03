為什麼用 POSIX 類別而非 \s
1 . 可讀性：[:space:] 語意明確
2 . 在字元集合裡混用方便：例如 [[:alnum:]_.-] 一眼看懂是「字母數字加底線、點、減號」
3 . 相容性：POSIX 類別在多數正則引擎 (grep、Tcl、Perl、Python 等) 通用

實務上，在 Tcl 裡若只是要移除空白，\s 最簡潔；但在複雜字元集合中，POSIX 類別更清楚。

;# ====================================================
說明 regexp :space: ?

Kiro
[:space:] 是正則表達式的 POSIX 字元類別 (character class)，代表「所有空白字元」。

語法結構
要特別注意，它必須寫在兩層方括號裡：

tcl

[[:space:]]
外層 [...] 是正則的「字元集合」
內層 [:space:] 是 POSIX 類別名稱
所以在我上一則建議的程式裡：

regsub -all {[\r\n[:space:]]} $tmp ""
這個 [...] 集合包含了：\r、\n，以及 [:space:]（所有空白）。

[:space:] 匹配哪些字元
字元	              說明
空格 (space, 0x20)	一般空白
\t	                Tab (0x09)
\n	                換行 (0x0A)
\r	                回車 (0x0D)
\v	                垂直 Tab (0x0B)
\f	                換頁 (0x0C)

所以 [:space:] 其實已經包含 \r 和 \n 了，我前面寫的 [\r\n[:space:]] 是重複保險，其實只寫 [[:space:]] 就夠：

regsub -all {[[:space:]]} $tmp ""
對照：常用寫法
以下三種在 Tcl 移除所有空白的效果幾乎相同：

regsub -all {[[:space:]]} $tmp ""    ;# POSIX 類別
regsub -all {\s}          $tmp ""    ;# \s 簡寫 (Tcl 也支援)
regsub -all {[ \t\r\n]}   $tmp ""    ;# 手動列舉

其他常見 POSIX 類別
類別	      匹配	                  等同
[:space:]	  空白字元	                \s
[:digit:]	  數字 0-9	              \d
[:alpha:]	  英文字母	                —
[:alnum:]	  字母+數字	              —
[:upper:]	  大寫字母	                —
[:lower:]	  小寫字母	                —
[:xdigit:]	十六進位字元 0-9A-Fa-f	  —
[:punct:]	  標點符號	                —

範例：
;# 移除非十六進位字元 (清理 MAC/MD5)
regsub -all {[^[:xdigit:]]} $mac ""

;# 只保留數字
regsub -all {[^[:digit:]]} $str ""


;# ======================================
為什麼用 POSIX 類別而非 \s
1 . 可讀性：[:space:] 語意明確
2 . 在字元集合裡混用方便：例如 [[:alnum:]_.-] 一眼看懂是「字母數字加底線、點、減號」
3 . 相容性：POSIX 類別在多數正則引擎 (grep、Tcl、Perl、Python 等) 通用

實務上，在 Tcl 裡若只是要移除空白，\s 最簡潔；但在複雜字元集合中，POSIX 類別更清楚。

Est. Credits Used: 1.43
Elapsed time: 19s
