set listitem [list cas.pem cert.pem]

foreach fname $listitem {
    switch $fname {
          cas.pem {
                    set ::md5_[string map {. _} $fname] AAA
                    set ::length_[string map {. _} $fname] bbb
          }
          cert.pem {
                    set ::md5_[string map {. _} $fname] BBB
                    set ::length_[string map {. _} $fname] bbb
          }
    }
}

puts "::md5_cas_pem : $::md5_cas_pem"
puts "::md5_cert_pem : $::md5_cert_pem"
