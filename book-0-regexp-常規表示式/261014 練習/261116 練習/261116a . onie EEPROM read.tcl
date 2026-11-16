
set item "0x21"
set value "ECS5550-54X"

regexp "$item\\s+\\d+ $value" $get_info

set get_info {
08:45:35:786| ONIE:/ # onie-syseeprom
08:45:36:005| 
08:45:36:018| TlvInfo Header:
08:45:36:018|    Id String:    TlvInfo
08:45:36:018|    Version:      1
08:45:36:031|    Total Length: 189
08:45:36:031| TLV Name             Code Len Value
08:45:36:031| -------------------- ---- --- -----
08:45:36:031| Product Name         0x21  11 ECS5550-54X
08:45:36:041| Part Number          0x22  13 C0PE16800021S
08:45:36:041| Serial Number        0x23  12 EC2520005274
08:45:36:041| Base MAC Address     0x24   6 A0:1A:E3:2D:ED:B8
08:45:36:051| Manufacture Date     0x25  19 11/16/2026 00:00:00
08:45:36:051| Device Version       0x26   1 1
08:45:36:051| Label Revision       0x27   3 R01
08:45:36:061| Platform Name        0x28  27 arm64-accton_ecs5550_54x-r0
08:45:36:061| ONIE Version         0x29  23 lite_2019.11br-03211524
08:45:36:071| Manufacturer         0x2B   8 Edgecore
08:45:36:071| Country Code         0x2C   2 TW
08:45:36:071| Vendor Name          0x2D   8 Edgecore
08:45:36:092| Diag Version         0x2E  10 V1.1.3.243
08:45:36:092| Service Tag          0x2F  12 EC2520005274
08:45:36:092| CRC-32               0xFE   4 0x42CEB540
08:45:36:092| Checksum is valid.
08:45:36:092| ONIE:/ # 
}
