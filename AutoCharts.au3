#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=assets\GUI_Menus\programicon_hxv_icon.ico
#AutoIt3Wrapper_Outfile=AutoCharts.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=Built for Catalyst and Rational Funds
#AutoIt3Wrapper_Res_Fileversion=2.1.0.2
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=AutoCharts
#AutoIt3Wrapper_Res_ProductVersion=2.1.0.1
#AutoIt3Wrapper_Res_CompanyName=Jakob Bradshaw Productions
#AutoIt3Wrapper_Res_LegalCopyright=© 2021 Jakob Bradshaw Productions
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Res_HiDpi=y
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <EditConstants.au3>
#include <GUIListBox.au3>

#Region ### GLOBAL Arrays and Variables
Global $aCatalystCheck[24]
Global $aRationalCheck[8]
Global $aStrategyCheck[3]

Global $FamilySwitch

Global $CurrentFund
Global $CSVDataDir = "\assets\ChartBuilder\public\Data\Backups"
Global $ini = 'settings.ini'
Global $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
Global $INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
Global $Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
Global $INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
Global $FundFamily = ""
Global $LogFile
Global $bDBVerified = IniRead($ini, 'Settings', 'DBVerified', 'False')





;Predeclare the variables with dummy values to prevent firing the Case statements, only for GUI this time
Global $GUI_UserSettings = 9999
$INPT_DropboxFolder = 9999
$BTN_Save = 9999
$BTN_Cancel = 9999
#EndRegion ### GLOBAL Arrays and Variables

#Region ### START Main GUI Load



RunMainGui()

