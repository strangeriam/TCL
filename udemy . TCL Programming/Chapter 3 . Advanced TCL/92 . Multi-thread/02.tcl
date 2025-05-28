package require Thread

set thread [thread::create {
    thread::wait
    puts "Received message: [thread::receive]"
}]

thread::send $thread "Hello, thread!"

thread::join $thread


;# 輸出:

;# Issue: 輸出有問題.
tid00004490
%
% thread::send $thread "Hello, thread!"
invalid command name "Hello,"
%
% thread::join $thread
cannot join thread tid00004490
%
%


