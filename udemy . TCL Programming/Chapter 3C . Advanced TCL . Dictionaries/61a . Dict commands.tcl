

======================================
Command - Descriptions

dict size dictname - Retrieves the size of the dictionary
dict keys $dictname - Retrieves the keys of the dictionary
dict get $dictname item - Retrieves item from the dictionary
dict values $dictname - Retieves all values from the dictionatry
dict append dictname key value - Appends {key value} to the dictionary
dict exists $dictname key - Texts if key is present in the dictionary
dict for {key value} $dictname - Iterates over all the key-value pairs from dictname

dict filter $dictanme script {k v} { FILTER EXPR }
dict filter $dictname key <KEYS>
 - Creates a new dictionary that contains a subset of key-value pairs based on the filter condition
