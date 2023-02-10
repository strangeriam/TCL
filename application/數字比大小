
## 比大小.
## 數值相同時, 也能帶出大小.

set tx_power_1 -11 ; set tx_power_2 -12 ; set tx_power_3 -13 ; set tx_power_4 -14 ; set tx_power_5 -9
set tx_power_6 -16 ; set tx_power_7 -17 ; set tx_power_8 -18 ; set tx_power_9 -19 ; set tx_power_10 -20  

set power_list [list $tx_power_1 $tx_power_2 $tx_power_3 $tx_power_4 $tx_power_5 $tx_power_6 $tx_power_7 $tx_power_8 $tx_power_9 $tx_power_10 ]
puts "power_list : $power_list"

set tx_power_max [findMax $power_list]
puts "tx_power_max : $tx_power_max"

proc findMax {array} {
      set maxValue [lindex $array 0]
      foreach value $array {
			      if {$value > $maxValue} {
	      			set maxValue $value
	          }
  		}
  		return $maxValue
}
