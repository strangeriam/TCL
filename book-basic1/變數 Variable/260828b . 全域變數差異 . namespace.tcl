出處: AWS Kiro AI
問題:
這 2 個 TCL 變數的差異在哪?
namespace eval ::app {
    variable version "1.0.0"
}
 
set ::version "1.0.0"

;# =========================================
這兩個變數的核心差異在於命名空間 (namespace)。

差異對照
tcl

namespace eval ::app {
    variable version "1.0.0"
}
# 變數完整名稱: ::app::version

set ::version "1.0.0"
# 變數完整名稱: ::version (全域命名空間)
項目	::app::version	::version
所在命名空間	::app (子命名空間)	:: (全域)
完整存取名	$::app::version	$::version
命名衝突風險	低 (被 app 隔離)	高 (全域共用)
宣告方式	variable	set
存取方式
tcl

# 存取 ::app::version
puts $::app::version

# 在 ::app 命名空間內可直接用短名
namespace eval ::app {
    puts $version
}

# 存取全域 ::version (任何地方)
puts $::version
variable vs set 的關鍵區別
在 namespace eval 區塊裡:

tcl

namespace eval ::app {
    variable version "1.0.0"   ;# 建立命名空間變數
    set other "test"          ;# 也是建立在 ::app::other
}
兩者在 namespace eval 內都會建立於該命名空間。但真正的差別出現在 proc 內部:

tcl

namespace eval ::app {
    variable version "1.0.0"

    proc show {} {
        # 必須先用 variable 宣告才能存取命名空間變數
        variable version
        puts $version         ;# 正確: 1.0.0

        # 如果沒宣告, 下面這行會找不到變數
        # puts $version       ;# 錯誤
    }
}
variable 在 proc 內是用來「連結」到命名空間變數的關鍵字, 類似 global 之於全域變數。

實務建議
用命名空間 (::app::version) 的好處:

避免污染全域 — 大型程式或多模組時不易撞名
模組化 — 相關變數/proc 集中管理
可封裝 — 搭配 namespace export 控制對外介面
全域變數 (::version) 適合:

小型腳本
確實需要跨模組共享的少數設定
以你之前的 iperf 工具為例, 若改用命名空間會像這樣:

tcl

namespace eval ::iperf {
    variable cfg
    variable state
}
# 存取: $::iperf::cfg(server_ip)
這樣就不會跟其他 source 進來的檔案 (如 tkcon) 撞到 ::cfg 或 ::state 全域變數。

Est. Credits Used: 0.73
Elapsed time: 19s



