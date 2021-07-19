Global $aCatalystCheck[24]
Global $aRationalCheck[8]
Global $aStrategyCheck[3]
Global $FamilySwitch
Global $CurrentFund
Global $ini = 'settings.ini'
Global $INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
Global $Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
Global $INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
Global $FundFamily = ""
Global $bDBVerified = IniRead($ini, 'Settings', 'DBVerified', 'False')
Global $GUI_UserSettings = 9999
Global $INPT_DropboxFolder = 9999
Global $BTN_Save = 9999
Global $BTN_Cancel = 9999
Global $BTN_SelectDBPath = 9999
Global $Radio_Q1 = 4
Global $Radio_Q2 = 4
Global $Radio_Q3 = 4
Global $Radio_Q4 = 4
Global $CSVDataDir = "\assets\ChartBuilder\public\Data\Backups\"
Global $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
Global $DatabaseDir = $DropboxDir & "\Marketing Team Files\AutoCharts_Database"
Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $SWP_NOZORDER = 0x0004
Global Const $SWP_NOACTIVATE = 0x0010
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
Global Const $BS_PUSHLIKE = 0x1000
Global Const $GUI_SS_DEFAULT_CHECKBOX = 0
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $GUI_SHOW = 16
Global Const $GUI_DISABLE = 128
Global Const $SS_NOTIFY = 0x0100
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $GUI_SS_DEFAULT_PIC = $SS_NOTIFY
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SIZEBOX = 0x00040000
Global Const $WS_HSCROLL = 0x00100000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $WM_SIZE = 0x0005
Global Const $WM_SYSCOMMAND = 0x0112
Global Const $ES_MULTILINE = 4
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $EM_SETSEL = 0xB1
Func _SendMessage($hWnd, $iMsg, $wParam = 0, $lParam = 0, $iReturn = 0, $wParamType = "wparam", $lParamType = "lparam", $sReturnType = "lresult")
Local $aResult = DllCall("user32.dll", $sReturnType, "SendMessageW", "hwnd", $hWnd, "uint", $iMsg, $wParamType, $wParam, $lParamType, $lParam)
If @error Then Return SetError(@error, @extended, "")
If $iReturn >= 0 And $iReturn <= 4 Then Return $aResult[$iReturn]
Return $aResult
EndFunc
Global Const $_UDF_GlobalIDs_OFFSET = 2
Global Const $_UDF_GlobalID_MAX_WIN = 16
Global Const $_UDF_STARTID = 10000
Global Const $_UDF_GlobalID_MAX_IDS = 55535
Global Const $__UDFGUICONSTANT_WS_TABSTOP = 0x00010000
Global Const $__UDFGUICONSTANT_WS_VISIBLE = 0x10000000
Global Const $__UDFGUICONSTANT_WS_CHILD = 0x40000000
Global $__g_aUDF_GlobalIDs_Used[$_UDF_GlobalID_MAX_WIN][$_UDF_GlobalID_MAX_IDS + $_UDF_GlobalIDs_OFFSET + 1]
Func __UDF_GetNextGlobalID($hWnd)
Local $nCtrlID, $iUsedIndex = -1, $bAllUsed = True
If Not WinExists($hWnd) Then Return SetError(-1, -1, 0)
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $__g_aUDF_GlobalIDs_Used[$iIndex][0] <> 0 Then
If Not WinExists($__g_aUDF_GlobalIDs_Used[$iIndex][0]) Then
For $x = 0 To UBound($__g_aUDF_GlobalIDs_Used, $UBOUND_COLUMNS) - 1
$__g_aUDF_GlobalIDs_Used[$iIndex][$x] = 0
Next
$__g_aUDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
$bAllUsed = False
EndIf
EndIf
Next
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $__g_aUDF_GlobalIDs_Used[$iIndex][0] = $hWnd Then
$iUsedIndex = $iIndex
ExitLoop
EndIf
Next
If $iUsedIndex = -1 Then
For $iIndex = 0 To $_UDF_GlobalID_MAX_WIN - 1
If $__g_aUDF_GlobalIDs_Used[$iIndex][0] = 0 Then
$__g_aUDF_GlobalIDs_Used[$iIndex][0] = $hWnd
$__g_aUDF_GlobalIDs_Used[$iIndex][1] = $_UDF_STARTID
$bAllUsed = False
$iUsedIndex = $iIndex
ExitLoop
EndIf
Next
EndIf
If $iUsedIndex = -1 And $bAllUsed Then Return SetError(16, 0, 0)
If $__g_aUDF_GlobalIDs_Used[$iUsedIndex][1] = $_UDF_STARTID + $_UDF_GlobalID_MAX_IDS Then
For $iIDIndex = $_UDF_GlobalIDs_OFFSET To UBound($__g_aUDF_GlobalIDs_Used, $UBOUND_COLUMNS) - 1
If $__g_aUDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = 0 Then
$nCtrlID =($iIDIndex - $_UDF_GlobalIDs_OFFSET) + 10000
$__g_aUDF_GlobalIDs_Used[$iUsedIndex][$iIDIndex] = $nCtrlID
Return $nCtrlID
EndIf
Next
Return SetError(-1, $_UDF_GlobalID_MAX_IDS, 0)
EndIf
$nCtrlID = $__g_aUDF_GlobalIDs_Used[$iUsedIndex][1]
$__g_aUDF_GlobalIDs_Used[$iUsedIndex][1] += 1
$__g_aUDF_GlobalIDs_Used[$iUsedIndex][($nCtrlID - 10000) + $_UDF_GlobalIDs_OFFSET] = $nCtrlID
Return $nCtrlID
EndFunc
Global Const $tagOSVERSIONINFO = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $__WINVER = __WINVER()
Func _WinAPI_GetModuleHandle($sModuleName)
Local $sModuleNameType = "wstr"
If $sModuleName = "" Then
$sModuleName = 0
$sModuleNameType = "ptr"
EndIf
Local $aResult = DllCall("kernel32.dll", "handle", "GetModuleHandleW", $sModuleNameType, $sModuleName)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func __WINVER()
Local $tOSVI = DllStructCreate($tagOSVERSIONINFO)
DllStructSetData($tOSVI, 1, DllStructGetSize($tOSVI))
Local $aRet = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $tOSVI)
If @error Or Not $aRet[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($tOSVI, 2), -8), DllStructGetData($tOSVI, 3))
EndFunc
Func _WinAPI_HiWord($iLong)
Return BitShift($iLong, 16)
EndFunc
Func _WinAPI_LoWord($iLong)
Return BitAND($iLong, 0xFFFF)
EndFunc
Global Const $DEFAULT_GUI_FONT = 17
Func _WinAPI_GetStockObject($iObject)
Local $aResult = DllCall("gdi32.dll", "handle", "GetStockObject", "int", $iObject)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_HideCaret($hWnd)
Local $aRet = DllCall('user32.dll', 'int', 'HideCaret', 'hwnd', $hWnd)
If @error Then Return SetError(@error, @extended, False)
Return $aRet[0]
EndFunc
Func _WinAPI_CreateWindowEx($iExStyle, $sClass, $sName, $iStyle, $iX, $iY, $iWidth, $iHeight, $hParent, $hMenu = 0, $hInstance = 0, $pParam = 0)
If $hInstance = 0 Then $hInstance = _WinAPI_GetModuleHandle("")
Local $aResult = DllCall("user32.dll", "hwnd", "CreateWindowExW", "dword", $iExStyle, "wstr", $sClass, "wstr", $sName, "dword", $iStyle, "int", $iX, "int", $iY, "int", $iWidth, "int", $iHeight, "hwnd", $hParent, "handle", $hMenu, "handle", $hInstance, "struct*", $pParam)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_GetClassName($hWnd)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $aResult = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 4096)
If @error Or Not $aResult[0] Then Return SetError(@error, @extended, '')
Return SetExtended($aResult[0], $aResult[2])
EndFunc
Func _WinAPI_IsClassName($hWnd, $sClassName)
Local $sSeparator = Opt("GUIDataSeparatorChar")
Local $aClassName = StringSplit($sClassName, $sSeparator)
If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
Local $sClassCheck = _WinAPI_GetClassName($hWnd)
For $x = 1 To UBound($aClassName) - 1
If StringUpper(StringMid($sClassCheck, 1, StringLen($aClassName[$x]))) = StringUpper($aClassName[$x]) Then Return True
Next
Return False
EndFunc
Func _WinAPI_SetFocus($hWnd)
Local $aResult = DllCall("user32.dll", "hwnd", "SetFocus", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_SetWindowPos($hWnd, $hAfter, $iX, $iY, $iCX, $iCY, $iFlags)
Local $aResult = DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $hWnd, "hwnd", $hAfter, "int", $iX, "int", $iY, "int", $iCX, "int", $iCY, "uint", $iFlags)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
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
Global Const $__RICHEDITCONSTANT_WM_USER = 0x400
Global Const $EM_FINDWORDBREAK = $__RICHEDITCONSTANT_WM_USER + 76
Global Const $EM_GETTEXTLENGTHEX = $__RICHEDITCONSTANT_WM_USER + 95
Global Const $EM_HIDESELECTION = $__RICHEDITCONSTANT_WM_USER + 63
Global Const $EM_SETBKGNDCOLOR = $__RICHEDITCONSTANT_WM_USER + 67
Global Const $EM_SETCHARFORMAT = $__RICHEDITCONSTANT_WM_USER + 68
Global Const $EM_SETTEXTEX = $__RICHEDITCONSTANT_WM_USER + 97
Global Const $ST_SELECTION = 2
Global Const $GTL_CLOSE = 4
Global Const $GTL_DEFAULT = 0
Global Const $GTL_NUMBYTES = 16
Global Const $GTL_PRECISE = 2
Global Const $GTL_USECRLF = 1
Global Const $CP_ACP = 0
Global Const $CP_UNICODE = 1200
Global Const $CFM_BACKCOLOR = 0x4000000
Global Const $CFM_CHARSET = 0x8000000
Global Const $CFM_COLOR = 0x40000000
Global Const $CFM_FACE = 0x20000000
Global Const $CFM_LCID = 0x2000000
Global Const $CFM_SIZE = 0x80000000
Global Const $CFE_AUTOBACKCOLOR = $CFM_BACKCOLOR
Global Const $CFE_AUTOCOLOR = $CFM_COLOR
Global Const $SCF_SELECTION = 0x1
Global Const $LF_FACESIZE = 32
Global Const $WB_MOVEWORDRIGHT = 5
Func _ClipBoard_RegisterFormat($sFormat)
Local $aResult = DllCall("user32.dll", "uint", "RegisterClipboardFormatW", "wstr", $sFormat)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Global $__g_sRTFClassName, $__g_sRTFVersion, $__g_iRTFTwipsPeSpaceUnit = 1440
Global $__g_sGRE_CF_RTF, $__g_sGRE_CF_RETEXTOBJ
Global $__g_pGRC_StreamFromFileCallback = DllCallbackRegister("__GCR_StreamFromFileCallback", "dword", "long_ptr;ptr;long;ptr")
Global $__g_pGRC_StreamFromVarCallback = DllCallbackRegister("__GCR_StreamFromVarCallback", "dword", "long_ptr;ptr;long;ptr")
Global $__g_pGRC_StreamToFileCallback = DllCallbackRegister("__GCR_StreamToFileCallback", "dword", "long_ptr;ptr;long;ptr")
Global $__g_pGRC_StreamToVarCallback = DllCallbackRegister("__GCR_StreamToVarCallback", "dword", "long_ptr;ptr;long;ptr")
Global $__g_pGRC_sStreamVar
Global $__g_tObj_RichComObject = DllStructCreate("ptr pIntf; dword  Refcount")
Global $__g_tCall_RichCom, $__g_pObj_RichCom
Global $__g_hLib_RichCom_OLE32 = DllOpen("OLE32.DLL")
Global $__g_pRichCom_Object_QueryInterface = DllCallbackRegister("__RichCom_Object_QueryInterface", "long", "ptr;dword;dword")
Global $__g_pRichCom_Object_AddRef = DllCallbackRegister("__RichCom_Object_AddRef", "long", "ptr")
Global $__g_pRichCom_Object_Release = DllCallbackRegister("__RichCom_Object_Release", "long", "ptr")
Global $__g_pRichCom_Object_GetNewStorage = DllCallbackRegister("__RichCom_Object_GetNewStorage", "long", "ptr;ptr")
Global $__g_pRichCom_Object_GetInPlaceContext = DllCallbackRegister("__RichCom_Object_GetInPlaceContext", "long", "ptr;dword;dword;dword")
Global $__g_pRichCom_Object_ShowContainerUI = DllCallbackRegister("__RichCom_Object_ShowContainerUI", "long", "ptr;long")
Global $__g_pRichCom_Object_QueryInsertObject = DllCallbackRegister("__RichCom_Object_QueryInsertObject", "long", "ptr;dword;ptr;long")
Global $__g_pRichCom_Object_DeleteObject = DllCallbackRegister("__RichCom_Object_DeleteObject", "long", "ptr;ptr")
Global $__g_pRichCom_Object_QueryAcceptData = DllCallbackRegister("__RichCom_Object_QueryAcceptData", "long", "ptr;ptr;dword;dword;dword;ptr")
Global $__g_pRichCom_Object_ContextSensitiveHelp = DllCallbackRegister("__RichCom_Object_ContextSensitiveHelp", "long", "ptr;long")
Global $__g_pRichCom_Object_GetClipboardData = DllCallbackRegister("__RichCom_Object_GetClipboardData", "long", "ptr;ptr;dword;ptr")
Global $__g_pRichCom_Object_GetDragDropEffect = DllCallbackRegister("__RichCom_Object_GetDragDropEffect", "long", "ptr;dword;dword;dword")
Global $__g_pRichCom_Object_GetContextMenu = DllCallbackRegister("__RichCom_Object_GetContextMenu", "long", "ptr;short;ptr;ptr;ptr")
Global Const $__RICHEDITCONSTANT_WM_SETFONT = 0x0030
Global Const $_GCR_S_OK = 0
Global Const $_GCR_E_NOTIMPL = 0x80004001
Global Const $tagCHARFORMAT = "struct;uint cbSize;dword dwMask;dword dwEffects;long yHeight;long yOffset;INT crCharColor;" & "byte bCharSet;byte bPitchAndFamily;wchar szFaceName[32];endstruct"
Global Const $tagCHARFORMAT2 = $tagCHARFORMAT & ";word wWeight;short sSpacing;INT crBackColor;dword lcid;dword dwReserved;" & "short sStyle;word wKerning;byte bUnderlineType;byte bAnimation;byte bRevAuthor;byte bReserved1"
Global Const $tagGETTEXTLENGTHEX = "dword flags;uint codepage"
Global Const $tagSETTEXTEX = "dword flags;uint codepage"
Func _GUICtrlRichEdit_AppendText($hWnd, $sText)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
Local $iLength = _GUICtrlRichEdit_GetTextLength($hWnd)
_GUICtrlRichEdit_SetSel($hWnd, $iLength, $iLength)
Local $tSetText = DllStructCreate($tagSETTEXTEX)
DllStructSetData($tSetText, 1, $ST_SELECTION)
Local $iRet
If StringLeft($sText, 5) <> "{\rtf" And StringLeft($sText, 5) <> "{urtf" Then
DllStructSetData($tSetText, 2, $CP_UNICODE)
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, $tSetText, $sText, 0, "struct*", "wstr")
Else
DllStructSetData($tSetText, 2, $CP_ACP)
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, $tSetText, $sText, 0, "struct*", "STR")
EndIf
If Not $iRet Then Return SetError(700, 0, False)
Return True
EndFunc
Func _GUICtrlRichEdit_Create($hWnd, $sText, $iLeft, $iTop, $iWidth = 150, $iHeight = 150, $iStyle = -1, $iExStyle = -1)
If Not IsHWnd($hWnd) Then Return SetError(1, 0, 0)
If Not IsString($sText) Then Return SetError(2, 0, 0)
If Not __GCR_IsNumeric($iWidth, ">0,-1") Then Return SetError(105, 0, 0)
If Not __GCR_IsNumeric($iHeight, ">0,-1") Then Return SetError(106, 0, 0)
If Not __GCR_IsNumeric($iStyle, ">=0,-1") Then Return SetError(107, 0, 0)
If Not __GCR_IsNumeric($iExStyle, ">=0,-1") Then Return SetError(108, 0, 0)
If $iWidth = -1 Then $iWidth = 150
If $iHeight = -1 Then $iHeight = 150
If $iStyle = -1 Then $iStyle = BitOR($ES_WANTRETURN, $ES_MULTILINE)
If BitAND($iStyle, $ES_MULTILINE) <> 0 Then $iStyle = BitOR($iStyle, $ES_WANTRETURN)
If $iExStyle = -1 Then $iExStyle = 0x200
$iStyle = BitOR($iStyle, $__UDFGUICONSTANT_WS_CHILD, $__UDFGUICONSTANT_WS_VISIBLE)
If BitAND($iStyle, $ES_READONLY) = 0 Then $iStyle = BitOR($iStyle, $__UDFGUICONSTANT_WS_TABSTOP)
Local $nCtrlID = __UDF_GetNextGlobalID($hWnd)
If @error Then Return SetError(@error, @extended, 0)
__GCR_Init()
Local $hRichEdit = _WinAPI_CreateWindowEx($iExStyle, $__g_sRTFClassName, "", $iStyle, $iLeft, $iTop, $iWidth, $iHeight, $hWnd, $nCtrlID)
If $hRichEdit = 0 Then Return SetError(700, 0, False)
__GCR_SetOLECallback($hRichEdit)
_SendMessage($hRichEdit, $__RICHEDITCONSTANT_WM_SETFONT, _WinAPI_GetStockObject($DEFAULT_GUI_FONT), True)
_GUICtrlRichEdit_AppendText($hRichEdit, $sText)
Return $hRichEdit
EndFunc
Func _GUICtrlRichEdit_Deselect($hWnd)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
_SendMessage($hWnd, $EM_SETSEL, -1, 0)
Return True
EndFunc
Func _GUICtrlRichEdit_GetCharPosOfNextWord($hWnd, $iCpStart)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, 0)
If Not __GCR_IsNumeric($iCpStart) Then Return SetError(102, 0, 0)
Return _SendMessage($hWnd, $EM_FINDWORDBREAK, $WB_MOVEWORDRIGHT, $iCpStart)
EndFunc
Func _GUICtrlRichEdit_GetTextLength($hWnd, $bExact = True, $bChars = False)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, 0)
If Not IsBool($bExact) Then Return SetError(102, 0, 0)
If Not IsBool($bChars) Then Return SetError(103, 0, 0)
Local $tGetTextLen = DllStructCreate($tagGETTEXTLENGTHEX)
Local $iFlags = BitOR($GTL_USECRLF,($bExact ? $GTL_PRECISE : $GTL_CLOSE))
$iFlags = BitOR($iFlags,($bChars ? $GTL_DEFAULT : $GTL_NUMBYTES))
DllStructSetData($tGetTextLen, 1, $iFlags)
DllStructSetData($tGetTextLen, 2,($bChars ? $CP_ACP : $CP_UNICODE))
Local $iRet = _SendMessage($hWnd, $EM_GETTEXTLENGTHEX, $tGetTextLen, 0, 0, "struct*")
Return $iRet
EndFunc
Func _GUICtrlRichEdit_InsertText($hWnd, $sText)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
If $sText = "" Then Return SetError(102, 0, False)
Local $tSetText = DllStructCreate($tagSETTEXTEX)
DllStructSetData($tSetText, 1, $ST_SELECTION)
_GUICtrlRichEdit_Deselect($hWnd)
Local $iRet
If StringLeft($sText, 5) <> "{\rtf" And StringLeft($sText, 5) <> "{urtf" Then
DllStructSetData($tSetText, 2, $CP_UNICODE)
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, $tSetText, $sText, 0, "struct*", "wstr")
Else
DllStructSetData($tSetText, 2, $CP_ACP)
$iRet = _SendMessage($hWnd, $EM_SETTEXTEX, $tSetText, $sText, 0, "struct*", "STR")
EndIf
If Not $iRet Then Return SetError(103, 0, False)
Return True
EndFunc
Func _GUICtrlRichEdit_SetCharBkColor($hWnd, $iBkColor = Default)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
Local $tCharFormat = DllStructCreate($tagCHARFORMAT2)
DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
If $iBkColor = Default Then
DllStructSetData($tCharFormat, 3, $CFE_AUTOBACKCOLOR)
$iBkColor = 0
Else
If BitAND($iBkColor, 0xff000000) Then Return SetError(1022, 0, False)
EndIf
DllStructSetData($tCharFormat, 2, $CFM_BACKCOLOR)
DllStructSetData($tCharFormat, 12, $iBkColor)
Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_SELECTION, $tCharFormat, 0, "wparam", "struct*") <> 0
EndFunc
Func _GUICtrlRichEdit_SetCharColor($hWnd, $iColor = Default)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
Local $tCharFormat = DllStructCreate($tagCHARFORMAT)
DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
If $iColor = Default Then
DllStructSetData($tCharFormat, 3, $CFE_AUTOCOLOR)
$iColor = 0
Else
If BitAND($iColor, 0xff000000) Then Return SetError(1022, 0, False)
EndIf
DllStructSetData($tCharFormat, 2, $CFM_COLOR)
DllStructSetData($tCharFormat, 6, $iColor)
Return _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_SELECTION, $tCharFormat, 0, "wparam", "struct*") <> 0
EndFunc
Func _GUICtrlRichEdit_SetBkColor($hWnd, $iBngColor = Default)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
Local $bSysColor = False
If $iBngColor = Default Then
$bSysColor = True
$iBngColor = 0
Else
If BitAND($iBngColor, 0xff000000) Then Return SetError(1022, 0, False)
EndIf
_SendMessage($hWnd, $EM_SETBKGNDCOLOR, $bSysColor, $iBngColor)
Return True
EndFunc
Func _GUICtrlRichEdit_SetFont($hWnd, $iPoints = Default, $sName = Default, $iCharset = Default, $iLcid = Default)
Local $iDwMask = 0
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
If Not($iPoints = Default Or __GCR_IsNumeric($iPoints, ">0")) Then Return SetError(102, 0, False)
If $sName <> Default Then
Local $aS = StringSplit($sName, " ")
For $i = 1 To UBound($aS) - 1
If Not StringIsAlpha($aS[$i]) Then Return SetError(103, 0, False)
Next
EndIf
If Not($iCharset = Default Or __GCR_IsNumeric($iCharset)) Then Return SetError(104, 0, False)
If Not($iLcid = Default Or __GCR_IsNumeric($iLcid)) Then Return SetError(105, 0, False)
Local $tCharFormat = DllStructCreate($tagCHARFORMAT2)
DllStructSetData($tCharFormat, 1, DllStructGetSize($tCharFormat))
If $iPoints <> Default Then
$iDwMask = $CFM_SIZE
DllStructSetData($tCharFormat, 4, Int($iPoints * 20))
EndIf
If $sName <> Default Then
If StringLen($sName) > $LF_FACESIZE - 1 Then SetError(-1, 0, False)
$iDwMask = BitOR($iDwMask, $CFM_FACE)
DllStructSetData($tCharFormat, 9, $sName)
EndIf
If $iCharset <> Default Then
$iDwMask = BitOR($iDwMask, $CFM_CHARSET)
DllStructSetData($tCharFormat, 7, $iCharset)
EndIf
If $iLcid <> Default Then
$iDwMask = BitOR($iDwMask, $CFM_LCID)
DllStructSetData($tCharFormat, 13, $iLcid)
EndIf
DllStructSetData($tCharFormat, 2, $iDwMask)
Local $iRet = _SendMessage($hWnd, $EM_SETCHARFORMAT, $SCF_SELECTION, $tCharFormat, 0, "wparam", "struct*")
If Not $iRet Then Return SetError(@error + 200, 0, False)
Return True
EndFunc
Func _GUICtrlRichEdit_SetSel($hWnd, $iAnchor, $iActive, $bHideSel = False)
If Not _WinAPI_IsClassName($hWnd, $__g_sRTFClassName) Then Return SetError(101, 0, False)
If Not __GCR_IsNumeric($iAnchor, ">=0,-1") Then Return SetError(102, 0, False)
If Not __GCR_IsNumeric($iActive, ">=0,-1") Then Return SetError(103, 0, False)
If Not IsBool($bHideSel) Then Return SetError(104, 0, False)
_SendMessage($hWnd, $EM_SETSEL, $iAnchor, $iActive)
If $bHideSel Then _SendMessage($hWnd, $EM_HIDESELECTION, $bHideSel)
_WinAPI_SetFocus($hWnd)
Return True
EndFunc
Func __GCR_Init()
Local $ah_GUICtrlRTF_lib = DllCall("kernel32.dll", "ptr", "LoadLibraryW", "wstr", "MSFTEDIT.DLL")
If $ah_GUICtrlRTF_lib[0] <> 0 Then
$__g_sRTFClassName = "RichEdit50W"
$__g_sRTFVersion = 4.1
Else
$ah_GUICtrlRTF_lib = DllCall("kernel32.dll", "ptr", "LoadLibraryW", "wstr", "RICHED20.DLL")
$__g_sRTFVersion = FileGetVersion(@SystemDir & "\riched20.dll", "ProductVersion")
Switch $__g_sRTFVersion
Case 3.0
$__g_sRTFClassName = "RichEdit20W"
Case 5.0
$__g_sRTFClassName = "RichEdit50W"
Case 6.0
$__g_sRTFClassName = "RichEdit60W"
EndSwitch
EndIf
$__g_sGRE_CF_RTF = _ClipBoard_RegisterFormat("Rich Text Format")
$__g_sGRE_CF_RETEXTOBJ = _ClipBoard_RegisterFormat("Rich Text Format with Objects")
EndFunc
Func __GCR_StreamFromFileCallback($hFile, $pBuf, $iBuflen, $pQbytes)
Local $tQbytes = DllStructCreate("long", $pQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tBuf = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $sBuf = FileRead($hFile, $iBuflen - 1)
If @error Then Return 1
DllStructSetData($tBuf, 1, $sBuf)
DllStructSetData($tQbytes, 1, StringLen($sBuf))
Return 0
EndFunc
Func __GCR_StreamFromVarCallback($iCookie, $pBuf, $iBuflen, $pQbytes)
#forceref $iCookie
Local $tQbytes = DllStructCreate("long", $pQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tCtl = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $sCtl = StringLeft($__g_pGRC_sStreamVar, $iBuflen - 1)
If $sCtl = "" Then Return 1
DllStructSetData($tCtl, 1, $sCtl)
Local $iLen = StringLen($sCtl)
DllStructSetData($tQbytes, 1, $iLen)
$__g_pGRC_sStreamVar = StringMid($__g_pGRC_sStreamVar, $iLen + 1)
Return 0
EndFunc
Func __GCR_StreamToFileCallback($hFile, $pBuf, $iBuflen, $pQbytes)
Local $tQbytes = DllStructCreate("long", $pQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tBuf = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $s = DllStructGetData($tBuf, 1)
FileWrite($hFile, $s)
DllStructSetData($tQbytes, 1, StringLen($s))
Return 0
EndFunc
Func __GCR_StreamToVarCallback($iCookie, $pBuf, $iBuflen, $pQbytes)
#forceref $iCookie
Local $tQbytes = DllStructCreate("long", $pQbytes)
DllStructSetData($tQbytes, 1, 0)
Local $tBuf = DllStructCreate("char[" & $iBuflen & "]", $pBuf)
Local $s = DllStructGetData($tBuf, 1)
$__g_pGRC_sStreamVar &= $s
Return 0
EndFunc
Func __GCR_IsNumeric($vN, $sRange = "")
If Not(IsNumber($vN) Or StringIsInt($vN) Or StringIsFloat($vN)) Then Return False
Switch $sRange
Case ">0"
If $vN <= 0 Then Return False
Case ">=0"
If $vN < 0 Then Return False
Case ">0,-1"
If Not($vN > 0 Or $vN = -1) Then Return False
Case ">=0,-1"
If Not($vN >= 0 Or $vN = -1) Then Return False
EndSwitch
Return True
EndFunc
Func __GCR_SetOLECallback($hWnd)
If Not IsHWnd($hWnd) Then Return SetError(101, 0, False)
If Not $__g_pObj_RichCom Then
$__g_tCall_RichCom = DllStructCreate("ptr[20]")
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_QueryInterface), 1)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_AddRef), 2)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_Release), 3)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_GetNewStorage), 4)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_GetInPlaceContext), 5)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_ShowContainerUI), 6)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_QueryInsertObject), 7)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_DeleteObject), 8)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_QueryAcceptData), 9)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_ContextSensitiveHelp), 10)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_GetClipboardData), 11)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_GetDragDropEffect), 12)
DllStructSetData($__g_tCall_RichCom, 1, DllCallbackGetPtr($__g_pRichCom_Object_GetContextMenu), 13)
DllStructSetData($__g_tObj_RichComObject, 1, DllStructGetPtr($__g_tCall_RichCom))
DllStructSetData($__g_tObj_RichComObject, 2, 1)
$__g_pObj_RichCom = DllStructGetPtr($__g_tObj_RichComObject)
EndIf
Local Const $EM_SETOLECALLBACK = 0x400 + 70
If _SendMessage($hWnd, $EM_SETOLECALLBACK, 0, $__g_pObj_RichCom) = 0 Then Return SetError(700, 0, False)
Return True
EndFunc
Func __RichCom_Object_QueryInterface($pObject, $iREFIID, $pPvObj)
#forceref $pObject, $iREFIID, $pPvObj
Return $_GCR_S_OK
EndFunc
Func __RichCom_Object_AddRef($pObject)
Local $tData = DllStructCreate("ptr;dword", $pObject)
DllStructSetData($tData, 2, DllStructGetData($tData, 2) + 1)
Return DllStructGetData($tData, 2)
EndFunc
Func __RichCom_Object_Release($pObject)
Local $tData = DllStructCreate("ptr;dword", $pObject)
If DllStructGetData($tData, 2) > 0 Then
DllStructSetData($tData, 2, DllStructGetData($tData, 2) - 1)
Return DllStructGetData($tData, 2)
EndIf
EndFunc
Func __RichCom_Object_GetInPlaceContext($pObject, $pPFrame, $pPDoc, $pFrameInfo)
#forceref $pObject, $pPFrame, $pPDoc, $pFrameInfo
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_ShowContainerUI($pObject, $bShow)
#forceref $pObject, $bShow
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_QueryInsertObject($pObject, $pClsid, $tStg, $vCp)
#forceref $pObject, $pClsid, $tStg, $vCp
Return $_GCR_S_OK
EndFunc
Func __RichCom_Object_DeleteObject($pObject, $pOleobj)
#forceref $pObject, $pOleobj
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_QueryAcceptData($pObject, $pDataobj, $pCfFormat, $vReco, $bReally, $hMetaPict)
#forceref $pObject, $pDataobj, $pCfFormat, $vReco, $bReally, $hMetaPict
Return $_GCR_S_OK
EndFunc
Func __RichCom_Object_ContextSensitiveHelp($pObject, $bEnterMode)
#forceref $pObject, $bEnterMode
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetClipboardData($pObject, $pChrg, $vReco, $pPdataobj)
#forceref $pObject, $pChrg, $vReco, $pPdataobj
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetDragDropEffect($pObject, $bDrag, $iGrfKeyState, $piEffect)
#forceref $pObject, $bDrag, $iGrfKeyState, $piEffect
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetContextMenu($pObject, $iSeltype, $pOleobj, $pChrg, $pHmenu)
#forceref $pObject, $iSeltype, $pOleobj, $pChrg, $pHmenu
Return $_GCR_E_NOTIMPL
EndFunc
Func __RichCom_Object_GetNewStorage($pObject, $pPstg)
#forceref $pObject
Local $aSc = DllCall($__g_hLib_RichCom_OLE32, "dword", "CreateILockBytesOnHGlobal", "hwnd", 0, "int", 1, "ptr*", 0)
Local $pLockBytes = $aSc[3]
$aSc = $aSc[0]
If $aSc Then Return $aSc
$aSc = DllCall($__g_hLib_RichCom_OLE32, "dword", "StgCreateDocfileOnILockBytes", "ptr", $pLockBytes, "dword", BitOR(0x10, 2, 0x1000), "dword", 0, "ptr*", 0)
Local $tStg = DllStructCreate("ptr", $pPstg)
DllStructSetData($tStg, 1, $aSc[4])
$aSc = $aSc[0]
If $aSc Then
Local $tObj = DllStructCreate("ptr", $pLockBytes)
Local $tUnknownFuncTable = DllStructCreate("ptr[3]", DllStructGetData($tObj, 1))
Local $pReleaseFunc = DllStructGetData($tUnknownFuncTable, 3)
DllCallAddress("long", $pReleaseFunc, "ptr", $pLockBytes)
EndIf
Return $aSc
EndFunc
Global Const $HGDI_ERROR = Ptr(-1)
Global Const $INVALID_HANDLE_VALUE = Ptr(-1)
Global Const $KF_EXTENDED = 0x0100
Global Const $KF_ALTDOWN = 0x2000
Global Const $KF_UP = 0x8000
Global Const $LLKHF_EXTENDED = BitShift($KF_EXTENDED, 8)
Global Const $LLKHF_ALTDOWN = BitShift($KF_ALTDOWN, 8)
Global Const $LLKHF_UP = BitShift($KF_UP, 8)
Func _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
Local $aRet = DllCall('comctl32.dll', 'lresult', 'DefSubclassProc', 'hwnd', $hWnd, 'uint', $iMsg, 'wparam', $wParam, 'lparam', $lParam)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func _WinAPI_RemoveWindowSubclass($hWnd, $pSubclassProc, $idSubClass)
Local $aRet = DllCall('comctl32.dll', 'bool', 'RemoveWindowSubclass', 'hwnd', $hWnd, 'ptr', $pSubclassProc, 'uint_ptr', $idSubClass)
If @error Then Return SetError(@error, @extended, False)
Return $aRet[0]
EndFunc
Func _WinAPI_SetWindowSubclass($hWnd, $pSubclassProc, $idSubClass, $pData = 0)
Local $aRet = DllCall('comctl32.dll', 'bool', 'SetWindowSubclass', 'hwnd', $hWnd, 'ptr', $pSubclassProc, 'uint_ptr', $idSubClass, 'dword_ptr', $pData)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Global $__g_iLogaInstances = 0
Global $__g_atLogaInstances[0]
Global $__g_aaLogaInstances[0]
Global $__g_hLogaCallback = 0
Global $__g_pLogaCallback = 0
Global $__g_bShowAllGUIOnCompiled = False
Global $__g_iLevel = -1
Global Const $LOGA_ALL = 64
Global Const $LOGA_TRACE = 32
Global Const $LOGA_DEBUG = 16
Global Const $LOGA_INFO = 8
Global Const $LOGA_WARN = 4
Global Const $LOGA_ERROR = 2
Global Const $LOGA_FATAL = 1
Global Const $LOGA_LEVEL_ALL = BitOR($LOGA_ALL, $LOGA_TRACE, $LOGA_DEBUG, $LOGA_INFO, $LOGA_WARN, $LOGA_ERROR, $LOGA_FATAL)
Global Const $LOGA_LEVEL_OFF = 0
Global Const $LOGA_LEVEL_INSTANCE = -1
Global Const $LOGA_APPEND_END = 1
Global Const $__g_LogaSubClassID = 76797165
Global Enum $eLOGA___InstanceIndex, $eLOGA___LogIndex, $eLOGA_Name, $eLOGA_Level, $eLOGA_LogToFile, $eLOGA_LogFileAutoFlush, $eLOGA_hFile, $eLOGA_LogToGUI, $eLOGA_LogToStdError, $eLOGA_ShowGUIOnCompiled, $eLOGA___hGUI, $eLOGA___hRichEdit, $eLOGA_AppendType, $eLOGA_GUIBkColor, $eLOGA_GUIShowLevelSymbol, $eLOGA_Trans, $eLOGA_Left, $eLOGA_Top, $eLOGA_Width, $eLOGA_Height, $eLOGA_FilePath, $eLOGA_Format, $eLOGA_EndOfLine, $eLOGA_TraceSymbol, $eLOGA_TraceFontName, $eLOGA_TraceString, $eLOGA_TraceFontColor, $eLOGA_TraceFontBkColor, $eLOGA_TraceFontSize, $eLOGA_TraceCharSet, $eLOGA_DebugSymbol, $eLOGA_DebugFontName, $eLOGA_DebugString, $eLOGA_DebugFontColor, $eLOGA_DebugFontBkColor, $eLOGA_DebugFontSize, $eLOGA_DebugCharSet, $eLOGA_InfoSymbol, $eLOGA_InfoFontName, $eLOGA_InfoString, $eLOGA_InfoFontColor, $eLOGA_InfoFontBkColor, $eLOGA_InfoFontSize, $eLOGA_InfoCharSet, $eLOGA_WarnSymbol, $eLOGA_WarnFontName, $eLOGA_WarnString, $eLOGA_WarnFontColor, $eLOGA_WarnFontBkColor, $eLOGA_WarnFontSize, $eLOGA_WarnCharSet, $eLOGA_ErrorSymbol, $eLOGA_ErrorFontName, $eLOGA_ErrorString, $eLOGA_ErrorFontColor, $eLOGA_ErrorFontBkColor, $eLOGA_ErrorFontSize, $eLOGA_ErrorCharSet, $eLOGA_FatalSymbol, $eLOGA_FatalFontName, $eLOGA_FatalString, $eLOGA_FatalFontColor, $eLOGA_FatalFontBkColor, $eLOGA_FatalFontSize, $eLOGA_FatalCharSet
$__g_iLevel = $LOGA_LEVEL_INSTANCE
OnAutoItExitRegister('__LogaFreeOnExit')
Func _LogaInfo($sLogaMessage, $iLogaInstance = 1, Const $iCurrentError = @error, Const $iCurrentExtended = @extended)
SetError($iCurrentError, $iCurrentExtended)
__LogaWriteMessage($sLogaMessage, $LOGA_INFO, $iLogaInstance)
SetError($iCurrentError, $iCurrentExtended)
EndFunc
Func _LogaError($sLogaMessage, $iLogaInstance = 1, Const $iCurrentError = @error, Const $iCurrentExtended = @extended)
SetError($iCurrentError, $iCurrentExtended)
__LogaWriteMessage($sLogaMessage, $LOGA_ERROR, $iLogaInstance)
SetError($iCurrentError, $iCurrentExtended)
EndFunc
Func _LogaFileClose($iLogaInstance = 1)
Local $hFile = 0
If IsDllStruct($iLogaInstance) Then
$hFile = $iLogaInstance.hFile
Else
If $iLogaInstance > $__g_iLogaInstances Or $iLogaInstance <= 0 Then Return
$hFile =($__g_aaLogaInstances[$iLogaInstance - 1])[$eLOGA_hFile]
EndIf
$hFile = Int($hFile)
FileFlush($hFile)
FileClose($hFile)
EndFunc
Func _LogaNew($sLogaSettings = "")
If Not $__g_hLogaCallback Then
$__g_hLogaCallback = DllCallbackRegister('__LogaCallbackProc', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
$__g_pLogaCallback = DllCallbackGetPtr($__g_hLogaCallback)
EndIf
Local $tLoga = DllStructCreate("uint __InstanceIndex;ulong __LogIndex;wchar Name[512];uint Level;" & "bool LogToFile;bool LogFileAutoFlush;handle hFile;bool LogToGUI;bool ShowGUIOnCompiled;bool LogToStdError;" & "handle __hGUI;handle __hRichEdit;int AppendType;bool GUIShowLevelSymbol;int GUIBkColor;uint Trans;int Left;int Top;int Width;int Height;" & "wchar FilePath[512];wchar Format[512];wchar EndOfLine[128];" & "wchar TraceSymbol[2];wchar TraceFontName[512];wchar TraceString[512];int TraceFontColor;Int TraceFontBkColor;int TraceFontSize;int TraceCharSet;" & "wchar DebugSymbol[2];wchar DebugFontName[512];wchar DebugString[512];int DebugFontColor;Int DebugFontBkColor;int DebugFontSize;int DebugCharSet;" & "wchar InfoSymbol[2];wchar InfoFontName[512];wchar InfoString[512];int InfoFontColor;Int InfoFontBkColor;int InfoFontSize;int InfoCharSet;" & "wchar WarnSymbol[2];wchar WarnFontName[512];wchar WarnString[512];int WarnFontColor;Int WarnFontBkColor;int WarnFontSize;int WarnCharSet;" & "wchar ErrorSymbol[2];wchar ErrorFontName[512];wchar ErrorString[512];int ErrorFontColor;Int ErrorFontBkColor;int ErrorFontSize;int ErrorCharSet;" & "wchar FatalSymbol[2];wchar FatalFontName[512];wchar FatalString[512];int FatalFontColor;Int FatalFontBkColor;int FatalFontSize;int FatalCharSet;")
$__g_iLogaInstances += 1
$tLoga.__InstanceIndex = $__g_iLogaInstances
$tLoga.__LogIndex = 1
__LogaSetDefaultSettings($tLoga)
__LogaLoadSettingsFromString($tLoga, $sLogaSettings)
Local $aLoga = __LogaCreateSettingsArrayFromStructure($tLoga)
If IsArray($aLoga) Then
If $aLoga[$eLOGA_LogToGUI] Then
Local $aLogGUIInfo = __CreateLogGUI($aLoga[$eLOGA_Name], $aLoga[$eLOGA_Width], $aLoga[$eLOGA_Height], $aLoga[$eLOGA_Left], $aLoga[$eLOGA_Top], $aLoga[$eLOGA_GUIBkColor], $aLoga[$eLOGA_Trans], $aLoga[$eLOGA_ShowGUIOnCompiled])
$tLoga.__hGUI = $aLogGUIInfo[0]
$tLoga.__hRichEdit = $aLogGUIInfo[1]
__LogaRefreshArrayFromStructure($tLoga, $aLoga)
_WinAPI_SetWindowSubclass($aLoga[$eLOGA___hGUI], $__g_pLogaCallback, $__g_LogaSubClassID, 0)
EndIf
If $aLoga[$eLOGA_LogToFile] Then
If Not $aLoga[$eLOGA_LogFileAutoFlush] Then $aLoga[$eLOGA_hFile] = FileOpen($aLoga[$eLOGA_FilePath], $FO_OVERWRITE)
$tLoga.hFile = $aLoga[$eLOGA_hFile]
__LogaRefreshArrayFromStructure($tLoga, $aLoga)
EndIf
EndIf
ReDim $__g_atLogaInstances[$__g_iLogaInstances]
ReDim $__g_aaLogaInstances[$__g_iLogaInstances]
$__g_atLogaInstances[$__g_iLogaInstances - 1] = $tLoga
$__g_aaLogaInstances[$__g_iLogaInstances - 1] = $aLoga
Return $__g_atLogaInstances[$__g_iLogaInstances - 1]
EndFunc
Func __LogaCallbackProc($hWnd, $iMsg, $wParam, $lParam, $iID, $pData)
#forceref $iID, $pData
Local Const $SC_CLOSE = 0xF060
If $iMsg = $WM_SIZE Then
Local $hRitchEdit = __LogaGetRichEditHandleFromWindowHandle($hWnd)
If $hRitchEdit Then
Local $NewW = _WinAPI_LoWord($lParam)
Local $NewH = _WinAPI_HiWord($lParam)
_WinAPI_SetWindowPos($hRitchEdit, 0, 0, 0, $NewW - 1, $NewH - 1, BitOR($SWP_NOACTIVATE, $SWP_NOZORDER))
Return $GUI_RUNDEFMSG
EndIf
EndIf
If $iMsg = $WM_SYSCOMMAND And $wParam = $SC_CLOSE Then
GUISetState(@SW_HIDE, $hWnd)
Return $GUI_RUNDEFMSG
EndIf
Return _WinAPI_DefSubclassProc($hWnd, $iMsg, $wParam, $lParam)
EndFunc
Func __LogaFreeOnExit()
Local $hGUI = 0
For $i = 0 To $__g_iLogaInstances - 1
_LogaFileClose(($__g_aaLogaInstances[$i])[$eLOGA_hFile])
$hGUI =($__g_aaLogaInstances[$i])[$eLOGA___hGUI]
If WinExists($hGUI) Then _WinAPI_RemoveWindowSubclass($hGUI, $__g_pLogaCallback, $__g_LogaSubClassID)
Next
If $__g_hLogaCallback Then DllCallbackFree($__g_hLogaCallback)
EndFunc
Func __LogaFormatMessage($aLoga, $iLogaLevelType, $sLogaMessage, Const $iCurrentError = @error, Const $iCurrentExtended = @extended)
Local $sFormatedMessage = $aLoga[$eLOGA_Format]
If StringInStr($sFormatedMessage, "{Symbol}", 2) Then
Select
Case $iLogaLevelType = $LOGA_TRACE
$sFormatedMessage = StringReplace($sFormatedMessage, "{Symbol}", $aLoga[$eLOGA_TraceSymbol])
Case $iLogaLevelType = $LOGA_DEBUG
$sFormatedMessage = StringReplace($sFormatedMessage, "{Symbol}", $aLoga[$eLOGA_DebugSymbol])
Case $iLogaLevelType = $LOGA_INFO
$sFormatedMessage = StringReplace($sFormatedMessage, "{Symbol}", $aLoga[$eLOGA_InfoSymbol])
Case $iLogaLevelType = $LOGA_WARN
$sFormatedMessage = StringReplace($sFormatedMessage, "{Symbol}", $aLoga[$eLOGA_WarnSymbol])
Case $iLogaLevelType = $LOGA_ERROR
$sFormatedMessage = StringReplace($sFormatedMessage, "{Symbol}", $aLoga[$eLOGA_ErrorSymbol])
Case $iLogaLevelType = $LOGA_FATAL
$sFormatedMessage = StringReplace($sFormatedMessage, "{Symbol}", $aLoga[$eLOGA_FatalSymbol])
Case Else
EndSelect
EndIf
Select
Case StringInStr($sFormatedMessage, "{LongDateTime}", 2)
$sFormatedMessage = StringReplace($sFormatedMessage, "{LongDateTime}", StringFormat("%02d\\%02d\\%04d %02d:%02d:%02d", @MDAY, @MON, @YEAR, @HOUR, @MIN, @SEC))
Case StringInStr($sFormatedMessage, "{DateTime}", 2)
$sFormatedMessage = StringReplace($sFormatedMessage, "{DateTime}", StringFormat("%02d\\%02d\\%04d %02d:%02d", @MDAY, @MON, @YEAR, @HOUR, @MIN))
Case StringInStr($sFormatedMessage, "{Date}", 2)
$sFormatedMessage = StringReplace($sFormatedMessage, "{Date}", StringFormat("%02d\\%02d\\%04d", @MDAY, @MON, @YEAR))
Case StringInStr($sFormatedMessage, "{Time}", 2)
$sFormatedMessage = StringReplace($sFormatedMessage, "{Time}", StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC))
Case Else
EndSelect
If StringInStr($sFormatedMessage, "{LevelName}", 2) Then
Select
Case $iLogaLevelType = $LOGA_TRACE
$sFormatedMessage = StringReplace($sFormatedMessage, "{LevelName}", $aLoga[$eLOGA_TraceString])
Case $iLogaLevelType = $LOGA_DEBUG
$sFormatedMessage = StringReplace($sFormatedMessage, "{LevelName}", $aLoga[$eLOGA_DebugString])
Case $iLogaLevelType = $LOGA_INFO
$sFormatedMessage = StringReplace($sFormatedMessage, "{LevelName}", $aLoga[$eLOGA_InfoString])
Case $iLogaLevelType = $LOGA_WARN
$sFormatedMessage = StringReplace($sFormatedMessage, "{LevelName}", $aLoga[$eLOGA_WarnString])
Case $iLogaLevelType = $LOGA_ERROR
$sFormatedMessage = StringReplace($sFormatedMessage, "{LevelName}", $aLoga[$eLOGA_ErrorString])
Case $iLogaLevelType = $LOGA_FATAL
$sFormatedMessage = StringReplace($sFormatedMessage, "{LevelName}", $aLoga[$eLOGA_FatalString])
Case Else
EndSelect
EndIf
If StringInStr($sFormatedMessage, "{Message}", 2) Then
$sFormatedMessage = StringReplace($sFormatedMessage, "{Message}", $sLogaMessage)
EndIf
If StringInStr($sFormatedMessage, "{LogaName}", 2) Then
$sFormatedMessage = StringReplace($sFormatedMessage, "{LogaName}", $aLoga[$eLOGA_Name])
EndIf
If StringInStr($sFormatedMessage, "{LogIndex}", 2) Then
$sFormatedMessage = StringReplace($sFormatedMessage, "{LogIndex}", StringFormat("%010s", $aLoga[$eLOGA___LogIndex]))
EndIf
If StringInStr($sFormatedMessage, "{error}",2) Then
$sFormatedMessage = StringReplace($sFormatedMessage, "{error}", $iCurrentError)
EndIf
If StringInStr($sFormatedMessage, "{extended}",2) Then
$sFormatedMessage = StringReplace($sFormatedMessage, "{extended}", $iCurrentExtended)
EndIf
Return $sFormatedMessage & $aLoga[$eLOGA_EndOfLine]
EndFunc
Func __LogaFontInfo($aLoga, $iLogaLevelType)
Local $aInfo[5] = ["Consolas", 10, 0x000000, 0xFFFFFF, 1]
Select
Case $iLogaLevelType = $LOGA_TRACE
$aInfo[0] = $aLoga[$eLOGA_TraceFontName]
$aInfo[1] = $aLoga[$eLOGA_TraceFontSize]
$aInfo[2] = $aLoga[$eLOGA_TraceFontColor]
$aInfo[3] = $aLoga[$eLOGA_TraceFontBkColor]
$aInfo[4] = $aLoga[$eLOGA_TraceCharSet]
Case $iLogaLevelType = $LOGA_DEBUG
$aInfo[0] = $aLoga[$eLOGA_DebugFontName]
$aInfo[1] = $aLoga[$eLOGA_DebugFontSize]
$aInfo[2] = $aLoga[$eLOGA_DebugFontColor]
$aInfo[3] = $aLoga[$eLOGA_DebugFontBkColor]
$aInfo[4] = $aLoga[$eLOGA_DebugCharSet]
Case $iLogaLevelType = $LOGA_INFO
$aInfo[0] = $aLoga[$eLOGA_InfoFontName]
$aInfo[1] = $aLoga[$eLOGA_InfoFontSize]
$aInfo[2] = $aLoga[$eLOGA_InfoFontColor]
$aInfo[3] = $aLoga[$eLOGA_InfoFontBkColor]
$aInfo[4] = $aLoga[$eLOGA_InfoCharSet]
Case $iLogaLevelType = $LOGA_WARN
$aInfo[0] = $aLoga[$eLOGA_WarnFontName]
$aInfo[1] = $aLoga[$eLOGA_WarnFontSize]
$aInfo[2] = $aLoga[$eLOGA_WarnFontColor]
$aInfo[3] = $aLoga[$eLOGA_WarnFontBkColor]
$aInfo[4] = $aLoga[$eLOGA_WarnCharSet]
Case $iLogaLevelType = $LOGA_ERROR
$aInfo[0] = $aLoga[$eLOGA_ErrorFontName]
$aInfo[1] = $aLoga[$eLOGA_ErrorFontSize]
$aInfo[2] = $aLoga[$eLOGA_ErrorFontColor]
$aInfo[3] = $aLoga[$eLOGA_ErrorFontBkColor]
$aInfo[4] = $aLoga[$eLOGA_ErrorCharSet]
Case $iLogaLevelType = $LOGA_FATAL
$aInfo[0] = $aLoga[$eLOGA_FatalFontName]
$aInfo[1] = $aLoga[$eLOGA_FatalFontSize]
$aInfo[2] = $aLoga[$eLOGA_FatalFontColor]
$aInfo[3] = $aLoga[$eLOGA_FatalFontBkColor]
$aInfo[4] = $aLoga[$eLOGA_FatalCharSet]
Case Else
EndSelect
Return $aInfo
EndFunc
Func __LogaWriteMessage($sLogaMessage, $iLogaLevelType, $iLogaInstance = 1, Const $iCurrentError = @error, Const $iCurrentExtended = @extended)
If IsDllStruct($iLogaInstance) Then
$iLogaInstance = $iLogaInstance.__InstanceIndex
Else
If $__g_iLogaInstances = 0 Then _LogaNew()
If $iLogaInstance > $__g_iLogaInstances Then $iLogaInstance = 1
If $iLogaInstance <= 0 Then $iLogaInstance = 1
EndIf
Local $aLoga = $__g_aaLogaInstances[$iLogaInstance - 1]
Local $iLevel = $aLoga[$eLOGA_Level]
If $aLoga[$eLOGA___InstanceIndex] = -1 Then Return SetError(0, 0, 0)
If $iLevel = $LOGA_LEVEL_OFF Then Return SetError(0, 0, 0)
If Not BitAND($__g_iLevel, $iLogaLevelType) Then
Return SetError(0, 0, 0)
EndIf
If $__g_iLevel = $LOGA_LEVEL_INSTANCE Then
If Not BitAND($iLevel, $iLogaLevelType) Then
Return SetError(0, 0, 0)
EndIf
EndIf
SetError($iCurrentError,$iCurrentExtended)
Local $sFormatedMessage = __LogaFormatMessage($aLoga, $iLogaLevelType, $sLogaMessage)
ConsoleWrite($sFormatedMessage)
If $aLoga[$eLOGA_LogToStdError] Then ConsoleWriteError($sFormatedMessage)
$aLoga[$eLOGA___LogIndex] += 1
$__g_aaLogaInstances[$iLogaInstance - 1] = $aLoga
If $aLoga[$eLOGA_LogToGUI] And((Not @Compiled) Or $aLoga[$eLOGA_ShowGUIOnCompiled] Or $__g_bShowAllGUIOnCompiled) Then
Local $aFontInfo = __LogaFontInfo($aLoga, $iLogaLevelType)
Local $FontName = $aFontInfo[0]
Local $FontSize = $aFontInfo[1]
Local $iFontColor = "0x" & $aFontInfo[2]
Local $iFontBkColor = "0x" & $aFontInfo[3]
Local $iFontCharSet = $aFontInfo[4]
If $aLoga[$eLOGA_GUIShowLevelSymbol] Then
__LogaGUIAppendText($aLoga[$eLOGA___hRichEdit], $sFormatedMessage, $FontName, $FontSize, $iFontColor, $iFontBkColor, $iFontCharSet, $aLoga[$eLOGA_AppendType])
Else
Local $sSymbol = StringMid($sFormatedMessage, 1)
Local $sSymbolToReplace = $aLoga[$eLOGA_DebugSymbol] & "|" & $aLoga[$eLOGA_TraceSymbol] & "|" & $aLoga[$eLOGA_WarnSymbol] & "|" & $aLoga[$eLOGA_InfoSymbol] & "|" & $aLoga[$eLOGA_ErrorSymbol] & "|" & $aLoga[$eLOGA_FatalSymbol]
$sSymbolToReplace = StringRegExpReplace($sSymbolToReplace, '+', '\+')
If StringRegExp($sSymbol, $sSymbolToReplace) Then $sFormatedMessage = StringMid($sFormatedMessage, 2)
__LogaGUIAppendText($aLoga[$eLOGA___hRichEdit], $sFormatedMessage, $FontName, $FontSize, $iFontColor, $iFontBkColor, $iFontCharSet, $aLoga[$eLOGA_AppendType])
EndIf
EndIf
If $aLoga[$eLOGA_LogToFile] Then
If $aLoga[$eLOGA_LogFileAutoFlush] Then
FileWrite($aLoga[$eLOGA_FilePath], $sFormatedMessage)
Else
FileWrite(Int($aLoga[$eLOGA_hFile]), $sFormatedMessage)
EndIf
EndIf
EndFunc
Func __LogaGUIAppendText($hWnd, $sText, $iFontName, $iFontSize, $iFontColor, $iFontBkColor, $iFontCharSet, $iAppendType)
ConsoleWrite($iFontName & @CRLF)
Local $iLength = _GUICtrlRichEdit_GetTextLength($hWnd, True, True)
Local $iCp = _GUICtrlRichEdit_GetCharPosOfNextWord($hWnd, $iLength)
If $iAppendType = $LOGA_APPEND_END Then
_GUICtrlRichEdit_AppendText($hWnd, $sText)
_GUICtrlRichEdit_SetSel($hWnd, $iCp - 1, $iLength + StringLen($sText), False)
Else
_GUICtrlRichEdit_SetSel($hWnd, 0, 0, True)
_GUICtrlRichEdit_InsertText($hWnd, $sText)
_GUICtrlRichEdit_SetSel($hWnd, 0, StringLen($sText) - 1, True)
EndIf
_GUICtrlRichEdit_SetFont($hWnd, $iFontSize, $iFontName, $iFontCharSet)
_GUICtrlRichEdit_SetCharColor($hWnd, $iFontColor)
_GUICtrlRichEdit_SetCharBkColor($hWnd, $iFontBkColor)
_GUICtrlRichEdit_Deselect($hWnd)
_WinAPI_HideCaret($hWnd)
EndFunc
Func __LogaRefreshArrayFromStructure($tLoga, ByRef $aLoga)
If IsArray($aLoga) Then
$aLoga[$eLOGA___InstanceIndex] = $tLoga.__InstanceIndex
$aLoga[$eLOGA___LogIndex] = $tLoga.__LogIndex
$aLoga[$eLOGA_Name] = $tLoga.Name
$aLoga[$eLOGA_Level] = $tLoga.Level
$aLoga[$eLOGA_LogToFile] = $tLoga.LogToFile
$aLoga[$eLOGA_LogFileAutoFlush] = $tLoga.LogFileAutoFlush
$aLoga[$eLOGA_hFile] = $tLoga.hFile
$aLoga[$eLOGA_LogToGUI] = $tLoga.LogToGUI
$aLoga[$eLOGA_LogToStdError] = $tLoga.LogToStdError
$aLoga[$eLOGA_ShowGUIOnCompiled] = $tLoga.ShowGUIOnCompiled
$aLoga[$eLOGA___hGUI] = $tLoga.__hGUI
$aLoga[$eLOGA___hRichEdit] = $tLoga.__hRichEdit
$aLoga[$eLOGA_AppendType] = $tLoga.AppendType
$aLoga[$eLOGA_GUIShowLevelSymbol] = $tLoga.GUIShowLevelSymbol
$aLoga[$eLOGA_GUIBkColor] = Hex($tLoga.GUIBkColor)
$aLoga[$eLOGA_Trans] = $tLoga.Trans
$aLoga[$eLOGA_Left] = $tLoga.Left
$aLoga[$eLOGA_Top] = $tLoga.Top
$aLoga[$eLOGA_Width] = $tLoga.Width
$aLoga[$eLOGA_Height] = $tLoga.Height
$aLoga[$eLOGA_FilePath] = $tLoga.FilePath
$aLoga[$eLOGA_Format] = $tLoga.Format
$aLoga[$eLOGA_EndOfLine] = $tLoga.EndOfLine
$aLoga[$eLOGA_TraceSymbol] = $tLoga.TraceSymbol
$aLoga[$eLOGA_TraceFontName] = $tLoga.TraceFontName
$aLoga[$eLOGA_TraceString] = $tLoga.TraceString
$aLoga[$eLOGA_TraceFontColor] = Hex($tLoga.TraceFontColor)
$aLoga[$eLOGA_TraceFontBkColor] =($tLoga.TraceFontBkColor = -1) ? $aLoga[$eLOGA_GUIBkColor] : Hex($tLoga.TraceFontBkColor)
$aLoga[$eLOGA_TraceFontSize] = $tLoga.TraceFontSize
$aLoga[$eLOGA_TraceCharSet] = $tLoga.TraceCharSet
$aLoga[$eLOGA_DebugSymbol] = $tLoga.DebugSymbol
$aLoga[$eLOGA_DebugFontName] = $tLoga.DebugFontName
$aLoga[$eLOGA_DebugString] = $tLoga.DebugString
$aLoga[$eLOGA_DebugFontColor] = Hex($tLoga.DebugFontColor)
$aLoga[$eLOGA_DebugFontBkColor] =($tLoga.DebugFontBkColor = -1) ? $aLoga[$eLOGA_GUIBkColor] : Hex($tLoga.DebugFontBkColor)
$aLoga[$eLOGA_DebugFontSize] = $tLoga.DebugFontSize
$aLoga[$eLOGA_DebugCharSet] = $tLoga.DebugCharSet
$aLoga[$eLOGA_InfoSymbol] = $tLoga.InfoSymbol
$aLoga[$eLOGA_InfoFontName] = $tLoga.InfoFontName
$aLoga[$eLOGA_InfoString] = $tLoga.InfoString
$aLoga[$eLOGA_InfoFontColor] = Hex($tLoga.InfoFontColor)
$aLoga[$eLOGA_InfoFontBkColor] =($tLoga.InfoFontBkColor = -1) ? $aLoga[$eLOGA_GUIBkColor] : Hex($tLoga.InfoFontBkColor)
$aLoga[$eLOGA_InfoFontSize] = $tLoga.InfoFontSize
$aLoga[$eLOGA_InfoCharSet] = $tLoga.InfoCharSet
$aLoga[$eLOGA_WarnSymbol] = $tLoga.WarnSymbol
$aLoga[$eLOGA_WarnFontName] = $tLoga.WarnFontName
$aLoga[$eLOGA_WarnString] = $tLoga.WarnString
$aLoga[$eLOGA_WarnFontColor] = Hex($tLoga.WarnFontColor)
$aLoga[$eLOGA_WarnFontBkColor] =($tLoga.WarnFontBkColor = -1) ? $aLoga[$eLOGA_GUIBkColor] : Hex($tLoga.WarnFontBkColor)
$aLoga[$eLOGA_WarnFontSize] = $tLoga.WarnFontSize
$aLoga[$eLOGA_WarnCharSet] = $tLoga.WarnCharSet
$aLoga[$eLOGA_ErrorSymbol] = $tLoga.ErrorSymbol
$aLoga[$eLOGA_ErrorFontName] = $tLoga.ErrorFontName
$aLoga[$eLOGA_ErrorString] = $tLoga.ErrorString
$aLoga[$eLOGA_ErrorFontColor] = Hex($tLoga.ErrorFontColor)
$aLoga[$eLOGA_ErrorFontBkColor] =($tLoga.ErrorFontBkColor = -1) ? $aLoga[$eLOGA_GUIBkColor] : Hex($tLoga.ErrorFontBkColor)
$aLoga[$eLOGA_ErrorFontSize] = $tLoga.ErrorFontSize
$aLoga[$eLOGA_ErrorCharSet] = $tLoga.ErrorCharSet
$aLoga[$eLOGA_FatalSymbol] = $tLoga.FatalSymbol
$aLoga[$eLOGA_FatalFontName] = $tLoga.FatalFontName
$aLoga[$eLOGA_FatalString] = $tLoga.FatalString
$aLoga[$eLOGA_FatalFontColor] = Hex($tLoga.FatalFontColor)
$aLoga[$eLOGA_FatalFontBkColor] =($tLoga.FatalFontBkColor = -1) ? $aLoga[$eLOGA_GUIBkColor] : Hex($tLoga.FatalFontBkColor)
$aLoga[$eLOGA_FatalFontSize] = $tLoga.FatalFontSize
$aLoga[$eLOGA_FatalCharSet] = $tLoga.FatalCharSet
EndIf
EndFunc
Func __CreateLogGUI($sTitle, $iWidth, $iHeight, $ileft, $iTop, $iGUIBkColor, $iTrans, $iShowOnCompiled)
Local $hGUI = GUICreate($sTitle, $iWidth, $iHeight, $ileft, $iTop, BitOR($WS_SIZEBOX, $WS_MINIMIZEBOX), $WS_EX_TOPMOST)
Local $hRitchEdit = _GUICtrlRichEdit_Create($hGUI, "", 0, 0, $iWidth, $iHeight, $ES_READONLY + $WS_HSCROLL + $ES_MULTILINE + $WS_VSCROLL + $ES_AUTOVSCROLL)
_WinAPI_HideCaret($hRitchEdit)
GUISetBkColor($iGUIBkColor, $hGUI)
_GUICtrlRichEdit_SetBkColor($hRitchEdit, $iGUIBkColor)
WinSetTrans($hGUI, "", $iTrans)
Local $aInfo[2] = [$hGUI, $hRitchEdit]
If((Not @Compiled) Or $iShowOnCompiled Or $__g_bShowAllGUIOnCompiled) Then
GUISetState(@SW_SHOW, $hGUI)
EndIf
Return $aInfo
EndFunc
Func __LogaGetRichEditHandleFromWindowHandle($hWnd)
Local $hRitchEdit = 0
For $i = 0 To $__g_iLogaInstances - 1
If($__g_aaLogaInstances[$i])[$eLOGA___hGUI] = $hWnd Then
$hRitchEdit =($__g_aaLogaInstances[$i])[$eLOGA___hRichEdit]
ExitLoop
EndIf
Next
Return $hRitchEdit
EndFunc
Func __LogaLoadSettingsFromString($tLoga, $sLogaSettings)
Local Const $sValidVariables = "Name|Level|LogToFile|LogFileAutoFlush|LogToGUI|ShowGUIOnCompiled|LogToStdError|GUIShowLevelSymbol|GUIBkColor|" & "Trans|Left|Top|Width|Height|FilePath|Format|EndOfLine|AppendType|" & "TraceSymbol|TraceFontName|TraceString|TraceFontColor|TraceFontBkColor|TraceFontSize|TraceCharSet|" & "DebugSymbol|DebugFontName|DebugString|DebugFontColor|DebugFontBkColor|DebugFontSize|DebugCharSet|" & "InfoSymbol|InfoFontName|InfoString|InfoFontColor|InfoFontBkColor|InfoFontSize|InfoCharSet|" & "WarnSymbol|WarnFontName|WarnString|WarnFontColor|WarnFontBkColor|WarnFontSize|WarnCharSet|" & "ErrorSymbol|ErrorFontName|ErrorString|ErrorFontColor|ErrorFontBkColor|ErrorFontSize|ErrorCharSet|" & "FatalSymbol|FatalFontName|FatalString|FatalFontColor|FatalFontBkColor|FatalFontSize|FatalCharSet|"
If $sLogaSettings = "" Then Return
If IsDllStruct($tLoga) Then
Local $aRegSettings = StringRegExp($sLogaSettings, '(?>' & $sValidVariables & ')="[^"]*"', 3)
Local $aSettingName = ""
Local $sSettingName = ""
Local $aSettingValue = ""
Local $sSettingValue = ""
Local $sExeValue = ""
For $i = 0 To UBound($aRegSettings) - 1
$aSettingName = StringRegExp($aRegSettings[$i], '^[^=]+', 3)
$aSettingValue = StringRegExp($aRegSettings[$i], '"([^"]*)"', 3)
If IsArray($aSettingName) And IsArray($aSettingValue) Then
$sSettingName = $aSettingName[0]
$sSettingValue = $aSettingValue[0]
$sExeValue = StringRegExp($sSettingValue, "true|false|0[xX][0-9a-fA-F]+|^\d+$|^\$") ? $sSettingValue : '"' & $sSettingValue & '"'
If StringRegExp($sSettingName, $sValidVariables) Then
Execute('DllStructSetData($tLoga,"' & $sSettingName & '",' & $sExeValue & ')')
EndIf
EndIf
Next
EndIf
EndFunc
Func __LogaSetDefaultSettings($tLoga)
If IsDllStruct($tLoga) Then
$tLoga.Name = StringFormat("%s%05s", "Loga-", $tLoga.__InstanceIndex)
$tLoga.Level = $LOGA_LEVEL_ALL
$tLoga.LogToFile = True
$tLoga.LogFileAutoFlush = True
$tLoga.hFile = 0
$tLoga.LogToGUI = False
$tLoga.LogToStdError = False
$tLoga.ShowGUIOnCompiled = False
$tLoga.__hGUI = 0
$tLoga.___hRichEdit = 0
$tLoga.AppendType = $LOGA_APPEND_END
$tLoga.GUIShowLevelSymbol = False
$tLoga.GUIBkColor = 0xFFFFFF
$tLoga.Trans = 255
$tLoga.Left = 1
$tLoga.Top = 1
$tLoga.Width = 600
$tLoga.Height = 300
$tLoga.FilePath = @ScriptDir & "\" & @YEAR & @MON & @MDAY & @HOUR & @MIN & "-Loga-" & $tLoga.__InstanceIndex & ".log"
$tLoga.Format = "{Symbol}{LogIndex} {LevelName} {LongDateTime} {Message}"
$tLoga.EndOfLine = @CRLF
$tLoga.TraceSymbol = ">"
$tLoga.TraceFontName = "Consolas"
$tLoga.TraceString = StringFormat("%-7s", "[Trace]")
$tLoga.TraceFontColor = 0x000000
$tLoga.TraceFontBkColor = -1
$tLoga.TraceFontSize = 10
$tLoga.TraceCharSet = 1
$tLoga.DebugSymbol = ">"
$tLoga.DebugFontName = "Consolas"
$tLoga.DebugString = StringFormat("%-7s", "[Debug]")
$tLoga.DebugFontColor = 0x000000
$tLoga.DebugFontBkColor = -1
$tLoga.DebugFontSize = 10
$tLoga.DebugCharSet = 1
$tLoga.InfoSymbol = "+"
$tLoga.InfoFontName = "Consolas"
$tLoga.InfoString = StringFormat("%-7s", "[Info]")
$tLoga.InfoFontColor = 0x000000
$tLoga.InfoFontBkColor = -1
$tLoga.InfoFontSize = 10
$tLoga.InfoCharSet = 1
$tLoga.WarnSymbol = "-"
$tLoga.WarnFontName = "Consolas"
$tLoga.WarnString = StringFormat("%-7s", "[Warn]")
$tLoga.WarnFontColor = 0x000000
$tLoga.WarnFontBkColor = -1
$tLoga.WarnFontSize = 10
$tLoga.WarnCharSet = 1
$tLoga.ErrorSymbol = "!"
$tLoga.ErrorFontName = "Consolas"
$tLoga.ErrorString = StringFormat("%-7s", "[Error]")
$tLoga.ErrorFontColor = 0x000000
$tLoga.ErrorFontBkColor = -1
$tLoga.ErrorFontSize = 10
$tLoga.ErrorCharSet = 1
$tLoga.FatalSymbol = "!"
$tLoga.FatalFontName = "Consolas"
$tLoga.FatalString = StringFormat("%-7s", "[Fatal]")
$tLoga.FatalFontColor = 0x000000
$tLoga.FatalFontBkColor = -1
$tLoga.FatalFontSize = 10
$tLoga.FatalCharSet = 1
EndIf
EndFunc
Func __LogaCreateSettingsArrayFromStructure($tLoga)
If IsDllStruct($tLoga) Then
Local $aLoga[65]
$aLoga[$eLOGA___InstanceIndex] = $tLoga.__InstanceIndex
$aLoga[$eLOGA_Name] = $tLoga.Name
$aLoga[$eLOGA_Level] = $tLoga.Level
$aLoga[$eLOGA_LogToFile] = $tLoga.LogToFile
$aLoga[$eLOGA_LogFileAutoFlush] = $tLoga.LogFileAutoFlush
$aLoga[$eLOGA_hFile] = $tLoga.hFile
$aLoga[$eLOGA_LogToGUI] = $tLoga.LogToGUI
$aLoga[$eLOGA_LogToStdError] = $tLoga.LogToStdError
$aLoga[$eLOGA_ShowGUIOnCompiled] = $tLoga.ShowGUIOnCompiled
$aLoga[$eLOGA___hGUI] = $tLoga.__hGUI
$aLoga[$eLOGA___hRichEdit] = $tLoga.__hRichEdit
$aLoga[$eLOGA_GUIShowLevelSymbol] = $tLoga.GUIShowLevelSymbol
$aLoga[$eLOGA_GUIBkColor] = $tLoga.GUIBkColor
$aLoga[$eLOGA_Trans] = $tLoga.Trans
$aLoga[$eLOGA_Left] = $tLoga.Left
$aLoga[$eLOGA_Top] = $tLoga.Top
$aLoga[$eLOGA_Width] = $tLoga.Width
$aLoga[$eLOGA_Height] = $tLoga.Height
$aLoga[$eLOGA_FilePath] = $tLoga.FilePath
$aLoga[$eLOGA_Format] = $tLoga.Format
$aLoga[$eLOGA_EndOfLine] = $tLoga.EndOfLine
$aLoga[$eLOGA_TraceSymbol] = $tLoga.TraceSymbol
$aLoga[$eLOGA_TraceFontName] = $tLoga.TraceFontName
$aLoga[$eLOGA_TraceString] = $tLoga.TraceString
$aLoga[$eLOGA_TraceFontColor] = $tLoga.TraceFontColor
$aLoga[$eLOGA_TraceFontBkColor] = $tLoga.TraceFontBkColor
$aLoga[$eLOGA_TraceFontSize] = $tLoga.TraceFontSize
$aLoga[$eLOGA_TraceCharSet] = $tLoga.TraceCharSet
$aLoga[$eLOGA_DebugSymbol] = $tLoga.DebugSymbol
$aLoga[$eLOGA_DebugFontName] = $tLoga.DebugFontName
$aLoga[$eLOGA_DebugString] = $tLoga.DebugString
$aLoga[$eLOGA_DebugFontColor] = $tLoga.DebugFontColor
$aLoga[$eLOGA_DebugFontBkColor] = $tLoga.DebugFontBkColor
$aLoga[$eLOGA_DebugFontSize] = $tLoga.DebugFontSize
$aLoga[$eLOGA_DebugCharSet] = $tLoga.DebugCharSet
$aLoga[$eLOGA_InfoSymbol] = $tLoga.InfoSymbol
$aLoga[$eLOGA_InfoFontName] = $tLoga.InfoFontName
$aLoga[$eLOGA_InfoString] = $tLoga.InfoString
$aLoga[$eLOGA_InfoFontColor] = $tLoga.InfoFontColor
$aLoga[$eLOGA_InfoFontBkColor] = $tLoga.InfoFontBkColor
$aLoga[$eLOGA_InfoFontSize] = $tLoga.InfoFontSize
$aLoga[$eLOGA_InfoCharSet] = $tLoga.InfoCharSet
$aLoga[$eLOGA_WarnSymbol] = $tLoga.WarnSymbol
$aLoga[$eLOGA_WarnFontName] = $tLoga.WarnFontName
$aLoga[$eLOGA_WarnString] = $tLoga.WarnString
$aLoga[$eLOGA_WarnFontColor] = $tLoga.WarnFontColor
$aLoga[$eLOGA_WarnFontBkColor] = $tLoga.WarnFontBkColor
$aLoga[$eLOGA_WarnFontSize] = $tLoga.WarnFontSize
$aLoga[$eLOGA_WarnCharSet] = $tLoga.WarnCharSet
$aLoga[$eLOGA_ErrorSymbol] = $tLoga.ErrorSymbol
$aLoga[$eLOGA_ErrorFontName] = $tLoga.ErrorFontName
$aLoga[$eLOGA_ErrorString] = $tLoga.ErrorString
$aLoga[$eLOGA_ErrorFontColor] = $tLoga.ErrorFontColor
$aLoga[$eLOGA_ErrorFontBkColor] = $tLoga.ErrorFontBkColor
$aLoga[$eLOGA_ErrorFontSize] = $tLoga.ErrorFontSize
$aLoga[$eLOGA_ErrorCharSet] = $tLoga.ErrorCharSet
$aLoga[$eLOGA_FatalSymbol] = $tLoga.FatalSymbol
$aLoga[$eLOGA_FatalFontName] = $tLoga.FatalFontName
$aLoga[$eLOGA_FatalString] = $tLoga.FatalString
$aLoga[$eLOGA_FatalFontColor] = $tLoga.FatalFontColor
$aLoga[$eLOGA_FatalFontBkColor] = $tLoga.FatalFontBkColor
$aLoga[$eLOGA_FatalFontSize] = $tLoga.FatalFontSize
$aLoga[$eLOGA_FatalCharSet] = $tLoga.FatalCharSet
EndIf
Return $aLoga
EndFunc
Global $sLogFilePath = 'FilePath="AutoCharts.log"'
Global $hLoga1 = _LogaNew($sLogFilePath)
Local $source
Local $destination
Global $timer
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
$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files"
$destination = $DatabaseDir & "\fin_backup_files"
$timer = TimerInit()
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files"
$destination = @ScriptDir & $CSVDataDir
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Synced Dropbox data with Autocharts Data")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullCatalystData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst"
$destination = $DatabaseDir & "\fin_backup_files\Catalyst"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Catalyst"
$destination = @ScriptDir & $CSVDataDir & "\Catalyst"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Pulled All Catalyst Data from Dropbox")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullCatalystFundData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst\" & $CurrentFund & "\"
$destination = $DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund & "\"
$destination = @ScriptDir & $CSVDataDir & "\Catalyst\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullRationalData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational\"
$destination = $DatabaseDir & "\fin_backup_files\Rational\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Rational\"
$destination = @ScriptDir & $CSVDataDir & "\Rational\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Pulled Rational Data from Dropbox")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullRationalFundData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational\" & $CurrentFund & "\"
$destination = $DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund & "\"
$destination = @ScriptDir & $CSVDataDir & "\Rational\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullStrategySharesFundData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\StrategyShares\" & $CurrentFund & "\"
$destination = $DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund & "\"
$destination = @ScriptDir & $CSVDataDir & "\StrategyShares\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func UploadamCharts()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = "C:\Users\mrjak\Documents\GitHub\AutoCharts\assets\ChartBuilder\public\scripts"
$destination = $DatabaseDir & "\amCharts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
SplashOff()
_LogaInfo("Uploaded amCharts Scripts to Database")
EndFunc
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
_LogaError("Error! Unable to Export Datalinker File to " & $sFileSelectFolder)
Else
MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File Exported to " & $sFileSelectFolder)
_LogaInfo("Datalinker File Exported to " & $sFileSelectFolder)
EndIf
EndIf
EndFunc
Func UploadDatalinker()
If $INPT_Name = "Jakob" Then
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir, 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir)
Else
MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")
_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir)
EndIf
Else
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir & "\" & $INPT_Name & "_Datalinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir)
Else
MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")
_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir)
EndIf
EndIf
EndFunc
Func ImportDatalinker()
FileCopy($DatabaseDir & "\DataLinker.xml", @ScriptDir & "\Datalinker_TEMP1.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "Unable to copy datalinker.xml file to script directory")
_LogaError("Error! Unable to copy datalinker.xml file to script directory")
Else
_LogaInfo("Datalinker File Imported to AutoCharts Directory")
EndIf
Local $file = @ScriptDir & "\Datalinker_TEMP1.xml"
Local $text = FileRead($file)
If $INPT_Name <> "Jakob" Then
$tout1 = StringReplace($text, 'X:\Marketing Team Files\', $DropboxDir & '\Marketing Team Files\')
FileWrite(@ScriptDir & "\DataLinker_Updated1.xml", $tout1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
_LogaInfo("Datalinker File Imported to InDesign successfully")
EndIf
Else
FileCopy(@ScriptDir & "\Datalinker_TEMP1.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
_LogaInfo("Datalinker File Imported to InDesign successfully")
EndIf
EndIf
FileCopy(@ScriptDir & "\Datalinker_Updated1.xml", @ScriptDir & "\Datalinker_TEMP2.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign")
_LogaError("Error! Unable to Import Datalinker File to InDesign")
Else
_LogaInfo("Datalinker File Imported to AutoCharts Directory")
EndIf
Local $file2 = @ScriptDir & "\Datalinker_TEMP2.xml"
Local $text2 = FileRead($file2)
If $INPT_Name <> "Jakob" Then
$tout2 = StringReplace($text2, 'file:///X:', 'file:///' & $DropboxDir)
FileWrite(@ScriptDir & "\DataLinker_Updated2.xml", $tout2)
FileCopy(@ScriptDir & "\Datalinker_Updated2.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
FileDelete(@ScriptDir & "\Datalinker_Updated2.xml")
FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
_LogaInfo("Datalinker File Imported to InDesign successfully")
EndIf
Else
FileCopy(@ScriptDir & "\Datalinker_TEMP.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
FileDelete(@ScriptDir & "\Datalinker_Updated.xml")
FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
_LogaInfo("Datalinker File Imported to InDesign successfully")
EndIf
EndIf
EndFunc
Func CheckForSettingsMigrate()
If FileExists(@ScriptDir & "/settings-MIGRATE.ini") Then
FileDelete(@ScriptDir & "/settings-MIGRATE.ini")
_LogaInfo("Updated install detected.")
MsgBox(64, "Thanks for upgrading!", "Thanks for upgrading AutoCharts!" & @CRLF & @CRLF & "Before you begin, please double check your settings have imported correctly.")
EndIf
EndFunc
Func CheckForUpdate()
Run(@AppDataDir & "/AutoCharts/AutoCharts_Updater.exe")
EndFunc
Func CheckForUpdateSilent()
Run(@ComSpec & " /c AutoCharts_Updater.exe -nogui", @AppDataDir & "/AutoCharts/", @SW_HIDE)
EndFunc
CheckForSettingsMigrate()
RunMainGui()
Func RunMainGui()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)
CheckForUpdateSilent()
Sleep(2000)
SplashOff()
$MainGUI = GUICreate("AutoCharts 2.4.9", 570, 609, -1, -1)
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
$mCheckUpdate = GUICtrlCreateMenuItem("&Check for Update", $mHelp)
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
ExitLoop
Case $mExit
Exit
Case $GUI_EVENT_CLOSE
Exit
Case $mEditSettings
OpenSettingsGUI()
Case $mUploadamCharts
UploadamCharts()
Case $mExportDataLinker
ExportDatalinker()
Case $mImportDataLinker
ImportDatalinker()
If @error Then
MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
Else
MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
EndIf
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
Case $mCheckUpdate
CheckForUpdate()
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
ImportDatalinker()
RunCSVConvert()
CreateCharts()
_LogaInfo("############################### END OF RUN - CATALYST ###############################")
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
ImportDatalinker()
PullCatalystData()
RunExpenseRatios()
_LogaInfo("############################### END OF RUN - CATALYST ###############################")
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
ImportDatalinker()
RunCSVConvert()
CreateCharts()
_LogaInfo("############################### END OF RUN - RATIONAL ###############################")
GUICtrlSetData($ProgressBar, 0)
MsgBox(0, "Finished", "The process has finished.")
GUICtrlSetData($UpdateLabel, "The process has finished.")
Case $BTN_Rational_UpdateExpenseRatio
$FundFamily = "Rational"
$FamilySwitch = $aRationalCheck
GUICtrlSetData($ProgressBar, 10)
ImportDatalinker()
PullRationalData()
RunExpenseRatios()
_LogaInfo("############################### END OF RUN - RATIONAL ###############################")
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
ImportDatalinker()
RunCSVConvert()
CreateCharts()
_LogaInfo("############################### END OF RUN - STRATEGY SHARES ###############################")
GUICtrlSetData($ProgressBar, 0)
MsgBox(0, "Finished", "The process has finished.")
GUICtrlSetData($UpdateLabel, "The process has finished.")
Case $mSyncFiles
SyncronizeDataFiles()
MsgBox(0, "Alert", "Sync Completed. Done in " & TimerDiff($timer) / 1000 & " seconds!")
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
_LogaInfo("Determined quarter to be ~" & $Select_Quarter & "~ and current year to be ~" & $INPT_CurYear & "~")
If FileExists($DatabaseDir & "\csv\Update_FactSheetDates.csv") Then
FileDelete($DatabaseDir & "\csv\Update_FactSheetDates.csv")
EndIf
Local $file = $DatabaseDir & "\csv\Update_FactSheetDatesTEMP.csv"
Local $text = FileReadLine($file, 1)
$tout1 = StringReplace($text, 'Label,ID', 'Label,ID' & @CRLF)
FileWrite($DatabaseDir & "\csv\Update_FactSheetDates.csv", $tout1)
$text = FileReadLine($file, 2)
$tout1 = StringReplace($text, '03/31/2021,1', $MonthNumber & '/' & $DayNumber & '/' & $INPT_CurYear & ',1' & @CRLF)
FileWrite($DatabaseDir & "\csv\Update_FactSheetDates.csv", $tout1)
$text = FileReadLine($file, 3)
$tout1 = StringReplace($text, '"March 31, 2021",2', '"' & $QtrToMonth & ' ' & $DayNumber & ', ' & $INPT_CurYear & '",2' & @CRLF)
FileWrite($DatabaseDir & "\csv\Update_FactSheetDates.csv", $tout1)
$text = FileReadLine($file, 4)
$tout1 = StringReplace($text, 'Q1 2021,3', $Select_Quarter & ' ' & $INPT_CurYear & ',3' & @CRLF)
FileWrite($DatabaseDir & "\csv\Update_FactSheetDates.csv", $tout1)
$text = FileReadLine($file, 5)
$tout1 = StringReplace($text, 'March 2021,4', $QtrToMonth & ' ' & $INPT_CurYear & ',4' & @CRLF)
FileWrite($DatabaseDir & "\csv\Update_FactSheetDates.csv", $tout1)
$text = FileReadLine($file, 6)
$tout1 = StringReplace($text, '03/2021,5', $MonthNumber & '/' & $INPT_CurYear & ',5')
FileWrite($DatabaseDir & "\csv\Update_FactSheetDates.csv", $tout1)
FileClose($DatabaseDir & "\csv\Update_FactSheetDates.csv")
_LogaInfo("Updated FactSheetDates CSV File with selected dates")
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
_LogaInfo("~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
If $FundFamily = "Catalyst" Then
PullCatalystFundData()
EndIf
If $FundFamily = "Rational" Then
PullRationalFundData()
EndIf
If $FundFamily = "StrategyShares" Then
PullStrategySharesFundData()
EndIf
FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "*.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & ".xlsx", @TempDir, @SW_HIDE)
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
_LogaInfo("Converted " & $CurrentFund & ".xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & ".xlsx file to csv")
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
RunCSVConvert4Institution()
EndIf
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
RunCSVConvert4Brochure()
EndIf
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
RunCSVConvert4Presentation()
EndIf
GUICtrlSetData($ProgressBar, 25)
FileCopy(@ScriptDir & "/VBS_Scripts/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1)
FileMove(@ScriptDir & "/VBS_Scripts/*.csv", $DatabaseDir & "\csv\" & $FundFamily & "\" & $CurrentFund & "\*.csv", 1)
_LogaInfo("Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in Dropbox")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in Dropbox")
GUICtrlSetData($ProgressBar, 30)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
_LogaInfo("Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
GUICtrlSetData($ProgressBar, 55)
Else
ContinueLoop
EndIf
Next
EndFunc
Func RunCSVConvert4Institution()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-institutional.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("Converted " & $CurrentFund & "-institutional.xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-institutional.xlsx file to csv")
EndFunc
Func RunCSVConvert4Brochure()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-brochure.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("Converted " & $CurrentFund & "-brochure.xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-brochure.xlsx file to csv")
EndFunc
Func RunCSVConvert4Presentation()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-presentation.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("Converted " & $CurrentFund & "-presentation.xlsx file to csv")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Converted " & $CurrentFund & "-presentation.xlsx file to csv")
EndFunc
Func HTMLChartEditor()
Local $file = @ScriptDir & "\assets\ChartBuilder\public\index_TEMPLATE.html"
Local $text = FileRead($file)
$tout1 = StringReplace($text, '<script src="/scripts/CHANGEME.js"></script>', '<script src="/scripts/' & $CurrentFund & '.js"></script>')
FileWrite(@ScriptDir & "\assets\ChartBuilder\public\index.html", $tout1)
_LogaInfo("~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")
_LogaInfo("Created HTML file for " & $CurrentFund & " chart generation")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Created HTML file for " & $CurrentFund & " chart generation")
_LogaInfo("Initializing Local Server for amCharts")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Initializing Local Server for amCharts")
EndFunc
Func CreateCharts()
For $a = 0 To(UBound($FamilySwitch) - 1)
If $FamilySwitch[$a] <> "" Then
$CurrentFund = $FamilySwitch[$a]
Call("HTMLChartEditor")
RunWait(@ComSpec & " /c node --unhandled-rejections=strict server.js", @ScriptDir & "/assets/ChartBuilder/", @SW_HIDE)
GUICtrlSetData($ProgressBar, 70)
_LogaInfo($CurrentFund & " charts generated in SVG format using amCharts")
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund & " | Charts generated in SVG format using amCharts")
FileDelete(@ScriptDir & "\assets\ChartBuilder\public\index.html")
FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $DatabaseDir & "\images\charts\" & $FundFamily & "\" & $CurrentFund & "\*.svg", 1)
GUICtrlSetData($ProgressBar, 92)
_LogaInfo($CurrentFund & " charts moved to the funds InDesign Links folder")
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
FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\Catalyst_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Catalyst_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("~~~~~~~~~~~~ Updating Catalyst Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")
_LogaInfo("Updated Catalyst Expense Ratios")
GUICtrlSetData($UpdateLabel, "Updated Catalyst Expense Ratios")
FileMove(@ScriptDir & "/VBS_Scripts/Catalyst_ExpenseRatios.csv", $DatabaseDir & "\csv\" & $FundFamily & "\Catalyst_ExpenseRatios.csv", 1)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
EndIf
If $FundFamily = "Rational" Then
GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
GUICtrlSetData($ProgressBar, 60)
FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\Rational_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Rational_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("~~~~~~~~~~~~ Updating Rational Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
_LogaInfo("Updated Rational Expense Ratios")
GUICtrlSetData($UpdateLabel, "Updated Rational Expense Ratios")
FileMove(@ScriptDir & "/VBS_Scripts/Rational_ExpenseRatios.csv", $DatabaseDir & "\csv\" & $FundFamily & "\Rational_ExpenseRatios.csv", 1)
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
$Zip = _Zip_Create($sFileSelectFolder & "\FactSheets_" & $Select_Quarter & "-" & $INPT_CurYear & ".zip")
_Zip_AddFolder($Zip, $DatabaseDir & "\fin_backup_files\", 4)
_Zip_AddFolder($Zip, $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\", 4)
MsgBox(0, "Items in Zip", "Succesfully added " & _Zip_Count($Zip) & " items in " & $Zip)
_LogaInfo("Created Factsheet Archive at " & $Zip)
EndIf
EndFunc
