#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force ; auto overwrites same named script running



/* GLOBAL VARIABLES 

The Top of the Script (the Auto-execute Section)

After the script has been loaded, it begins executing at the top line, continuing until a Return, Exit, hotkey/hotstring label, or the physical end of the script is encountered (whichever comes first). This top portion of the script is referred to as the auto-execute section.

*/ 

KingMogSayings := ["- may his glorious name live forever"
	, "- may his miraculous foresight ever be praised"
	, "- may his courageous sacrifice never be forgotten"
	, "- may his boundless grace fill our hearts with love"
	, "- may he reign forevermore, kupo"
	, "- may he justly reign till the end of days"
	, "- may his magnificent virtue serve as an example to us all"
	, "- may his reign end with minimal bloodshed"
	, "- may his scepter of judgment ever command our respect"]



sharepointsays := ["end-user document capture"
	, "native functionality"]
	
	
fantasy_sayings := ["verily doth I proclaim"
	, "must needs"
	, ""]


/* notes

firestarter working.
scythe working easy.
thunder working - had to delete other line...



*/ 


/* ========================================================
autohotkey helper functions

*/

; reload this script
^+u::
	SoundBeep, 750, 500
	Reload
	Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
return


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



/*
===============================================================
HOTSTRINGS
::hotstring::  ; -- replaces after \s space
:*:hotstring::  ; -- asterik makes it INSTANT (no room for extra char modifications)
*/


		
		
::btw::by the way  ; -- 'soft hotstring', sent after a space.
return

:*:]btw::  ; -- 'HOT' hotstring, sent instantly.
SendInput by the way
return


:*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
FormatTime, CurrentDateTime,, M/d/yyyy h:mm tt  ; It will look like 9/1/2005 3:53 PM
SendInput %CurrentDateTime%
return

:*:kmm::  ; This hotstring replaces "]d" with the current date and time via the commands below.
Random, rand_num , 1, 6
SendInput % "King Moggle Mog XII " . KingMogSayings[rand_num]
return



; -- WORKING RANDOM PHRASE FROM [INDEXED] ARRAY.
^k::
Random, rand_num , 1, 6
Msgbox, % "King Moggle Mog XII " . KingMogSayings[rand_num]  ; -- ! concatenates variable and string!
return

/*
===============================================================
MAIN HOTKEYS

*/


#IfWinActive FINAL FANTASY XIV 	; to force the hotkey only to FFXIV window

~!WheelDown::
	OneToggle := !OneToggle
	SendInput {0 down}
	Sleep 22				
	SendInput {0 up}
return



