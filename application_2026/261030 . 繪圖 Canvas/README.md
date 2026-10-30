# Tcl/Tk 多執行緒即時繪圖曲線 — 程式教學

這份範例示範如何用 **Tcl/Tk + Thread 套件**做一個「背景執行緒持續產生資料、主執行緒即時畫曲線」的程式。這是儀器量測、即時監控、訊號視覺化的常見架構。

## 執行

```
wish plot_thread.tcl
```

需求：Tcl/Tk 8.6+ 且有 **Thread** 套件（Magicsplat Tcl/Tk 或 ActiveTcl 內建）。

畫面：上方有「開始 / 暫停 / 清除」按鈕，下方 Canvas 即時畫出一條 sin 波 + 雜訊的曲線。

---

## 一、為什麼需要多執行緒？

### 問題：單執行緒會「卡住 UI」

如果資料產生（量測、運算）跟畫圖都在同一個執行緒，而資料產生很耗時，UI 就會凍結——按鈕按不動、視窗無法拖曳，因為程式忙著算資料，沒空回應 GUI 事件。

### 解法：分工

```
┌─────────────────────┐   資料 (thread::send)   ┌──────────────────────┐
│  Worker Thread       │ ──────────────────────> │  Main / GUI Thread   │
│  (背景執行緒)        │                          │  (主執行緒)          │
│                      │                          │                      │
│  - 持續算資料        │                          │  - Tk 視窗 / 按鈕    │
│  - 不碰 GUI          │                          │  - Canvas 畫曲線     │
└─────────────────────┘                          └──────────────────────┘
```

- **Worker**：只負責「算資料」，算完把資料送出去，不碰任何 GUI。
- **Main**：負責 GUI 和畫圖，收到資料才更新畫面。

這樣耗時的運算在背景跑，UI 永遠保持流暢。

---

## 二、關鍵觀念：Tk 不是 thread-safe

**最重要的規則：Tk 的 GUI 元件（視窗、Canvas、按鈕）只能在「建立它的那個執行緒」操作。**

所以 worker thread **絕對不能**直接去畫 Canvas 或改按鈕。它只能把資料「送回」主執行緒，由主執行緒來畫。這就是為什麼要用 `thread::send`。

---

## 三、程式架構逐段解說

### 1. 建立 Worker Thread

```tcl
set tid [thread::create -preserved {
    ;# 這個 {} 裡的程式碼在新執行緒內執行
    set ::go 0
    proc gen_one {} { ... }
    proc worker_start {} { set ::go 1 }
    proc worker_stop  {} { set ::go 0 }
    thread::wait        ;# 進入事件迴圈
}]
```

- `thread::create { ... }`：建立新執行緒，大括號裡是**在新執行緒內執行**的程式碼。
- `-preserved`：執行緒不會因閒置被自動回收。
- **每個 thread 有自己獨立的變數、proc 空間**——worker 的 `$::go`、`gen_one` 跟主 thread 完全隔離。
- `thread::wait`：**必須有這行**。它讓 thread 進入事件迴圈，`after` 和 `thread::send` 才會運作。沒有它，thread 執行完就結束了。

### 2. 讓 Worker 知道「資料要送回哪裡」

```tcl
thread::send $tid [list set ::main [thread::id]]
```

- `[thread::id]`（在主 thread 呼叫）= 主執行緒的 id。
- 把它設進 worker 的 `::main` 變數，worker 才知道資料要送回主 thread。

### 3. Worker 產生資料並送回

```tcl
proc gen_one {} {
    if {!$::go} { after 100 gen_one; return }   ;# 暫停中就等

    set val [expr {sin($t) + (rand()-0.5)*0.3}] ;# 算一個資料點

    thread::send -async $::main [list on_data $::seq $val]  ;# 送回主 thread

    after 50 gen_one                             ;# 50ms 後算下一個
}
```

- `thread::send -async $target $script`：叫**目標 thread**執行一段 script。
- **`-async`（非同步）很重要**：送出後 worker 不等對方做完，立刻繼續算下一筆。若用同步（不加 `-async`），worker 會卡住等主 thread 畫完，失去平行的意義。
- `[list on_data $seq $val]`：要主 thread 執行 `on_data <seq> <val>`。用 `list` 包起來可正確處理含空白的參數。
- `after 50 gen_one`：排程 50ms 後再呼叫自己 → 形成 20Hz 的取樣迴圈。**注意這是靠事件迴圈的 `after`，不是 `while` 迴圈**，所以不會把 thread 占滿。

