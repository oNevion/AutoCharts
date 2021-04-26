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
#Region ### GLOBAL Arrays and Variables
GLOBAL $aCatalystCheck[24]
GLOBAL $CurrentFund
GLOBAL $CSVDataDir = "\assets\ChartBuilder\public\Data\Backups"
GLOBAL $ini = 'settings.ini'
GLOBAL $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', 'Error! No Dropbox Directory')
GLOBAL $FundFamily = ""

;Predeclare the variables with dummy values to prevent firing the Case statements, only for GUI this time
Global $GUI_UserSettings = 9999
Global $INPT_DropboxFolder = 9999
Global $BTN_Save = 9999
Global $BTN_Cancel = 9999
#EndRegion ### GLOBAL Arrays and Variables

#Region ### START Main GUI Load

RunMainGui()

Func RunMainGui()
	$MainGUI = GUICreate("AutoCharts 2.0", 626, 638, -1, -1)
	$mFile = GUICtrlCreateMenu("&File")
	$mSyncFiles = GUICtrlCreateMenuItem("&Sync Files", $mFile)
	$mUploadFactsheets = GUICtrlCreateMenuItem("Upload Factsheets to Website", $mFile)
	$mExit = GUICtrlCreateMenuItem("&Exit", $mFile)
	$mSettings = GUICtrlCreateMenu("&Settings")
	$mEditSettings = GUICtrlCreateMenuItem("&Edit", $mSettings)
	$mImportSettings = GUICtrlCreateMenuItem("&Import", $mSettings)
	$mExportSettings = GUICtrlCreateMenuItem("&Export", $mSettings)
	$mHelp = GUICtrlCreateMenu("&Help")
	$mAbout = GUICtrlCreateMenuItem("&About", $mHelp)
	$mLogFile = GUICtrlCreateMenuItem("&Open Log File", $mHelp)
	$TAB_Main = GUICtrlCreateTab(8, 176, 601, 353)
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	$TAB_Catalyst = GUICtrlCreateTabItem("Catalyst Fact Sheets")
	GUICtrlSetState(-1,$GUI_SHOW)
	$BTN_RunCatalyst = GUICtrlCreateButton("Process Updates", 160, 483, 115, 33)
	GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	$BTN_SelectAllCatalyst = GUICtrlCreateButton("Select All", 28, 483, 115, 33)
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	$ACX = GUICtrlCreateCheckbox("ACX", 28, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$ATR = GUICtrlCreateCheckbox("ATR", 28, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$BUY = GUICtrlCreateCheckbox("BUY", 28, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CAX = GUICtrlCreateCheckbox("CAX", 28, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CFH = GUICtrlCreateCheckbox("CFH", 28, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CPE = GUICtrlCreateCheckbox("CPE", 132, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CLT = GUICtrlCreateCheckbox("CLT", 132, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CLP = GUICtrlCreateCheckbox("CLP", 132, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CGG = GUICtrlCreateCheckbox("CGG", 132, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CFR = GUICtrlCreateCheckbox("CFR", 132, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$IIX = GUICtrlCreateCheckbox("IIX", 236, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HII = GUICtrlCreateCheckbox("HII", 236, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$EIX = GUICtrlCreateCheckbox("EIX", 236, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CWX = GUICtrlCreateCheckbox("CWX", 236, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$CTV = GUICtrlCreateCheckbox("CTV", 236, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$INS = GUICtrlCreateCheckbox("INS", 340, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$IOX = GUICtrlCreateCheckbox("IOX", 340, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$MBX = GUICtrlCreateCheckbox("MBX", 340, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$MLX = GUICtrlCreateCheckbox("MLX", 340, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$OIP = GUICtrlCreateCheckbox("OIP", 340, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$SHI = GUICtrlCreateCheckbox("SHI", 444, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TEZ = GUICtrlCreateCheckbox("TEZ", 444, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TRI = GUICtrlCreateCheckbox("TRI", 444, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TRX = GUICtrlCreateCheckbox("TRX", 444, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$TAB_Rational = GUICtrlCreateTabItem("Rational Fact Sheets")
	$HBA = GUICtrlCreateCheckbox("HBA", 28, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HDC = GUICtrlCreateCheckbox("HDC", 28, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HRS = GUICtrlCreateCheckbox("HRS", 28, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HSU = GUICtrlCreateCheckbox("HSU", 28, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$NUX = GUICtrlCreateCheckbox("NUX", 28, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$PBX = GUICtrlCreateCheckbox("PBX", 132, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$RDM = GUICtrlCreateCheckbox("RDM", 132, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$RFX = GUICtrlCreateCheckbox("RFX", 132, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$RTAVF = GUICtrlCreateCheckbox("RTAVF", 132, 377, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$BTN_RunRational = GUICtrlCreateButton("Process Updates", 27, 477, 115, 33)
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	$TAB_StrategyShares = GUICtrlCreateTabItem("Strategy Shares Fact Sheets")
	$GLDB = GUICtrlCreateCheckbox("GLDB", 28, 227, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$HNDL = GUICtrlCreateCheckbox("HNDL", 28, 277, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$ROMO = GUICtrlCreateCheckbox("ROMO", 28, 327, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_PUSHLIKE))
	GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$BTN_RunStrategyShares = GUICtrlCreateButton("Process Updates", 29, 480, 115, 33)
	GUICtrlSetBkColor(-1, 0xC0DCC0)
	GUICtrlCreateTabItem("")
	$Pic1 = GUICtrlCreatePic("C:\Users\mrjak\Documents\SublimeProjects\AutoCharts\assets\Wizard\main-img.jpg", 8, 8, 593, 158, BitOR($GUI_SS_DEFAULT_PIC,$SS_CENTERIMAGE))
	$ProgressBar = GUICtrlCreateProgress(8, 536, 598, 17)

	GUISetState()

	Local $aMsg
	While 1
		$aMsg = GUIGetMsg(1) ; Use advanced parameter to get array
		Switch $aMsg[1] ; check which GUI box sent the message
			Case $MainGUI
				Switch $aMsg[0] ; Now check for the messages for $MainGUI
					Case $GUI_EVENT_CLOSE ; If we get the CLOSE message from this GUI - we exit <<<<<<<<<<<<<<<
						ExitLoop
					Case $mExit
						Exit
					Case $GUI_EVENT_CLOSE
						Exit
					Case $mEditSettings
						GUICtrlSetState($mEditSettings, $GUI_DISABLE)
						OpenSettingsGUI()

					Case $ACX
						If GUICtrlRead($ACX) = 1 Then $aCatalystCheck[0] = "acx" ; Sets first slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($ACX) = 4 Then $aCatalystCheck[0] = 0 ; Sets first slot of the Catalyst Array to 0 if NOT CHECKED
					Case $ATR
						If GUICtrlRead($ATR) = 1 Then $aCatalystCheck[1] = "atr" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($ATR) = 4 Then $aCatalystCheck[1] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $BUY
						If GUICtrlRead($BUY) = 1 Then $aCatalystCheck[2] = "buy" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($BUY) = 4 Then $aCatalystCheck[2] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CAX
						If GUICtrlRead($CAX) = 1 Then $aCatalystCheck[3] = "cax" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CAX) = 4 Then $aCatalystCheck[3] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CFH
						If GUICtrlRead($CFH) = 1 Then $aCatalystCheck[4] = "cfh" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CFH) = 4 Then $aCatalystCheck[4] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CPE
						If GUICtrlRead($CPE) = 1 Then $aCatalystCheck[5] = "cpe" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CPE) = 4 Then $aCatalystCheck[5] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CLT
						If GUICtrlRead($CLT) = 1 Then $aCatalystCheck[6] = "clt" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CLT) = 4 Then $aCatalystCheck[6] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CLP
						If GUICtrlRead($CLP) = 1 Then $aCatalystCheck[7] = "clp" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CLP) = 4 Then $aCatalystCheck[7] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CGG
						If GUICtrlRead($CGG) = 1 Then $aCatalystCheck[8] = "cgg" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CGG) = 4 Then $aCatalystCheck[8] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CFR
						If GUICtrlRead($CFR) = 1 Then $aCatalystCheck[9] = "cfr" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CFR) = 4 Then $aCatalystCheck[9] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $IIX
						If GUICtrlRead($IIX) = 1 Then $aCatalystCheck[10] = "iix" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($IIX) = 4 Then $aCatalystCheck[10] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $HII
						If GUICtrlRead($HII) = 1 Then $aCatalystCheck[11] = "hii" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($HII) = 4 Then $aCatalystCheck[11] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $EIX
						If GUICtrlRead($EIX) = 1 Then $aCatalystCheck[12] = "eix" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($EIX) = 4 Then $aCatalystCheck[12] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CWX
						If GUICtrlRead($CWX) = 1 Then $aCatalystCheck[13] = "cwx" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CWX) = 4 Then $aCatalystCheck[13] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $CTV
						If GUICtrlRead($CTV) = 1 Then $aCatalystCheck[14] = "ctv" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($CTV) = 4 Then $aCatalystCheck[14] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $INS
						If GUICtrlRead($INS) = 1 Then $aCatalystCheck[15] = "ins" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($INS) = 4 Then $aCatalystCheck[15] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $IOX
						If GUICtrlRead($IOX) = 1 Then $aCatalystCheck[16] = "iox" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($IOX) = 4 Then $aCatalystCheck[16] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $MBX
						If GUICtrlRead($MBX) = 1 Then $aCatalystCheck[17] = "mbx" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($MBX) = 4 Then $aCatalystCheck[17] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $MLX
						If GUICtrlRead($MLX) = 1 Then $aCatalystCheck[18] = "mlx" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($MLX) = 4 Then $aCatalystCheck[18] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $OIP
						If GUICtrlRead($OIP) = 1 Then $aCatalystCheck[19] = "oip" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($OIP) = 4 Then $aCatalystCheck[19] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $SHI
						If GUICtrlRead($SHI) = 1 Then $aCatalystCheck[20] = "shi" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($SHI) = 4 Then $aCatalystCheck[20] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $TEZ
						If GUICtrlRead($TEZ) = 1 Then $aCatalystCheck[21] = "tez" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($TEZ) = 4 Then $aCatalystCheck[21] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $TRI
						If GUICtrlRead($TRI) = 1 Then $aCatalystCheck[22] = "tri" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($TRI) = 4 Then $aCatalystCheck[22] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $TRX
						If GUICtrlRead($TRX) = 1 Then $aCatalystCheck[23] = "trx" ; Sets  slot of the Catalyst Array to 1 if CHECKED
						If GUICtrlRead($TRX) = 4 Then $aCatalystCheck[23] = 0 ; Sets  slot of the Catalyst Array to 0 if NOT CHECKED
					Case $BTN_RunCatalyst
						$FundFamily = "Catalyst"
						RunCSVConvert()
						CreateCharts()
						Exit
					Case $HBA
					Case $HDC
					Case $HRS
					Case $HSU
					Case $NUX
					Case $PBX
					Case $RDM
					Case $RFX
					Case $RTAVF
					Case $GLDB
					Case $HNDL
					Case $ROMO
					Case $mSyncFiles
						SyncronizeDataFiles()
						MsgBox(0,"Alert","Sync Successful")

				EndSwitch
			Case $GUI_UserSettings
				Switch $aMsg[0] ; Now check for the messages for $GUI_UserSettings
					Case $GUI_EVENT_CLOSE ; If we get the CLOSE message from this GUI - we just delete the GUI
						GUIDelete($GUI_UserSettings)
						GUICtrlSetState($mEditSettings, $GUI_ENABLE)
					Case $BTN_Save
						$DATA_UserSettings = GUICtrlRead($INPT_DropboxFolder)
						IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'DropboxDir', $DATA_UserSettings)
						; Close Settings Window after saving file.
						GUIDelete($GUI_UserSettings)
						GUICtrlSetState($mEditSettings, $GUI_ENABLE)
					Case $BTN_Cancel = $GUI_EVENT_CLOSE
						; Close Settings Window after saving file.

GUIDelete($GUI_UserSettings)
						GUICtrlSetState($mEditSettings, $GUI_ENABLE)
				EndSwitch
		EndSwitch
	WEnd
EndFunc ; MainGUI Load
#EndRegion ### END Koda GUI section ###


#Region ### START Koda GUI section ### Form=C:\Users\mrjak\Documents\SublimeProjects\AutoCharts\assets\GUI_UserSettings.kxf

Func OpenSettingsGUI()
	$GUI_UserSettings = GUICreate("User Settings", 236, 96, -1, -1)
	Local $INPT_DropboxFolder = GUICtrlCreateInput("", 16, 16, 201, 21)
	Local $BTN_Save = GUICtrlCreateButton("Save", 16, 48, 75, 25)
	Local $BTN_Cancel = GUICtrlCreateButton("Cancel", 144, 48, 75, 25)
	GUISetState()
EndFunc ;-->OpenSettingsGUI
#EndRegion ### END Koda GUI section ###


#Region ### Start Main Functions Region

Func SyncronizeDataFiles()
	DirCopy ( $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", @ScriptDir & $CSVDataDir, 1 )
EndFunc ;-->SyncronizeDataFiles


Func RunCSVConvert() ; Dynamically checks for funds with "-institutional.xlsx" files and converts those automatically as well.

	For $a = 0 To (UBound($aCatalystCheck) -1) ; Loops through FundFamily Array
		If $aCatalystCheck[$a] <> "" Then
			$CurrentFund = $aCatalystCheck[$a]
			If FileExists (@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then ; dynamically checks if Current Fund has institutional backupfile. If so, runs csv convert on both
				FileCopy ( @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "*.xlsx", @ScriptDir & "/VBS_Scripts/") ; grab .xlsx from current fund directory and move to /VBS_Scripts
				RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & ".xlsx", @TempDir, @SW_HIDE) ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv
				RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-institutional.xlsx", @TempDir, @SW_HIDE) ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

			Else
				FileCopy ( @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "*.xlsx", @ScriptDir & "/VBS_Scripts/") ; grab .xlsx from current fund directory and move to /VBS_Scripts
				RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & ".xlsx", @TempDir, @SW_HIDE) ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv

			EndIf
				FileCopy ( @ScriptDir & "/VBS_Scripts/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1) ; Move all .CSV back to Data folder and overwrite.
				FileMove ( @ScriptDir & "/VBS_Scripts/*.csv", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.csv", 1) ; Move all .CSV back to Data folder and overwrite.
				FileDelete ( @ScriptDir & "/VBS_Scripts/*.xlsx") ; deletes remaining .xlsx from conversion
	Else
			ContinueLoop
	EndIf

	Next

EndFunc ;-->RunCSVConvert


Func HTMLChartEditor() ; Edits index_TEMPLATE.html file to include current fund's chart .js file
	LOCAL $file = @ScriptDir & "\assets\ChartBuilder\public\index_TEMPLATE.html"
	LOCAL $text = FileRead ($file)

	$tout1 = StringReplace ($text, '<script src="/scripts/CHANGEME.js"></script>', '<script src="/scripts/' & $CurrentFund & '.js"></script>')
	FileWrite (@ScriptDir & "\assets\ChartBuilder\public\index.html", $tout1)
EndFunc ; -->HTMLChartEditor




Func CreateCharts()
		For $a = 0 To (UBound($aCatalystCheck) -1) ; Loops through FundFamily Array
		If $aCatalystCheck[$a] <> "" Then
			$CurrentFund = $aCatalystCheck[$a]
			Call ("HTMLChartEditor")
			RunWait(@ComSpec & " /c node --unhandled-rejections=strict server.js", @ScriptDir & "/assets/ChartBuilder/") ;~ Runs local server to create current fund's amcharts svgs.
			FileDelete (@ScriptDir & "\assets\ChartBuilder\public\index.html") ; ~ Deletes index.html file that was created in Func HTMLChartEditor to keep from editing the same file.
			FileMove ( @ScriptDir & "/assets/ChartBuilder/*.svg", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.svg", 1) ; Move all .SVG to Dropbox Indesign Files and Overwrite.

		Else
			ContinueLoop
		EndIf

	Next
EndFunc ;-->CreateCharts

#EndRegion ### END Main Functions Region ###
