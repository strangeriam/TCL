- Syntax:  -textvariable + 變數名
- button 和 entry 一樣可以使用 -textvariable 選項來反應 button 上的顯示文字.
    e.g. 我們把 -textvariable 的值設定為變數 ::btnText,
            這樣只要用 set 命令改變 ::btnText 的內容, 那按鈕上面顯示的文字也會及時的改變.
    ::ttk::button .btn -textvariable ::btnText
- 關於-textvariable選項, 這個選項也是很多視窗元件都會提供的選項.
