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
-all
-ascii
-decreasing
