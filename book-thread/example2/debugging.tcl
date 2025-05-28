package require Thread

# catch {console show}

set ::tid1 [thread::create {thread::wait}]
puts [list {created thread 1} $::tid1]

set ::tid2 [thread::create {thread::wait}]
puts [list {created thread 2} $::tid2]

proc test1 {} {
    puts {test 1 . starting}
    thread::send -async $::tid1 {puts "test 1 . [clock seconds]"}
    after 2000 test1
    puts {test 1 . ending}
}

proc test2 {} {
    puts {test 2 . starting}
    thread::send -async $::tid2 {puts "test 2 . [clock seconds]"}
    after 2000 test2
    puts {test 2 . ending}
}


test1
test2

#only needed for tclsh, to keep the interpreter alive and keep the event loop running
vwait forever


;# 輸出:
% test1
test 1 . starting
test 1 . ending
test 1 . 1748418313
% test2
test 2 . starting
test 2 . ending
test 2 . 1748418313
test 1 . starting
test 1 . ending
test 1 . 1748418315
test 2 . starting
test 2 . 1748418315
test 2 . ending
test 1 . starting
test 1 . ending
test 1 . 1748418317
test 2 . starting
test 2 . ending
test 2 . 1748418317
test 1 . starting
test 1 . ending
test 1 . 1748418319
test 2 . starting
test 2 . ending
test 2 . 1748418319
test 1 . starting
test 1 . ending
test 1 . 1748418321
test 2 . starting
...

