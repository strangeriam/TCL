1 list 變數使用 2 個值
說明:
listspec 的 2 個值各自帶入 $spec_min 和 $spec_max .


set listitem [list low \
                    mid \
                    high \
                    default \
                    low]
set listspec [list 1100 2100 \
                    3400 4400 \
                    6750 8250 \
                    7200 8800 \
                    1100 2100]

foreach item $listitem {spec_min spec_max} $listspec {
    puts "item: $item --> spec: $spec_min ~ $spec_max"
}

;# 輸出:
item: low --> spec: 1100 ~ 2100
item: mid --> spec: 3400 ~ 4400
item: high --> spec: 6750 ~ 8250
item: default --> spec: 7200 ~ 8800
item: low --> spec: 1100 ~ 2100
