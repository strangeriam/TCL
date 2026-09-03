什麼是 POSIX ?

Kiro
POSIX = Portable Operating System Interface（可攜式作業系統介面），是由 IEEE 制定的一套作業系統標準，正式編號為 IEEE 1003。

核心概念
POSIX 定義了「一個作業系統該提供哪些介面」，目的是讓程式寫一次，就能在不同 Unix-like 系統上執行，不必為每個系統改寫。

字尾的 -IX 是刻意呼應 Unix，由 Richard Stallman（GNU 創始人）建議命名。

為什麼需要它
1970-80 年代，Unix 分裂成很多版本（BSD、System V、AIX、HP-UX、Solaris...），每家介面都不太一樣。程式在 A 系統能跑，搬到 B 系統就掛掉。POSIX 就是為了統一標準而生。


沒有 POSIX:  程式 → 為每個 OS 各寫一套
有 POSIX:    程式 → 遵循 POSIX → 任何 POSIX 系統都能跑
POSIX 規範了哪些東西
類別	內容範例
系統呼叫 / API	fork(), exec(), open(), read(), write(), pipe()
Shell 與工具	sh, grep, awk, sed, ls, cp 的標準行為
正則表達式	就是你剛問的 [:space:], [:digit:] 等字元類別
執行緒	pthreads (POSIX threads)
檔案系統	路徑、權限、檔案操作語意
環境變數 / 訊號	SIGKILL, SIGTERM 等 signal 定義
哪些系統遵循 POSIX
系統	POSIX 相容性
Linux	大致相容（非官方認證，但實務上遵循）
macOS	官方 POSIX 認證
Unix (AIX, Solaris, HP-UX)	官方認證
BSD 系列	大致相容
Windows	原生不相容，需透過 WSL、Cygwin、MSYS 等相容層
這也是為什麼你的 Tcl 測試程式裡常見這種平台判斷：

tcl

if {$::tcl_platform(platform) eq "windows"} {
    set dev "\\\\.\\$com"      ;# Windows 路徑寫法
} else {
    set dev "/dev/$com"        ;# POSIX (Linux) 路徑寫法
}
回到你剛才的問題
「POSIX 正則字元類別」（[:space:]、[:digit:] 等）只是 POSIX 標準裡關於正則表達式的一小部分規範。
因為它是標準，所以 grep、sed、awk、Tcl、Python 等眾多工具都支援同樣的寫法，
這就是 POSIX「可攜性」的實際好處——你在 Linux grep 學到的 [:digit:]，在 Tcl 裡也能用。

一句話總結
POSIX 是一套讓不同 Unix-like 系統「長得像、行為一致」的介面標準，使程式和使用者的知識能在各系統間通用。

Est. Credits Used: 1.44
Elapsed time: 23s
