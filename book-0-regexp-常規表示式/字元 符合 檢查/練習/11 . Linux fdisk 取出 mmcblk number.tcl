取出這 2 行 Log 的 /dev/mmcblk0p1 和 /dev/mmcblk0p3, 並取得它的 mmcblk number.
例如: /dev/mmcblk0p1 的 number 是 1 . /dev/mmcblk0p3 的 number 是 3

/dev/mmcblk0p1    32,0,1      1023,3,16         2048     346111     344064  168M 83 Linux
/dev/mmcblk0p3    1023,3,16   1023,3,16       346112   62160895   61814784 29.4G 83 Linux


;# Code
if { [info exists plist] } { unset plist }

foreach partlist [regexp -all -inline -- {/dev/mmcblk0p[^\n]+} $get_info] {
	append plist "[string index [lindex $partlist 0] end-0] "
}

puts "plist: $plist"


;# 輸出:
plist: 1 3 
;# ================================================



set get_info {
/ # fdisk -l
Disk /dev/mmcblk[  137.790763] Buffer I/O error on dev mmcblk0rpmb, logical block 0, async page read
0: 30 GB, 31826378752 bytes, 62160896 sectors
971264 cylinders, 4 heads, 16 sectors/track
Units: sectors of 1 * 512 = 512 bytes

Device       Boot StartCHS    EndCHS        StartLBA     EndLBA    Sectors  Size Id Type
/dev/mmcblk0p1    32,0,1      1023,3,16         2048     346111     344064  168M 83 Linux
/dev/mmcblk0p3    1023,3,16   1023,3,16       346112   62160895   61814784 29.4G 83 Linux
Disk /dev/mmcblk0boot1: 31 MB, 33030144 bytes, 64512 sectors
1008 cylinders, 4 heads, 16 sectors/track
Units: sectors of 1 * 512 = 512 bytes

Disk /dev/mmcblk0boot1 doesn't contain a valid partition table
Disk /dev/mmcblk0boot0: 31 MB, 33030144 bytes, 64512 sectors
1008 cylinders, 4 heads, 16 sectors/track
Units: sectors of 1 * 512 = 512 bytes

Disk /dev/mmcblk0boot0 doesn't contain a valid partition table
/ #
}
