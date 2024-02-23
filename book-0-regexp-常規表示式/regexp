# 字串比對
# 內容有含字串, 則回傳 1. 反之 0.

set var "The result is PASS"
regexp {PASS} $var
# Output: 1

# $var 裡不含字串 PASS, 則 testResult 存入 FAIL.
if { ![regexp "PASS" $var]} {
       set testResult FAIL
}
