CoordMode, Mouse, Screen

; Keybindings I use on Linux to tile, close, minimize and maximize the active window.
; ctrl + alt + space    Close.
; alt + <space, x>      Maximize (with gaps) and Minimize.
; alt + <a, d>          Tile left and right.
; alt + <c, e, q, z>    Tile to a quadrant.

; Start keybindings ----------------------------------------------------------

; Close
; ctrl + super + space
^#Space::
    MouseGetPos, prevMouseX, prevMouseY
    WinClose, A
    MouseMove, %prevMouseX%, %prevMouseY%, 0
    return

; Minimize
; left alt + x
!x::
    MouseGetPos, prevMouseX, prevMouseY
    WinMinimize, A
    MouseMove, %prevMouseX%, %prevMouseY%, 0
    return

; Maximize with gaps
; left alt + space
!space:: WinTile("max")

; Tile-maximize on the other monitor
; super + alt + a
#!a::
    pinWindowOnAllDesktops()
    WinTile("max", false)
    return

; Tile-maximize on the other monitor
; super + alt + d
#!d::
    unpinWindowFromAllDesktops()
    WinTile("max", false)
    return

; alt + a
!a:: WinTile("left")

; Tile Left-Top
; alt + q
!q:: WinTile("left-top")


; Tile Left-Bottom
; alt + z
!z:: WinTile("left-bottom")
 
; Tile Right
; alt + d
!d:: WinTile("right")
    

; Tile Right-Top
; alt + e
!e:: WinTile("right-top")

; Tile Right-Bottom
; alt + c
!c:: WinTile("right-bottom")


WinTile(position, isCurrent:=true) {
    winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
    if not activeStatus
        return
    MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, isCurrent)
    WinGetTileMaximizedPosFromMonitor(position, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    return
}

MonitorGetWorkAreaRelPos(ByRef monitorX1, ByRef monitorX2, ByRef monitorY1, ByRef monitorY2, ByRef monitorWidth, ByRef monitorHeight, isCurrent) {
    ; Get the relative position of the current monitor if isCurrent = true
    ; else get the relative position of the other monitor.
    ; This works for setups with up to 2 monitors.
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    SysGet, monitorCount, MonitorCount
    Loop, %monitorCount%
    {
        SysGet, workArea, MonitorWorkArea, %A_Index%
        isMouseInMonitor := mouseX > workAreaLeft and mouseX < workAreaRight and mouseY > workAreaTop and mouseY < workAreaBottom
        if ((isMouseInMonitor and isCurrent) or (not isMouseInMonitor and not isCurrent)) {
            monitorX1 :=  workAreaLeft
            monitorX2 :=  workAreaRight
            monitorY1 := workAreaTop
            monitorY2 := workAreaBottom
            monitorWidth := Abs(workAreaRight - workAreaLeft)
            monitorHeight := Abs(workAreaBottom - workAreaTop)
            return
        }
    }
}

winGetTitlesAndActiveStatus(ByRef oldWinTitle, ByRef newWinTitle, ByRef activeStatus) {
    ; Check if a window is active and get its title
    activeStatus := true
    WinGetTitle, oldWinTitle, A
    newWinTitle := oldWinTitle
    if (oldWinTitle = "" or oldWinTitle = "Program Manager") {
        activeStatus := false
        return
    }

    ; Change the title in case we have more windows with the same one
    Random, rand, 1000, 9999
    resizeIndicator := " (" . rand . ")"
    newWinTitle := oldWinTitle . resizeIndicator
    WinSetTitle, %oldWinTitle%, , %newWinTitle%
    return
}


WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight) {
    ; Move and resize
    WinRestore, %newWinTitle%   ; restore in case of built-in maximization
    WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

    ; Center the mouse
    newMouseX := newWindowX + newWindowWidth/2
    newMouseY := newWindowY + newWindowHeight/2
    MouseMove, %newMouseX%, %newMouseY%, 0
    WinActivate, %newWinTitle%
    WinSetTitle, %newWinTitle%, , %oldWinTitle%
    return
}


WinGetTileMaximizedPosFromMonitor(tileType, x, y, width, height, ByRef winX, ByRef winY, ByRef winWidth, ByRef winHeight) {
    tileGap := 10

    ; Default to maximize
    winWidth := width - tileGap*2
    winHeight := height - tileGap*2
    winX := x + tileGap
    winY := y + tileGap

    ; Overrides
    if InStr(tileType, "left") or InStr(tileType, "right") {
        winWidth := width/2 - tileGap*1.5
    }
    if InStr(tileType, "top") or InStr(tileType, "bottom"){
        winHeight := height/2 - tileGap*1.5
    }
    if InStr(tileType, "bottom") {
        winY := y + tileGap*1.5 + winHeight
    }
    if  InStr(tileType, "right") {
        winX := x + winWidth + tileGap*2
    }
    return
}
