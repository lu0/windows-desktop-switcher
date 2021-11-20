;
; Workspaces (virtual desktops) and keybindings I use on Windows and LInux
;

; ----------------------------------------------------------
; Keybindings to switch workspaces
; ----------------------------------------------------------
LAlt & |::switchDesktopByNumber(1)  ; Web
LAlt & 1::switchDesktopByNumber(2)  ; Art
LAlt & 2::switchDesktopByNumber(3)  ; Coffee
LAlt & 3::switchDesktopByNumber(4)  ; Files
LAlt & 4::switchDesktopByNumber(5)  ; Terminal
LAlt & 8::switchDesktopByNumber(6)  ; Social
LAlt & 9::switchDesktopByNumber(7)  ; Games
LAlt & 0::switchDesktopByNumber(8)  ; Music

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
