
set item "0x21"
set value "ECS5550-54X"

regexp "$item\\s+\\d+ $value" $get_info

set get_info {
ONIE:/ # onie-syseeprom
TlvInfo Header:
   Id String:    TlvInfo
   Version:      1
   Total Length: 34
TLV Name             Code Len Value
-------------------- ---- --- -----
Product Name         0x21  11 ECS5550-54X
Part Number          0x22  13 C0PE16800021S
CRC-32               0xFE   4 0x0EAD27DD
Checksum is valid.
ONIE:/ # 
}
