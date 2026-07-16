% foreach a [list 1 2 3 4] b [list 5 6 7 8] c [list a b c d] d [list w x y z] {
      puts "$a $b $c $d"
  }
1 5 a w
2 6 b x
3 7 c y
4 8 d z
%

% unset -nocomplain a b c
% foreach {a b c} {1 2} {break}
% info exists c
1

% unset -nocomplain a b c
% foreach {a b c} {} {break;}
% info exists a
0

set l [list a bc def 1 23 456]
set m 0

foreach i $l {
    incr m
    puts "member $m is $i"
}
output:

member 1 is a
member 2 is bc
member 3 is def
member 4 is 1
member 5 is 23
member 6 is 456


foreach {key value} [array get myArray] {
    puts $myFile [list set myArray($key) $value]
}
