
取得以下 對應的 item & value.
;# ==========================
Loader Type            : Primary
Operation Code Type    : Primary


set listitem [list "Loader Type" "Operation Code Type"]
set listvalue [list Primary Primary]

foreach item $listitem value $listvalue {
   set regline "${item}\\s+:\\s$value"
   # puts "regline: $regline"

	  if {![regexp -line $regline $get_info]} {
		     puts "$item . $value --> FAIL"
	  } else {
		     puts "$item . $value --> PASS"
	  }
}

輸出:

Loader Type . Primary --> PASS
Operation Code Type . Primary --> PASS