### 4. 主執行緒接收資料

```tcl
proc on_data {seq val} {
    lappend ::state(data) $val       ;# 存資料
    ;# 超過上限捨棄最舊的 (曲線向左捲動)
    if {[llength $::state(data)] > $::CFG(maxpts)} {
        set ::state(data) [lrange $::state(data) end-...]
    }
    draw_curve                       ;# 重畫
}
```

- 這個 proc 雖然是 worker「叫」的，但因為 `thread::send` 的目標是主 thread，所以它**實際在主 thread 執行**——因此這裡操作 Tk（`draw_curve`、改 label）是安全的。
- 保留最近 N 點，超過就丟最舊的 → 曲線像心電圖一樣向左捲動。

### 5. 畫曲線（Canvas 座標轉換）

重點是「資料值」→「畫面像素」的轉換：

```tcl
;# X: 第 i 個點平均分布在寬度上
set x [expr {$M + $pw * $i / double($maxpts-1)}]

;# Y: 資料值映射到高度 (螢幕 Y 上小下大, 要翻轉)
set ratio [expr {($v - $ymin) / ($ymax - $ymin)}]
set y [expr {$M + $ph * (1.0 - $ratio)}]
```

- `ratio` 把資料值正規化成 0~1。
- `(1.0 - $ratio)`：因為螢幕座標 Y 往下增加，而我們要「值越大畫越上面」，所以翻轉。
- `$cv create line $pts -smooth true`：把所有點連成平滑曲線。

---

## 四、三種 thread 通訊方式對照

| 方式 | 說明 | 本範例用途 |
|------|------|-----------|
| `thread::send -async` | 非同步：送出不等結果 | worker 回傳資料、主 thread 下控制指令 |
| `thread::send`（同步） | 等對方執行完才返回 | 初始化設定 `::main` 時用 |
| `tsv`（shared variable） | 跨 thread 共享變數 | 本範例沒用，適合大量狀態共享 |

**通則**：資料流用 `-async`（不阻塞），一次性設定用同步。

---

## 五、常見陷阱

| 陷阱 | 說明 | 解法 |
|------|------|------|
| worker 直接畫 Canvas | Tk 非 thread-safe，會崩潰或行為異常 | 一律用 `thread::send` 把資料送回主 thread 畫 |
| 忘了 `thread::wait` | thread 執行完就死，`after`/`send` 不運作 | worker 結尾一定要 `thread::wait` |
| 用 `while 1` 產生資料 | 占滿 thread，`send` 進不來 | 改用 `after` 排程（事件驅動） |
| 同步 `send` 造成互等 | worker 等主 thread、主 thread 又忙 → 卡死 | 資料流用 `-async` |
| 關閉程式沒清 thread | thread 殘留 | `WM_DELETE_WINDOW` 裡 `thread::release` |

---

## 六、如何改成你自己的應用

把 `gen_one` 裡這行換成你的真實資料來源：

```tcl
;# 原本 (模擬):
set val [expr {sin($t) + (rand()-0.5)*0.3}]

;# 改成讀真實資料, 例如:
;#   - 讀序列埠感測器
;#   - 讀檔案 / 網路
;#   - 跑一段耗時運算的結果
set val [你的量測函式]
```

其他架構（送回、畫圖、捲動）都不用改。這就是分層設計的好處——**資料來源**和**視覺化**解耦。

---

## 七、延伸方向

- **多條曲線**：worker 送回多個值，主 thread 畫多條線（不同顏色）。
- **多個 worker**：每個感測器一個 worker thread，各自送資料回來。
- **存檔**：`on_data` 裡順便寫 CSV。
- **Y 軸自動縮放**：依資料最大最小值動態調整 `ymin/ymax`。

---

## 檔案

| 檔案 | 說明 |
|------|------|
| `plot_thread.tcl` | 主程式（可直接 `wish` 執行） |
| `README.md` | 本教學 |
