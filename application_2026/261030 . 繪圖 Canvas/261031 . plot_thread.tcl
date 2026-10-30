#!/usr/bin/env wish
encoding system utf-8
;############################################################################
;# plot_thread.tcl - Tcl/Tk 多執行緒即時繪圖曲線範例
;#---------------------------------------------------------------------------
;# 架構:
;#   主執行緒 (Main / GUI thread) : 負責 Tk 視窗、Canvas 繪圖
;#   工作執行緒 (Worker thread)   : 負責產生資料 (模擬感測器/量測)
;#
;# 為什麼要分兩個 thread?
;#   Tk 的 GUI 只能在「建立它的那個 thread」操作 (Tk 不是 thread-safe)。
;#   所以: Worker 只「算資料」, 算完把資料「送」回主 thread, 由主 thread 畫。
;#   這樣耗時的資料產生不會卡住 UI, 曲線能流暢更新。
;#
;# 需求: Tcl/Tk 8.6+ 且有 Thread 套件 (Magicsplat/ActiveTcl 內建)
;# 執行: wish plot_thread.tcl
;############################################################################

package require Tk
package require Thread

;############################################################################
;# 全域設定與狀態
;############################################################################
set ::CFG(width)    700      ;# 繪圖區寬
set ::CFG(height)   360      ;# 繪圖區高
set ::CFG(margin)   40       ;# 邊界
set ::CFG(maxpts)   200      ;# 曲線最多保留幾個點 (超過就捲動)
set ::CFG(ymin)     -1.2     ;# Y 軸範圍
set ::CFG(ymax)     1.2

set ::state(running)  0      ;# 是否正在取樣
set ::state(worker)   ""     ;# worker thread id
set ::state(data)     {}     ;# 收到的資料點 (y 值序列)
set ::state(count)    0      ;# 已收樣本數

;############################################################################
;# 建立 Worker Thread (資料產生器)
;#---------------------------------------------------------------------------
;# Worker 做的事:
;#   1. 每隔一段時間算一個新資料點 (這裡用 sin 波 + 雜訊模擬)
;#   2. 用 thread::send -async 把資料「非同步」送回主 thread
;#   3. 受 ::go 旗標控制, 可暫停/繼續
;############################################################################
proc create_worker {} {
    ;# 建立一個新執行緒 (-preserved: 不會因閒置被回收)
    set tid [thread::create -preserved {

        ;# ---- 以下程式碼在「worker thread 內部」執行 ----
        set ::go  0           ;# 1=取樣中, 0=暫停
        set ::seq 0           ;# 樣本序號
        set ::main ""         ;# 主 thread id (稍後由主 thread 設定)

        ;# 產生一個資料點並送回主 thread
        proc gen_one {} {
            if {!$::go} {
                ;# 暫停時, 每 100ms 檢查一次是否恢復
                after 100 gen_one
                return
            }

            ;# --- 這裡模擬「量測/計算」一個資料點 ---
            ;# 用 sin 波 + 隨機雜訊, 你可換成真實感測器讀值
            set t    [expr {$::seq * 0.1}]
            set val  [expr {sin($t) + (rand() - 0.5) * 0.3}]
            incr ::seq

            ;# 把資料「非同步」送回主 thread 的 on_data 程序
            ;# -async = 送出後不等待, worker 立刻繼續
            thread::send -async $::main [list on_data $::seq $val]

            ;# 排程下一個資料點 (50ms 後), 模擬取樣率 20Hz
            after 50 gen_one
        }

        ;# 控制指令 (由主 thread 呼叫)
        proc worker_start {} { set ::go 1 }
        proc worker_stop  {} { set ::go 0 }

        ;# 進入事件迴圈 (thread 必須有這行, after/send 才會運作)
        thread::wait
    }]

    ;# 把「主 thread 的 id」告訴 worker, 它才知道資料要送回哪裡
    thread::send $tid [list set ::main [thread::id]]

    ;# 啟動 worker 的資料產生迴圈
    thread::send -async $tid [list gen_one]

    return $tid
}

;############################################################################
;# 主執行緒: 接收 worker 送來的資料
;#---------------------------------------------------------------------------
;# 這個 proc 由 worker 透過 thread::send -async 呼叫,
;# 但它「實際執行」是在主 thread (因為 send 的目標是主 thread)。
;# 所以在這裡操作 Tk 元件是安全的。
;############################################################################
proc on_data {seq val} {
    ;# 加入資料序列
    lappend ::state(data) $val
    incr ::state(count)

    ;# 超過上限就捨棄最舊的點 (曲線向左捲動)
    if {[llength $::state(data)] > $::CFG(maxpts)} {
        set ::state(data) [lrange $::state(data) end-[expr {$::CFG(maxpts)-1}] end]
    }

    ;# 更新數值顯示 + 重畫曲線
    .top.info configure -text "樣本數: $::state(count)    最新值: [format %.3f $val]"
    draw_curve
}

