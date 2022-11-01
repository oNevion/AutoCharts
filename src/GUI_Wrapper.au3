; ===============================================================================================================================
; Name ..........: GUI Wrapper for Autocharts
; Version .......: v3.1
; Author ........: oNevion
; ===============================================================================================================================

;!Highly recommended for improved overall performance and responsiveness of the GUI effects etc.! (after compiling):
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so /rm /pe

;YOU NEED TO EXCLUDE FOLLOWING FUNCTIONS FROM AU3STRIPPER, OTHERWISE IT WON'T WORK:
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
;Please not that Au3Stripper will show errors. You can ignore them as long as you use the above Au3Stripper_Ignore_Funcs parameters.

;Required if you want High DPI scaling enabled. (Also requries _Metro_EnableHighDPIScaling())
#AutoIt3Wrapper_Res_HiDpi=y
; ===============================================================================================================================

#NoTrayIcon
#include "GUI\MetroGUI_UDF.au3"
#include "GUI\_GUIDisable.au3" ; For Dim effects when msgbox is displayed
#include <GUIConstants.au3>

;=======================================================================Creating the GUI===============================================================================
;Enable high DPI support: Detects the users DPI settings and resizes GUI and all controls to look perfectly sharp.
_Metro_EnableHighDPIScaling() ; Note: Requries "#AutoIt3Wrapper_Res_HiDpi=y" for compiling. To see visible changes without compiling, you have to disable dpi scaling in compatibility settings of Autoit3.exe



SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)

Sleep(2000)
SplashOff()
CheckForFreshInstall()
OpenMainGUI()

Func OpenMainGUI()
	Global $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
	_LogaInfo("Set AutoCharts Drive directory to | " & $DropboxDir)                             ; Write to the logfile

	Global $INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
	_LogaInfo("Set UserName to | " & $INPT_Name)                ; Write to the logfile

	Global $Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
	_LogaInfo("Set current quarter to | " & $Select_Quarter)                  ; Write to the logfile

	Global $INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
	_LogaInfo("Set current year to | " & $INPT_CurYear)                  ; Write to the logfile

	Global $bDBVerified = IniRead($ini, 'Settings', 'DBVerified', '')
	_LogaInfo("AutoCharts Drive directory verified? | " & $bDBVerified)                  ; Write to the logfile

	Global $Select_Theme = IniRead($ini, 'Settings', 'UITheme', '')
	_LogaInfo("Set theme to | " & $Select_Theme)                ; Write to the logfile
	;Set Theme
	_SetTheme($Select_Theme) ;See MetroThemes.au3 for selectable themes or to add more

	;Create resizable Metro GUI
	Global $Form1 = _Metro_CreateGUI("AutoCharts 3.5.0", 540, 700, -1, -1, True)
	GUISetIcon(@ScriptDir & "\assets\GUI_Menus\programicon_hxv_icon.ico")
	;Add/create control buttons to the GUI
	$Control_Buttons = _Metro_AddControlButtons(True, True, True, True, True) ;CloseBtn = True, MaximizeBtn = True, MinimizeBtn = True, FullscreenBtn = True, MenuBtn = True

	;Set variables for the handles of the GUI-Control buttons. (Above function always returns an array this size and in this order, no matter which buttons are selected.)
	$GUI_CLOSE_BUTTON = $Control_Buttons[0]
	$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
	$GUI_RESTORE_BUTTON = $Control_Buttons[2]
	$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
	$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
	$GUI_FSRestore_BUTTON = $Control_Buttons[5]
	$GUI_MENU_BUTTON = $Control_Buttons[6]
	;======================================================================================================================================================================

	$Pic1 = GUICtrlCreatePic(@ScriptDir & "\assets\GUI_Menus\main-img.bmp", 0, 35, 540, 158, BitOR($GUI_SS_DEFAULT_PIC, $SS_CENTERIMAGE))

	$HSeperator1 = _Metro_AddHSeperator(50, 240, 440, 1)

	Local $Label_Main = GUICtrlCreateLabel("Please Select a Fund Family", 50, 275, 440, 50)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 20, 400, 0, "Segoe UI")

	;Create  Buttons
	$TAB_Catalyst = _Metro_CreateButton("Catalyst Funds", 50, 350, 140, 40)
	$TAB_Rational = _Metro_CreateButton("Rational Funds", 200, 350, 140, 40)
	$TAB_StrategyShares = _Metro_CreateButton("Strategy Shares", 350, 350, 140, 40)

	;Local $CB_PDF_Upload = _Metro_CreateCheckbox("Upload PDF to Website?", 50, 430, 200, 30)


	$HSeperator2 = _Metro_AddHSeperator(50, 570, 440, 1)


	Local $BTN_Settings = _Metro_CreateButton("Settings", 50, 600, 100, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)
	Local $BTN_About = _Metro_CreateButton("About", 170, 600, 100, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)


	Local $Label_Version = GUICtrlCreateLabel("v3.5.0", 450, 620, 50, 50, $SS_RIGHT)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 15, 400, 0, "Segoe UI")


	;Set resizing options for the controls so they don't change in size or position. This can be customized to match your gui perfectly for resizing. See AutoIt Help file.
	GUICtrlSetResizing($Pic1, 768 + 8)
	GUICtrlSetResizing($HSeperator1, 768 + 8)
	GUICtrlSetResizing($TAB_Catalyst, 768 + 8)
	GUICtrlSetResizing($TAB_Rational, 768 + 8)
	GUICtrlSetResizing($TAB_StrategyShares, 768 + 8)
	GUICtrlSetResizing($HSeperator2, 768 + 8)
	GUICtrlSetResizing($BTN_Settings, 768 + 8)
	GUICtrlSetResizing($BTN_About, 768 + 8)
	GUICtrlSetResizing($Label_Version, 768 + 8)
	GUICtrlSetResizing($Label_Main, 768 + 8)

	GUISetState(@SW_SHOW)


	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Exit
			Case $GUI_MAXIMIZE_BUTTON
				GUISetState(@SW_MAXIMIZE, $Form1)
			Case $GUI_MINIMIZE_BUTTON
				GUISetState(@SW_MINIMIZE, $Form1)
			Case $GUI_RESTORE_BUTTON
				GUISetState(@SW_RESTORE, $Form1)
			Case $GUI_FULLSCREEN_BUTTON, $GUI_FSRestore_BUTTON
				ConsoleWrite("Fullscreen toggled" & @CRLF) ;Fullscreen toggle is processed automatically when $ControlBtnsAutoMode is set to true, otherwise you need to use here _Metro_FullscreenToggle($Form1)
			Case $GUI_MENU_BUTTON
				;Create an Array containing menu button names
				Local $MenuButtonsArray[5] = ["Archive Factsheets", "Settings", "Sync Options", "Help", "Exit"]
				; Open the metro Menu. See decleration of $MenuButtonsArray above.
				Local $MenuSelect = _Metro_MenuStart($Form1, 150, $MenuButtonsArray)
				Switch $MenuSelect ;Above function returns the index number of the selected button from the provided buttons array.
					Case "0"
						CreateFactSheetArchive()
					Case "1"
						_GUIDisable($Form1, 0, 50)
						_SettingsGUI()
						_GUIDisable($Form1)

					Case "2"
						_GUIDisable($Form1, 0, 50)
						_SyncGUI()
						_GUIDisable($Form1)

					Case "3"
						_GUIDisable($Form1, 0, 50)
						_HelpGUI()
						_GUIDisable($Form1)

					Case "4"
						_Metro_GUIDelete($Form1)
						Exit
				EndSwitch


			Case $TAB_Catalyst
				_GUIDisable($Form1, 0, 50)
				_CatalystFundsGUI()
				_GUIDisable($Form1)
			Case $TAB_Rational
				_GUIDisable($Form1, 0, 50)

				_RationalFundsGUI()
				_GUIDisable($Form1)

			Case $TAB_StrategyShares
				_GUIDisable($Form1, 0, 50)

				_StrategySharesFundsGUI()
				_GUIDisable($Form1)

			Case $BTN_Settings
				_GUIDisable($Form1, 0, 50)
				_SettingsGUI()
				_GUIDisable($Form1)

			Case $BTN_About
				ShellExecute("https://onevion.github.io/AutoCharts/")




		EndSwitch
	WEnd
