#RequireAdmin
Global Const $_ARRAYCONSTANT_SORTINFOSIZE = 11
Global $__g_aArrayDisplay_SortInfo[$_ARRAYCONSTANT_SORTINFOSIZE]
Global Const $_ARRAYCONSTANT_tagLVITEM = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($nItem1, $nItem2, $hWnd)
If $__g_aArrayDisplay_SortInfo[3] = $__g_aArrayDisplay_SortInfo[4] Then
If Not $__g_aArrayDisplay_SortInfo[7] Then
$__g_aArrayDisplay_SortInfo[5] *= -1
$__g_aArrayDisplay_SortInfo[7] = 1
EndIf
Else
$__g_aArrayDisplay_SortInfo[7] = 1
EndIf
$__g_aArrayDisplay_SortInfo[6] = $__g_aArrayDisplay_SortInfo[3]
Local $sVal1 = __ArrayDisplay_GetItemText($hWnd, $nItem1, $__g_aArrayDisplay_SortInfo[3])
Local $sVal2 = __ArrayDisplay_GetItemText($hWnd, $nItem2, $__g_aArrayDisplay_SortInfo[3])
If $__g_aArrayDisplay_SortInfo[8] = 1 Then
If(StringIsFloat($sVal1) Or StringIsInt($sVal1)) Then $sVal1 = Number($sVal1)
If(StringIsFloat($sVal2) Or StringIsInt($sVal2)) Then $sVal2 = Number($sVal2)
EndIf
Local $nResult
If $__g_aArrayDisplay_SortInfo[8] < 2 Then
$nResult = 0
If $sVal1 < $sVal2 Then
$nResult = -1
ElseIf $sVal1 > $sVal2 Then
$nResult = 1
EndIf
Else
$nResult = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $sVal1, 'wstr', $sVal2)[0]
EndIf
$nResult = $nResult * $__g_aArrayDisplay_SortInfo[5]
Return $nResult
EndFunc
Func __ArrayDisplay_GetItemText($hWnd, $iIndex, $iSubItem = 0)
Local $tBuffer = DllStructCreate("wchar Text[4096]")
Local $pBuffer = DllStructGetPtr($tBuffer)
Local $tItem = DllStructCreate($_ARRAYCONSTANT_tagLVITEM)
DllStructSetData($tItem, "SubItem", $iSubItem)
DllStructSetData($tItem, "TextMax", 4096)
DllStructSetData($tItem, "Text", $pBuffer)
If IsHWnd($hWnd) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hWnd, "uint", 0x1073, "wparam", $iIndex, "struct*", $tItem)
Else
Local $pItem = DllStructGetPtr($tItem)
GUICtrlSendMsg($hWnd, 0x1073, $iIndex, $pItem)
EndIf
Return DllStructGetData($tBuffer, "Text")
EndFunc
Global Const $FO_APPEND = 1
Global Const $FO_OVERWRITE = 2
Func _FileWriteLog($sLogPath, $sLogMsg, $iFlag = -1)
Local $iOpenMode = $FO_APPEND
Local $sMsg = @YEAR & "-" & @MON & "-" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & " : " & $sLogMsg
If $iFlag = Default Then $iFlag = -1
If $iFlag <> -1 Then
$iOpenMode = $FO_OVERWRITE
$sMsg &= @CRLF & FileRead($sLogPath)
EndIf
Local $hFileOpen = $sLogPath
If IsString($sLogPath) Then $hFileOpen = FileOpen($sLogPath, $iOpenMode)
If $hFileOpen = -1 Then Return SetError(1, 0, 0)
Local $iReturn = FileWriteLine($hFileOpen, $sMsg)
If IsString($sLogPath) Then $iReturn = FileClose($hFileOpen)
If $iReturn <= 0 Then Return SetError(2, $iReturn, 0)
Return $iReturn
EndFunc
Global Const $BS_PUSHLIKE = 0x1000
Global Const $GUI_SS_DEFAULT_CHECKBOX = 0
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_SHOW = 16
Global Const $SS_NOTIFY = 0x0100
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $GUI_SS_DEFAULT_PIC = $SS_NOTIFY
Global Const $tagOSVERSIONINFO = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $__WINVER = __WINVER()
Func __WINVER()
Local $tOSVI = DllStructCreate($tagOSVERSIONINFO)
DllStructSetData($tOSVI, 1, DllStructGetSize($tOSVI))
Local $aRet = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $tOSVI)
If @error Or Not $aRet[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($tOSVI, 2), -8), DllStructGetData($tOSVI, 3))
EndFunc
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
Global $GUI_UserSettings = 9999
$INPT_DropboxFolder = 9999
$BTN_Save = 9999
$BTN_Cancel = 9999
RunMainGui()
Func RunMainGui()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)
Sleep(2000)
SplashOff()
$MainGUI = GUICreate("AutoCharts 2.0", 570, 609, -1, -1)
$mFile = GUICtrlCreateMenu("&File")
$mSyncFiles = GUICtrlCreateMenuItem("&Pull Data From Dropbox", $mFile)
$mExit = GUICtrlCreateMenuItem("&Exit", $mFile)
$mSettings = GUICtrlCreateMenu("&Settings")
$mEditSettings = GUICtrlCreateMenuItem("&Edit", $mSettings)
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
$aMsg = GUIGetMsg(1)
Switch $aMsg[1]
Case $MainGUI
Switch $aMsg[0]
Case $GUI_EVENT_CLOSE
FileClose($LogFile)
ExitLoop
Case $mExit
Exit
Case $GUI_EVENT_CLOSE
FileClose($LogFile)
Exit
Case $mEditSettings
OpenSettingsGUI()
Case $mAbout
ShellExecute("https://onevion.github.io/AutoCharts/")
Case $mLogFile
$sTextFile = @ScriptDir & "\AutoCharts.log"
$_Run = "notepad.exe " & $sTextFile
ConsoleWrite("$_Run : " & $_Run & @CRLF)
Run($_Run, @WindowsDir, @SW_SHOWDEFAULT)
Case $ACX
If GUICtrlRead($ACX) = 1 Then $aCatalystCheck[0] = "ACX"
If GUICtrlRead($ACX) = 4 Then $aCatalystCheck[0] = 0
Case $ATR
If GUICtrlRead($ATR) = 1 Then $aCatalystCheck[1] = "ATR"
If GUICtrlRead($ATR) = 4 Then $aCatalystCheck[1] = 0
Case $BUY
If GUICtrlRead($BUY) = 1 Then $aCatalystCheck[2] = "BUY"
If GUICtrlRead($BUY) = 4 Then $aCatalystCheck[2] = 0
Case $CAX
If GUICtrlRead($CAX) = 1 Then $aCatalystCheck[3] = "CAX"
If GUICtrlRead($CAX) = 4 Then $aCatalystCheck[3] = 0
Case $CFH
If GUICtrlRead($CFH) = 1 Then $aCatalystCheck[4] = "CFH"
If GUICtrlRead($CFH) = 4 Then $aCatalystCheck[4] = 0
Case $CPE
If GUICtrlRead($CPE) = 1 Then $aCatalystCheck[5] = "CPE"
If GUICtrlRead($CPE) = 4 Then $aCatalystCheck[5] = 0
Case $CLT
If GUICtrlRead($CLT) = 1 Then $aCatalystCheck[6] = "CLT"
If GUICtrlRead($CLT) = 4 Then $aCatalystCheck[6] = 0
Case $CLP
If GUICtrlRead($CLP) = 1 Then $aCatalystCheck[7] = "CLP"
If GUICtrlRead($CLP) = 4 Then $aCatalystCheck[7] = 0
Case $CFR
If GUICtrlRead($CFR) = 1 Then $aCatalystCheck[9] = "CFR"
If GUICtrlRead($CFR) = 4 Then $aCatalystCheck[9] = 0
Case $IIX
If GUICtrlRead($IIX) = 1 Then $aCatalystCheck[10] = "IIX"
If GUICtrlRead($IIX) = 4 Then $aCatalystCheck[10] = 0
Case $HII
If GUICtrlRead($HII) = 1 Then $aCatalystCheck[11] = "HII"
If GUICtrlRead($HII) = 4 Then $aCatalystCheck[11] = 0
Case $EIX
If GUICtrlRead($EIX) = 1 Then $aCatalystCheck[12] = "EIX"
If GUICtrlRead($EIX) = 4 Then $aCatalystCheck[12] = 0
Case $CWX
If GUICtrlRead($CWX) = 1 Then $aCatalystCheck[13] = "CWX"
If GUICtrlRead($CWX) = 4 Then $aCatalystCheck[13] = 0
Case $CTV
If GUICtrlRead($CTV) = 1 Then $aCatalystCheck[14] = "CTV"
If GUICtrlRead($CTV) = 4 Then $aCatalystCheck[14] = 0
Case $INS
If GUICtrlRead($INS) = 1 Then $aCatalystCheck[15] = "INS"
If GUICtrlRead($INS) = 4 Then $aCatalystCheck[15] = 0
Case $IOX
If GUICtrlRead($IOX) = 1 Then $aCatalystCheck[16] = "IOX"
If GUICtrlRead($IOX) = 4 Then $aCatalystCheck[16] = 0
Case $MBX
If GUICtrlRead($MBX) = 1 Then $aCatalystCheck[17] = "MBX"
If GUICtrlRead($MBX) = 4 Then $aCatalystCheck[17] = 0
Case $MLX
If GUICtrlRead($MLX) = 1 Then $aCatalystCheck[18] = "MLX"
If GUICtrlRead($MLX) = 4 Then $aCatalystCheck[18] = 0
Case $SHI
If GUICtrlRead($SHI) = 1 Then $aCatalystCheck[20] = "SHI"
If GUICtrlRead($SHI) = 4 Then $aCatalystCheck[20] = 0
Case $TEZ
If GUICtrlRead($TEZ) = 1 Then $aCatalystCheck[21] = "TEZ"
If GUICtrlRead($TEZ) = 4 Then $aCatalystCheck[21] = 0
Case $TRI
If GUICtrlRead($TRI) = 1 Then $aCatalystCheck[22] = "TRI"
If GUICtrlRead($TRI) = 4 Then $aCatalystCheck[22] = 0
Case $TRX
If GUICtrlRead($TRX) = 1 Then $aCatalystCheck[23] = "TRX"
If GUICtrlRead($TRX) = 4 Then $aCatalystCheck[23] = 0
Case $HBA
If GUICtrlRead($HBA) = 1 Then $aRationalCheck[0] = "HBA"
If GUICtrlRead($HBA) = 4 Then $aRationalCheck[0] = 0
Case $HDC
If GUICtrlRead($HDC) = 1 Then $aRationalCheck[1] = "HDC"
If GUICtrlRead($HDC) = 4 Then $aRationalCheck[1] = 0
Case $HRS
If GUICtrlRead($HRS) = 1 Then $aRationalCheck[2] = "HRS"
If GUICtrlRead($HRS) = 4 Then $aRationalCheck[2] = 0
Case $HSU
If GUICtrlRead($HSU) = 1 Then $aRationalCheck[3] = "HSU"
If GUICtrlRead($HSU) = 4 Then $aRationalCheck[3] = 0
Case $PBX
If GUICtrlRead($PBX) = 1 Then $aRationalCheck[4] = "PBX"
If GUICtrlRead($PBX) = 4 Then $aRationalCheck[4] = 0
Case $RDM
If GUICtrlRead($RDM) = 1 Then $aRationalCheck[5] = "RDM"
If GUICtrlRead($RDM) = 4 Then $aRationalCheck[5] = 0
Case $RFX
If GUICtrlRead($RFX) = 1 Then $aRationalCheck[6] = "RFX"
If GUICtrlRead($RFX) = 4 Then $aRationalCheck[6] = 0
Case $RTAVF
If GUICtrlRead($RTAVF) = 1 Then $aRationalCheck[7] = "RTAVF"
If GUICtrlRead($RTAVF) = 4 Then $aRationalCheck[7] = 0
Case $GLDB
If GUICtrlRead($GLDB) = 1 Then $aStrategyCheck[0] = "GLDB"
If GUICtrlRead($GLDB) = 4 Then $aStrategyCheck[0] = 0
Case $HNDL
If GUICtrlRead($HNDL) = 1 Then $aStrategyCheck[1] = "HNDL"
If GUICtrlRead($HNDL) = 4 Then $aStrategyCheck[1] = 0
Case $ROMO
If GUICtrlRead($ROMO) = 1 Then $aStrategyCheck[2] = "ROMO"
If GUICtrlRead($ROMO) = 4 Then $aStrategyCheck[2] = 0
Case $BTN_RunCatalyst
$FundFamily = "Catalyst"
$FamilySwitch = $aCatalystCheck
GUICtrlSetData($ProgressBar, 10)
RunCSVConvert()
CreateCharts()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "############################### END OF RUN - CATALYST ###############################")
FileClose($LogFile)
GUICtrlSetData($ProgressBar, 0)
MsgBox(0, "Finished", "The process has finished.")
GUICtrlSetData($UpdateLabel, "The process has finished.")
Case $BTN_RunRational
$FundFamily = "Rational"
$FamilySwitch = $aRationalCheck
GUICtrlSetData($ProgressBar, 10)
RunCSVConvert()
CreateCharts()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "############################### END OF RUN - RATIONAL ###############################")
FileClose($LogFile)
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
_FileWriteLog($LogFile, "############################### END OF RUN - STRATEGY SHARES ###############################")
FileClose($LogFile)
GUICtrlSetData($ProgressBar, 0)
MsgBox(0, "Finished", "The process has finished.")
GUICtrlSetData($UpdateLabel, "The process has finished.")
Case $mSyncFiles
SyncronizeDataFiles()
MsgBox(0, "Alert", "Sync Successful")
EndSwitch
Case $GUI_UserSettings
Switch $aMsg[0]
Case $GUI_EVENT_CLOSE
GUIDelete($GUI_UserSettings)
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
GUIDelete($GUI_UserSettings)
EndIf
Case $BTN_Cancel
GUIDelete($GUI_UserSettings)
EndSwitch
EndSwitch
WEnd
EndFunc
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
EndFunc
Func VerifyDropbox()
If FileExists($DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\.checkfile") Then
$bDBVerified = True
IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
Else
$bDBVerified = False
IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
MsgBox(0, "Error!", "Your Dropbox directory can not be verified. Please try again.")
EndIf
EndFunc
Func SyncronizeDataFiles()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
DirCopy($DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", @ScriptDir & $CSVDataDir, 1)
SplashOff()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Synced Dropbox data with Autocharts Data")
EndFunc
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
_FileWriteLog($LogFile, "Determined quarter to be ~" & $Select_Quarter & "~ and current year to be ~" & $INPT_CurYear & "~")
FileClose($LogFile)
If FileExists(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv") Then
FileDelete(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv")
EndIf
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
$tout1 = StringReplace($text, '1Q 2021,3', $Select_Quarter & ' ' & $INPT_CurYear & ',3' & @CRLF)
FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)
$text = FileReadLine($file, 5)
$tout1 = StringReplace($text, 'March 2021,4', $QtrToMonth & ' ' & $INPT_CurYear & ',4' & @CRLF)
FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)
$text = FileReadLine($file, 6)
$tout1 = StringReplace($text, '03/2021,5', $MonthNumber & '/' & $INPT_CurYear & ',5')
FileWrite(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $tout1)
FileClose(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv")
FileMove(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", 1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Updated FactSheetDates CSV File with selected dates")
FileClose($LogFile)
EndFunc
Func RunCSVConvert()
For $a = 0 To(UBound($FamilySwitch) - 1)
If $FamilySwitch[$a] <> "" Then
$CurrentFund = $FamilySwitch[$a]
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund)
GUICtrlSetData($ProgressBar, 15)
FileCopy(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "*.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & ".xlsx", @TempDir, @SW_HIDE)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
_FileWriteLog($LogFile, "Converted " & $CurrentFund & ".xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & ".xlsx file to csv")
If FileExists(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
RunCSVConvert4Institution()
EndIf
If FileExists(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
RunCSVConvert4Brochure()
EndIf
GUICtrlSetData($ProgressBar, 25)
FileCopy(@ScriptDir & "/VBS_Scripts/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1)
FileMove(@ScriptDir & "/VBS_Scripts/*.csv", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.csv", 1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in Dropbox")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in Dropbox")
GUICtrlSetData($ProgressBar, 30)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
GUICtrlSetData($ProgressBar, 35)
Else
ContinueLoop
EndIf
Next
EndFunc
Func RunCSVConvert4Institution()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-institutional.xlsx", @TempDir, @SW_HIDE)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
_FileWriteLog($LogFile, "Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-institutional.xlsx files to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-institutional.xlsx files to csv")
EndFunc
Func RunCSVConvert4Brochure()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-brochure.xlsx", @TempDir, @SW_HIDE)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
_FileWriteLog($LogFile, "Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-brochure.xlsx files to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & ".xlsx and " & $CurrentFund & "-brochure.xlsx files to csv")
EndFunc
Func HTMLChartEditor()
Local $file = @ScriptDir & "\assets\ChartBuilder\public\index_TEMPLATE.html"
Local $text = FileRead($file)
$tout1 = StringReplace($text, '<script src="/scripts/CHANGEME.js"></script>', '<script src="/scripts/' & $CurrentFund & '.js"></script>')
FileWrite(@ScriptDir & "\assets\ChartBuilder\public\index.html", $tout1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")
_FileWriteLog($LogFile, "Created HTML file for " & $CurrentFund & " chart generation")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Created HTML file for " & $CurrentFund & " chart generation")
_FileWriteLog($LogFile, "Initializing Local Server for amCharts")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Initializing Local Server for amCharts")
EndFunc
Func CreateCharts()
For $a = 0 To(UBound($FamilySwitch) - 1)
If $FamilySwitch[$a] <> "" Then
$CurrentFund = $FamilySwitch[$a]
Call("HTMLChartEditor")
RunWait(@ComSpec & " /c node --unhandled-rejections=strict server.js", @ScriptDir & "/assets/ChartBuilder/", @SW_HIDE)
GUICtrlSetData($ProgressBar, 70)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, $CurrentFund & " charts generated in SVG format using amCharts")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Charts generated in SVG format using amCharts")
FileDelete(@ScriptDir & "\assets\ChartBuilder\public\index.html")
FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.svg", 1)
GUICtrlSetData($ProgressBar, 92)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, $CurrentFund & " charts moved to the funds InDesign Links folder")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Charts moved to the funds InDesign Links folder")
Else
ContinueLoop
EndIf
GUICtrlSetData($ProgressBar, 100)
Next
EndFunc
