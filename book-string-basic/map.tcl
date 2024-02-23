# Example: 將 ":" 置換成空格 " "

# ======================
set aaa "aa:bb:cc"
string map {: " "} $aaa

# ======================
# output: aa bb cc

# 刪除 ASCII 的 ^H (0x08)
string map {\x08 ""} $sourceFile

