- Enter 執行
    - 配合 bind.
    - invoke 的功能可以用來接執行 .btn2 本身 -command 裡的程式碼.
    ::ttk::button .btn1 -text "normal" -command {puts "normal"}
    ::ttk::button .btn2 -text "active" -default "active" -command {puts "active"}
    bind . <Return> { .btn2 invoke }
    pack .btn1 .btn2 -side left
