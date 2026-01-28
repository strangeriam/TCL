Retrieves 檢索
Iterates 迭代
subset 子集


======================================
Command - Descriptions

dict size dictname - Retrieves the size of the dictionary
dict keys $dictname - Retrieves the keys of the dictionary
dict get $dictname item - Retrieves item from the dictionary
dict values $dictname - Retieves all values from the dictionatry
dict append dictname key value - Appends {key value} to the dictionary
dict exists $dictname key - Tests if key is present in the dictionary
dict for {key value} $dictname - Iterates over all the key-value pairs from dictname

# CODE A
dict for { id info } $employeeInfo {
 puts "Employee #[incr i]: $id"
}

dict filter $dictanme script {k v} { FILTER EXPR }
 - Creates a new dictionary that contains a subset of key-value pairs based on the filter condition

# CODE B
set d [dict filter {k1 v1 k2 v2} script {k v} {expr {$keq "k1"}}]

dict filter $dictname key <KEYS>

# CODE C
dict filter {k1 v1 k2 v2 k3 v3} key k1 k3

