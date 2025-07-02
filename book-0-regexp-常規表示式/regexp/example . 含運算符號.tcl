
;# Example 5 含運算符號
set aa {
Console#show license
Currently Used Profile:
  L2+, cloud-m
Console#
}

regexp {L2\+, cloud\-m} $aa
