




================================================
TCL arrays are collection of variables, so we cannot pass them directly to procedures as a value.
We need to convert them to values using array get, or else use the upvar command to create an alias for the array.
Arrays connot be included in other data structures like lists.
