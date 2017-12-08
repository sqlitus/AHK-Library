#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


^j::
send, {Space}site:stackoverflow.com
return


^k::
click 990, 119
return


^l::
runwait chrome.exe
click 500, 119
send, autohotkey.com/docs
send, {enter}
return



^g:: ; GoogleSearch or Show Link with CTRL+G
  prevClipboard := ClipboardAll
  SendInput, ^c 
  ClipWait, 1
  if !(ErrorLevel)  { 
    Clipboard := RegExReplace(RegExReplace(Clipboard, "\r?\n"," "), "(^\s+|\s+$)")
    If SubStr(ClipBoard,1,7)="http://"
      Run, % Clipboard
    else 
      Run, % "http://www.google.com/search?hl=en&q=" Clipboard " site:stackoverflow.com"
  } 
  Clipboard := prevClipboard
return