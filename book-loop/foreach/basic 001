## Ping 2 ipaddress ======================

set ip_list "192.168.10.1 192.168.10.2"

foreach ip $ip_list {
	if { ![_f_pinger_app $ip 5 2 0] } {
		_f_termmsg_V1 "PING, FAIL"
		return 0
	}
}
