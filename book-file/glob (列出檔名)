# book A
;# ======
# 顯示指定目錄內的 檔名 清單, 不含目錄名稱.

glob -directory "data/cpk_log" -tails *

;# -tails
;# -tails 讓回傳的清單只包含檔名及目錄名稱而不包含路徑.
;# 表示只顯示文件名.
;# 可以與-directory 和 -path 一起使用.

;# book B
;# ======
;# 有時目錄裡沒有檔案, 如果下了指令

set log_dir "D:/EVT_TEST_LOG/02_Process/log_2_current/2023_10_24/"
glob -no -directory $log_dir -tails *

;# 會跳出錯誤訊息
no files matched glob pattern "*"

;# 可用 -no (-nocomplain) 避開.
;# 如果 glob 命令執行時沒有找到任何檔案或目錄, 它會抱怨找不到檔案.
;# 加上 -nocomplain 告訴 glob 不要產生抱怨訊息.

glob -no -directory $log_dir -tails *
