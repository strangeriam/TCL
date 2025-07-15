Lu: 不知如何使用.

根據 switch 所指定的選項為 list 排序.
可用的選項有 -ascii, -dictionary (字典), -integer (整數), -real, -increasing (遞增), -decreasing (遞減), -index ix, -unique, -command command.
Syntax: lsort ?switches? list

#; Example:
#; ========
set list1 [list I love Taipei]
lsort $list1

#; OUTPUT=> I Taipei love
