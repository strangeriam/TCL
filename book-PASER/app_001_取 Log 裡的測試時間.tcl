參考最下面 Log 樣本.
取得如下內容:
o  00:05:35    21              _f_power_on_uboot_only                         o
o  00:05:56    77              _f_diagcode_download_single                    o
o  00:07:13    29              _f_reset_uboot_parameter                       o
o  00:07:42    7               _f_go_to_bootloader                            o
o  00:07:49    2               _f_check_uboot_version                         o
o  00:07:51    26              _f_go_to_kernel_bootipq                        o
o  00:08:17    1               _f_check_fw_version                            o
o  00:08:18    44              _f_power_on_kernel_ssh                         o
o  00:09:02    135             _f_download_apcode_ec140                       o
o  00:11:17    186             _f_kwikbit_code_download                       o
o  00:14:23    1               _f_kwikbit_code_version                        o

## ==============================================================================
set sourceDir C:/testlog/trytryLu/sourceLog
set targetDir C:/testlog/trytryLu/targetLog

set build_date_time [clock format [clock seconds] -format "%y%m%d_%H%M%S"]
set targetDir $targetDir\_$build_date_time
if { ![file exist $targetDir] } { file mkdir $targetDir }

set report "$targetDir/report.csv"
_f_WriteFile $report w "filename,testCase,spendTime\n"

foreach fname [_f_GetFilePaths $sourceDir -expectedFiles *.cap] {
		set filename [file tail $fname]
		puts "filename : $filename"

		set infile [_f_ReadFile $fname]
		set infile [regexp -all -inline {Footer Information.*} $infile]
		# puts "infile : $infile"

		set lsfile [regexp -all -inline -- {_f_[0-9a-z_]+} $infile]
		set numfile [llength $lsfile]
		puts "numfile : $numfile"

		set total [expr [llength $lsfile] -1]
		puts "total : $total"

		for {set i 0} {$i <= $total} {incr i} {
			regexp -linestop .*[lindex $lsfile $i].* $infile dataTest
			puts "dataTest : $dataTest"

			set spendTime 	[lindex $dataTest 2]
			set testCase 	[lindex $dataTest 3]

			puts \n\n\n
			puts "filename : $filename"
			puts "numfile : $numfile"
			puts "spendTime : $spendTime"
			puts "testCase : $testCase"
			puts \n\n\n

			_f_mspause 200
			# append data "$filename,$testCase,$spendTime\n"

			set data "$filename,$testCase,$spendTime\n"
			_f_WriteFile $report a+ $data
		}
}
## ==============================================================================

輸出
{Footer Information                                 *
******************************************************
* Finish Date and Time : 2024/08/07 00:14:24         *
* Test Status: PASS                                  *
******************************************************

ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
o  Test_Start  Spent_Seconds   Test_Item                                      o
o --------------------------------------------------------------------------  o
o  00:05:35    21              _f_power_on_uboot_only                         o
o  00:05:56    77              _f_diagcode_download_single                    o
o  00:07:13    29              _f_reset_uboot_parameter                       o
o  00:07:42    7               _f_go_to_bootloader                            o
o  00:07:49    2               _f_check_uboot_version                         o
o  00:07:51    26              _f_go_to_kernel_bootipq                        o
o  00:08:17    1               _f_check_fw_version                            o
o  00:08:18    44              _f_power_on_kernel_ssh                         o
o  00:09:02    135             _f_download_apcode_ec140                       o
o  00:11:17    186             _f_kwikbit_code_download                       o
o  00:14:23    1               _f_kwikbit_code_version                        o
o --------------------------------------------------------------------------  o
o  Total 11 test items spent 529 seconds                                      o
ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
===================== Total Spent Time : 00:08:52 =====================
===================== Capture end 2024/08/07 00:14:25 =====================
}

步驟 4, 取得所需內容.



==============================
Log 樣本

= OACK: <timeout=5,blksize=1468,> [07/08 00:13:08.703]                                                                                                   =
= Using local port 65065 [07/08 00:13:08.735]                                                                                                            =
= <LinuxA.bin>: sent 23045 blks, 33829626 bytes in 14 s. 0 blk resent [07/08 00:13:22.512]                                                               =
= Connection received from 192.168.1.100 on port 3798 [07/08 00:13:35.306]                                                                               =
= Read request for file <WriteFS.bin>. Mode octet [07/08 00:13:35.838]                                                                                   =
= OACK: <timeout=5,blksize=1468,> [07/08 00:13:35.884]                                                                                                   =
= Using local port 65066 [07/08 00:13:35.916]                                                                                                            =
= <WriteFS.bin>: sent 1340 blks, 1966080 bytes in 1 s. 0 blk resent [07/08 00:13:36.775]                                                                 =
=                                                                                                                                                        =
==========================================================================================================================================================
......................................................
=============================
= <time:00:14:23>           =
=============================
=                           =
= KB-00-00-DA>              =
=                           =
=============================
.
######################################################
# <time:00:14:23> Kwikbit download,PASS              #
######################################################

