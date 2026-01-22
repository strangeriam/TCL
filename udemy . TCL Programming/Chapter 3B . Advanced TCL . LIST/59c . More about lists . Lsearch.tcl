efficiently 高效率
optimize 最佳化
sort 排序 分類
approach 方法


=======================================================
The lsearch command allows the programmer to efficiently get all indexes what contain a value,
or -1 if no matches are found.

Starting with TCL version 8.4,
the lsearch command has been added new features to optimize searches in sorted lists, with -sort option.
It also has a -int option to not convert the element to strings, which is a faster approach.

Basic lsearch syntax is as follows:
learch ?option? <list> <expr>

Example:
lsearch {hello my friend} f* => 2
lsearch -inline {hello my friend} f* => friend


lsearch options
Option - Descriptions
-all --> Return all matches. Otherwise it will return the first match only. Same as using -indices.
-ascii --> Compare ascii values. Only meaninful when used with -exact or -sorted.
-decreasing --> Assume the list elements are sorted. Only useful when used with -sorted.
-increasing --> same decreasing below.
-dictionary --> Use dictionary comparison. Only meaninful when used with -exact or -sorted.
-exact --> perform exact string match.
-glob --> Perform glob-style wildcard for pattern match.
-inline --> Return the matched element, instead of the index.
-integer --> Compare elements as interger numbers. Only meaninful when used with -exact or sorted.
-not --> Invert the match result (Return non-matching items)
-oncase --> Perform a case-insensitive match.
-real --> Compare elements as real numbers. Only meaninful when used with -exact or -sorted.
-regexp --> Perform a regular expression match.
-sorted --> Assume the list is presorted. This allows for a faster search algorithm.
-start <index> --> Use <index> as the start position for the search.


