
=============
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