###############################################################################
# <time:00:14:23> <_f_kwikbit_code_download> spent 186 Seconds                #
###############################################################################
.
###############################################################################
# <time:00:14:23> DIAGCODE_to_KWIKBIT APcode . kwikbit Version                #
###############################################################################
.....................................................
===============================================================================
= <time:00:14:24>                                                             =
===============================================================================
=                                                                             =
= KB-00-00-DA> id                                                             =
= Welcome kwikbit.  [Sat Jan  1 00:00:26 UTC 2022] on [KB-00-00-DA]           =
=  [HW name: K60cn1, software: 1.1.2]                                         =
=  description: system description not set                                    =
=  location: system location not set                                          =
= KB-00-00-DA>                                                                =
=                                                                             =
===============================================================================
....................................+++
========================================================================================================
= <time:00:14:24>                                                                                      =
========================================================================================================
=            kb_node_id                                                                                =
= name: KB-00-00-DA                                                                                    =
= HW name: K60cn1                                                                                      =
= HW rev: 3                                                                                            =
= HW type code: 112                                                                                    =
= Number Ethernet Interfaces: 2                                                                        =
= Ethernet MAC: 70:88:6B:00:00:DA                                                                      =
= Number RF Interfaces: 1                                                                              =
= Part number: 1430-2210-0221-K60cn1-3-LBKA0ZZ1SV1                                                     =
= Serial number: EC2416003873                                                                          =
= bootloader version: KBBLVERSION:1.1:prod:robot:2022-09-14_12-09-05:k60cn1:524f1d4                    =
= software: 1.1.2                                                                                      =
= location: system location not set                                                                    =
= description: system description not set                                                              =
= KB-00-00-DA>                                                                                         =
=                                                                                                      =
========================================================================================================
++
00:14:24:834| writing new private key to '/mnt/writeable-flash/certs/KB-00-00-DA.key'
00:14:24:834| -----
00:14:24:834| 
###############################################################################
# <time:00:14:24> <_f_kwikbit_code_version> spent 1 Seconds                   #
###############################################################################
Obtain SSL cert
00:14:24:876| trying "tftp -p -r request/crt-KB-00-00-DA.request -l /mnt/writeable-flash/certs/KB-00-00-DA.csr 192.168.1.1"
00:14:24:876| tftp -p -r request/crt-KB-00-00-DA.request -l /mnt/writeable-flash/certs/KB-00-00-DA.csr 192.168.1.1
00:14:24:876| 
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
x <time:00:14:24> Summary Report : 35/50                                      x
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
x | TestFunc                                             | PASS | FAIL |      x
x --------------------------------------------------------------------        x
x | _f_power_on_uboot_only                               | 35   | 0    |      x
x | _f_diagcode_download_single                          | 35   | 0    |      x
x | _f_reset_uboot_parameter                             | 35   | 0    |      x
x | _f_go_to_bootloader                                  | 35   | 0    |      x
x | _f_check_uboot_version                               | 35   | 0    |      x
x | _f_go_to_kernel_bootipq                              | 35   | 0    |      x
x | _f_check_fw_version                                  | 35   | 0    |      x
x | _f_power_on_kernel_ssh                               | 35   | 0    |      x
x | _f_download_apcode_ec140                             | 35   | 0    |      x
x | _f_kwikbit_code_download                             | 35   | 0    |      x
x | _f_kwikbit_code_version                              | 35   | 0    |      x
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

******************************************************
* Footer Information                                 *
******************************************************
* Finish Date and Time : 2024/08/07 00:14:24         *
* Test Status: PASS                                  *
******************************************************

ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
o  Test_Start  Spent_Seconds   Test_Item                                      o
o --------------------------------------------------------------------------  o
o  00:05:35    21              _f_power_on_uboot_only                         o
o  00:05:56    77              _f_diagcode_download_single                    o
o  00:07:13    29              _f_reset_uboot_parameter                       o
o  00:07:42    7               _f_go_to_bootloader                            o
o  00:07:49    2               _f_check_uboot_version                         o
o  00:07:51    26              _f_go_to_kernel_bootipq                        o
o  00:08:17    1               _f_check_fw_version                            o
o  00:08:18    44              _f_power_on_kernel_ssh                         o
o  00:09:02    135             _f_download_apcode_ec140                       o
o  00:11:17    186             _f_kwikbit_code_download                       o
o  00:14:23    1               _f_kwikbit_code_version                        o
o --------------------------------------------------------------------------  o
o  Total 11 test items spent 529 seconds                                      o
ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
===================== Total Spent Time : 00:08:52 =====================
===================== Capture end 2024/08/07 00:14:25 =====================
