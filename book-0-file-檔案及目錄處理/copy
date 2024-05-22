;# Note
;# ====
;# 1. Copy 資料夾, 無法複製到相同資料夾名稱, 雖然內含檔案名稱不同, 也不可以.
;# Error message

error copying "C:/testlog/trytryLu/CN2/AAA": file already exists

;# 強制複製
;# ========
;# 如果 targetFile 與 sourceFile 目錄名稱相同, 則 sourceFile 會被複製到 targetFile 目錄下.
file copy -force ../../file1.txt file2.txt
file copy -force BBB BBB (sourceFile BBB 會被複製到 targetFile BBB 之下)

# A, Copy old log file to folder "old".
# 將副檔名是 log 的檔案, 複製到資料夾 old.

set infiles [glob -nocomplain $::PATH_LOG/*.log]
if {[llength $infiles]} {
      file copy {*}$infiles $::PATH_LOG/old
}

# Remove old log file.
if {[llength $infiles]} {
      file delete -force {*}$infiles
}

# B, 將檔名前有 "EC2303003461" 的檔案, 複製到資料夾 old.
# 並且將檔名改為 EC2303003461.txt

set path "$ENVPATH/log/01_test/"
set infiles [glob -nocomplain $path/EC2303003461*.*]
if {[llength $infiles]} {
      file copy {*}$infiles $path/old/EC2303003461.txt
}
