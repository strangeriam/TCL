
set ::md5_cas_pem AAA
set ::length_cas_pem bbb

set listitem [list ::md5_cas_pem ::length_cas_pem]

foreach item $listitem {
    if {![info exists ::md5_cas_pem]} {
        puts "ERROR"
    }
}
