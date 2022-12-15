#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

+CapsLock::
SetCapsLockState, % !GetKeyState("CapsLock","T")
return

CapsLock::
Send {Esc}
return

+PgUp::Send, {Shift up}{PgDn}

;CapsLock & j::&
;CapsLock & k::*
;CapsLock & l::(
;CapsLock & ;::)
;CapsLock & '::_
;CapsLock & Return::+