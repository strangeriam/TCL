以左邊這份 comm2.tcl, 如何修改 當 DUT 用 console 下 reboot 後, 不會產生 I/O error .

Kiro

1 tool call
Read File

comm2.tcl
問題根源：當 DUT 執行 reboot 後，序列連線的另一端會重新初始化 UART（DTR/RTS 抖動、埠短暫斷開再恢復）。此時 Windows 對 COM port 的 read/fileevent 會拋出 I/O error，因為底層 handle 進入錯誤狀態。

你目前的程式有幾個問題導致無法妥善處理：

_f_getconsole 的 read $ch 沒有包 catch — reboot 時 read 拋錯就直接中斷 fileevent，錯誤冒到最上層
if { ![catch $ch err]} 這行是錯的 — catch 的參數應該是「要執行的 script」，這裡把 channel handle $ch 當成指令去執行，完全無意義
reboot 造成的 I/O error 沒有被辨識並優雅處理（清 buffer、重連或忽略）
核心修法
把所有對 channel 的 read/eof 操作都包在 catch 裡，並辨識「I/O error」這種暫時性錯誤 → 不要噴錯，改成優雅處理（記錄、選擇性重連）。

讓我先確認幾件事再給你完整修正：

1. reboot 後你希望的行為是？

(a) 保持連線、忽略錯誤，繼續等 DUT 重開機後的輸出（最常見）
(b) 主動關閉並重新開啟 COM port（DUT reboot 若會讓 USB-serial 轉接器重新枚舉，這個較穩）
2. 你的序列裝置是？

直接主機板 COM port，還是 USB-to-Serial（如 CP2102 / FTDI / PL2303）？ （USB 轉接器在 DUT 斷電/reboot 時很可能整個裝置消失再出現，需要做 (b) 重連）
先不管你怎麼回答，我可以直接給你一版通用的防護修正（涵蓋錯誤攔截 + 可選重連）。以下是修好的 comm2.tcl：


1 tool call
Write File

comm2.tcl



Details
已修好。以下是為什麼會有 I/O error 以及改了什麼。

為什麼 reboot 會噴 I/O error
DUT 執行 reboot 時，序列線另一端的 UART 會重新初始化 —— 訊號線（DTR/RTS/DCD）抖動、埠短暫斷開。Windows 底層對這個 COM handle 的後續 read/eof 就會拋出 I/O error。你原本的程式在這幾個地方沒防護，錯誤就直接冒出來。

你原本程式的 3 個問題
1. read $ch 沒有 catch（最主要原因）

tcl

set data [read $ch]     ;# reboot 時這行直接拋 I/O error
fileevent callback 裡拋出未捕捉的錯誤，會讓 fileevent 停止運作，錯誤也冒到上層。

2. if { ![catch $ch err]} 是錯的寫法

tcl

if { ![catch $ch err]} {   ;# 把 channel handle "file3" 當指令去執行!
catch 的第一個參數是「要執行的 script」，你傳的是 channel handle（如 file3），Tcl 會試圖把它當指令執行，毫無意義。這行已移除。

3. append buffer $data 用了 local 變數

tcl

append buffer $data   ;# buffer 是 local, 每次進來都消失, 累加無效
改成 ::comm_buffer 全域變數。

改了什麼
位置	修正
_f_getconsole	eof 和 read 都包 catch，攔截 reboot I/O error
_f_transmit	送指令也包 catch（reboot 當下對方 UART 可能已關）
_f_waitfor	read 包 catch，reboot 期間錯誤忽略繼續等，並修正 buffer 累加
新增 _f_handle_io_error	統一處理：關舊 channel → 自動重連
新增 _f_reconnect_rs232	reboot 後重試開啟 COM port（最多 30 次，每秒一次）
_f_ConfigConsoleDisconnect	關閉前先解除 fileevent
兩種模式（用 ::comm_reconnect 切換）
tcl

set ::comm_reconnect 1    ;# reboot 後自動重連 (適合 USB-serial 會重新枚舉的情況)
set ::comm_reconnect 0    ;# 只忽略錯誤、關閉 channel (適合實體 COM port, 保持連線)
你需要確認的一件事
我需要知道你的序列裝置類型，才能建議正確模式：

實體主機板 COM port → reboot 時埠不會消失，設 ::comm_reconnect 0（純忽略錯誤即可），或甚至不需要關 channel
USB-to-Serial（FTDI/CP2102/PL2303 等） → DUT reboot/斷電時整個 USB 裝置可能消失再出現，需要 ::comm_reconnect 1（自動重連）
你的是哪一種？ 告訴我，我可以把邏輯再收斂得更精準（例如實體 COM port 其實連 channel 都不用關，只要清掉錯誤狀態繼續讀就好，不必重連）。

Est. Credits Used: 3.72
Elapsed time: 1m 28s


