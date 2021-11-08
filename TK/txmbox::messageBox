set MesBox [txmbox::messageBox -type none -message "BL BOOT UP..$i." -font {"Consolas" 16 normal bold} -format true -wait false]
vwait_seconds 3
txmbox::destroyMsgBox $MesBox


## ================================

-type 
- option:
    - ok, okcancel, cancel, yesno, yesnocancel, abort, 
    - abortretrycancel, retrycancel, none, custom

Example
    set img [image create photo -file "$ENVPATH/metadata/Photo/general/warning.gif"]
    
    set MesBox [txmbox::messageBox -type none -image $img \
                                    -message "Waiting Reboot" \
                                    -font {"Consolas" 16 normal bold} \
                                    -format true -wait false]
    txmbox::destroyMsgBox $MesBox

----------
wm geometry
    set xPhotoWidth    800
    set yWindowHeight  340
    set yPhotoHeight   300
    set toplevelPhoto ""
    
    set toplevelPhoto [toplevel .photo]
    set xScreenWidth  [expr {([winfo screenwidth .] - $xPhotoWidth)/2}]
    set yScreenHeight [expr {([winfo screenheight .] - [expr $yWindowHeight + $yPhotoHeight])/2}]
    
    wm geometry $toplevelPhoto [set xPhotoWidth]x[set yPhotoHeight]+$xScreenWidth+[expr $yScreenHeight + $yWindowHeight]
    wm title $toplevelPhoto "GUI face"
    wm protocol $toplevelPhoto WM_DELETE_WINDOW {destroy $toplevelPhoto}
    
    image create photo guiFace -file $picSource
    
    set labelPhoto [label .photo.label -image guiFace]
    pack $labelPhoto
    
    set check_StationChanging [txmbox::messageBox -type none -icon info \
                        -title "" \
                        -message "Changing..." \
                        -force true -grab true -font {"Consolas" 20 normal bold} \
                        -beep false -resize false -showtime false -wait false]
    txmbox::destroyMsgBox $check_StationChanging
    vwait_mseconds 200