EndFunc   ;==>OpenMainGUI


Func _CatalystFundsGUI()

	Local $Form2 = _Metro_CreateGUI("Catalyst Funds GUI", 540, 620, -1, -1, False, $Form1)
	;Add control buttons
	Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
	Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]



	;Create Fund Toggles
	Local $ACX = _Metro_CreateToggle("ACX", 50, 50, 130, 30)
	Local $ATR = _Metro_CreateToggle("ATR", 50, 95, 130, 30)
	Local $BUY = _Metro_CreateToggle("BUY", 50, 140, 130, 30)
	Local $CAX = _Metro_CreateToggle("CAX", 50, 185, 130, 30)
	Local $CFR = _Metro_CreateToggle("CFR", 50, 230, 130, 30)
	Local $CLP = _Metro_CreateToggle("CLP", 50, 275, 130, 30)
	Local $CLT = _Metro_CreateToggle("CLT", 50, 320, 130, 30)
	Local $CPE = _Metro_CreateToggle("CPE", 50, 365, 130, 30)

	Local $vSeperator1 = _Metro_AddVSeperator(180, 50, 350, 1)

	Local $CWX = _Metro_CreateToggle("CWX", 220, 50, 130, 30)
	Local $DCX = _Metro_CreateToggle("DCX", 220, 95, 130, 30)
	Local $EIX = _Metro_CreateToggle("EIX", 220, 140, 130, 30)
	Local $HII = _Metro_CreateToggle("HII", 220, 185, 130, 30)
	Local $IIX = _Metro_CreateToggle("IIX", 220, 230, 130, 30)
	Local $INS = _Metro_CreateToggle("INS", 220, 275, 130, 30)
	Local $IOX = _Metro_CreateToggle("IOX", 220, 320, 130, 30)
	Local $MBX = _Metro_CreateToggle("MBX", 220, 365, 130, 30)

	Local $vSeperator2 = _Metro_AddVSeperator(350, 50, 350, 1)

	Local $MLX = _Metro_CreateToggle("MLX", 390, 50, 130, 30)
	Local $SHI = _Metro_CreateToggle("SHI", 390, 95, 130, 30)
	Local $TRI = _Metro_CreateToggle("TRI", 390, 140, 130, 30)
	Local $TRX = _Metro_CreateToggle("TRX", 390, 185, 130, 30)
	Local $UCITS = _Metro_CreateToggle("UCITS", 390, 230, 130, 30)

	Global $UpdateLabel = GUICtrlCreateLabel("", 50, 420, 440, 20)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")

	Global $CB_FactSheet_Catalyst = _Metro_CreateCheckbox("Factsheet", 60, 450, 105, 30)
	Global $CB_Brochure_Catalyst = _Metro_CreateCheckbox("Brochure", 210, 450, 105, 30)
	Global $CB_Presentation_Catalyst = _Metro_CreateCheckbox("Presentation", 350, 450, 115, 30)

	_Metro_CheckboxCheck($CB_FactSheet_Catalyst, True)


	Global $BTN_RunCatalyst = _Metro_CreateButton("Process Updates", 50, 550, 210, 40)
	Global $BTN_Catalyst_UpdateExpenseRatio = _Metro_CreateButtonEx("Update Expense Ratios", 280, 550, 210, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)
	Local $BTN_Back = _Metro_AddControlButton_Back()
	Global $ProgressBar = _Metro_CreateProgress(50, 500, 440, 26)

	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $BTN_Back, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form2) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0

			Case $ACX
				If _Metro_ToggleIsChecked($ACX) Then
					_Metro_ToggleUnCheck($ACX)
					$aCatalystCheck[0] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($ACX)
					$aCatalystCheck[0] = "ACX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[0] & " Toggle checked!" & @CRLF)
				EndIf

			Case $ATR
				If _Metro_ToggleIsChecked($ATR) Then
					_Metro_ToggleUnCheck($ATR)
					$aCatalystCheck[1] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($ATR)
					$aCatalystCheck[1] = "ATR" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[1] & " Toggle checked!" & @CRLF)
				EndIf

			Case $BUY
				If _Metro_ToggleIsChecked($BUY) Then
					_Metro_ToggleUnCheck($BUY)
					$aCatalystCheck[2] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($BUY)
					$aCatalystCheck[2] = "BUY" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[2] & " Toggle checked!" & @CRLF)
				EndIf

			Case $CAX
				If _Metro_ToggleIsChecked($CAX) Then
					_Metro_ToggleUnCheck($CAX)
					$aCatalystCheck[3] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($CAX)
					$aCatalystCheck[3] = "CAX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[3] & " Toggle checked!" & @CRLF)
				EndIf

			Case $CFR
				If _Metro_ToggleIsChecked($CFR) Then
					_Metro_ToggleUnCheck($CFR)
					$aCatalystCheck[4] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($CFR)
					$aCatalystCheck[4] = "CFR" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[4] & " Toggle checked!" & @CRLF)
				EndIf

			Case $CLP
				If _Metro_ToggleIsChecked($CLP) Then
					_Metro_ToggleUnCheck($CLP)
					$aCatalystCheck[5] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($CLP)
					$aCatalystCheck[5] = "CLP" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[5] & " Toggle checked!" & @CRLF)
				EndIf

			Case $CLT
				If _Metro_ToggleIsChecked($CLT) Then
					_Metro_ToggleUnCheck($CLT)
					$aCatalystCheck[6] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($CLT)
					$aCatalystCheck[6] = "CLT" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[6] & " Toggle checked!" & @CRLF)
				EndIf



			Case $CPE
				If _Metro_ToggleIsChecked($CPE) Then
					_Metro_ToggleUnCheck($CPE)
					$aCatalystCheck[7] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($CPE)
					$aCatalystCheck[7] = "CPE" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[7] & " Toggle checked!" & @CRLF)
				EndIf

			Case $CWX
				If _Metro_ToggleIsChecked($CWX) Then
					_Metro_ToggleUnCheck($CWX)
					$aCatalystCheck[8] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($CWX)
					$aCatalystCheck[8] = "CWX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[8] & " Toggle checked!" & @CRLF)
				EndIf

			Case $DCX
				If _Metro_ToggleIsChecked($DCX) Then
					_Metro_ToggleUnCheck($DCX)
					$aCatalystCheck[9] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($DCX)
					$aCatalystCheck[9] = "DCX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[9] & " Toggle checked!" & @CRLF)

				EndIf

			Case $EIX
				If _Metro_ToggleIsChecked($EIX) Then
					_Metro_ToggleUnCheck($EIX)
					$aCatalystCheck[10] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($EIX)
					$aCatalystCheck[10] = "EIX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[10] & " Toggle checked!" & @CRLF)
				EndIf

			Case $HII
				If _Metro_ToggleIsChecked($HII) Then
					_Metro_ToggleUnCheck($HII)
					$aCatalystCheck[11] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($HII)
					$aCatalystCheck[11] = "HII" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[11] & " Toggle checked!" & @CRLF)
				EndIf

			Case $IIX
				If _Metro_ToggleIsChecked($IIX) Then
					_Metro_ToggleUnCheck($IIX)
					$aCatalystCheck[12] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($IIX)
					$aCatalystCheck[12] = "IIX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[12] & " Toggle checked!" & @CRLF)
				EndIf

			Case $INS
				If _Metro_ToggleIsChecked($INS) Then
					_Metro_ToggleUnCheck($INS)
					$aCatalystCheck[13] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($INS)
					$aCatalystCheck[13] = "INS" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[13] & " Toggle checked!" & @CRLF)
				EndIf

			Case $IOX
				If _Metro_ToggleIsChecked($IOX) Then
					_Metro_ToggleUnCheck($IOX)
					$aCatalystCheck[14] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($IOX)
					$aCatalystCheck[14] = "IOX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[14] & " Toggle checked!" & @CRLF)
				EndIf

			Case $MBX
				If _Metro_ToggleIsChecked($MBX) Then
					_Metro_ToggleUnCheck($MBX)
					$aCatalystCheck[15] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($MBX)
					$aCatalystCheck[15] = "MBX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[15] & " Toggle checked!" & @CRLF)
				EndIf

			Case $MLX
				If _Metro_ToggleIsChecked($MLX) Then
					_Metro_ToggleUnCheck($MLX)
					$aCatalystCheck[16] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($MLX)
					$aCatalystCheck[16] = "MLX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[16] & " Toggle checked!" & @CRLF)
				EndIf

			Case $SHI
				If _Metro_ToggleIsChecked($SHI) Then
					_Metro_ToggleUnCheck($SHI)
					$aCatalystCheck[17] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($SHI)
					$aCatalystCheck[17] = "SHI" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[17] & " Toggle checked!" & @CRLF)
				EndIf


			Case $TRI
				If _Metro_ToggleIsChecked($TRI) Then
					_Metro_ToggleUnCheck($TRI)
					$aCatalystCheck[19] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($TRI)
					$aCatalystCheck[19] = "TRI" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[19] & " Toggle checked!" & @CRLF)
				EndIf

			Case $TRX
				If _Metro_ToggleIsChecked($TRX) Then
					_Metro_ToggleUnCheck($TRX)
					$aCatalystCheck[20] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($TRX)
					$aCatalystCheck[20] = "TRX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[20] & " Toggle checked!" & @CRLF)
				EndIf

			Case $UCITS
				If _Metro_ToggleIsChecked($UCITS) Then
					_Metro_ToggleUnCheck($UCITS)
					$aCatalystCheck[21] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($UCITS)
					$aCatalystCheck[21] = "UCITS" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aCatalystCheck[21] & " Toggle checked!" & @CRLF)
				EndIf

			Case $CB_FactSheet_Catalyst
				If _Metro_CheckboxIsChecked($CB_FactSheet_Catalyst) Then
					_Metro_CheckboxUnCheck($CB_FactSheet_Catalyst)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_FactSheet_Catalyst)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $CB_Brochure_Catalyst
				If _Metro_CheckboxIsChecked($CB_Brochure_Catalyst) Then
					_Metro_CheckboxUnCheck($CB_Brochure_Catalyst)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_Brochure_Catalyst)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $CB_Presentation_Catalyst
				If _Metro_CheckboxIsChecked($CB_Presentation_Catalyst) Then
					_Metro_CheckboxUnCheck($CB_Presentation_Catalyst)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_Presentation_Catalyst)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $BTN_RunCatalyst

				VerifyDropbox()
				If $bDBVerified = True Then
					$FundFamily = "Catalyst"
					$FamilySwitch = $aCatalystCheck
					ImportDatalinker()
					RunCSVConvert()
					CreateCharts()

					_LogaInfo("############################### END OF RUN - CATALYST ###############################")
					Global $aCatalystCheck[24]

					_GUIDisable($Form2, 0, 30)
					_Metro_MsgBox(0, "Finished", "The process has finished.", 500, 11, $Form2)

					_GUIDisable($Form2)
					_Metro_GUIDelete($Form2) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
					Return 0
				Else
					If @error = 50 Then

						_GUIDisable($Form2, 0, 30)
						_Metro_MsgBox(0, "Error", "Error Code: " & @error & " | AutoCharts Drive path not verified. Process has been aborted.", 500, 11, $Form2)
						_GUIDisable($Form2)

					EndIf
				EndIf

			Case $BTN_Catalyst_UpdateExpenseRatio
				$FundFamily = "Catalyst"
				$FamilySwitch = $aCatalystCheck
				GUICtrlSetData($ProgressBar, 10)
				ImportDatalinker()
				PullCatalystData()
				RunExpenseRatios()

				_LogaInfo("############################### END OF RUN - CATALYST ###############################")             ; Write to the logfile

				GUICtrlSetData($ProgressBar, 0)
				Global $aCatalystCheck[24]

				_GUIDisable($Form2, 0, 30)
				_Metro_MsgBox(0, "Finished", "The process has finished.", 500, 11, $Form2)
				_GUIDisable($Form2)

				If @error = 50 Then

					_GUIDisable($Form2, 0, 30)
					_Metro_MsgBox(0, "Error", "Error Code: " & @error & " | AutoCharts Drive path not verified. Process has been aborted.", 500, 11, $Form2)
					_GUIDisable($Form2)

				EndIf

		EndSwitch
	WEnd
