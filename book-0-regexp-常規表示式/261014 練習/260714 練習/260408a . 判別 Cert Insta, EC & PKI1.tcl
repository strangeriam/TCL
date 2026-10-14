
;# Certificate file list:
;# ======================
set certlist_pki1 [list cas.pem cert.pem dev-id key.pem] ;# --> PKI 1.0
set certlist_pki2insta [list cas.pem cert.pem cert-id key.pem] ;# --> PKI 2.0 Insta
set certlist_pki2ec [list key.pem operational.ca operational.pem] ;# --> PKI 2.0 EC (Self-Signed)

set mac E001A63FB622

set listitem [glob -no -directory ${::ASPECTPATH}extapp/FTP_TFTP_AUTO/apcode_certs/$mac/ -tail *]
set cert_num [llength $listitem]

if { $cert_num == 3 } {
    puts "Found Certificate EC Self-Signed"
} elseif { $cert_num == 4 } {
    puts "Found Certificate PKI 2.0 Insta or PKI 1.0"
} else {
    puts "Wrong Certificate file number ($cert_num)"
}

;# lsearch -inline $listitem cert-id
foreach fname $certlist_pki2insta {
        puts "fname: $fname"
        if { [llength [lsearch -inline $listitem $fname]] == 1} {
            puts OK
        } else {
            puts NOT_OK
        }
}
;# 輸出
fname: cas.pem
OK
fname: cert.pem
OK
fname: dev-id
NOT_OK
fname: key.pem
OK

foreach fname $certlist_pki1 {
        puts "fname: $fname"
        if { [llength [lsearch -inline $listitem $fname]] == 1} {
            puts OK
        } else {
            puts NOT_OK
        }
}
;# 輸出
fname: cas.pem
OK
fname: cert.pem
OK
fname: dev-id
NOT_OK
fname: key.pem
OK

foreach fname $certlist_pki2ec {
        puts "fname: $fname"
        if { [llength [lsearch -inline $listitem $fname]] == 1} {
            puts OK
        } else {
            puts NOT_OK
        }
}
;# 輸出
fname: key.pem
OK
fname: operational.ca
NOT_OK
fname: operational.pem
NOT_OK
=============================
