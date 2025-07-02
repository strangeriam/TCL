# 字串比對
;# Note-240700: 內容有含字串, 則回傳 1. 反之 0.
;# Note-250702: 比對內容可使用變數或字串.
;# Note-250702: 比對內容區分大小寫.
;# Note-250702: 比對內容如含運算符號 (+-*/), 則需使用跳脫字元.

set content "The result is PASS"

;# Example 1
regexp {PASS} $content
;# 輸出: 1

;# Example 2
regexp {Pass} $content
;# 輸出: 0

;# Example 3
set var PASS
regexp $var $content
;# 輸出: 1

;# Example 4
set var Pass
;# 輸出: 0
