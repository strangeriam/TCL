namespace eval ::app {
    variable version "1.0.0"
    variable title "IPQ5018 iPerf3 Throughput Test Tool"
    variable base_dir [file dirname [file normalize [info script]]]
    variable config
    variable test_running 0
    variable test_paused 0
    variable start_time ""
    variable elapsed_seconds 0
}

set ::app::version
;# 輸出 --> 1.0.0

set ::app::test_running
;# 輸出 --> 0
