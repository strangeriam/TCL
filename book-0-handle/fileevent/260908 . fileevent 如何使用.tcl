fileevent 如何使用

Kiro
fileevent 是 Tcl 用來做非阻塞 I/O 的核心指令，
讓你在 channel（檔案、pipe、socket、serial port）有資料可讀或可寫時自動觸發 callback，
而不需要用 read/gets 阻塞等待。這正是你 iperf 工具跟 SSH/RS232 溝通時不卡住 UI 的關鍵。

基本語法
fileevent channelId readable ?script?
fileevent channelId writable ?script?

參數         說明
channelId	  開啟的 channel（open 或 socket 回傳的 fd）
readable	  當 channel 有資料可讀時觸發
writable	  當 channel 可寫時觸發
script	    要執行的 callback；省略則回傳目前綁定的 script

三個前置條件（缺一不可）
;# 1. channel 必須設為非阻塞
fconfigure $fd -blocking 0

;# 2. 綁定 readable 事件到 handler
fileevent $fd readable [list read_handler $fd]

;# 3. 程式必須進入事件迴圈 (Tk 的 wish 自動有；純 tclsh 需 vwait)
最重要：fileevent 只在事件迴圈運作時才會觸發。 Tk (wish) 天生就有事件迴圈；純 tclsh 則要用 vwait 或 after 進入。

完整範例（讀取 pipe，對應你的 SSH 情境）


;# 開啟 SSH pipe
set fd [open "| plink -ssh root@192.168.10.1" r+]

;# 設非阻塞 + 行緩衝
fconfigure $fd -blocking 0 -buffering line -translation auto

;# 綁定讀取事件
fileevent $fd readable [list on_readable $fd]

proc on_readable {fd} {
    ;# 一定要檢查 EOF（連線關閉）
    if {[eof $fd]} {
        fileevent $fd readable {}   ;# 解除綁定
        catch {close $fd}
        puts "連線已關閉"
        return
    }

    ;# 讀一行（非阻塞下 gets 回傳 -1 表示還沒有完整一行）
    if {[gets $fd line] >= 0} {
        puts "收到: $line"
        ;# 這裡處理資料，例如解析 iperf throughput
    }
}
關鍵重點
1. callback 裡一定要檢查 eof 非阻塞 channel 關閉時，fileevent 會持續觸發 readable。若不檢查 eof 並解除綁定，會造成無窮迴圈：
if {[eof $fd]} {
    fileevent $fd readable {}   ;# 用空字串解除
    close $fd
    return
}

2. 非阻塞下 gets 的回傳值
set n [gets $fd line]
;# n >= 0 : 讀到完整一行 (n = 字元數)
;# n <  0 : 沒讀到完整行 (可能還沒到，或 EOF)
所以要搭配 if {[gets $fd line] >= 0} 判斷。

3. 用 read 一次讀全部（適合大量或無行結構資料）
proc on_readable {fd} {
    if {[eof $fd]} { fileevent $fd readable {}; close $fd; return }
    set data [read $fd]        ;# 非阻塞下讀取目前所有可讀資料
    if {$data ne ""} {
        # 處理 data
    }
}

4. 解除綁定

fileevent $fd readable {}   ;# 傳空字串即可解除
對照你的 DUTxTIP / iperf 專案
你目前 DUTxTIP.tcl 是用 _f_waitor / _f_waitfor 這種同步等待模式（阻塞直到看到特定字串）。
而 fileevent 是非同步模式，兩者用途不同：

模式	        適用場景
_f_waitfor     (同步阻塞)	一問一答、照順序的測試流程（等 prompt → 送指令 → 等回應）
fileevent       (非同步)	需要 UI 同時反應、長時間監聽、多 channel 並行（如 iperf 即時 throughput 顯示）

你的 iperf 工具就是用 fileevent 才能一邊跑測試、一邊即時更新儀表、UI 不凍結：

proc fallback_readable {fd role} {
    if {[eof $fd]} {
        fileevent $fd readable {}
        log_msg "$role connection closed (EOF)"
        return
    }
    if {[gets $fd line] >= 0} {
        set line [string trim $line \r]
        if {$line eq ""} return
        on_comm_data $role $line   ;# 解析 iperf 輸出、偵測 prompt
    }
}

純 tclsh 需要事件迴圈
如果不是用 wish（沒有 Tk），要自己啟動事件迴圈：

set ::done 0
fileevent $fd readable {
    if {[eof $fd]} { set ::done 1; return }
    ...
}
vwait ::done   ;# 進入事件迴圈，直到 ::done 被設值
writable 的用法（較少用）
當你要送大量資料、怕 buffer 塞滿時：

fileevent $fd writable [list on_writable $fd]
proc on_writable {fd} {
    puts $fd $data
    fileevent $fd writable {}   ;# 送完就解除，避免一直觸發
}

一般小量指令直接 puts $fd $cmd; flush $fd 即可，不太需要 writable。

一句話總結 fileevent = 
「當 channel 有資料時自動叫我的 handler」，搭配 fconfigure -blocking 0 和事件迴圈，
就能做到不阻塞、UI 不凍結的即時 I/O。
記得 callback 裡必檢查 eof 並在關閉時解除綁定。

Est. Credits Used: 1.56
Elapsed time: 41s
