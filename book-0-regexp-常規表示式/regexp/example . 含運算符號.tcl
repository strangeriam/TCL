
set content {
Console#show license
Currently Used Profile:
  L2+, cloud-m
Console#
}

regexp {L2+, cloud-m} $content
;# 輸出: 0

regexp {L2\+, cloud\-m} $content
;# 輸出: 1
