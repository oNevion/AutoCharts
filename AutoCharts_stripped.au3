Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $MB_SYSTEMMODAL = 4096
Global Const $STR_ENTIRESPLIT = 1
Global Const $STR_NOCOUNT = 2
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
Global Enum $ARRAYFILL_FORCE_DEFAULT, $ARRAYFILL_FORCE_SINGLEITEM, $ARRAYFILL_FORCE_INT, $ARRAYFILL_FORCE_NUMBER, $ARRAYFILL_FORCE_PTR, $ARRAYFILL_FORCE_HWND, $ARRAYFILL_FORCE_STRING, $ARRAYFILL_FORCE_BOOLEAN
Func _ArrayAdd(ByRef $aArray, $vValue, $iStart = 0, $sDelim_Item = "|", $sDelim_Row = @CRLF, $iForce = $ARRAYFILL_FORCE_DEFAULT)
If $iStart = Default Then $iStart = 0
If $sDelim_Item = Default Then $sDelim_Item = "|"
If $sDelim_Row = Default Then $sDelim_Row = @CRLF
If $iForce = Default Then $iForce = $ARRAYFILL_FORCE_DEFAULT
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
Local $hDataType = 0
Switch $iForce
Case $ARRAYFILL_FORCE_INT
$hDataType = Int
Case $ARRAYFILL_FORCE_NUMBER
$hDataType = Number
Case $ARRAYFILL_FORCE_PTR
$hDataType = Ptr
Case $ARRAYFILL_FORCE_HWND
$hDataType = Hwnd
Case $ARRAYFILL_FORCE_STRING
$hDataType = String
Case $ARRAYFILL_FORCE_BOOLEAN
$hDataType = "Boolean"
EndSwitch
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iForce = $ARRAYFILL_FORCE_SINGLEITEM Then
ReDim $aArray[$iDim_1 + 1]
$aArray[$iDim_1] = $vValue
Return $iDim_1
EndIf
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(5, 0, -1)
$hDataType = 0
Else
Local $aTmp = StringSplit($vValue, $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
If UBound($aTmp, $UBOUND_ROWS) = 1 Then
$aTmp[0] = $vValue
EndIf
$vValue = $aTmp
EndIf
Local $iAdd = UBound($vValue, $UBOUND_ROWS)
ReDim $aArray[$iDim_1 + $iAdd]
For $i = 0 To $iAdd - 1
If String($hDataType) = "Boolean" Then
Switch $vValue[$i]
Case "True", "1"
$aArray[$iDim_1 + $i] = True
Case "False", "0", ""
$aArray[$iDim_1 + $i] = False
EndSwitch
ElseIf IsFunc($hDataType) Then
$aArray[$iDim_1 + $i] = $hDataType($vValue[$i])
Else
$aArray[$iDim_1 + $i] = $vValue[$i]
EndIf
Next
Return $iDim_1 + $iAdd - 1
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
If $iStart < 0 Or $iStart > $iDim_2 - 1 Then Return SetError(4, 0, -1)
Local $iValDim_1, $iValDim_2 = 0, $iColCount
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(5, 0, -1)
$iValDim_1 = UBound($vValue, $UBOUND_ROWS)
$iValDim_2 = UBound($vValue, $UBOUND_COLUMNS)
$hDataType = 0
Else
Local $aSplit_1 = StringSplit($vValue, $sDelim_Row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
$iValDim_1 = UBound($aSplit_1, $UBOUND_ROWS)
Local $aTmp[$iValDim_1][0], $aSplit_2
For $i = 0 To $iValDim_1 - 1
$aSplit_2 = StringSplit($aSplit_1[$i], $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
$iColCount = UBound($aSplit_2)
If $iColCount > $iValDim_2 Then
$iValDim_2 = $iColCount
ReDim $aTmp[$iValDim_1][$iValDim_2]
EndIf
For $j = 0 To $iColCount - 1
$aTmp[$i][$j] = $aSplit_2[$j]
Next
Next
$vValue = $aTmp
EndIf
If UBound($vValue, $UBOUND_COLUMNS) + $iStart > UBound($aArray, $UBOUND_COLUMNS) Then Return SetError(3, 0, -1)
ReDim $aArray[$iDim_1 + $iValDim_1][$iDim_2]
For $iWriteTo_Index = 0 To $iValDim_1 - 1
For $j = 0 To $iDim_2 - 1
If $j < $iStart Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
ElseIf $j - $iStart > $iValDim_2 - 1 Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
Else
If String($hDataType) = "Boolean" Then
Switch $vValue[$iWriteTo_Index][$j - $iStart]
Case "True", "1"
$aArray[$iWriteTo_Index + $iDim_1][$j] = True
Case "False", "0", ""
$aArray[$iWriteTo_Index + $iDim_1][$j] = False
EndSwitch
ElseIf IsFunc($hDataType) Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = $hDataType($vValue[$iWriteTo_Index][$j - $iStart])
Else
$aArray[$iWriteTo_Index + $iDim_1][$j] = $vValue[$iWriteTo_Index][$j - $iStart]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($aArray, $UBOUND_ROWS) - 1
EndFunc
Global Const $FO_APPEND = 1
Global Const $FO_OVERWRITE = 2
Global Const $FO_CREATEPATH = 8
Func _FileCreate($sFilePath)
Local $hFileOpen = FileOpen($sFilePath, BitOR($FO_OVERWRITE, $FO_CREATEPATH))
If $hFileOpen = -1 Then Return SetError(1, 0, 0)
Local $iFileWrite = FileWrite($hFileOpen, "")
FileClose($hFileOpen)
If Not $iFileWrite Then Return SetError(2, 0, 0)
Return 1
EndFunc
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
Global Const $GUI_DISABLE = 128
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
If UBound($CMDLine) > 1 Then
If $CMDLine[1] <> "" Then _Zip_VirtualZipOpen()
EndIf
Func _Zip_Create($hFilename)
$hFp = FileOpen($hFilename, 26)
$sString = Chr(80) & Chr(75) & Chr(5) & Chr(6) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0)
FileWrite($hFp, $sString)
If @error Then Return SetError(1,0,0)
FileClose($hFp)
While Not FileExists($hFilename)
Sleep(10)
Wend
Return $hFilename
EndFunc
Func _Zip_AddFolder($hZipFile, $hFolder, $flag = 1)
Local $DLLChk = _Zip_DllChk()
If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0)
If not _IsFullPath($hZipFile) then Return SetError(4,0)
If Not FileExists($hZipFile) Then Return SetError(1, 0, 0)
If StringRight($hFolder, 1) <> "\" Then $hFolder &= "\"
$files = _Zip_Count($hZipFile)
$oApp = ObjCreate("Shell.Application")
$oCopy = $oApp.NameSpace($hZipFile).CopyHere($oApp.Namespace($hFolder))
While 1
If $flag = 1 then _Hide()
If _Zip_Count($hZipFile) =($files+1) Then ExitLoop
Sleep(10)
WEnd
Return SetError(0,0,1)
EndFunc
Func _Zip_Unzip($hZipFile, $hFilename, $hDestPath, $flag = 1)
Local $DLLChk = _Zip_DllChk()
If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0)
If not _IsFullPath($hZipFile) then Return SetError(4,0)
If Not FileExists($hZipFile) Then Return SetError(1, 0, 0)
If Not FileExists($hDestPath) Then DirCreate($hDestPath)
$oApp = ObjCreate("Shell.Application")
$hFolderitem = $oApp.NameSpace($hZipFile).Parsename($hFilename)
$oApp.NameSpace($hDestPath).Copyhere($hFolderitem)
While 1
If $flag = 1 then _Hide()
If FileExists($hDestPath & "\" & $hFilename) Then
return SetError(0, 0, 1)
ExitLoop
EndIf
Sleep(500)
WEnd
EndFunc
Func _Zip_Count($hZipFile)
Local $DLLChk = _Zip_DllChk()
If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0)
If not _IsFullPath($hZipFile) then Return SetError(4,0)
If Not FileExists($hZipFile) Then Return SetError(1, 0, 0)
$items = _Zip_List($hZipFile)
Return UBound($items) - 1
EndFunc
Func _Zip_List($hZipFile)
local $aArray[1]
Local $DLLChk = _Zip_DllChk()
If $DLLChk <> 0 Then Return SetError($DLLChk, 0, 0)
If not _IsFullPath($hZipFile) then Return SetError(4,0)
If Not FileExists($hZipFile) Then Return SetError(1, 0, 0)
$oApp = ObjCreate("Shell.Application")
$hList = $oApp.Namespace($hZipFile).Items
For $item in $hList
_ArrayAdd($aArray,$item.name)
Next
$aArray[0] = UBound($aArray) - 1
Return $aArray
EndFunc
Func _Zip_VirtualZipOpen()
$ZipSplit = StringSplit($CMDLine[1], ",")
$ZipName = $ZipSplit[1]
$ZipFile = $ZipSplit[2]
_Zip_Unzip($ZipName, $ZipFile, @TempDir & "\", 4+16)
If @error Then Return SetError(@error,0,0)
ShellExecute(@TempDir & "\" & $ZipFile)
EndFunc
Func _Zip_DllChk()
If Not FileExists(@SystemDir & "\zipfldr.dll") Then Return 2
If Not RegRead("HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}", "") Then Return 3
Return 0
EndFunc
Func _IsFullPath($path)
if StringInStr($path,":\") then
Return True
Else
Return False
EndIf
Endfunc
Func _Hide()
If ControlGetHandle("[CLASS:#32770]", "", "[CLASS:SysAnimate32; INSTANCE:1]") <> "" And WinGetState("[CLASS:#32770]") <> @SW_HIDE Then
$hWnd = WinGetHandle("[CLASS:#32770]")
WinSetState($hWnd, "", @SW_HIDE)
EndIf
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
Global $DatabaseDir = $DropboxDir & "\Marketing Team Files\AutoCharts_Database"
Global $GUI_UserSettings = 9999
$INPT_DropboxFolder = 9999
$BTN_Save = 9999
$BTN_Cancel = 9999
$BTN_SelectDBPath = 9999
$Radio_Q1 = 4
$Radio_Q2 = 4
$Radio_Q3 = 4
$Radio_Q4 = 4
Func ExportDatalinker()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
Local Const $sMessage = "Select where you would like to save the Datalinker file."
Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
If @error Then
MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
Else
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $sFileSelectFolder & "\" & $INPT_Name & "_Datalinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error finding your DataLinker file.")
_FileWriteLog($LogFile, "Error! Unable to Export Datalinker File to " & $sFileSelectFolder)
Else
MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File Exported to " & $sFileSelectFolder)
_FileWriteLog($LogFile, "Datalinker File Exported to " & $sFileSelectFolder)
EndIf
EndIf
EndFunc
Func UploadDatalinker()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
If $INPT_Name = "Jakob" Then
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir, 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
_FileWriteLog($LogFile, "Error! Unable to Upload Datalinker File to " & $DatabaseDir)
Else
MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")
_FileWriteLog($LogFile, "Datalinker File Uploaded to " & $DatabaseDir)
EndIf
Else
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir & "\" & $INPT_Name & "_Datalinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
_FileWriteLog($LogFile, "Error! Unable to Upload Datalinker File to " & $DatabaseDir)
Else
MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")
_FileWriteLog($LogFile, "Datalinker File Uploaded to " & $DatabaseDir)
EndIf
EndIf
EndFunc
Func ImportDatalinker()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
FileCopy($DatabaseDir & "\DataLinker.xml", @ScriptDir & "\Datalinker_TEMP.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign")
_FileWriteLog($LogFile, "Error! Unable to Import Datalinker File to InDesign")
Else
_FileWriteLog($LogFile, "Datalinker File Imported to AutoCharts Directory")
EndIf
Local $file = @ScriptDir & "\Datalinker_TEMP.xml"
Local $text = FileRead($file)
If $INPT_Name <> "Jakob" Then
$tout1 = StringReplace($text, 'X:\Marketing Team Files\', $DropboxDir & '\Marketing Team Files\')
FileWrite(@ScriptDir & "\DataLinker_Updated.xml", $tout1)
FileCopy(@ScriptDir & "\Datalinker_Updated.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
_FileWriteLog($LogFile, "Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
FileDelete(@ScriptDir & "\Datalinker_Updated.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP.xml")
_FileWriteLog($LogFile, "Datalinker File Imported to InDesign successfully")
EndIf
Else
FileCopy(@ScriptDir & "\Datalinker_TEMP.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
_FileWriteLog($LogFile, "Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
FileDelete(@ScriptDir & "\Datalinker_Updated.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP.xml")
_FileWriteLog($LogFile, "Datalinker File Imported to InDesign successfully")
EndIf
EndIf
EndFunc
RunMainGui()
Func RunMainGui()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)
Sleep(2000)
SplashOff()
$MainGUI = GUICreate("AutoCharts 2.3.1", 570, 609, -1, -1)
$mFile = GUICtrlCreateMenu("&File")
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
$CPE = GUICtrlCreateCheckbox("CPE", 132, 329, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$CLT = GUICtrlCreateCheckbox("CLT", 132, 279, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$CLP = GUICtrlCreateCheckbox("CLP", 132, 229, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$CFR = GUICtrlCreateCheckbox("CFR", 28, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
GUICtrlSetFont(-1, 12, 400, 0, "Montserrat Black")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$DCX = GUICtrlCreateCheckbox("DCX", 132, 427, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
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
$CWX = GUICtrlCreateCheckbox("CWX", 132, 379, 90, 30, BitOR($GUI_SS_DEFAULT_CHECKBOX, $BS_PUSHLIKE))
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
$aMsg = GUIGetMsg(1)
Switch $aMsg[1]
Case $MainGUI
If $INPT_Name <> "Jakob" Then
GUICtrlSetState($mUploadamCharts, $GUI_DISABLE)
GUICtrlSetState($mUploadDatalinker, $GUI_DISABLE)
EndIf
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
Case $DCX
If GUICtrlRead($DCX) = 1 Then $aCatalystCheck[4] = "DCX"
If GUICtrlRead($DCX) = 4 Then $aCatalystCheck[4] = 0
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
VerifyDropbox()
If $bDBVerified = True Then
$FundFamily = "Catalyst"
$FamilySwitch = $aCatalystCheck
GUICtrlSetData($ProgressBar, 10)
PullCatalystData()
RunCSVConvert()
CreateCharts()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "############################### END OF RUN - CATALYST ###############################")
FileClose($LogFile)
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
_FileWriteLog($LogFile, "############################### END OF RUN - CATALYST ###############################")
FileClose($LogFile)
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
_FileWriteLog($LogFile, "############################### END OF RUN - RATIONAL ###############################")
FileClose($LogFile)
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
_FileWriteLog($LogFile, "############################### END OF RUN - RATIONAL ###############################")
FileClose($LogFile)
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
If GUICtrlRead($Radio_Q1) = 1 Then
$Select_Quarter = "Q1"
$DATA_UserSettings = "Q1"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
EndIf
If GUICtrlRead($Radio_Q2) = 1 Then
$Select_Quarter = "Q2"
$DATA_UserSettings = "Q2"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
EndIf
If GUICtrlRead($Radio_Q3) = 1 Then
$Select_Quarter = "Q3"
$DATA_UserSettings = "Q3"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
EndIf
If GUICtrlRead($Radio_Q4) = 1 Then
$Select_Quarter = "Q4"
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
GUIDelete($GUI_UserSettings)
EndIf
Case $BTN_SelectDBPath
BrowseForDBPath()
Case $BTN_Cancel
GUIDelete($GUI_UserSettings)
EndSwitch
EndSwitch
WEnd
EndFunc
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
EndFunc
Func BrowseForDBPath()
Local Const $sMessage = "Select a folder"
Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
If @error Then
MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
GUICtrlSetData($INPT_DropboxFolder, "")
Else
GUICtrlSetData($INPT_DropboxFolder, $sFileSelectFolder)
EndIf
EndFunc
Func VerifyDropbox()
If FileExists($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\.checkfile") Then
$bDBVerified = True
IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
Else
$bDBVerified = False
IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
SetError(50)
EndIf
EndFunc
Func SyncronizeDataFiles()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
DirRemove(@ScriptDir & $CSVDataDir, 1)
DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", @ScriptDir & $CSVDataDir, 1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Synced Dropbox data with Autocharts Data")
DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullCatalystData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
DirRemove(@ScriptDir & $CSVDataDir & "\Catalyst", 1)
DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst", @ScriptDir & $CSVDataDir & "\Catalyst", 1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Pulled Catalyst Data from Dropbox")
DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullRationalData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
DirRemove(@ScriptDir & $CSVDataDir & "\Rational", 1)
DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational", @ScriptDir & $CSVDataDir & "\Rational", 1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Pulled Rational Data from Dropbox")
DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullStrategySharesData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
DirRemove(@ScriptDir & $CSVDataDir & "\StrategyShares", 1)
DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\StrategyShares", @ScriptDir & $CSVDataDir & "\StrategyShares", 1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Pulled Strategy Shares Data from Dropbox")
DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
_FileWriteLog($LogFile, "Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func UploadamCharts()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
DirRemove($DatabaseDir & "\amCharts", 1)
DirCopy(@ScriptDir & "\assets\ChartBuilder\public\scripts", $DatabaseDir & "\amCharts", 1)
SplashOff()
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Uploaded amCharts Scripts to Database")
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
FileClose(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv")
FileMove(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $DropboxDir & "Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", 1)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Updated FactSheetDates CSV File with selected dates")
FileClose($LogFile)
EndFunc
Func ClearLog()
FileDelete(@ScriptDir & "\AutoCharts.log")
_FileCreate(@ScriptDir & "\AutoCharts.log")
If @error = 0 Then
MsgBox(0, "Success", "Log file cleared.")
EndIf
If @error = 1 Then
MsgBox(0, "Error!", "There was an error with clearing the log.")
EndIf
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
If FileExists(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
RunCSVConvert4Presentation()
EndIf
GUICtrlSetData($ProgressBar, 25)
FileCopy(@ScriptDir & "/VBS_Scripts/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1)
FileMove(@ScriptDir & "/VBS_Scripts/*.csv", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.csv", 1)
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
_FileWriteLog($LogFile, "Converted " & $CurrentFund & "-institutional.xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-institutional.xlsx file to csv")
EndFunc
Func RunCSVConvert4Brochure()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-brochure.xlsx", @TempDir, @SW_HIDE)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Converted " & $CurrentFund & "-brochure.xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-brochure.xlsx file to csv")
EndFunc
Func RunCSVConvert4Presentation()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-presentation.xlsx", @TempDir, @SW_HIDE)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Converted " & $CurrentFund & "-presentation.xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-presentation.xlsx file to csv")
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
FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\Links\" & "*.svg", 1)
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
Func RunExpenseRatios()
If $FundFamily = "Catalyst" Then
GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")
GUICtrlSetData($ProgressBar, 60)
FileCopy(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Catalyst_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Catalyst_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "~~~~~~~~~~~~ Updating Catalyst Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")
_FileWriteLog($LogFile, "Updated Catalyst Expense Ratios")
GUICtrlSetData($UpdateLabel, "Updated Catalyst Expense Ratios")
FileCopy(@ScriptDir & "/VBS_Scripts/Catalyst_ExpenseRatios.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Catalyst_ExpenseRatios.csv", 1)
FileMove(@ScriptDir & "/VBS_Scripts/Catalyst_ExpenseRatios.csv", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\" & $FundFamily & "\Catalyst_ExpenseRatios.csv", 1)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
EndIf
If $FundFamily = "Rational" Then
GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
GUICtrlSetData($ProgressBar, 60)
FileCopy(@ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Rational_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Rational_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "~~~~~~~~~~~~ Updating Rational Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
_FileWriteLog($LogFile, "Updated Rational Expense Ratios")
GUICtrlSetData($UpdateLabel, "Updated Rational Expense Ratios")
FileCopy(@ScriptDir & "/VBS_Scripts/Rational_ExpenseRatios.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\Rational_ExpenseRatios.csv", 1)
FileMove(@ScriptDir & "/VBS_Scripts/Rational_ExpenseRatios.csv", $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\" & $FundFamily & "\Rational_ExpenseRatios.csv", 1)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
EndIf
GUICtrlSetData($ProgressBar, 100)
EndFunc
Func CreateFactSheetArchive()
Local $Zip, $myfile
Local Const $sMessage = "Select Save Location"
Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
If @error Then
MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
Else
$Zip = _Zip_Create($sFileSelectFolder & "\FactSheets_" & $INPT_Name & "_" & $Select_Quarter & "-" & $INPT_CurYear & ".zip")
_Zip_AddFolder($Zip, $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\", 4)
_Zip_AddFolder($Zip, $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\", 4)
MsgBox(0, "Items in Zip", "Succesfully added " & _Zip_Count($Zip) & " items in " & $Zip)
$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)
_FileWriteLog($LogFile, "Created Factsheet Archive at " & $Zip)
EndIf
EndFunc