;############################################################################
;# 繪製曲線 (Canvas)
;############################################################################
proc draw_curve {} {
    set cv .plot
    $cv delete all

    set W   $::CFG(width)
    set H   $::CFG(height)
    set M   $::CFG(margin)
    set pw  [expr {$W - 2*$M}]        ;# 繪圖內部寬
    set ph  [expr {$H - 2*$M}]        ;# 繪圖內部高

    ;# ---- 畫座標軸外框 ----
    $cv create rectangle $M $M [expr {$W-$M}] [expr {$H-$M}] -outline "#888"

    ;# ---- 畫 Y 軸格線與刻度 ----
    for {set i 0} {$i <= 4} {incr i} {
        set y   [expr {$M + $ph * $i / 4.0}]
        set val [expr {$::CFG(ymax) - ($::CFG(ymax)-$::CFG(ymin)) * $i / 4.0}]
        $cv create line $M $y [expr {$W-$M}] $y -fill "#eee"
        $cv create text [expr {$M-5}] $y -anchor e \
            -text [format %.1f $val] -font {Arial 8} -fill "#666"
    }

    ;# ---- 把資料點轉成畫面座標並連線 ----
    set n [llength $::state(data)]
    if {$n < 2} return

    set pts {}
    for {set i 0} {$i < $n} {incr i} {
        set v [lindex $::state(data) $i]

        ;# X: 依點的序位平均分布在繪圖寬度上
        set x [expr {$M + $pw * $i / double($::CFG(maxpts)-1)}]

        ;# Y: 把資料值 (ymin~ymax) 映射到畫面高度 (注意 Y 軸螢幕是上小下大, 要翻轉)
        set ratio [expr {($v - $::CFG(ymin)) / ($::CFG(ymax) - $::CFG(ymin))}]
        set y [expr {$M + $ph * (1.0 - $ratio)}]

        lappend pts $x $y
    }

    ;# 畫平滑曲線
    $cv create line $pts -fill "#2980b9" -width 2 -smooth true

    ;# 標出最新點
    set lx [lindex $pts end-1]
    set ly [lindex $pts end]
    $cv create oval [expr {$lx-4}] [expr {$ly-4}] [expr {$lx+4}] [expr {$ly+4}] \
        -fill "#e74c3c" -outline ""
}

;############################################################################
;# 控制按鈕動作
;############################################################################
proc do_start {} {
    if {$::state(running)} return

    ;# 第一次按才建立 worker thread
    if {$::state(worker) eq ""} {
        set ::state(worker) [create_worker]
    }

    set ::state(running) 1
    thread::send -async $::state(worker) [list worker_start]

    .top.btn_start configure -state disabled
    .top.btn_stop  configure -state normal
    .top.status    configure -text "狀態: 取樣中" -foreground "#27ae60"
}

proc do_stop {} {
    if {!$::state(running)} return
    set ::state(running) 0
    thread::send -async $::state(worker) [list worker_stop]

    .top.btn_start configure -state normal
    .top.btn_stop  configure -state disabled
    .top.status    configure -text "狀態: 已暫停" -foreground "#e67e22"
}

proc do_clear {} {
    set ::state(data)  {}
    set ::state(count) 0
    draw_curve
    .top.info configure -text "樣本數: 0    最新值: --"
}

;############################################################################
;# 建立 GUI
;############################################################################
proc build_gui {} {
    wm title . "Tcl/Tk 多執行緒即時曲線"
    wm resizable . 0 0

    ;# ---- 頂部控制列 ----
    frame .top
    pack .top -fill x -padx 8 -pady 6

    button .top.btn_start -text "開始" -width 8 -command do_start \
        -bg "#27ae60" -fg white
    button .top.btn_stop  -text "暫停" -width 8 -command do_stop \
        -bg "#e67e22" -fg white -state disabled
    button .top.btn_clear -text "清除" -width 8 -command do_clear \
        -bg "#7f8c8d" -fg white
    label  .top.status -text "狀態: 就緒" -font {Arial 10 bold}
    pack .top.btn_start .top.btn_stop .top.btn_clear -side left -padx 3
    pack .top.status -side right -padx 8

    ;# ---- 資訊顯示 (樣本數 / 最新值), on_data 與 draw 會更新它 ----
    label .top.info -text "樣本數: 0    最新值: --" -font {Consolas 10}
    pack .top.info -side left -padx 15

    ;# ---- 繪圖 Canvas ----
    canvas .plot -width $::CFG(width) -height $::CFG(height) \
        -bg white -highlightthickness 1 -highlightbackground "#bdc3c7"
    pack .plot -padx 8 -pady 6

    draw_curve
}

;############################################################################
;# 關閉時清理 thread
;############################################################################
proc on_exit {} {
    if {$::state(worker) ne ""} {
        catch { thread::send -async $::state(worker) [list worker_stop] }
        catch { thread::release $::state(worker) }
    }
    exit
}

;############################################################################
;# 啟動
;############################################################################
build_gui
wm protocol . WM_DELETE_WINDOW on_exit
