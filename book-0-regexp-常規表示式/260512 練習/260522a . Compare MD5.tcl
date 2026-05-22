
set ::md5_cas_pem "dbdd18608c3cfe4d7f54e2a65f1b2d29"
set ::md5_cert_pem "e00b5b67335f567f91fcc4cc3f7f81fe"
set ::md5_dev_id "4e28bba2ea2deefb58f524ce2bd77e4a"
set ::md5_key_pem "8162c46bc37c064f23ef05fa1a9d02df"
set ::md5_operational_pem "e00b5b67335f567f91fcc4cc3f7f81fe"
set ::md5_operational_ca "dbdd18608c3cfe4d7f54e2a65f1b2d29"

set listitem [list cas.pem \
						cert.pem \
						dev.id \
						key.pem \
						operational.pem \
						operational.ca ]

set listmd5 [list $::md5_cas_pem \
						$::md5_cert_pem \
						$::md5_dev_id \
						$::md5_key_pem \
						$::md5_operational_pem \
						$::md5_operational_ca ]

foreach md5 $listmd5 item $listitem {
		if {[lindex [split $item .] 0] == "operational"} {
			set pattern "${item}: $md5"
		} else {
			set pattern "${item}\\s+: $md5"
		}
		
		if { ![regexp -line $pattern $get_info] } {
			  puts "MD5 $md5 --> $item ,FAIL"
			  return 0
		} else {
			  puts "MD5 $md5 --> $item ,PASS"
			  return 1
		}
}


;# ==================================================
set get_info {
show ucentral certificate status
13:39:51:239| 
13:39:51:239| TIP Certificate MD5 Checksum
13:39:51:250| 
13:39:51:250|   cas.pem   : dbdd18608c3cfe4d7f54e2a65f1b2d29
13:39:51:266|   cert.pem  : e00b5b67335f567f91fcc4cc3f7f81fe
13:39:51:282|   dev-id    : 4e28bba2ea2deefb58f524ce2bd77e4a
13:39:51:335|   key.pem   : 8162c46bc37c064f23ef05fa1a9d02df
13:39:51:335| Operational Certificate MD5 Checksum
13:39:51:335| 
13:39:51:335|   operational.pem: e00b5b67335f567f91fcc4cc3f7f81fe
13:39:51:335| Operational Certificate Authority MD5 Checksum
13:39:51:335| 
13:39:51:335|   operational.ca: dbdd18608c3cfe4d7f54e2a65f1b2d29
13:39:51:335| Console#
}
