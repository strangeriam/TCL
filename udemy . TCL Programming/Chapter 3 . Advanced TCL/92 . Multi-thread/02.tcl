package require Thread

set thread [thread::create {
    thread::wait
    puts "Received message: [thread::receive]"
}]

thread::send $thread "Hello, thread!"

thread::join $thread


;# 輸出:
