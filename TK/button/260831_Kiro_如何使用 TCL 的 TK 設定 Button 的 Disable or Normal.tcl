如何使用 TCL 的 TK 設定 Button 的 Disable or Normal.

Kiro
在 Tk 裡, Button 的啟用/停用是透過 -state 選項控制, 有三種狀態: normal、disabled、active。

基本用法
tcl

# 建立按鈕
button .btn -text "開始測試" -command doTest

# 停用 (變灰, 無法點擊)
.btn configure -state disabled

# 啟用 (恢復正常)
.btn configure -state normal
建立時就指定狀態
tcl

button .btn -text "終止" -command doStop -state disabled
讀取當前狀態
tcl

set s [.btn cget -state]
puts $s   ;# 輸出: normal 或 disabled
三種狀態說明
狀態	說明
normal	正常, 可點擊
disabled	停用, 變灰, 無法點擊, 不觸發 command
active	滑鼠移上去的高亮狀態 (通常由系統自動管理, 少手動設定)
ttk::button (主題式按鈕)
如果用的是 ttk::button (較新、外觀較現代), 語法略有不同 — 使用 state 命令:

tcl

ttk::button .btn -text "開始" -command doTest

# 停用
.btn state disabled

# 啟用 (移除 disabled 狀態)
.btn state !disabled

# 或用 configure (兩種都可)
.btn configure -state disabled
.btn configure -state normal

# 檢查是否被停用
if {[.btn instate disabled]} {
    puts "按鈕已停用"
}
實務範例 (對應你的 iperf 工具)
tcl

proc ui_test_started {} {
    # 測試開始: 停用"開始", 啟用"終止"和"暫停"
    .btn_start configure -state disabled
    .btn_stop  configure -state normal
    .btn_pause configure -state normal
}

proc ui_test_stopped {} {
    # 測試結束: 恢復"開始", 停用其他
    .btn_start configure -state normal
    .btn_stop  configure -state disabled
    .btn_pause configure -state disabled
}
小提醒
button (傳統) 和 ttk::button (主題式) 都支援 -state normal/disabled, 所以 configure -state 是最通用的寫法。
停用狀態下, 即使按鈕被點也不會執行 -command, 不需額外判斷。
若按鈕存在變數中 (如你程式的 $::ui_btn_start), 寫法是:
tcl

$::ui_btn_start configure -state disabled
Est. Credits Used: 1.29
Elapsed time: 20s
