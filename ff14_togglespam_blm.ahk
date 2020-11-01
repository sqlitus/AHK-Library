#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force ; auto overwrites same named script running


/* notes

firestarter working.
scythe working easy.
thunder at buff 2&3 working. slot 1 not working ????




*/ 





; --- BLACKMAGE. FFXIV.

; -- MAIN LOOP.
/* 
; -- first check if i have a hostile target...
; -- SCATHE: if enemy at 1% health
; -- otherwise
	; -- FIRE III: IF any buffs show firestarter
	; -- THUNDER III: if any buffs show thundercloud
	; -- TRANSPOSE OR BLIZZARD 3: if mana is too low for Fire (around 700)
outside of combat: use transpose if mana is low.
				
*/



^p::
	Pause
	Suspend
return

^b::
	OneToggle:=!OneToggle
Return



#IfWinActive FINAL FANTASY XIV 	; to force the hotkey only to FFXIV window
OneToggle=0 
MButton::
		
		; -- NOTIFY TOGGLE IS ON.
		SendInput 3
		Sleep 50
		SendInput 3
		Sleep 70
		
		if (OneToggle := !OneToggle)
			
			SetTimer, timer, -1
			
			SendInput 3
			Sleep 50
			SendInput 5  ; -- this part runs when turned off via ^b:: OneToggle:=!OneToggle
			Sleep 60
			SendInput 5
		return
		
		
		; -- TIMER LOOP SEGMENT.
		timer:
		
		last_status_firestarter := 0
		
		While (OneToggle)
		{  

			; -- buff pixel locations for resolution: 2560x1440
			; -- PixelGetColor, mana_6pct, 1305, 1090, RGB  ; -- empty: 0x33231A
			PixelGetColor, mana_800_over, 1314, 1090, RGB ; -- empty: 0x33231A
			PixelGetColor, mana_1100, 1312, 1091, RGB ; -- empty: 0x2B1B13
			PixelGetColor, mana_1400, 1321, 1090, RGB ; -- empty: 0x33231A
			
			PixelGetColor, enemy_health_1pct, 1004, 157, RGB  ; -- full enemy health color 0xFFBDBF. ; -- empty health bar color 0x471515
					; -- also purple color: full: 0xFFDCFF. low: 0x402141.
			
			status_firestarter := 0
			status_thundercloud := 0
			
			
			; -- tagged enemy (red bar) or untagged enemy (purple bar), with low health
			if (enemy_health_1pct = 0x471515 or enemy_health_1pct = 0x402141)
			{
				SendInput {7 down}
				Sleep 16
				SendInput {7 up}
				; -- SendInputInput ^{5} ; -- also tech works?, but might need sleep w/ control 
			}
			else if (enemy_health_1pct = 0xFFBDBF or enemy_health_1pct = 0xFFDCFF)
			{
				
				PixelGetColor, buff_1, 1561, 919, RGB ; -- thundercloud: 0xEEDADD
				PixelGetColor, buff_1_2, 1561, 921, RGB ; -- !!!  for thundercloud since buff_1 wasn't working.: 0xB2898A.
				PixelGetColor, buff_2, 1600, 918, RGB ; -- thundercloud: 0xECD0D2.
				PixelGetColor, buff_3, 1636, 921, RGB; -- thundercloud: 0xB2898A.
				PixelGetColor, buff_4, 1674, 918, RGB ; -- firestarter: FFFECA. thundercloud: 0xC799BD.
				PixelGetColor, buff_5, 1711, 921, RGB ; -- !!! theorized position for buff_5 based on 1_2 and _3. Same thundercloud color for each 0xB2898A.
				PixelGetColor, buff_6, 1674, 918, RGB
				
				if  (buff_1 = 0xF6F67E or buff_2 = 0xFFFCD7 or buff_3 = 0xEEB345 or buff_4 = 0xFFFECA)
				{
					; -- set status of firestarter=true
					status_firestarter := 1
					
					; -- attempt to Cast firestarter
					SendInput {3 down}
					Sleep 14
					SendInput {3 up}
					
				}
				else if (buff_1 = 0x0xEEDADD or buff_2 = 0xECD0D2 or buff_3 = 0xB2898A or buff_4 = 0xC799BD or buff_5 = 0xB2898A or buff_1_2 = 0xB2898A)
				{
					status_thundercloud := 1
					
					SendInput {4 down}				
					Sleep 15
					SendInput {4 up}
				}	
				else if (mana_1400 = 0x33231A)
				{
					SendInput {r down}
					Sleep 16
					SendInput {r up}
					
					SendInput {5 down}
					Sleep 13				
					SendInput {5 up}
				}
			}
			

			
			; -- out of combat. switch to gain mana. AND NOT IN FIRE.
			if (mana_800_over = 0x33231A)
			{
				SendInput {r down}
				Sleep 22
				SendInput {r up}
				Sleep 79
			}

			
			/*
			; -- low mana check: around 700
			1305, 1090 0x33231A
			*/
			
			
			
			/*
			; -- health check for buffs
			PixelGetColor, health_40, 1149, 1092, RGB
			health_40_color := 0x4B791E  ; -- colof if health full at ~40
			

			; -- if health is EMPTY AT  ~40% and buff is ready: use shield
			if (health_40 <> health_40_color)
			{
				; -- check if shield ability keybind.is available
				PixelGetColor, ability_shield, 1524, 1299, RGB
				ability_shield_color = 0xE7DCFC  ; -- color if available
				
				if (ability_shield = ability_shield_color)
				{
					Send 0																																								
				}
			}
			*/
			
			
			/*
			; -- set the value of last_status firestart = to this status_firestarter
			last_status := status_firestarter
			
			; -- if firestarter just rolled off, ...wait & cast fire???
			if (last_status = 1 and status_firestarter = 0)
				Sleep 150
				Send 2
			*/
			; -- OTHERWISE NOTHING
		
		
			Sleep 45
		}
		
