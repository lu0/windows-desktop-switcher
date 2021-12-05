truncateString(string:="", n:=100) {
    return (StrLen(string) > n ? SubStr(string, 1, n-3) . "..." : string)
}

showMessage(txt, title:="") {
    hideMessage()
    title := truncateString(title)
    txt := truncateString(txt)
    TrayTip, %title%, %txt%, , 16
}

hideMessage() {
    TrayTip  ; Attempt to hide it the normal way.
    if SubStr(A_OSVersion,1,3) = "10." {
        Menu Tray, NoIcon
        Sleep 200  ; In case of defects, it may be necessary to adjust the value
        Menu Tray, Icon
    }
}