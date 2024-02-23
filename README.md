TCL 的全名為 Tool Command Language, 唸作 ”Tickle”.
事實上它是一個 Scripting Language（俗稱劇本語言或腳本語言）, 也是一個直譯器 (Interpreter).

TCL 的身份如同 UNIX 裡的 Shell languages,
像是 Bourne Shell (sh)、C Shell (csh)、Korn Shell (ksh) 與 Perl一樣, 用來執行與控制系統上的程式.
TCL 具備足夠的程式化能力 (variable、flow control、procedure) 與存取檔案、程序 (Process) 及網路的功能, 供組裝既有軟體元件以建立符合需求的新工具.

可內嵌 (embed) 到應用程式中, 讓軟體使用者透過程式員提供的高階 TCL 指令, 自訂應用程式的行為.

強大的字串處理能力『常規表示式 (Regular Expressions)』, 用來
搜尋、比對、粹取、取代符合樣式 (patter) 的複雜字串.

可用 C 語言開發 TCL Extension Library, 擴充 TCL 的指令與能力, 例如
Tk extension 讓 TCL 擁有 GUI Programming 的功能
expect extension 用來開發可與應用程式互動式溝通的程式

已有一大堆可在各式場合發揮效用的 package, 諸如各種
網路應用(ftp, http、email, dns, msn, icq 等)
圖形化介面開發 (TK, BWidget, Tktable, SpecTCL, VisualTCL, ActiveState KOMODO)
物件導向程式開發 (incrTcl, XOTcl, SNIT 等)
資料庫程式開發 (MetaKit, daFT 等)



置換與群組處理 (Substitution and Grouping)

TCL 指令的參數是以空白字元分隔, 可以使用雙引號或大括號將多個元素組成一個參數.

{ }
如果是以大括號組出一個參數, TCL 不會對括住的內容進行任何置換, 在對應的結束大括號 出現前, 任何字元都將視為參數的一部份, 包含換行符號、分號或是內部巢狀的大括號.

" "
如果是以雙引號組出一個參數, 則在對應的結束雙引號出現前, 雙引號中的內容會被 TCL 進行置換動作.

"$arg"
如果參數或是雙引號內的單字是以變數符號 $ 為開頭, 則 TCL 為會進行變數的置換.

"[set arg "hello world"]"
如果參數或是雙引號中有中括號, 則在對應的中括號出現前, TCL 會對中括號中的內容進行指令的置換.

因為 TCL 是以空白字元作為參數分隔符號, 因此要避免下列的錯誤：
if {$x > 1}{puts $x}
        ^ 在此加上一個空白字元, 隔開 if 指令的第二及第三個參數.
