string compare STR1 STR2
string first STR1 STR2
string index STR n
string last STR1 STR2
string length STR
string ratch PATTERN STR
string range STR n1 n2



rather --> TCL 8.5 not support.
set p "AAA"
set str "this is my AAA not yours."

TCL wronging message.
string ratch $p $str
unknown or ambiguous subcommand "ratch": must be 
bytelength, compare, equal, first, index, is, last, length, map, 
match, range, repeat, replace, reverse, tolower, totitle, toupper, 
trim, trimleft, trimright, wordend, or wordstart


