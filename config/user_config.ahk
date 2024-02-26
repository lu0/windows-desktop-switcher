;
; Workspaces (virtual desktops) and keybindings I use on Windows and LInux
;

; ----------------------------------------------------------
; Setup workspace indexes and names
; ----------------------------------------------------------
desktops := { "Web": 1
            , "Art": 2
            , "Coffee": 3
            , "Files": 4
            , "Terminal": 5
            , "Social": 6
            , "Games": 7
            , "Music": 8 }

DesktopCount := getNumberOfDesktops()

; ----------------------------------------------------------
; Keybindings to switch workspaces
; ----------------------------------------------------------
LAlt & |::switchDesktopByNumber(1)
LAlt & 1::switchDesktopByNumber(2)
LAlt & 2::switchDesktopByNumber(3)
LAlt & 3::switchDesktopByNumber(4)
LAlt & 4::switchDesktopByNumber(5)
LAlt & 8::switchDesktopByNumber(6)
LAlt & 9::switchDesktopByNumber(7)
LAlt & 0::switchDesktopByNumber(8)

; ----------------------------------------------------------
; Keybindings to move the active window to another workspace
; ----------------------------------------------------------

; Left Alt + Left Hand Numbers or Escape
LAlt & Esc:: MoveCurrentWindowToDesktop(1)
LAlt & F1:: MoveCurrentWindowToDesktop(2)
LAlt & F2:: MoveCurrentWindowToDesktop(3)
LAlt & F3:: MoveCurrentWindowToDesktop(4)
LAlt & F4:: MoveCurrentWindowToDesktop(5)

; Left Alt + Right Hand Numbers
LAlt & F9:: MoveCurrentWindowToDesktop(6)
LAlt & F10:: MoveCurrentWindowToDesktop(6)   ; Repeated 'cause everyone makes mistakes :P
LAlt & F11:: MoveCurrentWindowToDesktop(7)
LAlt & F12:: MoveCurrentWindowToDesktop(8)


; ----------------------------------------------------------
; Misc
; ----------------------------------------------------------

; Show active window on all desktops
; Alt + Enter
!Enter:: togglePinWindowOnAllDesktops()

; Show active window on all desktops, on top of all windows.
; Alt + Shift + Enter
!+Enter::togglePinWindowOnAllDesktopsOnTop()
