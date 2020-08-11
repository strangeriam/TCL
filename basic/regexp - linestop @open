# Syntax: regexp -linestop  {條件字串}  “source string”  新變數名
# 含其後面字串表示: {條件字串.*}

# Example Code 2, 來源檔 sourceFile_tmp 裡有 fail 字串.

set sourceFile_tmp [file_open "aaa.log" r]

# 將有 fail 的這一整行寫進 bbb.log.
set targetFile [open bbb.log w]

# 將來源檔內容存入變數 $sourceFile.
set sourceFile [read $sourceFile_tmp]

file_close $sourceFile_tmp

regexp -linestop {.* fail.*} $sourceFile targetContent
puts $targetFile $targetContent

# 寫入目的地檔 targetFile, 並觀關閉此 channel id.
close $targetFile
