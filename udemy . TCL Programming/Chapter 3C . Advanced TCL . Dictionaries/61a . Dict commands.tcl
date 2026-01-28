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

dict filter $dictanme script {k v} { FILTER EXPR }
dict filter $dictname key <KEYS>
 - Creates a new dictionary that contains a subset of key-value pairs based on the filter condition


dict incr dictName key ?incr? - Increment the key (default incr is 1)
dict lappend dictName key value - 
- Appends the list of values to the list in the given key.
- Returns the updated dictionary

dict map {keyVar} valueVar} dictName body - 
- Similar to lmap, this command transforms all key-value pairs in a dict.
- Returns a new dict.

dict merge dictNames - 
- Returns a dictionary that contains the merged contents of each dictName provided.
- If the same key is used by more than one dict, the latter is preserved.

dict remove dictName keys - Removes key from the dictName and returns a new dict.
dict replace dictName key value - Returns a new dictionary with updated key-value
dict unset dictName keys - Returns an updated dictionary with the given keys removed
