
set get_info {
version
08:51:12:437| U-Boot 2023.01-1.0.4 (Jun 17 2024 - 18:21:03 +0800)
08:51:12:437| 
08:51:12:437| aarch64-linux-gnu-gcc (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 8.3.0
08:51:12:437| GNU ld (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36)) 2.32.0.20190321
08:51:12:437| Marvell>> 
}

set ::Uboot_ver "1.0.2"
regexp $::Uboot_ver $get_info

輸出: 1
錯誤:
get_info 內的 uboot version "U-Boot 2023.01-1.0.4 (Jun 17 2024 - 18:21:03 +0800)" 是 "1.0.4".
須判斷正確的 uboot 是 "1.0.2", 應該 return 0.


