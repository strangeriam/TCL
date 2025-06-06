Escape sequence
        / Description             / result
\n      . New line                . puts "Hello\nWorld"
                                  輸出: Hello
                                        World

\r      . Carriage return         . 結果與 \n 一樣
\t      . Horizontal tab          . "Hello   World" 像是兩字之間按了 tab 健一樣的空白.
\v      . Vertical tab            . "Hello^KWorld" 多了 ^K
\a      . Alert or bell (audible) . "發出聲音"
\b      . Backspace               . "HellWorld" 消除 \b 的前一個字母, Hello 的 o 不見了.
\f      . From feed (page break)  . 沒變

