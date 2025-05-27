# Package require
# ===============
# 此 package require 後, 就會新增一 thread id.
# Example ID: tid00002080

package require Thread


# Create 2 threads.
# =================
# Output: tid000019C8
# Output: tid00001CD4

puts [set t1 [thread::create]]
puts [set t2 [thread::create]]


# List exist thread IDs.
# ====================
# Output: tid00001CD4 tid000019C8 tid00002080

thread::names
