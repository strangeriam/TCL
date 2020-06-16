
# 強制複製 "sourceFile" 到 "targetFile".
file copy -force "sourceFile "targetFile"

# 目錄 $folderNmae 如果不存在, 則新建立 $folderName.
if { ![file isdirectory $folderName] } {
       file mkdir $folderName
}

# 目錄 $fileNmae 如果不存在, 則新建立 $fileName.
if { ![file isfile $fileName] } {
       set fd [open $fileName a]
       close $fd
}
