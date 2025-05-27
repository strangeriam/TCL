package require Thread

proc make_worker_thread {logger_id body} {
      set newbody [list set ::logger $logger_id]

      append newbody \n {
            proc ::log {severity msg} {
                  global logger
                  thread::send $logger [list ::log $severity $msg]
            }
      } \n $body

      thread::create $newbody
}

set logger [thread::create {
      package require logger

      proc log {severity msg} {
            puts "hey, that's it: ($severity) $msg"
      }

      puts "logger thread created: [thread::id]"

      thread::wait
}]

for {set i 0} {$i < 3} {incr i} {
        make_worker_thread $logger {
              proc post_msg {} {
                    log notice "A message from [thread::id]"
                    after 1000 ::post_msg
              }

              puts "worker thread created: [thread::id]"
              after 1000 ::post_msg

              thread::wait
        }
}

vwait forever

