proc _f_language_detect_260624 {} {
	package require msgcat

	if { [string equal -nocase [_f_vini_profilerd DUTINFO LANGUAGE] "vn"] } {
		source ${::ASPECTPATH}/locale/vi_vn.msg
		::msgcat::mclocale vi_vn
	} elseif { [string equal -nocase [_f_vini_profilerd DUTINFO LANGUAGE] "tw"] } {
		source ${::ASPECTPATH}/locale/zh_tw.msg
		::msgcat::mclocale zh_tw
	} else {
	}
}

語言檔內容
encoding system utf-8
::msgcat::mcset zh_tw {SHORT PRESS} {短按}
::msgcat::mcset zh_tw {NOT FOUND} {找不到}
