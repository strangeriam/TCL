

set get_info {
Console#show license file
ID Expired Date Feature
-- ------------ -----------------------------------------------------
 1 2025-09-01   L2+, cloud-m
 2 2025-03-27   L2+, cloud-u

Input ID to show detail: 1

sw-license/1.1
Name: ECRD
CPU-MAC-Address: 5C-17-83-4A-A4-A0
Project-Number: ECS4150
Accept-Mode: legacy
License-Number: 0a3f15e1-86b4-4d17-85a6-12c3b12aeb43
License-Issue-Date: Fri Jun 27 07:19:11 2025
License-Valid-Start-Date: Sat May 24 00:00:00 2025
License-Valid-End-Date: Mon Sep  1 00:00:00 2025
License-Profile: L2+, cloud-m
License-Profile-Digest: d706d2cb898282347a8ce9589505c2f9
License-Access-List: 0OcJrb2Zc/hQxCAbGAilnmPVsWHcC2yIdsuzE8ESaLbrRq82/Rj3Mxe9NkV
gCiP1PB220U4x6t0yQ/944Br7JrDE4FtpxIUhwd7u8IO1ofg8etMu9B7Gok2Ud2t/WFu37x66c284Gyq
kk/XBT1uBq/N1UJ6W56Y7IO1NHJo5cNSWkKfs4tATtof9xG3SaawpGqs4fdtE16gQhyrwzg41rO4aScOr7lIocxqQA1fxF2rrKyl+nQGdjMdH
n8qo/YuzkfAdRzYYx1pvCngiqi6D8tKHah1A34nFwnV1qV8QDcIqAfapxZNHSPcWMw8+S9iJoBCS/V+R
hWp6RD4Y8ELrThEfv4oaPn8ceAsqgysj4guKL06tGFuZ4xb1QzyIBwtoPe3IULmr1jv3lMDGGYtxmIlvXoTFqUVV70PlcYShmo3Xk5zfIvIXy
sRLUjHNhDk4yBn6ISAfERBelrtsTdwI3w==
Signature1: D7SkLXCpF1aVM/7Nri70jXFvNLsd+co2VlJTT3mLrYGuVm0b9KG5nvNRXy6N/DZldKlb
MBULIpFk917e68keIwsbHTaaa8MPIiEd6ULKu93TKvV2tpU+AO+7T4OrlanxsPBPwxTMSioJisjeKb+K
nz93RflCDvl6Rg+PjCmE09GAhn3B0KRoyigChpHLh5ulRdDQi/H2MpzPYTncJ1Kka4JxRJAsB7iBSPivmCv+VuIFzIlj5QlWf8oX50CeEWz4D
63bmOLhnR7bWdReiNmVfQyNFQ/SP3ssKODTyJmh73Rh5C6ZCFqX613IopOu9MHgIoxpQrNuAUhWoQtmw
vKBJA==
Signature2: Vxhz9RVs2JGUgTZfoCdd+INM1lZPdKDcDNPKR3Sz9S4kho+iIkfxVa0i86oJABMRqWRD
JIE7NUTWTOkcZV81e+C3RFPd+edIdC0m8NAmjFUU9xe8JT+icT9hI5JQAzQug7Nm1VbWaVU+sqBxJpfK
jM3f7YUCUIPCnhZwbVHym9DLVb4E8Dr9dMJZ1oNOgOYCm07+1BE9QqYZiWHdL7yNP3/fogVl5cx5D/7T3F5Etzudak/fFotaVIQJ6Ffya7aJB
7AhKWiy/F37lIhGpq5YKrNAm3XqY5JeTixRjGrqOZdsuHTxF0AWsbA9t/ZDOiRIyK8Qsxr/i8S6F82n3
aw7bA==
Console#
}


if { [info exists faillist] } {
	unset faillist
}

set items [list "License-Profile" "License-Profile-Digest"]
set datas [list "L2\\+, cloud-m" "d706d2cb898282347a8ce9589505c2f9"]

foreach item $items data $datas {
	if { ! [regexp -line "$item\: $data" $get_info] } {
		append faillist $item
	}
}
