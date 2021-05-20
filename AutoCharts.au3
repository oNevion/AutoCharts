#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=assets\GUI_Menus\programicon_hxv_icon.ico
#AutoIt3Wrapper_Outfile=AutoCharts.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=Built for Catalyst and Rational Funds
#AutoIt3Wrapper_Res_Fileversion=2.3.0.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=AutoCharts
#AutoIt3Wrapper_Res_ProductVersion=2.3.0
#AutoIt3Wrapper_Res_CompanyName=Jakob Bradshaw Productions
#AutoIt3Wrapper_Res_LegalCopyright=© 2021 Jakob Bradshaw Productions
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
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
#include "Zip.au3"

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
Global $DatabaseDir = $DropboxDir & "\Marketing Team Files\AutoCharts_Database"

;Predeclare the variables with dummy values to prevent firing the Case statements, only for GUI this time
Global $GUI_UserSettings = 9999
$INPT_DropboxFolder = 9999
$BTN_Save = 9999
$BTN_Cancel = 9999
$BTN_SelectDBPath = 9999

$Radio_Q1 = 4
$Radio_Q2 = 4
$Radio_Q3 = 4
$Radio_Q4 = 4

#EndRegion ### GLOBAL Arrays and Variables

#Region ### START Main GUI Load



RunMainGui()

