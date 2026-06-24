package require msgcat

set ::lang tw

if { [string equal -nocase $::lang "vn"] } {
		source ${::ASPECTPATH}/locale/vi_vn.msg
		::msgcat::mclocale vi_vn
} elseif { [string equal -nocase $::lang "tw"] } {
		source ${::ASPECTPATH}/locale/zh_tw.msg
		::msgcat::mclocale zh_tw
}

puts "[::msgcat::mc "NOT FOUND"] APC"
;# 輸出:
找不到 APC

==================================================
;# 語言檔內容
encoding system utf-8
::msgcat::mcset zh_tw {SHORT PRESS} {短按}
::msgcat::mcset zh_tw {NOT FOUND} {找不到}
