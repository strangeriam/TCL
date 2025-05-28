package require Thread

set thread [thread::create {
    thread::wait
    puts "Received message: [thread::receive]"
}]

#thread::send $thread "Hello, thread!"
thread::send $thread "puts Hello!"

thread::join $thread


;# 輸出:
