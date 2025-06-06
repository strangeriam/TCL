set M 6 ;# 0110
set N 5 ;# 0101
set P 8 ;# 1000

-----------         . Syntax / Example expression / Example result
Bitwise AND         . A & B  / $M & $N            / 4 ;# 0100
Bitwise OR          . A | B  / $M | $N            / 7 ;# 0111
Bitwise XOR         . A ^ B  / $M ^ $N             / 3 ;# 0011
Bitwise shift left  . A << n / $M << 1             / 12 ;# 1100
Bitwise shift right . A >> n / $P >> 3              / 1 ;# 0001
