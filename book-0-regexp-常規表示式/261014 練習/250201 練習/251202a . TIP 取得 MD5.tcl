set get_info {
Console#show ucentral certificate status
OpenLAN Demo Birth Certificate MD5 Checksum
  cas.pem   : 5bb74a8defd16ec0b679e736b36dde0b
  cert.pem  : 6f1c506bd2db28df1a2b8a01b00a0ae0
  cert-id   : e30b9e500ffedda8f4b4783828f57e9b
  key.pem   : fe48851586655b29cbdcf0d8e013cb56
Console#
}

set listitem [list 	cas.pem \
					cert.pem \
					cert.id \
					key.pem ]
set listmd5 [list 	5bb74a8defd16ec0b679e736b36dde0b \
					6f1c506bd2db28df1a2b8a01b00a0ae0 \
					e30b9e500ffedda8f4b4783828f57e9b \
					fe48851586655b29cbdcf0d8e013cb56]

foreach md5 $listmd5 item $listitem {
	if { ![regexp -line "${item}\\s+: $md5" $get_info] } {
		puts "MD5 Check: $item . $md5 ,FAIL"
		return 0
	} else {
		puts "MD5 Check: $item . $md5 ,PASS"
	}
}

