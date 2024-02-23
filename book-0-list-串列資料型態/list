set list1 [list motocycle car bus truck airplane cablecar]

## Application
set var [lindex $list1 end-2]
set var [lrange $list1 1 3]

## 在清單裡插入一新字串 taxi.
set var [linsert $list1 2 taxi]

## 清單內字串數.
set var [llength $list1]

## 在清單 $list1 後面加入字串 all, I don’t like.
lappend list1 all, I don't like


通常我們會把 list 與 foreach 結合運用。例如底下的 foreach迴圈列出環境變數的名稱及內容(array names 可取出指定陣列的所有 index)：
% foreach index [array names env] { 
    %     puts “$index = $env(index)”
    % }
    =>OS = Windows NT
    =>windir = C:\Windows
    =>ComSpec = C:\WINDOWS\system32\cmd.exe
    =>(略)

利用 foreach 與 list 寫個 join 指令：
proc join {list sep{} } {
   set s {}  ;# s is the current separator
   set result {}
   foreach x $list {
      append result $s $x
      set s $sep
   }
   return $result
}
