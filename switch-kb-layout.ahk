;- keyboardx Capn Odin
; Google for LCID and convert number to Hex.
;https://autohotkey.com/boards/viewtopic.php?f=6&t=18519
#1::SetDefaultKeyboard(0x00000409) ; English (USA)
#2::SetDefaultKeyboard(0x00000419) ; Russian
#3::SetDefaultKeyboard(0x00020409) ; USA - International
#4::SetDefaultKeyboard(0x00000804) ; Chinese (Simplified)
#5::SetDefaultKeyboard(0x0000040A) ; Spanish

return

SetDefaultKeyboard(LocaleID){
	Global
	SPI_SETDEFAULTINPUTLANG := 0x005A
	SPIF_SENDWININICHANGE := 2
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(Lan%LocaleID%, 4, 0)
	NumPut(LocaleID, Lan%LocaleID%)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &Lan%LocaleID%, "UInt", SPIF_SENDWININICHANGE)
	WinGet, windows, List
	Loop %windows% {
		PostMessage 0x50, 0, %Lan%, , % "ahk_id " windows%A_Index%
	}
}
return