Return





; -- ======================================================
; -- REFERENCE
; -- ======================================================



;-- reference: 4k pixel locations


; -- FIRESTARTER BUFF AREA CHECK
			/* for 4k res
			PixelGetColor, buff_Firestarter_1, 2405, 1387, RGB
			PixelGetColor, buff_Firestarter_2, 2452, 1385 , RGB
			PixelGetColor, buff_Firestarter_3, 2503, 1385, RGB
			
			color1 = 0x0F8F8AB
			color2 = 0xFBFBA2
			color3 = 0xFBFBB6
			*/
			






/*
; -- MOUSE TOGGLE SPAM BUTTON - FIRE SPAM / TRANSPOSE / ICE SPAM

; -- SUMMARY
; -- check for firestarter buff. cast it if true. 
; -- if not, check if (not in ice) + have mana. if so, cast fire
; -- no mana -> transpose or blizz 3?
; -- full mana + umbral ice -> transpose, then fire


; -- Condition Checks 
PixelGetColor, check_buff_1, X, Y , Mode
PixelGetColor, check_buff_2, X, Y , Mode
PixelGetColor, check_buff_3, X, Y , Mode
PixelGetColor, check_buff_4, X, Y , Mode


PixelGetColor, check_Umbral_Ice, X, Y , Mode
PixelGetColor, check_Umbral_Ice_lvl_3, X, Y , Mode
PixelGetColor, check_Astral_Fire, X, Y , Mode
PixelGetColor, check_Astral_Fire_lvl_3, X, Y , Mode


PixelGetColor, check_mana_over_90_pct, X, Y , Mode
PixelGetColor, check_mana_under_30_pct, X, Y , Mode
PixelGetColor, check_health_under_30_pct, X, Y , Mode



; -- turns off / on toggle?
^b::
	OneToggle := !OneToggle
return

~!WheelDown::
	OneToggle := !OneToggle
return

*/