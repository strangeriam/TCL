


=============================
dict update dictName ?key? varname script - 
- Update values within a dictionary based on a key.
- It allows you to modify values of existing keys without creating a new dictionary.

# CODE A
set d {key1 value1 key2 value2}
key1 value1 key2 value2

dict update d key1 varKey1 {
  append varKey1 new
}

value1new
set d
key1 value1new key2 value2


dict with dictName script - 
- Access the values of a dictionary within a script block without explicitly referencing the dictionary variable.
- This command does not allow program to make changes in the dictionary values.

# CODE A
set d {key1 value1 key2 value2}
key1 value1 key2 value2

dict update d key1 varKey1 {
  unset varKey1
}

set d
key2 value2
