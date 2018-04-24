#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; all hotkey shortcuts. push keys in order.

^j::
   SendInput, {Space}site:stackoverflow.com
Return


; 3 keyboard shortcuts. have to push GetKeyState button first, then other two in order

Numpad0 & Space::
If !GetKeyState("a")
	Return
MsgBox, you pressed this hotkey
WinActivate, outlook.exe
Return

; run, firefox.exe
; click, 465 63

;; -- Set 1 Keys

Numpad0 & NumpadDot::
FormatTime, CurrentDateTime,, dddd
SendInput %CurrentDateTime%{Alt}hl{Tab}{Tab}{Tab}{Enter}
return

Numpad0 & Numpad1::
SendInput, <Exec Metrics Deck>
return

Numpad0 & Numpad2::
SendInput, <RST / GHD CSQ Report & temporary OnePOS Snapshot>
return

Numpad0 & Numpad3::
SendInput, <L1 Analyst Metrics Sheet Update>
return

Numpad0 & Numpad4::
SendInput, <L1 Heatmap Report>
return

Numpad0 & Numpad5::
SendInput, <Aloha Keywords Report>
return

Numpad0 & Numpad6::
SendInput, <Exec Metrics Meeting & mailed to David>
return

Numpad0 & Numpad7::
FormatTime, CurrentDateTime,, yyyy-MM-dd
SendInput %CurrentDateTime%
return



;; -- Set 2 Keys
^Numpad0::
FormatTime, CurrentDateTime,, dddd
SendInput %CurrentDateTime%{Alt}hl{Tab}{Tab}{Tab}{Enter}
return

^Numpad1::
MsgBox, you pressed this hotkey
Return



;; -- testing with dates
^Numpad2::
FormatTime, CurrentDateTime,, MM/dd/yyyy
SendInput %CurrentDateTime%
return

^Numpad3::
FormatTime, CurrentDateTime,, dddd
SendInput %CurrentDateTime%
return


; -- test sending keys to non-active window

; -- opens notepad if not open, properly waits on it, and sends keys (even if in background)
^l::
	IfWinNotExist, ahk_class Notepad
		Run, Notepad.exe
		
	WinWait, ahk_exe notepad.exe, , 3	
	
	FormatTime, time, A_now, yyyy/MM/dd hh:mm tt	; -- creates 'time' variable
	
	WinGet, winid, ProcessName, A	; -- creates 'winid' variable with the proper .exe name
	WinGetClass, winclass, A		; -- creates winclass variable with the 'common' name of the application
	
	; -- send to program with process name notepad.exe (instead of window name, which is ID)
	ControlSend, , {Enter}%time%, ahk_exe notepad.exe	
	ControlSend, Edit1, - from %winid% / %winclass%{Enter}, ahk_exe notepad.exe
	ControlSend, , line 1 in notepad {Enter}, ahk_exe notepad.exe
	ControlSend, Edit1, line 2 in notepad also.{Enter}, ahk_exe notepad.exe
	ControlSend, Edit1, again`, 3rd line in notepad.{Enter}, ahk_exe notepad.exe
	
	
	; -- copy + paste info...
return




/*

REFERENCES

; -- send to notepad++ new window
ControlSend, Scintilla1, YourTextHere, *new 1

; -- to activate a window?
WinGet, winid ,, A ; <-- need to identify window A = acitive
WinActivate ahk_id %winid%
*/