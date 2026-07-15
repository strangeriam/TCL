proc _f_aaa {} {

    f_bbb
    puts "msg1: $msg1"
    puts "msg2: $msg2"
}

proc f_bbb {} { uplevel {
  upvar 1 msg1 "this is message 1."
  upvar 1 msg2 "that is text 2."
}}
