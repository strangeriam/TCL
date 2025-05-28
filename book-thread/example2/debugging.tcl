package require Thread
catch {console show}
set ::gThread [thread::create {thread::wait}]
puts [list {created thread} $::gThread]
proc test {} {
    puts {test starting}
    thread::send -async $::gThread {puts [clock seconds]}
    after 2000 test
    puts {test ending}
}

test
puts {started first test}

#only needed for tclsh, to keep the interpreter alive and keep the event loop running
vwait forever
