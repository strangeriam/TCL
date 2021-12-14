configure
- Button
    Button 可使用 -textvariable + 變數名 來變更  Button 上的文字.
    也可使用 configure. 
    e.g. 按下 btn2 將  btn1 的 “Hello” 換成 “Hi”.
    ::ttk::button .btn1 -text "Hello"
    ::ttk::button .btn2 -text "Change" -command {.btn1 configure -text "Hi" }
    pack .btn1 .btn2


cget
- Button
    configure 用來設定特定選項的值, 而 cget 剛好反過來, 取得按鈕的選項值.
    e.g. 
    ::ttk::button .btn1 -text "Hello"
    ::ttk::button .btn2 -text "Change" -command { puts [.btn1 cget -text] }
    pack .btn1 .btn2
