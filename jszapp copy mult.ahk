#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


; copy multiple. copy on something when you already have copied something to clipboard

; Created by: Chris J
; Date: 12/2/2017
; Purpose: create multiple clipboards for copying
; reference: https://jszapp.com/how-to-make-a-script-that-can-copy-multiple-strings/


; copy 1
^1:: 

old_clip := ClipboardAll
Clipboard := ""
Send, ^c ;
ClipWait, 2
clip_one := Clipboard
Clipboard := old_clip
return



; paste 1
+1::

if (clip_one = "") ; if the variable is empty
    return ; end this rutine
old_clip := ClipboardAll
clipboard := clip_one
Send, ^v ; (^ = ctrl) + v
Clipboard := old_clip
return


; copy 2
^2::

old_clip := ClipboardAll
Clipboard := ""
Send ^c  
clipwait, 2 
Clip_two := Clipboard
clipboard := old_clip
return


; paste 2
+2::
if (clip_two = "") ; if the variable is blank or not set, return
    return
old_clip := ClipboardAll
clipboard := clip_two
Send, ^v      ; ( ctrl+v )
clipboard := old_clip
return