EndFunc   ;==>_CatalystFundsGUI




Func _RationalFundsGUI()
	Local $Form3 = _Metro_CreateGUI("Rational Funds GUI", 540, 620, -1, -1, False, $Form1)
	;Add control buttons
	Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
	Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]


	;Create Fund Toggles
	Local $HDC = _Metro_CreateToggle("HDC", 50, 50, 130, 30)
	Local $HRS = _Metro_CreateToggle("HRS", 50, 95, 130, 30)
	Local $HSU = _Metro_CreateToggle("HSU", 50, 140, 130, 30)
	Local $IGO = _Metro_CreateToggle("IGO", 50, 185, 130, 30)
	Local $PBX = _Metro_CreateToggle("PBX", 50, 230, 130, 30)
	Local $RDM = _Metro_CreateToggle("RDM", 50, 275, 130, 30)
	Local $RFX = _Metro_CreateToggle("RFX", 50, 320, 130, 30)
	Local $RHS = _Metro_CreateToggle("RHS", 50, 365, 130, 30)

	Local $vSeperator1 = _Metro_AddVSeperator(180, 50, 350, 1)

	Local $vSeperator2 = _Metro_AddVSeperator(350, 50, 350, 1)

	Global $UpdateLabel = GUICtrlCreateLabel("", 50, 420, 440, 20)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")

	Global $CB_FactSheet_Rational = _Metro_CreateCheckbox("Factsheet", 60, 450, 105, 30)
	Global $CB_Brochure_Rational = _Metro_CreateCheckbox("Brochure", 210, 450, 105, 30)
	Global $CB_Presentation_Rational = _Metro_CreateCheckbox("Presentation", 350, 450, 115, 30)

	_Metro_CheckboxCheck($CB_FactSheet_Rational, True)


	Local $BTN_RunRational = _Metro_CreateButton("Process Updates", 50, 550, 210, 40)
	Local $BTN_Rational_UpdateExpenseRatio = _Metro_CreateButton("Update Expense Ratios", 280, 550, 210, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)
	Local $BTN_Back = _Metro_AddControlButton_Back()
	Global $ProgressBar = _Metro_CreateProgress(50, 500, 440, 26)

	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $BTN_Back, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form3) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0

			Case $RHS
				If _Metro_ToggleIsChecked($RHS) Then
					_Metro_ToggleUnCheck($RHS)
					$aRationalCheck[0] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($RHS)
					$aRationalCheck[0] = "RHS" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[0] & " Toggle checked!" & @CRLF)
				EndIf

			Case $HDC
				If _Metro_ToggleIsChecked($HDC) Then
					_Metro_ToggleUnCheck($HDC)
					$aRationalCheck[1] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($HDC)
					$aRationalCheck[1] = "HDC" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[1] & " Toggle checked!" & @CRLF)
				EndIf

			Case $HRS
				If _Metro_ToggleIsChecked($HRS) Then
					_Metro_ToggleUnCheck($HRS)
					$aRationalCheck[2] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($HRS)
					$aRationalCheck[2] = "HRS" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[2] & " Toggle checked!" & @CRLF)
				EndIf

			Case $HSU
				If _Metro_ToggleIsChecked($HSU) Then
					_Metro_ToggleUnCheck($HSU)
					$aRationalCheck[3] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($HSU)
					$aRationalCheck[3] = "HSU" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[3] & " Toggle checked!" & @CRLF)
				EndIf

			Case $IGO
				If _Metro_ToggleIsChecked($IGO) Then
					_Metro_ToggleUnCheck($IGO)
					$aRationalCheck[4] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($IGO)
					$aRationalCheck[4] = "IGO" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[4] & " Toggle checked!" & @CRLF)
				EndIf

			Case $PBX
				If _Metro_ToggleIsChecked($PBX) Then
					_Metro_ToggleUnCheck($PBX)
					$aRationalCheck[5] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($PBX)
					$aRationalCheck[5] = "PBX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[5] & " Toggle checked!" & @CRLF)
				EndIf

			Case $RDM
				If _Metro_ToggleIsChecked($RDM) Then
					_Metro_ToggleUnCheck($RDM)
					$aRationalCheck[6] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($RDM)
					$aRationalCheck[6] = "RDM" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[6] & " Toggle checked!" & @CRLF)
				EndIf

			Case $RFX
				If _Metro_ToggleIsChecked($RFX) Then
					_Metro_ToggleUnCheck($RFX)
					$aRationalCheck[7] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($RFX)
					$aRationalCheck[7] = "RFX" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aRationalCheck[7] & " Toggle checked!" & @CRLF)
				EndIf

			Case $CB_FactSheet_Rational
				If _Metro_CheckboxIsChecked($CB_FactSheet_Rational) Then
					_Metro_CheckboxUnCheck($CB_FactSheet_Rational)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_FactSheet_Rational)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $CB_Brochure_Rational
				If _Metro_CheckboxIsChecked($CB_Brochure_Rational) Then
					_Metro_CheckboxUnCheck($CB_Brochure_Rational)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_Brochure_Rational)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $CB_Presentation_Rational
				If _Metro_CheckboxIsChecked($CB_Presentation_Rational) Then
					_Metro_CheckboxUnCheck($CB_Presentation_Rational)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_Presentation_Rational)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $BTN_RunRational
				$FundFamily = "Rational"
				$FamilySwitch = $aRationalCheck
				GUICtrlSetData($ProgressBar, 10)
				ImportDatalinker()
				RunCSVConvert()
				CreateCharts()

				_LogaInfo("############################### END OF RUN - RATIONAL ###############################")         ; Write to the logfile

				GUICtrlSetData($ProgressBar, 0)
				Global $aRationalCheck[8]

				_GUIDisable($Form3, 0, 30)
				_Metro_MsgBox(0, "Finished", "The process has finished.", 500, 11, $Form3)
				_GUIDisable($Form3)

				_Metro_GUIDelete($Form3) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0
			Case $BTN_Rational_UpdateExpenseRatio
				$FundFamily = "Rational"
				$FamilySwitch = $aRationalCheck
				GUICtrlSetData($ProgressBar, 10)
				ImportDatalinker()

				PullRationalData()
				RunExpenseRatios()

				_LogaInfo("############################### END OF RUN - RATIONAL ###############################")             ; Write to the logfile

				GUICtrlSetData($ProgressBar, 0)
				Global $aRationalCheck[8]

				_GUIDisable($Form3, 0, 30)
				_Metro_MsgBox(0, "Finished", "The process has finished.", 500, 11, $Form3)
				_GUIDisable($Form3)
				If @error = 50 Then

					_GUIDisable($Form3, 0, 30)
					_Metro_MsgBox(0, "Error", "Error Code: " & @error & " | AutoCharts Drive path not verified. Process has been aborted.", 500, 11, $Form3)
					_GUIDisable($Form3)
				EndIf

		EndSwitch
	WEnd
