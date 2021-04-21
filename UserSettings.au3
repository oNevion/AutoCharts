#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Users\mrjak\Documents\SublimeProjects\AutoCharts\assets\GUI_UserSettings.kxf
Global $GUI_UserSettings = GUICreate("User Settings", 236, 96, -1, -1)
Global $INPT_DropboxFolder = GUICtrlCreateInput("Path to Dropbox Folder", 16, 16, 201, 21)
Global $BTN_Save = GUICtrlCreateButton("Save", 16, 48, 75, 25)
Global $BTN_Default = GUICtrlCreateButton("Default", 144, 48, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $BTN_Save
			$DATA_UserSettings = GUICtrlRead($INPT_DropboxFolder)
			IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'DropboxDir', $DATA_UserSettings)
			Exit
	EndSwitch
WEnd
