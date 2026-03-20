
set mac A01AE32DEDB8
set LIC_test "./extapp/FTP_TFTP_AUTO/ec_license/test_lic/PROFILE_$::lic_projectname\_$mac.lic"

if { ![file exists $LIC_test]} { usermsg "WRONG !!!\nNo $LIC_test" }
set get_info [_f_ReadFile $LIC_test]
