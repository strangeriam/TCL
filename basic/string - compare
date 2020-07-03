# 比對/字串處理

# 比對字串是以 Unicode 逐一比對 str1 & str2.

# compare: str1 內含字元大於 str2, 則回傳  1
# compare: str1 內含字元相同 str2, 則回傳  0
# compare: str1 內含字元小於 str2, 則回傳 -1

# syntax]:
# string compare str1  str2
# parameter:
#     - nocase | 比對時不分大小寫
#     - length | 決定比對的長度 "length  len"

set str1 "Hello Tcl !!"
set str2 "Hello tcl !!"
    
string compare         $str1 $str2
string compare -nocase $str1 $str2
    
# output:
#   -1       <S2 Tcl 與 S3 tcl 的 T/t 不同, T 在 unicode 的十進制為 84, t 為 116, 所以 s2 小於 s3.>
#    0       <如不分大小寫, 則 S2 & S3 字串大小相同.>
