可以用來判斷檔案或目錄是否存在.
是的話回傳 1
否則回傳 0

if { ![file exist "targetFile"] } {
      ;# 假如 targetFile 不在, 則程式跑這這裡.
}

# 假如 targetFile 存在, 則將 targetFile 刪除.
if { [file exist "targetFile"] } {
           file delete -force "targetFile"
}
