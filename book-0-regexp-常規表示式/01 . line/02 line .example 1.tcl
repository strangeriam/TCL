## 還不全了解此正規式.
## ===============================================
set memory_tmp1 ""
set DIMM1_TypeResult ""
set DIMM1_SizeResult ""
regexp -line {Memory DIMM Location: CPU1_DIMM_A1\n+.*?\n+.*?\n+.*?\n+.*?\n+.*?\n+.*?\n+Memory type Test result: (\w+)\nMemory size Test result: (\w+)} $tmp memory_tmp1 DIMM1_TypeResult DIMM1_SizeResult

## 語法參考
Memory DIMM Location: CPU1_DIMM_A1
\n+.*?
\n+.*?
\n+.*?
\n+.*?
\n+.*?
\n+.*?
\n+Memory type Test result: (\w+)
\nMemory size Test result: (\w+)


## 程式解釋
\n  ==> 跳行
.*? ==> 忽略後續字串
(\w+) ==> 還不曉得做啥的