EndFunc   ;==>_RationalFundsGUI




Func _StrategySharesFundsGUI()
	Local $Form4 = _Metro_CreateGUI("Strategy Shares Funds GUI", 540, 620, -1, -1, False, $Form1)
	;Add control buttons
	Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
	Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]


	;Create Fund Toggles
	Local $GLDB = _Metro_CreateToggle("GLDB", 50, 50, 130, 30)
	Local $HNDL = _Metro_CreateToggle("HNDL", 50, 95, 130, 30)
	Local $ROMO = _Metro_CreateToggle("ROMO", 50, 140, 130, 30)
	Local $FIVR = _Metro_CreateToggle("FIVR", 50, 185, 130, 30)
	Local $TENH = _Metro_CreateToggle("TENH", 50, 230, 130, 30)
	Local $NZRO = _Metro_CreateToggle("NZRO", 50, 275, 130, 30)

	Local $vSeperator1 = _Metro_AddVSeperator(180, 50, 350, 1)

	Local $vSeperator1 = _Metro_AddVSeperator(350, 50, 350, 1)

	Global $UpdateLabel = GUICtrlCreateLabel("", 50, 420, 440, 20)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")

	Global $CB_FactSheet_SS = _Metro_CreateCheckbox("Factsheet", 60, 450, 105, 30)
	Global $CB_Brochure_SS = _Metro_CreateCheckbox("Brochure", 210, 450, 105, 30)
	Global $CB_Presentation_SS = _Metro_CreateCheckbox("Presentation", 350, 450, 115, 30)

	_Metro_CheckboxCheck($CB_FactSheet_SS, True)


	Local $BTN_RunStrategyShares = _Metro_CreateButton("Process Updates", 50, 550, 210, 40)
	Local $BTN_Back = _Metro_AddControlButton_Back()
	Global $ProgressBar = _Metro_CreateProgress(50, 500, 440, 26)

	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $BTN_Back, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form4) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0

			Case $GLDB
				If _Metro_ToggleIsChecked($GLDB) Then
					_Metro_ToggleUnCheck($GLDB)
					$aStrategyCheck[0] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($GLDB)
					$aStrategyCheck[0] = "GLDB" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aStrategyCheck[0] & " Toggle checked!" & @CRLF)
				EndIf

			Case $HNDL
				If _Metro_ToggleIsChecked($HNDL) Then
					_Metro_ToggleUnCheck($HNDL)
					$aStrategyCheck[1] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($HNDL)
					$aStrategyCheck[1] = "HNDL" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aStrategyCheck[1] & " Toggle checked!" & @CRLF)
				EndIf

			Case $ROMO
				If _Metro_ToggleIsChecked($ROMO) Then
					_Metro_ToggleUnCheck($ROMO)
					$aStrategyCheck[2] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($ROMO)
					$aStrategyCheck[2] = "ROMO" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aStrategyCheck[2] & " Toggle checked!" & @CRLF)
				EndIf

			Case $FIVR
				If _Metro_ToggleIsChecked($FIVR) Then
					_Metro_ToggleUnCheck($FIVR)
					$aStrategyCheck[3] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($FIVR)
					$aStrategyCheck[3] = "FIVR" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aStrategyCheck[3] & " Toggle checked!" & @CRLF)
				EndIf

			Case $TENH
				If _Metro_ToggleIsChecked($TENH) Then
					_Metro_ToggleUnCheck($TENH)
					$aStrategyCheck[4] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($TENH)
					$aStrategyCheck[4] = "TENH" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aStrategyCheck[4] & " Toggle checked!" & @CRLF)
				EndIf

			Case $NZRO
				If _Metro_ToggleIsChecked($NZRO) Then
					_Metro_ToggleUnCheck($NZRO)
					$aStrategyCheck[5] = 0 ; Sets first slot of the Catalyst Array to 1 if CHECKED
					ConsoleWrite("Toggle unchecked!" & @CRLF)
				Else
					_Metro_ToggleCheck($NZRO)
					$aStrategyCheck[5] = "NZRO" ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					ConsoleWrite($aStrategyCheck[5] & " Toggle checked!" & @CRLF)
				EndIf


			Case $CB_FactSheet_SS
				If _Metro_CheckboxIsChecked($CB_FactSheet_SS) Then
					_Metro_CheckboxUnCheck($CB_FactSheet_SS)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_FactSheet_SS)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $CB_Brochure_SS
				If _Metro_CheckboxIsChecked($CB_Brochure_SS) Then
					_Metro_CheckboxUnCheck($CB_Brochure_SS)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_Brochure_SS)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $CB_Presentation_SS
				If _Metro_CheckboxIsChecked($CB_Presentation_SS) Then
					_Metro_CheckboxUnCheck($CB_Presentation_SS)
					ConsoleWrite("Checkbox unchecked!" & @CRLF)
				Else
					_Metro_CheckboxCheck($CB_Presentation_SS)
					ConsoleWrite("Checkbox checked!" & @CRLF)
				EndIf

			Case $BTN_RunStrategyShares
				$FundFamily = "StrategyShares"
				$FamilySwitch = $aStrategyCheck
				GUICtrlSetData($ProgressBar, 10)
				ImportDatalinker()

				;PullStrategySharesData()
				RunCSVConvert()
				CreateCharts()

				_LogaInfo("############################### END OF RUN - STRATEGY SHARES ###############################")         ; Write to the logfile
				Global $aStrategyCheck[6]

				GUICtrlSetData($ProgressBar, 0)
				_GUIDisable($Form4, 0, 30)
				_Metro_MsgBox(0, "Finished", "The process has finished.", 500, 11, $Form4)
				_GUIDisable($Form4)

				_Metro_GUIDelete($Form4) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0

		EndSwitch
	WEnd
