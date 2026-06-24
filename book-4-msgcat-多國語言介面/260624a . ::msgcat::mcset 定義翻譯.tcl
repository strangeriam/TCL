package require msgcat
定義翻譯 --> ::msgcat::mcset zh_tw "Hello" "你好"
目前系統語系 --> ::msgcat::mclocale zh_tw
呼叫翻譯 --> puts [::msgcat::mc "Hello"] --> 輸出: 你好

語系檔
a1. 副檔名為 .msg
a2. 全部小寫
a3. 檔名: en.msg , zh_tw.msg , vi_vn.msg , zh_cn


Syntax --> ::msgcat::mcset locale src-string ?translate-string?

Parameter
locale -->
  . en : 英文
  . zh_tw : 繁體中文
  . zh_cn : 簡體中文
  . vi_vn : 越南文
src-string --> 預設英文字串
translate-string --> (option) 對應的翻譯字串. 如省略此參數, Tcl 會直接使用 src-string 作為翻譯值.

::msgcat::mcset en "Hello, World!"
::msgcat::mcset vi_vn {Please Check LED if ON} {Vui lòng kiểm tra đèn LED nếu BẬT}
::msgcat::mcset zh_tw "Hello, World!" "哈囉，世界！"