Func RunMainGui()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)
	Sleep(2000)
	SplashOff()

	$MainGUI = GUICreate("AutoCharts 2.3.0", 570, 609, -1, -1)
	$mFile = GUICtrlCreateMenu("&File")
	;$mUploadFactsheets = GUICtrlCreateMenuItem("Upload Factsheets to Website", $mFile)
	$mCreateArchive = GUICtrlCreateMenuItem("&Create Factsheet Archive", $mFile)
	$mExit = GUICtrlCreateMenuItem("&Exit", $mFile)
	$mSettings = GUICtrlCreateMenu("&Settings")
	$mEditSettings = GUICtrlCreateMenuItem("&Edit", $mSettings)
	$mSyncOptions = GUICtrlCreateMenu("Sync Options")
	$mSyncFiles = GUICtrlCreateMenuItem("&Pull Data From Dropbox", $mSyncOptions)
	$mUploadamCharts = GUICtrlCreateMenuItem("Upload amChart Files", $mSyncOptions)
	$mDataLinker = GUICtrlCreateMenu("&DataLinker", $mSyncOptions)
	$mImportDataLinker = GUICtrlCreateMenuItem("Import Data Sources", $mDataLinker)
	$mExportDataLinker = GUICtrlCreateMenuItem("Export Data Sources", $mDataLinker)
	$mUploadDatalinker = GUICtrlCreateMenuItem("Upload Data Sources to Database", $mDataLinker)
	$mHelp = GUICtrlCreateMenu("&Help")
	$mAbout = GUICtrlCreateMenuItem("&About", $mHelp)
	$mLogFile = GUICtrlCreateMenuItem("&Open Log File", $mHelp)
	$mClearLog = GUICtrlCreateMenuItem("&Clear Log File", $mHelp)

	$TAB_Main = GUICtrlCreateTab(8, 176, 553, 353)
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	$TAB_Catalyst = GUICtrlCreateTabItem("Catalyst Fact Sheets")
	GUICtrlSetState(-1, $GUI_SHOW)
	$BTN_RunCatalyst = GUICtrlCreateButton("Process Updates", 28, 475, 195, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	$BTN_Catalyst_UpdateExpenseRatio = GUICtrlCreateButton("Update Expense Ratios", 236, 475, 195, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
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
	$IIX = GUICtrlCreateCheckbox("IIX", 236, 329, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HII = GUICtrlCreateCheckbox("HII", 236, 279, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$EIX = GUICtrlCreateCheckbox("EIX", 236, 229, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CWX = GUICtrlCreateCheckbox("CWX", 132, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$INS = GUICtrlCreateCheckbox("INS", 236, 379, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$IOX = GUICtrlCreateCheckbox("IOX", 236, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$MBX = GUICtrlCreateCheckbox("MBX", 340, 229, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$MLX = GUICtrlCreateCheckbox("MLX", 340, 279, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$SHI = GUICtrlCreateCheckbox("SHI", 340, 329, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TEZ = GUICtrlCreateCheckbox("TEZ", 340, 379, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TRI = GUICtrlCreateCheckbox("TRI", 340, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TRX = GUICtrlCreateCheckbox("TRX", 444, 229, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
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
	$BTN_RunRational = GUICtrlCreateButton("Process Updates", 28, 475, 195, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	$BTN_Rational_UpdateExpenseRatio = GUICtrlCreateButton("Update Expense Ratios", 236, 475, 195, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")

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
				If $INPT_Name <> "Jakob" Then
					GUICtrlSetState($mUploadamCharts, $GUI_DISABLE)
					GUICtrlSetState($mUploadDatalinker, $GUI_DISABLE)
				EndIf
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
					Case $mUploadamCharts
						UploadamCharts()
					Case $mExportDataLinker
						ExportDatalinker()
					Case $mImportDataLinker
						ImportDatalinker()
					Case $mUploadDatalinker
						UploadDatalinker()
					Case $mClearLog
						ClearLog()
					Case $mAbout
						ShellExecute("https://onevion.github.io/AutoCharts/")

					Case $mLogFile
						$sTextFile = @ScriptDir & "\AutoCharts.log"
						$_Run = "notepad.exe " & $sTextFile
						ConsoleWrite("$_Run : " & $_Run & @CRLF)
						Run($_Run, @WindowsDir, @SW_SHOWDEFAULT)

					Case $mCreateArchive
						CreateFactSheetArchive()

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

							PullCatalystData()
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


					Case $BTN_Catalyst_UpdateExpenseRatio
						$FundFamily = "Catalyst"
						$FamilySwitch = $aCatalystCheck
						GUICtrlSetData($ProgressBar, 10)

						PullCatalystData()
						RunExpenseRatios()

						$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
						_FileWriteLog($LogFile, "############################### END OF RUN - CATALYST ###############################")     ; Write to the logfile
						FileClose($LogFile)     ; Close the filehandle to release the file.
						GUICtrlSetData($ProgressBar, 0)
						MsgBox(0, "Finished", "The process has finished.")
						GUICtrlSetData($UpdateLabel, "The process has finished.")
						If @error = 50 Then
							MsgBox(0, "Error!", "Error Code: " & @error & " | Dropbox path not verified. Process has been aborted.")
						EndIf


					Case $BTN_RunRational
						$FundFamily = "Rational"
						$FamilySwitch = $aRationalCheck
						GUICtrlSetData($ProgressBar, 10)

						PullRationalData()
						RunCSVConvert()
						CreateCharts()

						$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
						_FileWriteLog($LogFile, "############################### END OF RUN - RATIONAL ###############################") ; Write to the logfile
						FileClose($LogFile) ; Close the filehandle to release the file.
						GUICtrlSetData($ProgressBar, 0)
						MsgBox(0, "Finished", "The process has finished.")
						GUICtrlSetData($UpdateLabel, "The process has finished.")

					Case $BTN_Rational_UpdateExpenseRatio
						$FundFamily = "Rational"
						$FamilySwitch = $aRationalCheck
						GUICtrlSetData($ProgressBar, 10)

						PullRationalData()
						RunExpenseRatios()

						$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
						_FileWriteLog($LogFile, "############################### END OF RUN - RATIONAL ###############################")     ; Write to the logfile
						FileClose($LogFile)     ; Close the filehandle to release the file.
						GUICtrlSetData($ProgressBar, 0)
						MsgBox(0, "Finished", "The process has finished.")
						GUICtrlSetData($UpdateLabel, "The process has finished.")
						If @error = 50 Then
							MsgBox(0, "Error!", "Error Code: " & @error & " | Dropbox path not verified. Process has been aborted.")
						EndIf

					Case $BTN_RunStrategyShares
						$FundFamily = "StrategyShares"
						$FamilySwitch = $aStrategyCheck
						GUICtrlSetData($ProgressBar, 10)

						PullStrategySharesData()
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

							If GUICtrlRead($Radio_Q1) = 1 Then
								$Select_Quarter = "Q1" ; Checks to see if Radio for Q1 is Checked
								$DATA_UserSettings = "Q1"
								$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
							EndIf

							If GUICtrlRead($Radio_Q2) = 1 Then
								$Select_Quarter = "Q2" ; Checks to see if Radio for Q2 is Checked
								$DATA_UserSettings = "Q2"
								$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
							EndIf

							If GUICtrlRead($Radio_Q3) = 1 Then
								$Select_Quarter = "Q3" ; Checks to see if Radio for Q3 is Checked
								$DATA_UserSettings = "Q3"
								$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
							EndIf

							If GUICtrlRead($Radio_Q4) = 1 Then
								$Select_Quarter = "Q4" ; Checks to see if Radio for Q4 is Checked
								$DATA_UserSettings = "Q4"
								$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
							EndIf



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
					Case $BTN_SelectDBPath
						BrowseForDBPath()
					Case $BTN_Cancel
						GUIDelete($GUI_UserSettings)
				EndSwitch
		EndSwitch
	WEnd
EndFunc   ;==>RunMainGui
#EndRegion ### END Koda GUI section ###



#Region ### START Koda GUI section ### Form=C:\Users\mrjak\Documents\SublimeProjects\AutoCharts\assets\GUI_UserSettings.kxf


Func OpenSettingsGUI()

	$DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
	$INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
	$Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
	$INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')

	$GUI_UserSettings = GUICreate("User Settings", 207, 254, -1, -1)
	$INPT_DropboxFolder = GUICtrlCreateInput($DropboxDir, 16, 32, 169, 21)
	$BTN_Save = GUICtrlCreateButton("Save", 16, 208, 75, 25)
	$BTN_Cancel = GUICtrlCreateButton("Cancel", 112, 208, 75, 25)
	$Label_Dropbox = GUICtrlCreateLabel("Path to Dropbox Folder:", 16, 15, 116, 17)
	$BTN_SelectDBPath = GUICtrlCreateButton("Browse", 16, 56, 169, 25)
	$INPT_Name = GUICtrlCreateInput($INPT_Name, 16, 112, 169, 21)
	$Label_Name = GUICtrlCreateLabel("Your Name:", 16, 95, 60, 17)

	$Radio_Q1 = GUICtrlCreateRadio("Q1", 17, 152, 35, 17)
	If $Select_Quarter = "Q1" Then
		GUICtrlSetState($Radio_Q1, 1)
	EndIf

	$Radio_Q2 = GUICtrlCreateRadio("Q2", 56, 152, 35, 17)
	If $Select_Quarter = "Q2" Then
		GUICtrlSetState($Radio_Q2, 1)
	EndIf
	$Radio_Q3 = GUICtrlCreateRadio("Q3", 17, 176, 35, 17)
	If $Select_Quarter = "Q3" Then
		GUICtrlSetState($Radio_Q3, 1)
	EndIf
	$Radio_Q4 = GUICtrlCreateRadio("Q4", 56, 176, 35, 17)
	If $Select_Quarter = "Q4" Then
		GUICtrlSetState($Radio_Q4, 1)
	EndIf

	$INPT_CurYear = GUICtrlCreateInput($INPT_CurYear, 120, 168, 63, 21)
	$Label_Year = GUICtrlCreateLabel("Current Year", 120, 151, 63, 17)
	GUISetState()
EndFunc   ;==>OpenSettingsGUI
#EndRegion ### END Koda GUI section ###

Func BrowseForDBPath()
	; Create a constant variable in Local scope of the message to display in FileSelectFolder.
	Local Const $sMessage = "Select a folder"

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
		GUICtrlSetData($INPT_DropboxFolder, "")

	Else
		GUICtrlSetData($INPT_DropboxFolder, $sFileSelectFolder)
	EndIf
EndFunc   ;==>BrowseForDBPath


Func VerifyDropbox()
	If FileExists($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\.checkfile") Then  ; dynamically checks if Current Fund has institutional backupfile. If so, runs csv convert on both
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

	DirRemove(@ScriptDir & $CSVDataDir, 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", @ScriptDir & $CSVDataDir, 1)

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Synced Dropbox data with Autocharts Data") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database") ; Write to the logfile


	SplashOff()



EndFunc   ;==>SyncronizeDataFiles

Func PullCatalystData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove(@ScriptDir & $CSVDataDir & "\Catalyst", 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst", @ScriptDir & $CSVDataDir & "\Catalyst", 1)

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Pulled Catalyst Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullCatalystData

Func PullRationalData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove(@ScriptDir & $CSVDataDir & "\Rational", 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational", @ScriptDir & $CSVDataDir & "\Rational", 1)

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Pulled Rational Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullRationalData


Func PullStrategySharesData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove(@ScriptDir & $CSVDataDir & "\StrategyShares", 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\StrategyShares", @ScriptDir & $CSVDataDir & "\StrategyShares", 1)

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Pulled Strategy Shares Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()

EndFunc   ;==>PullStrategySharesData

Func UploadamCharts()
	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove($DatabaseDir & "\amCharts", 1)
	DirCopy(@ScriptDir & "\assets\ChartBuilder\public\scripts", $DatabaseDir & "\amCharts", 1)

	SplashOff()

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
	_FileWriteLog($LogFile, "Uploaded amCharts Scripts to Database") ; Write to the logfile
EndFunc   ;==>UploadamCharts


Func ExportDatalinker()
	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)


	Local Const $sMessage = "Select where you would like to save the Datalinker file."

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
	Else
		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $sFileSelectFolder & "\" & $INPT_Name & "_Datalinker.xml", 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error finding your DataLinker file.")
			_FileWriteLog($LogFile, "Error! Unable to Export Datalinker File to " & $sFileSelectFolder) ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File Exported to " & $sFileSelectFolder)

			_FileWriteLog($LogFile, "Datalinker File Exported to " & $sFileSelectFolder) ; Write to the logfile

		EndIf
	EndIf

EndFunc   ;==>ExportDatalinker

Func UploadDatalinker()
	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)



	If $INPT_Name = "Jakob" Then
		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir, 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
			_FileWriteLog($LogFile, "Error! Unable to Upload Datalinker File to " & $DatabaseDir) ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")

			_FileWriteLog($LogFile, "Datalinker File Uploaded to " & $DatabaseDir) ; Write to the logfile

		EndIf
	Else

		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir & "\" & $INPT_Name & "_Datalinker.xml", 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
			_FileWriteLog($LogFile, "Error! Unable to Upload Datalinker File to " & $DatabaseDir) ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")

			_FileWriteLog($LogFile, "Datalinker File Uploaded to " & $DatabaseDir) ; Write to the logfile

		EndIf
	EndIf

EndFunc   ;==>UploadDatalinker


Func ImportDatalinker()

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)


	FileCopy($DatabaseDir & "\DataLinker.xml", @ScriptDir & "\Datalinker_TEMP.xml", 1)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign")
		_FileWriteLog($LogFile, "Error! Unable to Import Datalinker File to InDesign")     ; Write to the logfile
	Else
		_FileWriteLog($LogFile, "Datalinker File Imported to AutoCharts Directory")     ; Write to the logfile

	EndIf

	Local $file = @ScriptDir & "\Datalinker_TEMP.xml"
	Local $text = FileRead($file)


	If $INPT_Name <> "Jakob" Then
		$tout1 = StringReplace($text, 'X:\Marketing Team Files\', $DropboxDir & '\Marketing Team Files\')
		FileWrite(@ScriptDir & "\DataLinker_Updated.xml", $tout1)
		FileCopy(@ScriptDir & "\Datalinker_Updated.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)

		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
			_FileWriteLog($LogFile, "Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file") ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
			FileDelete(@ScriptDir & "\Datalinker_Updated.xml")
			FileDelete(@ScriptDir & "\Datalinker_TEMP.xml")
			_FileWriteLog($LogFile, "Datalinker File Imported to InDesign successfully") ; Write to the logfile

		EndIf
	Else
		FileCopy(@ScriptDir & "\Datalinker_TEMP.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
			_FileWriteLog($LogFile, "Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file") ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
			FileDelete(@ScriptDir & "\Datalinker_Updated.xml")
			FileDelete(@ScriptDir & "\Datalinker_TEMP.xml")
			_FileWriteLog($LogFile, "Datalinker File Imported to InDesign successfully") ; Write to the logfile

		EndIf

	EndIf

EndFunc   ;==>ImportDatalinker


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

	Local $file = @ScriptDir & "\assets\ChartBuilder\public\Data\Update_FactSheetDatesTEMP.csv"
	Local $text = FileReadLine($file, 1)

	$tout1 = StringReplace($text, 'Label,ID', 'Label,ID' & @CRLF)
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)

	$text = FileReadLine($file, 2)

	$tout1 = StringReplace($text, '03/31/2021,1', $MonthNumber & '/' & $DayNumber & '/' & $INPT_CurYear & ',1' & @CRLF)
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

Func ClearLog()
	FileDelete(@ScriptDir & "\AutoCharts.log")
	_FileCreate(@ScriptDir & "\AutoCharts.log")
	If @error = 0 Then
		MsgBox(0, "Success", "Log file cleared.")
	EndIf
	If @error = 1 Then
		MsgBox(0, "Error!", "There was an error with clearing the log.")
	EndIf

EndFunc   ;==>ClearLog



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
			If FileExists(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
				RunCSVConvert4Presentation()
			EndIf



			GUICtrlSetData($ProgressBar, 25)




			FileCopy(@ScriptDir & "/VBS_Scripts/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1)       ; Move all .CSV back to Data folder and overwrite.
			FileMove(@ScriptDir & "/VBS_Scripts/*.csv", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.csv", 1)       ; Move all .CSV back to Data folder and overwrite.

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

	_FileWriteLog($LogFile, "Converted " & $CurrentFund & "-institutional.xlsx file to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-institutional.xlsx file to csv")


EndFunc   ;==>RunCSVConvert4Institution



Func RunCSVConvert4Brochure() ; Dynamically checks for funds with "-brochure.xlsx" files and converts those automatically as well.

	RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-brochure.xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)

	_FileWriteLog($LogFile, "Converted " & $CurrentFund & "-brochure.xlsx file to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-brochure.xlsx file to csv")


EndFunc   ;==>RunCSVConvert4Brochure


Func RunCSVConvert4Presentation() ; Dynamically checks for funds with "-brochure.xlsx" files and converts those automatically as well.

	RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-presentation.xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)

	_FileWriteLog($LogFile, "Converted " & $CurrentFund & "-presentation.xlsx file to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-presentation.xlsx file to csv")


EndFunc   ;==>RunCSVConvert4Presentation




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
			FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.svg", 1)   ; Move all .SVG to Dropbox Indesign Files and Overwrite.
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

Func RunExpenseRatios()
	If $FundFamily = "Catalyst" Then
		GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")
		GUICtrlSetData($ProgressBar, 60)

		FileCopy(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Catalyst_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")       ; grab Expense Ratio .xlsx from Catalyst Data Directory
		RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Catalyst_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)         ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv

		$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
		_FileWriteLog($LogFile, "~~~~~~~~~~~~ Updating Catalyst Expense Ratios ~~~~~~~~~~~~")         ; Write to the logfile
		GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")

		_FileWriteLog($LogFile, "Updated Catalyst Expense Ratios")         ; Write to the logfile

		GUICtrlSetData($UpdateLabel, "Updated Catalyst Expense Ratios")
		FileCopy(@ScriptDir & "/VBS_Scripts/Catalyst_ExpenseRatios.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Catalyst_ExpenseRatios.csv", 1)           ; Move all .CSV back to Data folder and overwrite.
		FileMove(@ScriptDir & "/VBS_Scripts/Catalyst_ExpenseRatios.csv", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\" & $FundFamily & "\Catalyst_ExpenseRatios.csv", 1)           ; Move all .CSV back to Data folder and overwrite.
		FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")           ; deletes remaining .xlsx from conversion


	EndIf
	If $FundFamily = "Rational" Then
		GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
		GUICtrlSetData($ProgressBar, 60)

		FileCopy(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Rational_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")       ; grab Expense Ratio .xlsx from Rational Data Directory
		RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Rational_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)         ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv

		$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
		_FileWriteLog($LogFile, "~~~~~~~~~~~~ Updating Rational Expense Ratios ~~~~~~~~~~~~")         ; Write to the logfile
		GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")

		_FileWriteLog($LogFile, "Updated Rational Expense Ratios")         ; Write to the logfile

		GUICtrlSetData($UpdateLabel, "Updated Rational Expense Ratios")
		FileCopy(@ScriptDir & "/VBS_Scripts/Rational_ExpenseRatios.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Rational_ExpenseRatios.csv", 1)           ; Move all .CSV back to Data folder and overwrite.
		FileMove(@ScriptDir & "/VBS_Scripts/Rational_ExpenseRatios.csv", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\" & $FundFamily & "\Rational_ExpenseRatios.csv", 1)           ; Move all .CSV back to Data folder and overwrite.
		FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")           ; deletes remaining .xlsx from conversion


	EndIf

	GUICtrlSetData($ProgressBar, 100)

EndFunc   ;==>RunExpenseRatios

Func CreateFactSheetArchive()
	Local $Zip, $myfile

	; Create a constant variable in Local scope of the message to display in FileSelectFolder.
	Local Const $sMessage = "Select Save Location"

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")

	Else
		$Zip = _Zip_Create($sFileSelectFolder & "\FactSheets_" & $INPT_Name & "_" & $Select_Quarter & "-" & $INPT_CurYear & ".zip") ;Create The Zip File. Returns a Handle to the zip File
		_Zip_AddFolder($Zip, $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", 4) ;Add a folder to the zip file (files/subfolders will be added)
		_Zip_AddFolder($Zip, $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\", 4) ;Add a folder to the zip file (files/subfolders will be added)
		MsgBox(0, "Items in Zip", "Succesfully added " & _Zip_Count($Zip) & " items in " & $Zip) ;Msgbox Counting Items in $Zip
		$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)

		_FileWriteLog($LogFile, "Created Factsheet Archive at " & $Zip) ; Write to the logfile

	EndIf


EndFunc   ;==>CreateFactSheetArchive


#EndRegion ### Start Main Functions Region