EndFunc   ;==>_StrategySharesFundsGUI

Func _SettingsGUI()

	$DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
	$INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
	$Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
	$INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')


	Global $Form5 = _Metro_CreateGUI("AutoCharts Settings", 540, 620, -1, -1, False, $Form1)
	;Add control buttons
	Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
	Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]


	;Create Settings Options
	Local $Label_Dropbox = GUICtrlCreateLabel("Path to AutoCharts Drive:", 50, 50, 440, 20)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
	Global $INPT_DropboxFolder = GUICtrlCreateInput($DropboxDir, 50, 75, 440, 30)
	GUICtrlSetFont(-1, 11, 500, 0, "Segoe UI")
	Local $BTN_SelectDBPath = _Metro_CreateButton("Browse", 280, 110, 210, 40)


	Local $Label_Name = GUICtrlCreateLabel("Your Name:", 50, 175, 440, 40)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")

	Local $INPT_Name_BOX = GUICtrlCreateInput($INPT_Name, 50, 200, 440, 30)
	GUICtrlSetFont(-1, 11, 500, 0, "Segoe UI")

	Local $Label_CurQuarter = GUICtrlCreateLabel("Current Quarter:", 50, 275, 440, 40)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")

	;Create 4 Radios that are assigned to Radio Group 1
	Local $Radio_Q1 = _Metro_CreateRadioEx("1", "Q1", 50, 300, 100, 30)
	If $Select_Quarter = "Q1" Then
		_Metro_RadioCheck("1", $Radio_Q1)         ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf

	Local $Radio_Q2 = _Metro_CreateRadioEx("1", "Q2", 160, 300, 100, 30)
	If $Select_Quarter = "Q2" Then
		_Metro_RadioCheck("1", $Radio_Q2)         ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf

	Local $Radio_Q3 = _Metro_CreateRadioEx("1", "Q3", 270, 300, 100, 30)
	If $Select_Quarter = "Q3" Then
		_Metro_RadioCheck("1", $Radio_Q3)         ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf

	Local $Radio_Q4 = _Metro_CreateRadioEx("1", "Q4", 380, 300, 100, 30)
	If $Select_Quarter = "Q4" Then
		_Metro_RadioCheck("1", $Radio_Q4)         ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf


	Local $Label_CurYear = GUICtrlCreateLabel("Current Year:", 50, 375, 440, 40)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")

	Local $INPT_CurYear_BOX = GUICtrlCreateInput($INPT_CurYear, 50, 400, 440, 30)
	GUICtrlSetFont(-1, 11, 500, 0, "Segoe UI")


	;Create 4 Radios that are assigned to Radio Group 1
	Local $Radio_DarkBlue = _Metro_CreateRadioEx("2", "Blue", 50, 480, 100, 30)
	If $Select_Theme = "DarkBlue" Then
		_Metro_RadioCheck("2", $Radio_DarkBlue)                 ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf

	Local $Radio_LightBlue = _Metro_CreateRadioEx("2", "Blue 2", 160, 480, 100, 30)
	If $Select_Theme = "LightBlue" Then
		_Metro_RadioCheck("2", $Radio_LightBlue)                 ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf

	Local $Radio_DarkPurple = _Metro_CreateRadioEx("2", "Purple", 270, 480, 100, 30)
	If $Select_Theme = "DarkPurple" Then
		_Metro_RadioCheck("2", $Radio_DarkPurple)                 ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf

	Local $Radio_LightPurple = _Metro_CreateRadioEx("2", "Purple 2", 380, 480, 100, 30)
	If $Select_Theme = "LightPurple" Then
		_Metro_RadioCheck("2", $Radio_LightPurple)                 ;check $Radio1 which is assigned to radio group "1" and uncheck any other radio in group "1"
	EndIf



	Local $BTN_Save = _Metro_CreateButton("Save Settings", 50, 550, 210, 40)
	Local $BTN_Cancel = _Metro_CreateButton("Cancel", 280, 550, 210, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)

	Local $BTN_Back = _Metro_AddControlButton_Back()


	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $BTN_Back, $GUI_CLOSE_BUTTON, $BTN_Cancel
				_Metro_GUIDelete($Form5) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0

			Case $BTN_SelectDBPath
				BrowseForDBPath()

			Case $Radio_Q1
				_Metro_RadioCheck(1, $Radio_Q1)
				ConsoleWrite("Radio 1 selected!" & @CRLF)
			Case $Radio_Q2
				_Metro_RadioCheck(1, $Radio_Q2)
				ConsoleWrite("Radio 4 selected!" & @CRLF)
			Case $Radio_Q3
				_Metro_RadioCheck(1, $Radio_Q3)
				ConsoleWrite("Radio 3 selected!" & @CRLF)
			Case $Radio_Q4
				_Metro_RadioCheck(1, $Radio_Q4)
				ConsoleWrite("Radio 4 selected!" & @CRLF)


			Case $Radio_DarkBlue
				_Metro_RadioCheck(2, $Radio_DarkBlue)
				ConsoleWrite("Dark Blue Theme selected!" & @CRLF)
			Case $Radio_LightBlue
				_Metro_RadioCheck(2, $Radio_LightBlue)
				ConsoleWrite("Light Blue Theme selected!" & @CRLF)
			Case $Radio_DarkPurple
				_Metro_RadioCheck(2, $Radio_DarkPurple)
				ConsoleWrite("Dark Purple Theme selected!" & @CRLF)
			Case $Radio_LightPurple
				_Metro_RadioCheck(2, $Radio_LightPurple)
				ConsoleWrite("Light Purple Theme selected!" & @CRLF)

			Case $BTN_Save
				$DATA_UserSettings = GUICtrlRead($INPT_DropboxFolder)
				If $DATA_UserSettings = "" Then
					_GUIDisable($Form5, 0, 30)
					_Metro_MsgBox(0, "Error!", "You must select the AutoCharts Drive!", 500, 11, $Form5)
					_GUIDisable($Form5)
				Else
					$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'DropboxDir', $DATA_UserSettings)

					$DATA_UserSettings = GUICtrlRead($INPT_Name_BOX)
					$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UserName', $DATA_UserSettings)

					If _Metro_RadioIsChecked(1, $Radio_Q1) Then
						$Select_Quarter = "Q1"     ; Checks to see if Radio for Q1 is Checked
						$DATA_UserSettings = "Q1"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
					EndIf

					If _Metro_RadioIsChecked(1, $Radio_Q2) Then
						$Select_Quarter = "Q2"     ; Checks to see if Radio for Q2 is Checked
						$DATA_UserSettings = "Q2"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
					EndIf

					If _Metro_RadioIsChecked(1, $Radio_Q3) Then
						$Select_Quarter = "Q3"     ; Checks to see if Radio for Q3 is Checked
						$DATA_UserSettings = "Q3"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
					EndIf

					If _Metro_RadioIsChecked(1, $Radio_Q4) Then
						$Select_Quarter = "Q4"     ; Checks to see if Radio for Q4 is Checked
						$DATA_UserSettings = "Q4"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
					EndIf



					If _Metro_RadioIsChecked(2, $Radio_DarkBlue) Then
						$Select_Theme = "DarkBlue"     ; Checks to see if Radio for Dark Blue Theme is Checked
						_SetTheme("DarkBlue") ;See MetroThemes.au3 for selectable themes or to add more

						$DATA_UserSettings = "DarkBlue"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $DATA_UserSettings)
					EndIf


					If _Metro_RadioIsChecked(2, $Radio_LightBlue) Then
						$Select_Theme = "LightBlue"     ; Checks to see if Radio for Dark Blue Theme is Checked
						_SetTheme("LightBlue") ;See MetroThemes.au3 for selectable themes or to add more

						$DATA_UserSettings = "LightBlue"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $DATA_UserSettings)
					EndIf


					If _Metro_RadioIsChecked(2, $Radio_DarkPurple) Then
						$Select_Theme = "DarkPurple"     ; Checks to see if Radio for Dark Blue Theme is Checked
						_SetTheme("DarkPurple") ;See MetroThemes.au3 for selectable themes or to add more

						$DATA_UserSettings = "DarkPurple"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $DATA_UserSettings)
					EndIf


					If _Metro_RadioIsChecked(2, $Radio_LightPurple) Then
						$Select_Theme = "LightPurple"     ; Checks to see if Radio for Dark Blue Theme is Checked
						_SetTheme("LightPurple") ;See MetroThemes.au3 for selectable themes or to add more

						$DATA_UserSettings = "LightPurple"
						$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $DATA_UserSettings)
					EndIf


					$DATA_UserSettings = GUICtrlRead($INPT_CurYear_BOX)
					$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentYear', $DATA_UserSettings)

					If $iSettingsConfirm = 1 Then

						$DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
						$INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
						$Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
						$INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
						$bDBVerified = IniRead($ini, 'Settings', 'DBVerified', '')
						$Select_Theme = IniRead($ini, 'Settings', 'UITheme', '')

						DetermineDates()
						_GUIDisable($Form5, 0, 30)
						_Metro_MsgBox(0, "Success!", "Your settings were saved.", 500, 11, $Form5)
						_GUIDisable($Form5)
					Else
						_GUIDisable($Form5, 0, 30)
						_Metro_MsgBox(0, "Error!", "An error occured", 500, 11, $Form5)
						_GUIDisable($Form5)
					EndIf
					VerifyDropbox()
					If @error = 50 Then
						_GUIDisable($Form5, 0, 30)
						_Metro_MsgBox(0, "Error!", "Error Code: " & @error & " | AutoCharts Drive path not verified. Please try resetting it.", 500, 11, $Form5)
						_GUIDisable($Form5)
					EndIf

					FileCopy(@ScriptDir & "\settings.ini", @MyDocumentsDir & "\AutoCharts\settings.ini", 1)

					_Metro_GUIDelete($Form5) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
					_Metro_GUIDelete($Form1) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
					OpenMainGUI()


				EndIf

		EndSwitch
	WEnd