OneToggle=0 
MButton::
		
		; -- NOTIFY TOGGLE IS ON.
		SendInput 3
		Sleep 50
		SendInput 3
		Sleep 70
		
		if (OneToggle := !OneToggle)
			
			SetTimer, timer, -1
			Sleep 22
			SendInput 3
			Sleep 50
			SendInput 5  ; -- this part runs when turned off via ^b:: OneToggle:=!OneToggle
			Sleep 60
			SendInput 5
		return
		
		
		; -- TIMER LOOP SEGMENT.
		timer:
		
		last_status_firestarter := 0
		last_status_thundercloud := 0
		status_firestarter := 0  
		status_thundercloud := 0
		fire_counter := 0
		
		
		While (OneToggle)
		{  

			; -- buff pixel locations for resolution: 2560x1440
			PixelGetColor, enemy_health_1pct, 1004, 157, RGB  ; -- full enemy health color 0xFFBDBF. ; -- empty health bar color 0x471515
					; -- also purple color: full: 0xFFDCFF. low: 0x402141

			
			; -- SCATHE: 1%. tagged enemy (red bar) or untagged enemy (purple bar), with low health
			; -- NORMAL ROTATION if enemy targeted, and has >1% health
			
			if (enemy_health_1pct = 0x471515 or enemy_health_1pct = 0x402141)  ; low health shade?
			{
				SendInput 7
				Sleep 14
				; fire_counter += 16
				; -- SendInputInput ^{5} ; -- also tech works?, but might need sleep w/ control 
			}
			
			; -- else if (enemy_health_1pct = 0xFFBDBF or enemy_health_1pct = 0xFFDCFF)  ; high health shade?  0xFFBDBF
			if (1=1)
			{
				
				PixelGetColor, buff_1, 1561, 919, RGB ; -- thundercloud: 0xEEDADD
				PixelGetColor, buff_1_2, 1561, 921, RGB ; -- !!!  for thundercloud since buff_1 wasn't working.: 0xB2898A
				PixelGetColor, buff_2, 1600, 918, RGB ; -- thundercloud: 0xECD0D2
				PixelGetColor, buff_3, 1636, 921, RGB; -- thundercloud: 0xB2898A
				PixelGetColor, buff_4, 1674, 918, RGB ; -- firestarter: FFFECA. thundercloud: 0xC799BD
				PixelGetColor, buff_5, 1711, 921, RGB ; -- !!! theorized position for buff_5 based on 1_2 and _3. Same thundercloud color for each 0xB2898A
				
				; FIRESTARTER check buff locations 1-4
				if  (buff_1 = 0xF6F67E or buff_2 = 0xFFFCD7 or buff_3 = 0xEEB345 or buff_4 = 0xFFFECA)
				{
					; -- set status of firestarter=true
					; status_firestarter := 1
					
					; -- attempt to Cast firestarter. Instant is best, vs holding down key
					SendInput {3 down}
					Sleep 15
					SendInput {3 up}
					
				}
				
				; thundercloud check buff 1-5
				if (buff_1 = 0x0xEEDADD or buff_2 = 0xECD0D2 or buff_3 = 0xB2898A or buff_4 = 0xC799BD or buff_5 = 0xB2898A or buff_1_2 = 0xB2898A)
				{
					status_thundercloud := 1
					
					SendInput {4 down}
					Sleep 16
					SendInput {4 up}
					; fire_counter += 15
					
				}
				

				
			}
			
			
			

			PixelGetColor, mana_10pct, 1305, 1092, RGB ; empty: 0x2D1D14
			
			; -- BLIZZARD III / TRANSPOSE: if low mana. (happens w or w/o enemy targeted.)
			if (mana_10pct = 0x2D1D14)
			{
				PixelGetColor, transpose_up, 872, 1148, RGB  ; upper left quad of button. non pressed. 0x81822D
				if (transpose_up = 0x81822D)
				{
					Sleep 21
					SendInput {r down}
					Sleep 22
					SendInput {r up}
					Sleep 24
				}
				
				Sleep 10
				SendInput 5
				
				; fire_counter += 57
			}
		
			Sleep 34
			
		}
		
Return





; -- ======================================================
; -- REFERENCE
; -- ======================================================

			; mana bar empty values. CERTIFIED. mana bar 1300-1500.
			/*
			PixelGetColor, mana_5pct, 1300, 1092, RGB  ; empty: 0x2C1C14 1 with this. close to 95pct val
			PixelGetColor, mana_10pct, 1305, 1092, RGB ; empty: 0x2D1D14 3 HAVE THIS
			PixelGetColor, mana_25pct, 1350, 1092, RGB ; empty: 0x2D1D14
			PixelGetColor, mana_50pct, 1400, 1092, RGB ; empty: 0x3E2C1F ??
			PixelGetColor, mana_75pct, 1450, 1092, RGB ; empty: 0x2D1D14
			PixelGetColor, mana_95pct, 1505, 1092, RGB ; empty: 0x2C1D14 1 WITH THIS. CLOSE TO 5pct val
			*/
			
			
			; other mana values w/ 1300-1500 castbar.
			/*
			PixelGetColor, mana_800_ish, 1307, 1090, RGB ; -- empty: 0x2B1B13 ; -- NOT WORKING
			PixelGetColor, mana_1000_ish, 1310, 1090, RGB ; -- empty: 0x2D1D14 ; - GUESSING
			*/


			; castbar progress
			/*
			PixelGetColor, castbar_20pct, 1217, 1028, RGB ; full: 0x860C48
			PixelGetColor, castbar_75pct, 1364, 1028, RGB ; full: 0xD64F8B
			PixelGetColor, castbar_90pct, 1400, 1028, RGB ; EMPTY?: 0x2B1B13. 
			*/


				/*
				else 
				{
					status_thundercloud := 0
				}
				*/
				
				; if in combat targeting someone, and high mana, cast fire I
				/*
				if (mana_9500 = 0xE05793)
				{
					SendInput 2
					Sleep 39
				}
				*/

				; -- if either firestarter or thundercloud just finished, and the other isn't active..continue with Fire I rotation.
				/*
				if (last_status_firestarter = 1 and status_firestarter = 0 and status_thundercloud = 0 or last_status_thundercloud = 1 and status_thundercloud = 0 and status_firestarter = 0)
				{	
					; start counting to 2300 ms to queue fire.
					
					SoundBeep, 750, 500
					fire_counter := 0
					
					
				}
				*/
				
				; -- cast fire I if it's been long enough
				/*
				if (fire_counter > 755)
				{	
					Send 23
					Sleep 68
					Send 23
					fire_counter := 0
				}
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
