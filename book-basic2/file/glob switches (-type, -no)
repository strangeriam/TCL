glob -nocomplain -types f -directory $folder $pattern

-nocomplain
如果 glob 命令執行時沒有找到任何檔案或目錄, 它會抱怨找不到檔案.
加上 -nocomplain 告訴 glob 不要產生抱怨訊息.

-types [typeList]
限定搜尋的檔案類型,
必需要為包含以下字元的清單:
b (block special file)
c (character special file)
d (directory)
f (plain file)
l (symbolic link)
p (named pipe)
s (socket) 
r (可讀)
w (可寫)
x (可執行)
readonly (唯讀)
hidden (隱藏檔)

-directory [directory]
使用 directory 當成要搜尋的目標目錄, 若沒有指定則使用目前的工作目錄.

-path [pathPrefix]
搜尋時把 pathPrefix 串接在 pattern 的開頭, 且不解釋pathPrefix內的特殊字元.

-join
以目錄分隔字元把所有的 pattern 組合為單一 pattern, 再執行搜尋.
