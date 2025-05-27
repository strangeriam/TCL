package require Thread

set ::gThread [thread::create {thread::wait}]

proc printTime {} {
     thread::send -async $::gThread { puts stdout [clock format [clock seconds]] }
     after 1000 printTime
}

printTime
puts "started test..."

;# Keep the interpreter alive and keep the event loop running.
vwait forever
