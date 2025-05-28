package require Thread

set mutex [thread::mutex]
set condition [thread::contition]

set thread1 [thread::create{
    thread::mutex lock $mutex
    thread::condition wait $condition $mutex
    puts "Thread 1 received signal"
    thread::mutex unlock $mutex
}]

set thread2 [thread::create 
    thread::after 2000
    thread::mutex lock $mutex
    thread::condition signal $condition
    thread::mutex unlock $mutex
}]

thread::join $thread1
thread::join $thread2

;# 輸出:

