package require Thread

set mutex [thread::mutex]
;# 出現錯誤: wrong # args: should be "thread::mutex option ?args?"

set condition [thread::condition]
;# 出現錯誤: invalid command name "thread::condition"

set thread1 [thread::create {
    thread::mutex lock $mutex
    thread::condition wait $condition $mutex
    puts "Thread 1 received signal"
    thread::mutex unlock $mutex
}]

set thread2 [thread::create {
    thread::after 2000
    thread::mutex lock $mutex
    thread::condition signal $condition
    thread::mutex unlock $mutex
}]

thread::join $thread1
thread::join $thread2

;# 輸出:

