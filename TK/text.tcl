
set dialog_txt [text .myText -background red -foreground white -relief ridge -borderwidth 8 -padx 10 -pady 10 -font {Helvetica -18 bold} -width 20 -height 5]

## 第一筆文字.
$dialog_txt insert 1.0 "Hello\nWorld\n"

## 第二筆文字.
$dialog_txt insert 1.0 "Hello\nWorld\n"

## 最後一筆文字.
$dialog_txt insert end "A new line\n"

$dialog_txt tag configure para -spacing1 0.15i -spacing2 0.05i -lmargin1 0.25i -lmargin2 0.2i -rmargin 0.25i
$dialog_txt tag configure hang -lmargin1 0.30i -lmargin2 0.25i
$dialog_txt tag add para 1.0 2.end
$dialog_txt tag add hang 3.0 3.end

pack $dialog_txt


## 刪除內容文字.
$dialog_txt delete 1.0 end