EndFunc   ;==>_SettingsGUI


Func _HelpGUI()

	Global $Form6 = _Metro_CreateGUI("AutoCharts Help", 540, 500, -1, -1, False, $Form1)
	;Add control buttons
	Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
	Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]


	;Create Settings Options

	Local $BTN_About = _Metro_CreateButton("About AutoCharts", 50, 100, 440, 40)
	Local $BTN_OpenLog = _Metro_CreateButton("Open Log File", 50, 160, 440, 40)
	Local $BTN_ClearLog = _Metro_CreateButton("Clear Log File", 50, 220, 440, 40)
	Local $BTN_CheckForUpdate = _Metro_CreateButton("Check for Update", 50, 280, 440, 40)

	Local $BTN_Back = _Metro_AddControlButton_Back()


	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $BTN_Back, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form6) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0

			Case $BTN_About
				ShellExecute("https://onevion.github.io/AutoCharts/")

			Case $BTN_OpenLog
				$sTextFile = @ScriptDir & "\AutoCharts.log"
				$_Run = "notepad.exe " & $sTextFile
				ConsoleWrite("$_Run : " & $_Run & @CRLF)
				Run($_Run, @WindowsDir, @SW_SHOWDEFAULT)

			Case $BTN_ClearLog
				ClearLog()

			Case $BTN_CheckForUpdate
				CheckForUpdate()

		EndSwitch
	WEnd