Func RunMainGui()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)
	Sleep(2000)
	SplashOff()

	$MainGUI = GUICreate("AutoCharts 2.1.1", 570, 609, -1, -1)
	$mFile = GUICtrlCreateMenu("&File")
	$mSyncFiles = GUICtrlCreateMenuItem("&Pull Data From Dropbox", $mFile)
	;$mUploadFactsheets = GUICtrlCreateMenuItem("Upload Factsheets to Website", $mFile)
	$mExit = GUICtrlCreateMenuItem("&Exit", $mFile)
	$mSettings = GUICtrlCreateMenu("&Settings")
	$mEditSettings = GUICtrlCreateMenuItem("&Edit", $mSettings)
	;$mImportSettings = GUICtrlCreateMenuItem("&Import", $mSettings)
	;$mExportSettings = GUICtrlCreateMenuItem("&Export", $mSettings)
	$mHelp = GUICtrlCreateMenu("&Help")
	$mAbout = GUICtrlCreateMenuItem("&About", $mHelp)
	$mLogFile = GUICtrlCreateMenuItem("&Open Log File", $mHelp)
	$TAB_Main = GUICtrlCreateTab(8, 176, 553, 353)
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	$TAB_Catalyst = GUICtrlCreateTabItem("Catalyst Fact Sheets")
	GUICtrlSetState(-1, $GUI_SHOW)
	$BTN_RunCatalyst = GUICtrlCreateButton("Process Updates", 28, 475, 195, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	;$BTN_SelectAllCatalyst = GUICtrlCreateButton("Select All", 28, 483, 115, 33)
	;GUICtrlSetBkColor(-1, 0xC0DCC0)
	$ACX = GUICtrlCreateCheckbox("ACX", 28, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$ATR = GUICtrlCreateCheckbox("ATR", 28, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$BUY = GUICtrlCreateCheckbox("BUY", 28, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CAX = GUICtrlCreateCheckbox("CAX", 28, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CFH = GUICtrlCreateCheckbox("CFH", 28, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CPE = GUICtrlCreateCheckbox("CPE", 132, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CLT = GUICtrlCreateCheckbox("CLT", 132, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CLP = GUICtrlCreateCheckbox("CLP", 132, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CFR = GUICtrlCreateCheckbox("CFR", 132, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$IIX = GUICtrlCreateCheckbox("IIX", 236, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HII = GUICtrlCreateCheckbox("HII", 236, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$EIX = GUICtrlCreateCheckbox("EIX", 236, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CWX = GUICtrlCreateCheckbox("CWX", 236, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CTV = GUICtrlCreateCheckbox("CTV", 132, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$INS = GUICtrlCreateCheckbox("INS", 236, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$IOX = GUICtrlCreateCheckbox("IOX", 340, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$MBX = GUICtrlCreateCheckbox("MBX", 340, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$MLX = GUICtrlCreateCheckbox("MLX", 340, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$SHI = GUICtrlCreateCheckbox("SHI", 340, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TEZ = GUICtrlCreateCheckbox("TEZ", 340, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TRI = GUICtrlCreateCheckbox("TRI", 444, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TRX = GUICtrlCreateCheckbox("TRX", 444, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)


	$TAB_Rational = GUICtrlCreateTabItem("Rational Fact Sheets")
	$HBA = GUICtrlCreateCheckbox("HBA", 28, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HDC = GUICtrlCreateCheckbox("HDC", 28, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HRS = GUICtrlCreateCheckbox("HRS", 28, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HSU = GUICtrlCreateCheckbox("HSU", 28, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$PBX = GUICtrlCreateCheckbox("PBX", 132, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$RDM = GUICtrlCreateCheckbox("RDM", 132, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$RFX = GUICtrlCreateCheckbox("RFX", 132, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$RTAVF = GUICtrlCreateCheckbox("RTAVF", 132, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$BTN_RunRational = GUICtrlCreateButton("Process Updates", 28, 475, 195, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUICtrlSetBkColor(-1, 0xC0DCC0)


	$TAB_StrategyShares = GUICtrlCreateTabItem("Strategy Shares Fact Sheets")
	$GLDB = GUICtrlCreateCheckbox("GLDB", 28, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HNDL = GUICtrlCreateCheckbox("HNDL", 28, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$ROMO = GUICtrlCreateCheckbox("ROMO", 28, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$BTN_RunStrategyShares = GUICtrlCreateButton("Process Updates", 28, 475, 195, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	GUICtrlCreateTabItem("")
	$Pic1 = GUICtrlCreatePic(@ScriptDir & "\assets\GUI_Menus\main-img.bmp", 0, 0, 569, 167, BitOR($GUI_SS_DEFAULT_PIC, $SS_CENTERIMAGE))
	GUISetIcon(@ScriptDir & "\assets\GUI_Menus\programicon_hxv_icon.ico")
	Global $ProgressBar = GUICtrlCreateProgress(8, 536, 550, 17)
	Global $UpdateLabel = GUICtrlCreateLabel("Click Process Updates to Start", 16, 560, 540, 17)

	GUISetState()

	Local $aMsg
	While 1
		$aMsg = GUIGetMsg(1) ; Use advanced parameter to get array
		Switch $aMsg[1] ; check which GUI box sent the message
			Case $MainGUI
				Switch $aMsg[0] ; Now check for the messages for $MainGUI
					Case $GUI_EVENT_CLOSE ; If we get the CLOSE message from this GUI - we exit <<<<<<<<<<<<<<<
						FileClose($LogFile)
						ExitLoop
					Case $mExit
						Exit
					Case $GUI_EVENT_CLOSE
						FileClose($LogFile)
						Exit
					Case $mEditSettings
						;GUICtrlSetState($mEditSettings, $GUI_DISABLE)
						OpenSettingsGUI()
					Case $mAbout
						ShellExecute("https://onevion.github.io/AutoCharts/")

					Case $mLogFile
						$sTextFile = @ScriptDir & "\AutoCharts.log"
						$_Run = "notepad.exe " & $sTextFile
						ConsoleWrite("$_Run : " & $_Run & @CRLF)
						Run($_Run, @WindowsDir, @SW_SHOWDEFAULT)

					Case $ACX
						If GUICtrlRead($ACX) = 1 Then $aCatalystCheck[0] = "ACX" ; Sets first slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($ACX) = 4 Then $aCatalystCheck[0] = 0 ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					Case $ATR
						If GUICtrlRead($ATR) = 1 Then $aCatalystCheck[1] = "ATR" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($ATR) = 4 Then $aCatalystCheck[1] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $BUY
						If GUICtrlRead($BUY) = 1 Then $aCatalystCheck[2] = "BUY" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($BUY) = 4 Then $aCatalystCheck[2] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CAX
						If GUICtrlRead($CAX) = 1 Then $aCatalystCheck[3] = "CAX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CAX) = 4 Then $aCatalystCheck[3] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CFH
						If GUICtrlRead($CFH) = 1 Then $aCatalystCheck[4] = "CFH" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CFH) = 4 Then $aCatalystCheck[4] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CPE
						If GUICtrlRead($CPE) = 1 Then $aCatalystCheck[5] = "CPE" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CPE) = 4 Then $aCatalystCheck[5] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CLT
						If GUICtrlRead($CLT) = 1 Then $aCatalystCheck[6] = "CLT" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CLT) = 4 Then $aCatalystCheck[6] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CLP
						If GUICtrlRead($CLP) = 1 Then $aCatalystCheck[7] = "CLP" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CLP) = 4 Then $aCatalystCheck[7] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CFR
						If GUICtrlRead($CFR) = 1 Then $aCatalystCheck[9] = "CFR" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CFR) = 4 Then $aCatalystCheck[9] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $IIX
						If GUICtrlRead($IIX) = 1 Then $aCatalystCheck[10] = "IIX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($IIX) = 4 Then $aCatalystCheck[10] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $HII
						If GUICtrlRead($HII) = 1 Then $aCatalystCheck[11] = "HII" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($HII) = 4 Then $aCatalystCheck[11] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $EIX
						If GUICtrlRead($EIX) = 1 Then $aCatalystCheck[12] = "EIX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($EIX) = 4 Then $aCatalystCheck[12] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CWX
						If GUICtrlRead($CWX) = 1 Then $aCatalystCheck[13] = "CWX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CWX) = 4 Then $aCatalystCheck[13] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CTV
						If GUICtrlRead($CTV) = 1 Then $aCatalystCheck[14] = "CTV" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CTV) = 4 Then $aCatalystCheck[14] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $INS
						If GUICtrlRead($INS) = 1 Then $aCatalystCheck[15] = "INS" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($INS) = 4 Then $aCatalystCheck[15] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $IOX
						If GUICtrlRead($IOX) = 1 Then $aCatalystCheck[16] = "IOX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($IOX) = 4 Then $aCatalystCheck[16] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $MBX
						If GUICtrlRead($MBX) = 1 Then $aCatalystCheck[17] = "MBX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($MBX) = 4 Then $aCatalystCheck[17] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $MLX
						If GUICtrlRead($MLX) = 1 Then $aCatalystCheck[18] = "MLX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($MLX) = 4 Then $aCatalystCheck[18] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $SHI
						If GUICtrlRead($SHI) = 1 Then $aCatalystCheck[20] = "SHI" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($SHI) = 4 Then $aCatalystCheck[20] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $TEZ
						If GUICtrlRead($TEZ) = 1 Then $aCatalystCheck[21] = "TEZ" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($TEZ) = 4 Then $aCatalystCheck[21] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $TRI
						If GUICtrlRead($TRI) = 1 Then $aCatalystCheck[22] = "TRI" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($TRI) = 4 Then $aCatalystCheck[22] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $TRX
						If GUICtrlRead($TRX) = 1 Then $aCatalystCheck[23] = "TRX" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($TRX) = 4 Then $aCatalystCheck[23] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED


					Case $HBA
						If GUICtrlRead($HBA) = 1 Then $aRationalCheck[0] = "HBA" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($HBA) = 4 Then $aRationalCheck[0] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED
					Case $HDC
						If GUICtrlRead($HDC) = 1 Then $aRationalCheck[1] = "HDC" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($HDC) = 4 Then $aRationalCheck[1] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED
					Case $HRS
						If GUICtrlRead($HRS) = 1 Then $aRationalCheck[2] = "HRS" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($HRS) = 4 Then $aRationalCheck[2] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED
					Case $HSU
						If GUICtrlRead($HSU) = 1 Then $aRationalCheck[3] = "HSU" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($HSU) = 4 Then $aRationalCheck[3] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED
					Case $PBX
						If GUICtrlRead($PBX) = 1 Then $aRationalCheck[4] = "PBX" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($PBX) = 4 Then $aRationalCheck[4] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED
					Case $RDM
						If GUICtrlRead($RDM) = 1 Then $aRationalCheck[5] = "RDM" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($RDM) = 4 Then $aRationalCheck[5] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED
					Case $RFX
						If GUICtrlRead($RFX) = 1 Then $aRationalCheck[6] = "RFX" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($RFX) = 4 Then $aRationalCheck[6] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED
					Case $RTAVF
						If GUICtrlRead($RTAVF) = 1 Then $aRationalCheck[7] = "RTAVF" ; Sets  slot of the Rational Array to 1 if CHECKED
						If GUICtrlRead($RTAVF) = 4 Then $aRationalCheck[7] = 0 ; Sets  slot of the Rational Array to 0 if NOT CHECKED


					Case $GLDB
						If GUICtrlRead($GLDB) = 1 Then $aStrategyCheck[0] = "GLDB" ; Sets  slot of the Strategy Shares Array to 1 if CHECKED
						If GUICtrlRead($GLDB) = 4 Then $aStrategyCheck[0] = 0 ; Sets  slot of the Strategy Shares Array to 0 if NOT CHECKED
					Case $HNDL
						If GUICtrlRead($HNDL) = 1 Then $aStrategyCheck[1] = "HNDL" ; Sets  slot of the Strategy Shares Array to 1 if CHECKED
						If GUICtrlRead($HNDL) = 4 Then $aStrategyCheck[1] = 0 ; Sets  slot of the Strategy Shares Array to 0 if NOT CHECKED
					Case $ROMO
						If GUICtrlRead($ROMO) = 1 Then $aStrategyCheck[2] = "ROMO" ; Sets  slot of the Strategy Shares Array to 1 if CHECKED
						If GUICtrlRead($ROMO) = 4 Then $aStrategyCheck[2] = 0 ; Sets  slot of the Strategy Shares Array to 0 if NOT CHECKED





					Case $BTN_RunCatalyst
						VerifyDropbox()
						If $bDBVerified = True Then
							$FundFamily = "Catalyst"
							$FamilySwitch = $aCatalystCheck
							GUICtrlSetData($ProgressBar, 10)


							RunCSVConvert()
							CreateCharts()

							$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
							_FileWriteLog($LogFile, "############################### END OF RUN - CATALYST ###############################") ; Write to the logfile
							FileClose($LogFile) ; Close the filehandle to release the file.
							GUICtrlSetData($ProgressBar, 0)
							MsgBox(0, "Finished", "The process has finished.")
							GUICtrlSetData($UpdateLabel, "The process has finished.")
						Else
							If @error = 50 Then
								MsgBox(0, "Error!", "Error Code: " & @error & " | Dropbox path not verified. Process has been aborted.")
							EndIf
						EndIf


					Case $BTN_RunRational
						$FundFamily = "Rational"
						$FamilySwitch = $aRationalCheck
						GUICtrlSetData($ProgressBar, 10)

						RunCSVConvert()
						CreateCharts()

						$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
						_FileWriteLog($LogFile, "############################### END OF RUN - RATIONAL ###############################") ; Write to the logfile
						FileClose($LogFile) ; Close the filehandle to release the file.
						GUICtrlSetData($ProgressBar, 0)
						MsgBox(0, "Finished", "The process has finished.")
						GUICtrlSetData($UpdateLabel, "The process has finished.")

					Case $BTN_RunStrategyShares
						$FundFamily = "StrategyShares"
						$FamilySwitch = $aStrategyCheck
						GUICtrlSetData($ProgressBar, 10)

						RunCSVConvert()
						CreateCharts()

						$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
						_FileWriteLog($LogFile, "############################### END OF RUN - STRATEGY SHARES ###############################") ; Write to the logfile
						FileClose($LogFile) ; Close the filehandle to release the file.
						GUICtrlSetData($ProgressBar, 0)
						MsgBox(0, "Finished", "The process has finished.")

						GUICtrlSetData($UpdateLabel, "The process has finished.")



					Case $mSyncFiles
						SyncronizeDataFiles()
						MsgBox(0, "Alert", "Sync Successful")

				EndSwitch
			Case $GUI_UserSettings
				Switch $aMsg[0] ; Now check for the messages for $GUI_UserSettings
					Case $GUI_EVENT_CLOSE ; If we get the CLOSE message from this GUI - we just delete the GUI
						GUIDelete($GUI_UserSettings)
						;GUICtrlSetState($mEditSettings, $GUI_ENABLE)
					Case $BTN_Save
						$DATA_UserSettings = GUICtrlRead($INPT_DropboxFolder)
						If $DATA_UserSettings = "" Then
							MsgBox(0, "Error!", "You must select a dropbox directory!")
						Else
							$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'DropboxDir', $DATA_UserSettings)

							$DATA_UserSettings = GUICtrlRead($INPT_Name)
							$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UserName', $DATA_UserSettings)

							$DATA_UserSettings = GUICtrlRead($Select_Quarter)
							$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)

							$DATA_UserSettings = GUICtrlRead($INPT_CurYear)
							$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentYear', $DATA_UserSettings)

							If $iSettingsConfirm = 1 Then

								$DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
								$INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
								$Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
								$INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
								$bDBVerified = IniRead($ini, 'Settings', 'DBVerified', '')

								DetermineDates()
								MsgBox(0, "Success", "Your settings were saved.")
							Else
								MsgBox(0, "Error!", "An error occured")
							EndIf
							VerifyDropbox()
							If @error = 50 Then
								MsgBox(0, "Error!", "Error Code: " & @error & " | Dropbox path not verified. Please try resetting it.")
							EndIf


							; Close Settings Window after saving file.
							GUIDelete($GUI_UserSettings)
						EndIf
					Case $BTN_Cancel
						GUIDelete($GUI_UserSettings)

				EndSwitch
		EndSwitch
	WEnd
EndFunc   ;==>RunMainGui
#EndRegion ### END Koda GUI section ###



#Region ### START Koda GUI section ### Form=C:\Users\mrjak\Documents\SublimeProjects\AutoCharts\assets\GUI_UserSettings.kxf


Func OpenSettingsGUI()
	$GUI_UserSettings = GUICreate("User Settings", 203, 249, -1, -1)
	$INPT_DropboxFolder = GUICtrlCreateInput($DropboxDir, 16, 32, 169, 21)
	$BTN_Save = GUICtrlCreateButton("Save", 16, 208, 75, 25)
	$BTN_Cancel = GUICtrlCreateButton("Cancel", 112, 208, 75, 25)
	$Label_Dropbox = GUICtrlCreateLabel("Path to Dropbox Folder:", 16, 15, 116, 17)
	$INPT_Name = GUICtrlCreateInput($INPT_Name, 16, 80, 169, 21)
	$Label_Name = GUICtrlCreateLabel("Your Name:", 16, 63, 60, 17)
	$Select_Quarter = GUICtrlCreateList("", 16, 120, 57, 58)
	GUICtrlSetData(-1, "Q1|Q2|Q3|Q4")
	$INPT_CurYear = GUICtrlCreateInput($INPT_CurYear, 80, 136, 105, 21)
	$Label_Year = GUICtrlCreateLabel("Current Year", 80, 119, 63, 17)
	GUISetState()
EndFunc   ;==>OpenSettingsGUI
#EndRegion ### END Koda GUI section ###


Func VerifyDropbox()
	If FileExists($DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\.checkfile") Then  ; dynamically checks if Current Fund has institutional backupfile. If so, runs csv convert on both
		$bDBVerified = True
		IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
	Else
		$bDBVerified = False
		IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
		SetError(50)
	EndIf
EndFunc   ;==>VerifyDropbox


#Region ### Start Main Functions Region

Func SyncronizeDataFiles()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)


	DirCopy($DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", @ScriptDir & $CSVDataDir, 1)

	SplashOff()

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Synced Dropbox data with Autocharts Data") ; Write to the logfile

EndFunc   ;==>SyncronizeDataFiles


Func DetermineDates()
	$Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
	$INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
	Local $QtrToMonth
	Local $DayNumber
	Local $MonthNumber

	If $Select_Quarter = 'Q1' Then
		$QtrToMonth = "March"
		$MonthNumber = "03"
		$DayNumber = "31"
	ElseIf $Select_Quarter = 'Q2' Then
		$QtrToMonth = "June"
		$MonthNumber = "06"
		$DayNumber = "30"
	ElseIf $Select_Quarter = 'Q3' Then
		$QtrToMonth = "September"
		$MonthNumber = "09"
		$DayNumber = "30"
	ElseIf $Select_Quarter = 'Q4' Then
		$QtrToMonth = "December"
		$MonthNumber = "12"
		$DayNumber = "31"
	Else
		MsgBox(0, "Error!", "A quarter has not been selected in the settings tab.")
	EndIf

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Determined quarter to be ~" & $Select_Quarter & "~ and current year to be ~" & $INPT_CurYear & "~") ; Write to the logfile
	FileClose($LogFile) ; Close the filehandle to release the file.

	If FileExists(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv") Then
		FileDelete(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv")
	EndIf

	;Create CSV Line by Line for Datalinker to read current year and quarter.

	Local $file = @ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDatesTEMP.csv"
	Local $text = FileReadLine($file, 1)

	$tout1 = StringReplace($text, 'Label,ID', 'Label,ID' & @CRLF)
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)

	$text = FileReadLine($file, 2)

	$tout1 = StringReplace($text, '3/31/2021,1', $MonthNumber & '/' & $DayNumber & '/' & $INPT_CurYear & ',1' & @CRLF)
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)

	$text = FileReadLine($file, 3)

	$tout1 = StringReplace($text, '"March 31, 2021",2', '"' & $QtrToMonth & ' ' & $DayNumber & ', ' & $INPT_CurYear & '",2' & @CRLF)
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)

	$text = FileReadLine($file, 4)

	$tout1 = StringReplace($text, 'Q1 2021,3', $Select_Quarter & ' ' & $INPT_CurYear & ',3' & @CRLF)
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)

	$text = FileReadLine($file, 5)

	$tout1 = StringReplace($text, 'March 2021,4', $QtrToMonth & ' ' & $INPT_CurYear & ',4' & @CRLF)
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)

	$text = FileReadLine($file, 6)

	$tout1 = StringReplace($text, '03/2021,5', $MonthNumber & '/' & $INPT_CurYear & ',5')
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)
	FileClose(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv") ; Close the filehandle to release the file.
	FileMove(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", 1)

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Updated FactSheetDates CSV File with selected dates") ; Write to the logfile
	FileClose($LogFile) ; Close the filehandle to release the file.


EndFunc   ;==>DetermineDates


Func RunCSVConvert() ; Dynamically checks for funds with "-institutional.xlsx" files and converts those automatically as well.

	For $a = 0 To (UBound($FamilySwitch) - 1) ; Loops through FundFamily Array
		If $FamilySwitch[$a] <> "" Then
			$CurrentFund = $FamilySwitch[$a]
			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund)
			GUICtrlSetData($ProgressBar, 15)

			FileCopy(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "*.xlsx", @ScriptDir & "/VBS_Scripts/")   ; grab .xlsx from current fund directory and move to /VBS_Scripts
			RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & ".xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv

			$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
			_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")     ; Write to the logfile
			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")

			_FileWriteLog($LogFile, "Converted " & $CurrentFund & ".xlsx file to csv")     ; Write to the logfile

			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & ".xlsx file to csv")

			If FileExists(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then  ; dynamically checks if Current Fund has institutional backupfile. If so, runs csv convert on both
				RunCSVConvert4Institution()
			EndIf
			If FileExists(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
				RunCSVConvert4Brochure()
			EndIf



			GUICtrlSetData($ProgressBar, 25)




			FileCopy(@ScriptDir & "/VBS_Scripts/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1)       ; Move all .CSV back to Data folder and overwrite.
			FileMove(@ScriptDir & "/VBS_Scripts/*.csv", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.csv", 1)       ; Move all .CSV back to Data folder and overwrite.

			$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
			_FileWriteLog($LogFile, "Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in Dropbox") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in Dropbox")
			GUICtrlSetData($ProgressBar, 30)


			FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")       ; deletes remaining .xlsx from conversion
			$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
			_FileWriteLog($LogFile, "Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
			GUICtrlSetData($ProgressBar, 35)

		Else
			ContinueLoop
		EndIf

	Next

EndFunc   ;==>RunCSVConvert


Func RunCSVConvert4Institution() ; Dynamically checks for funds with "-institutional.xlsx" files and converts those automatically as well.

	RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-institutional.xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")

	_FileWriteLog($LogFile, "Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-institutional.xlsx files to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-institutional.xlsx files to csv")


EndFunc   ;==>RunCSVConvert4Institution



Func RunCSVConvert4Brochure() ; Dynamically checks for funds with "-brochure.xlsx" files and converts those automatically as well.

	RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-brochure.xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")

	_FileWriteLog($LogFile, "Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-brochure.xlsx files to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-brochure.xlsx files to csv")


EndFunc   ;==>RunCSVConvert4Brochure




Func HTMLChartEditor() ; Edits index_TEMPLATE.html file to include current fund's chart .js file
	Local $file = @ScriptDir & "\assets\ChartBuilder\public\index_TEMPLATE.html"
	Local $text = FileRead($file)

	$tout1 = StringReplace($text, '<script src="/scripts/CHANGEME.js"></script>', '<script src="/scripts/' & $CurrentFund & '.js"></script>')
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\index.html", $tout1)

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~") ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")

	_FileWriteLog($LogFile, "Created HTML file for " & $CurrentFund & " chart generation") ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Created HTML file for " & $CurrentFund & " chart generation")

	_FileWriteLog($LogFile, "Initializing Local Server for amCharts") ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Initializing Local Server for amCharts")


EndFunc   ;==>HTMLChartEditor




Func CreateCharts()
	For $a = 0 To (UBound($FamilySwitch) - 1)    ; Loops through FundFamily Array
		If $FamilySwitch[$a] <> "" Then
			$CurrentFund = $FamilySwitch[$a]
			Call("HTMLChartEditor")
			RunWait(@ComSpec & " /c node --unhandled-rejections=strict server.js", @ScriptDir & "/assets/ChartBuilder/", @SW_HIDE) ;~ Runs local server to create current fund's amcharts svgs.
			;RunWait(@ComSpec & " /c node server.js", @ScriptDir & "/assets/ChartBuilder/") ;~ Runs local server to create current fund's amcharts svgs.
			GUICtrlSetData($ProgressBar, 70)

			$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
			_FileWriteLog($LogFile, $CurrentFund & " charts generated in SVG format using amCharts") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Charts generated in SVG format using amCharts")


			FileDelete(@ScriptDir & "\assets\ChartBuilder\public\index.html")  ; ~ Deletes index.html file that was created in Func HTMLChartEditor to keep from editing the same file.
			FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.svg", 1)   ; Move all .SVG to Dropbox Indesign Files and Overwrite.
			GUICtrlSetData($ProgressBar, 92)

			$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
			_FileWriteLog($LogFile, $CurrentFund & " charts moved to the funds InDesign Links folder") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Charts moved to the funds InDesign Links folder")


		Else
			ContinueLoop
		EndIf
		GUICtrlSetData($ProgressBar, 100)

	Next
EndFunc   ;==>CreateCharts


#EndRegion ### Start Main Functions Region
