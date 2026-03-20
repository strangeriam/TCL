clock scan (反向): 秒數 <-- 轉換 <-- 其他時間格式
clock scan inputString ?-option value...?

#; A. 年份
#; =======
#; 調出現在的年份, 現在是 2024 年.
set aa [clock format [clock seconds] -format %Y]
#; OUTPUT: 2024

#; 反推 2024 年是幾秒, 是 1717344000 秒.
clock scan $aa -format %Y
#; OUTPUT: 1717344000


#; B. 年-月-日
#; ===========
set aa [clock format [clock seconds] -format %Y-%m-%d]
#; OUTPUT: 2024-06-03

#; 反推 2024-06-03 年是幾秒, 是 1717344000 秒.
clock scan $aa -format "%Y-%m-%d"
#; OUTPUT: 1717344000


#; C. 年-月-日 時:分:秒
#; ===================
set aa [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"]
#; OUTPUT: 2024-06-03 13:48:55

#; 反推 2024-06-03 13:48:55 年是幾秒, 是 1717393735 秒.
clock scan $aa -format "%Y-%m-%d %H:%M:%S"
#; OUTPUT: 1717393735


#; ==================================
# Try several formats for clock scan.
proc incremental-clock-scan {date {debug 0}} {
    set date [regsub -all {[ :.T/]+} $date {-}]

    set result {}
    foreach {format padding} {
        {%Y} {-01-01-00-00-00}
        {%Y-%m} {-01-00-00-00}
        {%Y-%m-%d} {-00-00-00}
        {%Y-%m-%d-%H-%M} {-00}
        {%Y-%m-%d-%H-%M-%S} {}
    } {
        if {$debug} {
            puts "$format $date"
        }
        if {![catch {
                set scan [clock scan $date -format $format]
            }]} {
            # Work around unexpected treatment %Y and %Y-%m dates, see
            # https://wiki.tcl-lang.org/2525.
            set result [
                clock scan [
                    join [
                        list $date $padding
                    ] ""
                ] -format {%Y-%m-%d-%H-%M-%S}
            ]
            if {$debug} {
                puts "match"
                puts [clock format $scan]
            }
        }
    }
    return $result
}

It assumes the unspecified month or day to be 01 and the unspecified time to be midnight and treats the delimiters :.T/ as equivalent, so

incremental-clock-scan {2014}
incremental-clock-scan {2014-01}
incremental-clock-scan {2014-01-01T00:00:00}
incremental-clock-scan {2014/01/01 00:00:00}
all return the same value as clock scan {2014-01-01-00-00-00} -format {%Y-%m-%d-%H-%M-%S}

