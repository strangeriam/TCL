目的: 比對 License 是否過期.

set get_info {
sw-license/1.1
Name: NTC
CPU-MAC-Address: A0-1A-E3-2D-ED-B8
Project-Number: ECS5550
Accept-Mode: *
License-Number: 371ae45e-5c55-4d04-8bad-8747a200d903
License-Issue-Date: Tue Feb 24 08:15:13 2026
License-Valid-Start-Date: Tue Feb 24 00:00:00 2026
License-Valid-End-Date: Sun May 24 00:00:00 2026
License-Profile: Essential, cloud-m
License-Profile-Digest: da407b2c4c92090ced9e3b9c5f8747ab
License-Access-List: 0eLt7Lj3Uzp/+zjbVTXM3OMiWbjka3qhCVmdZN8KaNSb0ohuJXP0Q1lLhXNfn9QoLCjfejeA+et2Wrj3QkRo+Htkqqyoh9sfn/Dc2B0wOYDSt2uGWS9ujY1+LDjzLCIvIvWmJuE65VCjQ/fz9sMqASyJqcnUnpNguXUzCgYb4P21qFGXpfzVbyjIAnfKnGoT14PdAbvjCZNd+QVHrxYxFsfDKdOPK6ECVVbPfj9UsOdHQZyX+Sf4a0gI9X8+4grfjtAyV3ELq4y1KVkKD5OuUVYkPpUoZ7K5iH12fty504CbSnuT9/29ts6usFzmGlKbS5/n74tdqxZCHf+kgwsT+4GJ13H7zbqoNHKJTtpHVo6zYlP66aOLHA66xE6X56PRdHj61i+nLQTnTkFEuaUf6fFmkAyI67ZgHjCfrRo/A4gCON+xbo8HIUlRZxNWuC5qE47q7vdDFYRyNbY0gtPsqQ==
Signature1: E99o/U7faFCQ9K0BGOh3Kt0e6jTzSaqdl2LQVWWzmtI/AE27FjpACfFShbuVgUc83Vdj2nIeCU7vfLhmYyWXTvTtACeHVbnEvcatR7WR3V7xcra8WaG84e1y09M5l7fwHRJt10UV8JgbFLdjzVpB4gDY3vCiFJVweY7N19ecRrxm9J4FeIgM/ZnO+jJtIBI2126k5tr+KhhR1oJ/yJLAZrLMb4YOBNn9KQ1HXHrH9BLBtUT02OnI19oETBtmcmv/DOeve0jWQLQvIbz0EhZVPo7SwCVZ85HPrgKMxGnfILMdq12T2G8EYflRJ9aqsdJpYXpf6WVah7rY2EuoQmHleg==
Signature2: Ka4CKl0dOYhWfOcQHkb+iiSNGkR/cDKQ9nRu4LUXSTVJEmBcTywBfsVkzmlRmXUUb2DSA3YNfIGJ5aaJTtCkmHodQ+UTtmu4kCfBuxpE0Ujs98iIFWObxEwlWx5gWRhhhTAVTVhm8zRxAIMDY9P0J2hDwVcnW1wbnyk3/gSRdvDgmSotvavFoTDbl5Fbm4f1btZq6YR6iz7CMatBI7NsPMzCETAxjzHIYB5IWSWFR7ZDH2mNzeIs3mJe58QrXiF1jxRYU2cvsSwFmOMmfofrGWOpdncv6sDqT9euZSoFbZ0HMpaQfPc/MNDedwWtnQVWDvNh2adHlTttKXvkudpS7Q==
}

;# Step 1: 取得過期時間那行 --> License-Valid-End-Date: Sun May 24 00:00:00 2026
;# ======================================
set pattern {License-Valid-End-Date:\s\D+\s\D+\s+\d+\s\d+:\d+:\d+\s\d+}
set time_expir_tmp [regexp -all -inline $pattern $get_info]
if { ![llength $time_expir_tmp] } { return 0 }

set time_expir [lindex $time_expir_tmp 0]
;#輸出: License-Valid-End-Date: Sun May 24 00:00:00 2026

;# Step 2: 取得過期時間 --> May 24 00:00:00 2026
;# ======================================
set time_expir [lrange $time_expir end-3 end-0]
;# 輸出: May 24 00:00:00 2026

;# Step 3: 反算出過期時間的 "秒" --> 1764432000
;# ======================================
set sec_expir [clock scan $time_expir -format "%H:%m:%d %Y"]
;# 輸出: 1764432000

;# Step 4: 取得現在時間 "秒". 現在時間 2026.03.20 09:29:00
;# ======================================
set sec_now [clock seconds]
;# 輸出: 1773970173
