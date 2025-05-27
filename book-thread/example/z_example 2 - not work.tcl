
# Example code
# ============
package require Thread

set t1 [thread::create]
set t2 [thread::create]
thread::send -async $t1 "set a 1" result
thread::send -async $t2 "set b 2" result

for {set i 0} {$i < 2} {incr i} {
        vwait result
}

# Example code
# ============
proc f_sayHello {} {
	puts "Hello Everyone..."
}

package require Thread
while 1 {
	set t [thread::create]
	thread::send $t [f_sayHello]
	thread::release $t
}



# Output
一直重複 Hello Everyone...
