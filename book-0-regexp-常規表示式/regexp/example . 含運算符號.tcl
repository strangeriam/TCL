
set get_info {
Console#show license
Currently Used Profile:
  L2+, cloud-m
Console#
}

regexp {L2+, cloud-m} $get_info
;# 輸出: 0

regexp {L2\+, cloud\-m} $get_info
;# 輸出: 1

;# =================================
set ::Lic_profile {L2\+, cloud\-m}
regexp $::Lic_profile $get_info
;# 輸出: 1

set ::Lic_profile "L2+, cloud-m"
regexp $::Lic_profile $get_info
;# 輸出: 0

set ::Lic_profile "L2+, cloud-m"
regexp ${::Lic_profile} $get_info
;# 輸出: 0

set ::Lic_profile {L2+, cloud-m}
regexp ${::Lic_profile} $get_info
;# 輸出: 0

set ::Lic_profile "L2\+, cloud\-m"
regexp $::Lic_profile $get_info
;# 輸出: 0
