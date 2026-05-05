file tail name
Returns all of the characters in the last filesystem component of name. Any trailing directory separator in name is ignored. If name contains no separators then returns name. So, file tail a/b, file tail a/b/ and file tail b all return b.