EndFunc   ;==>_HelpGUI


Func _SyncGUI()

	Global $Form7 = _Metro_CreateGUI("AutoCharts Sync Options", 540, 500, -1, -1, False, $Form1)
	;Add control buttons
	Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
	Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]


	;Create Settings Options

	Local $BTN_SyncAll = _Metro_CreateButton("Synchronize with Database", 50, 100, 440, 40)
	Local $BTN_DL_Import = _Metro_CreateButton("Import Datalinker from Database", 50, 160, 440, 40)

	_Metro_AddHSeperator(50, 240, 440, 1)

	Local $Label_AdminSettings = GUICtrlCreateLabel("Admin Settings", 200, 230, 150, 40, $SS_CENTER)
	GUICtrlSetColor(-1, $FontThemeColor)
	GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")

	Local $BTN_UploadAMCharts = _Metro_CreateButton("Upload amCharts to Database", 50, 280, 440, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)
	Local $BTN_UploadDatalinker = _Metro_CreateButton("Upload DataLinker to Database", 50, 340, 440, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)

	Local $BTN_Back = _Metro_AddControlButton_Back()


	GUISetState(@SW_SHOW)

	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $GUI_EVENT_CLOSE, $BTN_Back, $GUI_CLOSE_BUTTON
				_Metro_GUIDelete($Form7) ;Delete GUI/release resources, make sure you use this when working with multiple GUIs!
				Return 0

			Case $BTN_SyncAll
				ConsoleWrite($DatabaseDir & @CRLF)
				SyncronizeDataFiles()

				_GUIDisable($Form7, 0, 50)
				_Metro_MsgBox(0, "Alert", "Sync Completed. Done in " & TimerDiff($timer) / 1000 & " seconds!")
				_GUIDisable($Form7)

			Case $BTN_DL_Import
				ImportDatalinker()
				If @error Then
					_GUIDisable($Form7, 0, 50)
					_Metro_MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
					_GUIDisable($Form7)

				Else
					_GUIDisable($Form7, 0, 50)
					_Metro_MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
					_GUIDisable($Form7)
				EndIf
			Case $BTN_UploadAMCharts
				UploadamCharts()

			Case $BTN_UploadDatalinker
				UploadDatalinker()

		EndSwitch
	WEnd
EndFunc   ;==>_SyncGUI


Func BrowseForDBPath()
	; Create a constant variable in Local scope of the message to display in FileSelectFolder.
	Local Const $sMessage = "Select a folder"

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
	If @error Then
		; Display the error message.

		_GUIDisable($Form5, 0, 50)
		_Metro_MsgBox($MB_SYSTEMMODAL, "Error", "No folder was selected.")
		_GUIDisable($Form5)

		GUICtrlSetData($INPT_DropboxFolder, "")

	Else
		GUICtrlSetData($INPT_DropboxFolder, $sFileSelectFolder)
	EndIf
EndFunc   ;==>BrowseForDBPath


