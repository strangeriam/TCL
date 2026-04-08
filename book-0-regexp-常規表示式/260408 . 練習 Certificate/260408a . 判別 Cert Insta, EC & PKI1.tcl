
Certificate file list:
======================
set certlist_pki1 [list cas.pem cert.pem dev-id key.pem] ;# --> PKI 1.0
set certlist_pki2insta [list cas.pem cert.pem cert-id key.pem] ;# --> PKI 2.0 Insta
set certlist_pki2ec [list key.pem operational.ca operational.pem] ;# --> PKI 2.0 EC (Self-Signed)

set mac E001A63FB633

set listitem [glob -no -directory ${::ASPECTPATH}extapp/FTP_TFTP_AUTO/apcode_certs/$mac/ -tail *]
set cert_num [llength $listitem]

if { $cert_num == 3 } {
    puts "Found Certificate EC Self-Signed"
} elseif { $cert_num == 4 } {
    puts "Found Certificate PKI 2.0 Insta or PKI 1.0"
} else {
    puts "Wrong Certificate file number ($cert_num)"
}


=============================
