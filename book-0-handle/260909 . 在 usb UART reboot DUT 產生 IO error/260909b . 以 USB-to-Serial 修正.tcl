以 USB-to-Serial 修正

Kiro
USB-to-Serial 的情況比較特殊：DUT reboot（或斷電）時，如果 USB-serial 轉接器是由 DUT 供電或跟著 DUT 一起斷電，整個 USB 裝置會從 Windows 消失再重新枚舉。這代表：

舊的 COM handle 完全失效，必須 close 掉，不能沿用
COM port 在裝置消失期間根本不存在，open 會失敗（找不到裝置），要重試等它回來
裝置重新枚舉後，COM 埠號可能改變（例如 COM8 變 COM9）—— 這是 USB-serial 最麻煩的地方
讓我針對 USB-to-Serial 重寫，處理上述三點。


1 tool call
Read File

comm2.tcl
現在針對 USB-to-Serial 特性重寫。關鍵改進：

偵測 COM 埠是否重新枚舉成不同埠號（用註冊表 HKLM\HARDWARE\DEVICEMAP\SERIALCOMM 查目前存在的 COM 埠）
等裝置消失再重新出現，而不是盲目重試同一個埠號
用 VID/PID 或裝置描述鎖定是「同一顆」USB-serial（避免接到別的裝置）
重連成功後回填新的 channel，並可選擇通知上層

1 tool call
Write File

comm2.tcl



Details
已針對 USB-to-Serial 特性重寫完成。

USB-to-Serial 的關鍵差異（跟實體 COM port 不同）
情況	實體 COM port	USB-to-Serial
DUT reboot 時	埠還在，只是訊號抖動	整個裝置從 Windows 消失
舊 handle	可能還能用	完全失效，必須 close
重新出現後	同一個埠號	埠號可能改變（COM8→COM9）
open 重試	直接重開就好	要等裝置枚舉回來才開得成
主要修正內容
1. 偵測裝置消失並等它回來 _f_handle_io_error 關掉失效的 handle，進入 _f_reconnect_usb_serial 流程，每秒重試、最多 60 次（給 USB 枚舉足夠時間）。

2. 支援埠號改變（USB-serial 最麻煩的點） _f_list_serial_ports 掃描註冊表 HKLM\HARDWARE\DEVICEMAP\SERIALCOMM，列出目前真正存在的 COM 埠。若原本的 COM8 不見了，就用新出現的埠：

tcl

set ::comm_allow_port_change 1    ;# 允許埠號改變
3. 用 VID/PID 精準鎖定同一顆轉接器（選用，最穩） 若治具上有多個 USB-serial，避免接錯，可設定：

tcl

set ::comm_match_hint "VID_10C4&PID_EA60"   ;# CP2102
set ::comm_match_hint "FTDI"                 ;# 或用描述關鍵字
_f_find_port_by_hint 用 PowerShell WMI 找對應描述的埠。

4. 重連狀態鎖 ::comm_reconnecting 避免 reboot 瞬間多個 fileevent 同時觸發、重複進入重連。重連期間舊 channel 的事件一律忽略。

5. _f_waitfor 改用全域 buffer 因為 reboot 後 channel 會被換成新的，_f_waitfor 不能再抓著舊 $ch 讀。改成比對事件驅動累積的 ::comm_buffer（重連後 _f_getconsole 仍會把新資料 append 進去），跨 reboot 也能正確等到 prompt。

新增的實用功能：重連後自動重登入
DUT reboot 後通常要重新登入。你可以掛個 callback：

tcl

_f_set_reconnect_callback {apply {{ch port} {
    puts "COMM2: 重連成功於 $port, 重新登入..."
    after 3000
    _f_transmit $ch "root\r"
    _f_transmit $ch "openwifi\r"
}}}
建議設定
tcl

set ::comm_reconnect         1     ;# 開啟自動重連
set ::comm_allow_port_change 1     ;# USB-serial 埠號會變, 開啟
set ::comm_match_hint        ""    ;# 治具只有一顆轉接器就留空; 多顆才填 VID/PID
需要確認
你的 USB-serial 晶片是哪家？（CP2102 / FTDI / PL2303 / CH340）— 若治具上有多個 serial 裝置，我可以幫你查對應的 VID/PID 填進 match_hint
DUT reboot 時，USB-serial 轉接器會不會跟著斷電？ 如果轉接器是獨立供電（不隨 DUT 斷電），那它其實不會消失，情況會單純很多（只需忽略短暫 I/O error，不需重連整個裝置）——這種情況要告訴我，我可以簡化。
要我幫你查特定晶片的 VID/PID，或針對「轉接器獨立供電」的情況再調整嗎？

Est. Credits Used: 4.02
Elapsed time: 1m 44s


Checkpoint
Restore
不需要查特定 chip, 讓我先研究你的 code, thanks.

Kiro
沒問題，你慢慢研究。

快速給你幾個看 code 時的重點提示：

主流程：_f_getconsole（fileevent 觸發）→ 偵測到 I/O error → _f_handle_io_error（關舊 channel）→ _f_reconnect_usb_serial（等裝置回來、重開、重掛事件）
埠號改變由 _f_list_serial_ports（讀註冊表）處理，靠 ::comm_allow_port_change 開關控制
::comm_reconnecting 是防重入鎖，reboot 瞬間會有多個 event 同時進來，靠它擋掉重複重連
_f_waitfor 改用 ::comm_buffer 的原因：reboot 後 channel 物件會被換掉，舊的 $ch 不能再讀
有兩個地方你實測時可以留意可能要微調：

_f_reconnect_usb_serial 裡的重試次數/間隔（目前 60 次 × 1 秒 = 最多等 60 秒），依你的 DUT 開機時間調整
_f_list_serial_ports 需要 registry 套件（ActiveTcl/Magicsplat 內建），若沒有會自動 fallback 到 reg.exe 命令列
有任何問題或要調整再找我。

Est. Credits Used: 0.9
Elapsed time: 12s
