#; Example A
#; 讀取 MainConfig.ini 的測試設定值. 求 LOOPTEST= 多少的值.

set aaa [::twapi::read_inifile_key "LOOP-FDL" "DUT_1" -inifile "${::ASPECTPATH}MainConfig.ini" -default "0"]

foreach {item} $aaa {
	puts $item
	if {[regexp "LOOPTEST=" $item]} { break }
}

#; Outputs
puts $aaa
{COS1=DUT CMD=} {COS2=APC CMD=} {COS3=DUT COM=1,115200,N,8,1} {UI=SHOW} {LIST=1,15} {LOOPTEST=2} {FAILCONTINUE=1} {SN=EC2150000828} {MAC=98192CAE32DA}

puts $item
LOOPTEST=2
