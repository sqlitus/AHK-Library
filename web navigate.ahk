#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


ie := ComObjCreate("InternetExplorer.Application")
ie.Visible := True
ie.Navigate("www.google.com")
IEWait(ie)
msgbox, WebPage is loaded now.
return

IEWait(ie){
   while ie.busy || (ie.document && ie.document.readyState != "complete") || ie.readyState!=4
   Sleep 100
}