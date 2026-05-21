concat list list … 將多個 list 串成一個.

#; Example：
set list1 [list Gpapa Gmama]
set list2 [list papa mama]
set list3 [list brother sisters]

set listFamily [concat $list1 $list2 $list3]
puts "Family member : $listFamily"
#; OUTPUT=> Family member : Gpapa Gmama papa mama brother sisters

llength $listFamily
#; OUTPUT=> 9
