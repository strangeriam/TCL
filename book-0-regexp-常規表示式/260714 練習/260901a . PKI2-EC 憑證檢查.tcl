	set listitem [list 	cert.pem \
						key.pem \
						operational.ca \
						operational.pem]

	set listmd5 [list 	$::md5_cert_pem \
						$::md5_key_pem \
						$::md5_operational_ca \
						$::md5_operational_pem]

	foreach md5 $listmd5 item $listitem {
		if { ![regexp -line "${item}\\s+: $md5" $get_info] } {
			puts "MD5 $md5 --> $item ,FAIL"
		} else {
			puts "MD5 $md5 --> $item ,PASS"
		}
	}


;# =======================================================
set get_info {
Console#show ucentral certificate status
16:12:59:406| 
16:12:59:406| TIP Certificate MD5 Checksum
16:12:59:609| 
16:12:59:609|   cas.pem   : NONE
16:12:59:609|   cert.pem  : e07a20ced13f61bd2ef744eab1bdccfb
16:12:59:609|   dev-id    : NONE
16:12:59:609|   key.pem   : 28f6bf3a3444a7923588f08224a0fc61
16:12:59:609| Operational Certificate MD5 Checksum
16:12:59:609| 
16:12:59:609|   operational.pem: e07a20ced13f61bd2ef744eab1bdccfb
16:12:59:609| Operational Certificate Authority MD5 Checksum
16:12:59:609| 
16:12:59:609|   operational.ca: e32e46fc190abe06f1046552d25c2418
16:12:59:609| Console#
}
