# 比對/字串處理

# 比對字串是以 Unicode 逐一比對 str1 & str2.
# equal: str1 完全等於 str2, 則回傳 1, 反之回傳 0

# syntax]:
# string equal str1 str2
# parameter:
#     - nocase | 比對時不分大小寫
#     - length | 決定比對的長度 "length  len"

set str1 "Hello Tcl !!"
set str2 "Hello tcl !!"

string equal           $str1 $str2
string equal -nocase   $str1 $str2
    
# output:
#    0       <S2 & S3 字串不相同, 參數 equal 回傳 0.>
#    1       <不分大小寫後, S2 & S3 字串就相同, 則回傳 1.>
