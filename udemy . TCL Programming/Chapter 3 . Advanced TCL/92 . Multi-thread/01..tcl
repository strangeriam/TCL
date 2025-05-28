package required Thread

thread::create {
  for {set i 0} {$i < 5} {incr i} {
    puts "Side thread interation $i"
    after 5000  
  }
}

for {set i 0} {$i < 5} {incr i} {
    puts "Main thread interation $i"
    after 2000
}

