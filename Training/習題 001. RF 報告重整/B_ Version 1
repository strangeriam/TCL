encoding system utf-8
# source c:/tcl/bin/tkcon.tcl
# tkcon show

set ::ASPECTPATH [pwd]/
source ${::ASPECTPATH}necessary/fileProcess.tcl

## ====================================================
set ::resultDir "./report"
if { ![file exist $::resultDir] } { file mkdir $::resultDir }

set BUILD_DATE_TIME [clock format [clock seconds] -format "%y%m%d_%H%M%S"]

set reportFile "$::resultDir/EAP111_Report\_$BUILD_DATE_TIME.csv"

if { ! [file exists $reportFile] } {
	_f_WriteFile $reportFile w "Frequency,Data Rate,Bandwidth,Antenna,Tx Power,None A,Power (dBm),EVM (dB),Freq Error (ppm),Sym Clk Error (ppm),LO Leakage (dBc),Spectrum Mask (%)\n"
}
## ====================================================


# set infile [_f_ReadFile ${::ASPECTPATH}sourceFile/log_all.csv]
set infile [_f_ReadFile ${::ASPECTPATH}sourceFile/sample_lu4.csv]


## PART A, Get RF Item.
set line_start {WIFI }
set line_end { ,WIFI}

## ,2412 MHz DSSS-1 BW-20 ANT_1 23 dBm NON_HT NA 
set p01 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z][A-Z]-\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+ dBm [A-Z][A-Z][A-Z]_[A-Z][A-Z]+ NA }

## ,2412 MHz CCK-11 BW-20 ANT_1 23 dBm NON_HT NA 
set p02 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]-{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+ dBm [A-Z][A-Z][A-Z]_[A-Z][A-Z]+ NA }

## ,2412 MHz MCS0 BW-20 ANT_1 22 dBm HT_MF NA 
set p03 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+ dBm [A-Z][A-Z]_[A-Z][A-Z]+ NA }

## ,2412 MHz MCS0 BW-20 ANT_1 22 dBm VHT NA 
set p04 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+ dBm [A-Z][A-Z][A-Z]+ NA }

## ,2422 MHz MCS9 BW-40 ANT_1 17.5 dBm VHT NA 
set p05 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+\.\d+ dBm [A-Z][A-Z][A-Z]+ NA }

## ,2412 MHz MCS11 BW-20 ANT_1 18.5 dBm HE_SU NA 
set p06 {,-{0,1}\d+ MHz [A-Z][A-Z][A-Z]{0,1}\d+ [A-Z][A-Z]-\d+ [A-Z][A-Z][A-Z]_\d+ {0,1}\d+\.\d+ dBm [A-Z][A-Z]_[A-Z][A-Z]+ NA }

## l 組 24
set dsss1_x3 [string repeat $p01 72]
set cck11_x1 [string repeat $p02 24]
set ofdm6_x3 [string repeat $p01 72]
set ofdm54_x3 [string repeat $p01 72]
set mcsHtmf_x12 [string repeat $p03 288]

set data1 [string map {WIFI: ""} [string map { \} ""} [string map { \{ ""} [string map {, " "} [string map { " " :} [regexp -all -inline -- $line_start$dsss1_x3$cck11_x1$ofdm6_x3$ofdm54_x3$mcsHtmf_x12 $infile]]]]]]

if {[info exists csvData1]} {
	unset csvData1
}

set i 0
set ii 0

foreach line $data1 {
	if {$i == $ii} {
		set line1 [string map {: " "} $line]

		set data1_freq [lindex $line1 0]
		set data1_rate [lindex $line1 2]
		set data1_bw [lindex $line1 3]
		set data1_ant [lindex $line1 4]
		set data1_tx [lindex $line1 5]
		set data1_non [lindex $line1 7]

		append csvData1 "$data1_freq,$data1_rate,$data1_bw,$data1_ant,$data1_tx,$data1_non,\n"

		set ii [expr $ii +6]
	}

	incr i
}

## ===================================
set mcsVht_x9 [string repeat $p04 216]
set mcsVht175_x3 [string repeat $p05 72]

set data1 [string map { \} ""} [string map { \{ ""} [string map {, " "} [string map { " " :} [regexp -all -inline -- $mcsVht_x9$mcsVht175_x3 $infile]]]]]

set i 0
set ii 0

foreach line $data1 {
	if {$i == $ii} {
		set line1 [string map {: " "} $line]

		set data1_freq [lindex $line1 0]
		set data1_rate [lindex $line1 2]
		set data1_bw [lindex $line1 3]
		set data1_ant [lindex $line1 4]
		set data1_tx [lindex $line1 5]
		set data1_non [lindex $line1 7]

		append csvData1 "$data1_freq,$data1_rate,$data1_bw,$data1_ant,$data1_tx,$data1_non,\n"

		set ii [expr $ii +6]
	}

	incr i
}

## 以下一組 12
## 以下對應 4T4R 的值皆是無效資訊, 如下2行, 故不取.
## Error Message ()
## Analyze power failed!
## ===================================
# set mcsHtmf_x3 [string repeat $p03 36]
# set mcsHtmf185_x3 [string repeat $p06 36]
# set mcsHtmf_x6 [string repeat $p03 72]

# set data1 [string map { \} ""} [string map { \{ ""} [string map {, " "} [string map { " " :} [regexp -all -inline -- $mcsHtmf_x3$mcsHtmf185_x3$mcsHtmf_x6 $infile]]]]]

# set i 0
# set ii 0

# foreach line $data1 {
# 	if {$i == $ii} {
# 		set line1 [string map {: " "} $line]

# 		set data1_freq [lindex $line1 0]
# 		set data1_rate [lindex $line1 2]
# 		set data1_bw [lindex $line1 3]
# 		set data1_ant [lindex $line1 4]
# 		set data1_tx [lindex $line1 5]
# 		set data1_non [lindex $line1 7]

# 		append csvData1 "$data1_freq,$data1_rate,$data1_bw,$data1_ant,$data1_tx,$data1_non,\n"

# 		set ii [expr $ii +3]
# 	}

# 	incr i
# }


## PART B, Get Power dBm.
set line [string map {" " _} [regexp -all -inline -- {4T4R,[^\n]+,} $infile]]
set data2 [string map { "4T4R " ""} [string trim [string trim [split $line ,] \\\{] \\\}]]

if {[info exists csvData2]} {
	unset csvData2
}

set i 0
set ii 5

foreach line $data2 {
	# puts "line: $line"

	if {$i == $ii} {
		append csvData2 "$line "
		set ii [expr $ii +6]
	} {
		append csvData2 $line\,
	}

	incr i
}

## Make CSV
## ================================================
foreach item $csvData1 value $csvData2 {
	if {$item == ""} {break}
	append csvData $item$value\n
}


_f_WriteFile $reportFile a $csvData
