set value_list "Capture:failed! Capture:failed! Capture:failed! 23.4199 -18.4212 7.72009 7.77935 -58.0936 0 24.4397 -19.1818 7.70967 7.86928 -60.4537 0 23.3936 -18.0513 7.72115 8.10128 -78.9322 0 Capture:failed! Capture:failed! Capture:failed! 23.6856 -18.6571 7.70925 7.99969 -63.6664 0 24.5126 -19.7618 7.74053 7.9075 -57.7409 0 23.6393 -18.425 7.72839 8.12837 -60.7272 0 Capture:failed! Capture:failed! Capture:failed! 23.4654 -18.3897 7.7141 7.6378 -58.5181 0 24.4012 -19.6035 7.70353 7.794 -61.0348 0 23.1928 -18.2591 7.71268 7.57956 -63.8299 0"

if {[info exists csvValue]} {
	unset csvValue
}

set i 1 ; set i1 3 ; set i2 9 ; set i3 15 ; set i4 21

foreach value $value_list {
	if {$i == $i1} {
		append csvValue "$value "
		set i1 [expr $i1 +21]

	} elseif {$i == $i2} {
		append csvValue "$value "
		set i2 [expr $i2 +21]

	} elseif {$i == $i3} {
		append csvValue "$value "
		set i3 [expr $i3 +21]

	} elseif {$i == $i4} {
		append csvValue "$value "
		set i4 [expr $i4 +21]

	} else {
		append csvValue $value\,
	}


	incr i
}

## OUTPUT:
llength $value_list
63

llength $csvValue
12

set csvValue
Capture:failed!,Capture:failed!,Capture:failed! 23.4199,-18.4212,7.72009,7.77935,-58.0936,0 24.4397,-19.1818,7.70967,7.86928,-60.4537,0 23.3936,-18.0513,7.72115,8.10128,-78.9322,0 Capture:failed!,Capture:failed!,Capture:failed! 23.6856,-18.6571,7.70925,7.99969,-63.6664,0 24.5126,-19.7618,7.74053,7.9075,-57.7409,0 23.6393,-18.425,7.72839,8.12837,-60.7272,0 Capture:failed!,Capture:failed!,Capture:failed! 23.4654,-18.3897,7.7141,7.6378,-58.5181,0 24.4012,-19.6035,7.70353,7.794,-61.0348,0 23.1928,-18.2591,7.71268,7.57956,-63.8299,0 


