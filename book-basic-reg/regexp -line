-line	開啓行敏感匹配，與regexp相同。


## 程式解釋
\n  ==> 跳行
.*? ==> 忽略後續字串
(\w+) ==> 還不曉得做啥的

## Example Code
set tmp "
**************************************************
Memory Bank: NODE 1
Memory DIMM Location: CPU1_DIMM_A1
Memory Type: DDR4
Memory Size: 8192 MB
Memory Speed: 2666 MT/s
Memory Manufacturer: <BAD INDEX>
Memory Serial Number: <BAD INDEX>
Memory Part Number: <BAD INDEX>


Memory type Test result: PASS
Memory size Test result: PASS
"

## Step 1:
## 取 Memory DIMM Location: CPU1_DIMM_A1 到 Memory size Test result: PASS 的字串.
## =====================================================================================
set memory_tmp1 ""
regexp -line {Memory DIMM Location: CPU1_DIMM_A1\n+.*?\n+.*?\n+.*?\n+.*?\n+.*?\n+.*?\n+.*?\n+.*?} $tmp memory_tmp1
puts $memory_tmp1

## OUTPUT
Memory DIMM Location: CPU1_DIMM_A1
Memory Type: DDR4
Memory Size: 8192 MB
Memory Speed: 2666 MT/s
Memory Manufacturer: <BAD INDEX>
Memory Serial Number: <BAD INDEX>
Memory Part Number: <BAD INDEX>


Memory type Test result: PASS
Memory size Test result: PASS



## Step 2:
## 取 Memory type Test result: PASS
## 取 Memory size Test result: PASS
## =====================================================================================
set DIMM1_TypeResult ""
regexp -linestop {Memory type Test result:.*} $memory_tmp1 DIMM1_TypeResult
puts $DIMM1_TypeResult

set DIMM1_SizeResult ""
regexp -linestop {Memory size Test result:.*} $memory_tmp1 DIMM1_SizeResult
puts $DIMM1_SizeResult
