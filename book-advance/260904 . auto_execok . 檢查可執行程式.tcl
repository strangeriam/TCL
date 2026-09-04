什麼是 auto_execok

Kiro
auto_execok 是 TCL 內建指令，用來檢查系統上是否存在某個可執行程式，並回傳它的完整路徑。

基本用途
它會在系統的 PATH 環境變數中尋找指定的執行檔：

;# =================================
set path [auto_execok plink]
找到 → 回傳可執行檔的完整路徑（例如 C:/Program Files/PuTTY/plink.exe）
找不到 → 回傳空字串 ""
在你的 iperf3 工具中的用途
在 comm.tcl 裡就用它來檢查 plink 是否安裝：

if {[auto_execok plink] eq ""} {
    return -code error "找不到 plink.exe，請安裝 PuTTY..."
}
這行的意思是：如果找不到 plink 就報錯，避免後續執行 SSH 連線時才失敗。

;# =================================
平台差異
Windows — 會自動處理副檔名（.exe, .bat, .cmd, .com），也會辨識內建指令如 dir、copy。所以 auto_execok dir 也能找到。
Unix/Linux — 單純在 PATH 中找可執行檔。

常見用法
# 檢查程式是否存在
if {[auto_execok git] ne ""} {
    puts "git 已安裝"
}

# 取得路徑後執行
set sshcmd [auto_execok ssh]
if {$sshcmd ne ""} {
    exec {*}$sshcmd user@host
}

;# =================================
小提醒
auto_execok
會快取結果在全域陣列 ::auto_execs 中，所以第一次查詢後同一個程式的後續查詢會很快。
如果你在程式執行期間安裝了新程式，可能需要 unset ::auto_execs(程式名) 來清除快取。

它只確認「檔案存在且可執行」，不會驗證程式能不能正常運作或版本是否正確。

Est. Credits Used: 0.76
Elapsed time: 15s
