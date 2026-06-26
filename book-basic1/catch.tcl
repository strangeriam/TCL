# 空值判斷
# 語法: catch script ?resultVarName? ?optionsVarName?

## A. 不存在的變數, 所產生的 Error message.
## ==========================================================
set tmp AAA

## 如果有錯誤訊息, 則將訊息導到 變數 err.
catch {puts $tmp} err
## 輸出
AAA
0

unset tmp
catch {puts $tmp} err
## 輸出
1

set err
## 輸出
can't read "tmp": no such variable


## B. 不存在的變數, 跳出錯誤訊息告知.
## ==========================================================
unset tmp

## 輸出
can't unset "tmp": no such variable

## 如果有錯誤訊息, 則將訊息導到 變數 err.
if { [catch {unset tmp} err] } { errormsg "沒有此變數\n$err" }


## ==========================================================
# Example: Check any tftpd32.exe process ID on Win7.
# If yes, return "1"
# If no, return "0"

catch [twapi::get_process_ids -name tftpd32.exe]

# 搭配判斷式 if..else.
if {[catch [twapi::get_process_ids -name tftpd32.exe]]} {
         puts "Have tftpd32.exe."
} else {
         puts "Have not tftpd32.exe."
}

## ==========================================================
set TimeDIR "$::ENVPATH/Log/TIME/TIME-$::testCaseName-$::buildDate"

if { [catch {file mkdir $TimeDIR} err] } {
          save_msg "\[$err\]: Can't create time log fail folder." ERROR
          return
}

## ==========================================================
if { [catch {glob -directory "${::ASPECTPATH}60g/BrdCSV/testplan" -tail *.csv} err]} {
	errormsg "沒有 testplan *.csv 檔"
}
