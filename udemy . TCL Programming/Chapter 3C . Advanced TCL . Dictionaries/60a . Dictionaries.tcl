dictionaries 字典
alias 別名
structures 結構
nested 嵌套
particular 獨特的
complex 複雜的

================================================
TCL arrays are collection of variables, so we cannot pass them directly to procedures as a value.
We need to convert them to values using array get, or else use the upvar command to create an alias for the array.
Arrays connot be included in other data structures like lists.

TCL dictionaries are very similar to arrays, but they are key-value pairs of pure values.
This allows dictionaries to be passed directly to procedures.
Unlike arrays, dictionaries can be nested, so that the value of a particular key can be another dictionary.
Programmer can use dictionaries to build complex data structures.

Two ways to create dictionaries:
dict set dictname key value
or
dict create dictname key1 value1 key2 value2 ...
