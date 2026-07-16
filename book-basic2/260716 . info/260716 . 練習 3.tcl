
set listitem [list cas.pem cert.pem]

foreach fname $listitem {
		set fn [string map {. _} $fname]
		set ::md5_$fn AAA
		set ::length_$fn aaa

		if { ![info exist ::md5_$fn] || ![info exist ::length_$fn] } {
			  puts "Unknown CERT !!!"
		}
}
