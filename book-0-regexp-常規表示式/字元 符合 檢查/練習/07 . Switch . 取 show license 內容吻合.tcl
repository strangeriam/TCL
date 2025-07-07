
set get_info {
Console#show license
Currently Used Profile:
  L2+, cloud-m
Console#
}

set lic 		"L2\\+, cloud-m"
set lic_digest 	"d706d2cb898282347a8ce9589505c2f9"

if { [regexp -line $lic $get_info] } {
	return 0
}
