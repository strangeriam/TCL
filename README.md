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
