
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=
Global $GUI = GUICreate("GUI", 197, 107, -1, -1)
Global $Notepad = GUICtrlCreateButton("Notepad", 16, 24, 75, 25)
Global $Calculator = GUICtrlCreateButton("Calculator", 96, 24, 75, 25)
Global $ExitButton = GUICtrlCreateButton("Exit", 56, 64, 75, 25)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Calculator
			StartCalc()

		Case $Notepad
			StartNotepad()
		Case $ExitButton
			Exit
	EndSwitch
WEnd





Func StartNotepad()
   Run('notepad.exe')
EndFunc ;==>StartNotepad

Func StartCalc()
   Run('calc.exe')
   WinWaitActive('Calculator')
   Sleep(500)
   Send('1234*2=')
EndFunc ;==>StartCalc

