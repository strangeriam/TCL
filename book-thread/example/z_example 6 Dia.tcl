## =============
## Dai 建議這樣寫
## =============
package require Thread

tsv::set share mainTid [thread::id]

set tid [thread::create -joinable {
            set mainTid [tsv::get share mainTid]
            thread::send -async $mainTid [list puts "Hello"]
}]

set ::bye 0
after 3000 [list set ::bye 1]
vwait ::bye

thread::join $tid
puts "bye~~~"


## Code End
