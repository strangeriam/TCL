
# Example 1
# =========
set msgTitle "ENV Check..."
set pic "./bitmap/stations/PDL.png"
set msgEnglish 	"Check DUT is ready. Press PASS."
set msgChinese 	"確認待測物已放置完成. 點選 PASS."
_f_Client_SelectUI "$msgTitle\n$msgEnglish\n$msgChinese" PassOnly $pic

# Example 2
# =========
set this_select_1 [_f_Client_SelectUI "$msgEnglish\n$msgChinese" PassFail $jpg]
switch $this_select_1 {
	0 	{ set tryResult FAIL ; break }
	1 	{ set tryResult PASS }
	default { usermsg "unexpectreturn $this_select_1 for clearbutton" ; exit }
}

# Example 3
# =========
1. TITLE: Tile 修改為 WRONGING...
2. TXT: Button 修改為 Continue
3. FUN: 為起頭者 . 表示即將有一個 簡短的動作要執行.

_f_Client_SelectUI "這是上面內容\nAAA\nBBB\nCCC" PassOnly "TITLE:WRONGING..." "TXT:Continue"

# Example 4
# =========
usermsg "User Select Skip"
