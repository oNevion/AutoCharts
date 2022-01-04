#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
Global $aCatalystCheck[24]
Global $aRationalCheck[8]
Global $aStrategyCheck[6]
Global $FamilySwitch
Global $CurrentFund
Global $ini = 'settings.ini'
Global $INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
Global $Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
Global $INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
Global $FundFamily = ""
Global $bDBVerified = IniRead($ini, 'Settings', 'DBVerified', 'False')
Global $bACDriveVerified = IniRead($ini, 'Settings', 'ACDriveVerified', 'False')
Global $Select_Theme = IniRead($ini, 'Settings', 'UITheme', '')
Global $INPT_DropboxFolder = 9999
Global $CSVDataDir = "\assets\ChartBuilder\public\Data\Backups\"
Global $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
Global $AutoChartsDriveDir = "Z:\"
Global $DatabaseDir = $AutoChartsDriveDir & "\database"
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $SWP_NOSIZE = 0x0001
Global Const $SWP_NOMOVE = 0x0002
Global Const $SWP_NOZORDER = 0x0004
Global Const $SWP_NOREDRAW = 0x0008
Global Const $SWP_NOACTIVATE = 0x0010
Global Const $SWP_FRAMECHANGED = 0x0020
Global Const $MB_SYSTEMMODAL = 4096
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
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
Global Const $SS_CENTER = 0x1
Global Const $SS_RIGHT = 0x2
Global Const $SS_NOTIFY = 0x0100
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $GUI_SS_DEFAULT_PIC = $SS_NOTIFY
Global Const $WS_MAXIMIZEBOX = 0x00010000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SIZEBOX = 0x00040000
Global Const $WS_HSCROLL = 0x00100000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_EX_MDICHILD = 0x00000040
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $WM_SIZE = 0x0005
Global Const $WM_SYSCOMMAND = 0x0112
Global Const $HTCAPTION = 2
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
Global Const $tagRECT = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $tagGDIPRECTF = "struct;float X;float Y;float Width;float Height;endstruct"
Global Const $tagGDIPSTARTUPINPUT = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $tagWINDOWPLACEMENT = "uint length;uint flags;uint showCmd;long ptMinPosition[2];long ptMaxPosition[2];long rcNormalPosition[4]"
Global $__g_vEnum, $__g_vExt = 0
Global Const $tagOSVERSIONINFO = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $__WINVER = __WINVER()
Func _WinAPI_FreeLibrary($hModule)
Local $aResult = DllCall("kernel32.dll", "bool", "FreeLibrary", "handle", $hModule)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
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
Func _WinAPI_LoadLibrary($sFileName)
Local $aResult = DllCall("kernel32.dll", "handle", "LoadLibraryW", "wstr", $sFileName)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func __Inc(ByRef $aData, $iIncrement = 100)
Select
Case UBound($aData, $UBOUND_COLUMNS)
If $iIncrement < 0 Then
ReDim $aData[$aData[0][0] + 1][UBound($aData, $UBOUND_COLUMNS)]
Else
$aData[0][0] += 1
If $aData[0][0] > UBound($aData) - 1 Then
ReDim $aData[$aData[0][0] + $iIncrement][UBound($aData, $UBOUND_COLUMNS)]
EndIf
EndIf
Case UBound($aData, $UBOUND_ROWS)
If $iIncrement < 0 Then
ReDim $aData[$aData[0] + 1]
Else
$aData[0] += 1
If $aData[0] > UBound($aData) - 1 Then
ReDim $aData[$aData[0] + $iIncrement]
EndIf
EndIf
Case Else
Return 0
EndSelect
Return 1
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
Func _WinAPI_DeleteObject($hObject)
Local $aResult = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hObject)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_GetStockObject($iObject)
Local $aResult = DllCall("gdi32.dll", "handle", "GetStockObject", "int", $iObject)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_IsBadReadPtr($pAddress, $iLength)
Local $aRet = DllCall('kernel32.dll', 'bool', 'IsBadReadPtr', 'struct*', $pAddress, 'uint_ptr', $iLength)
If @error Then Return SetError(@error, @extended, False)
Return $aRet[0]
EndFunc
Func _WinAPI_IsBadWritePtr($pAddress, $iLength)
Local $aRet = DllCall('kernel32.dll', 'bool', 'IsBadWritePtr', 'struct*', $pAddress, 'uint_ptr', $iLength)
If @error Then Return SetError(@error, @extended, False)
Return $aRet[0]
EndFunc
Func _WinAPI_MoveMemory($pDestination, $pSource, $iLength)
If _WinAPI_IsBadReadPtr($pSource, $iLength) Then Return SetError(10, @extended, 0)
If _WinAPI_IsBadWritePtr($pDestination, $iLength) Then Return SetError(11, @extended, 0)
DllCall('ntdll.dll', 'none', 'RtlMoveMemory', 'struct*', $pDestination, 'struct*', $pSource, 'ulong_ptr', $iLength)
If @error Then Return SetError(@error, @extended, 0)
Return 1
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
Func _WinAPI_GetParent($hWnd)
Local $aResult = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
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
Func _WinAPI_GetWindowPlacement($hWnd)
Local $tWindowPlacement = DllStructCreate($tagWINDOWPLACEMENT)
DllStructSetData($tWindowPlacement, "length", DllStructGetSize($tWindowPlacement))
Local $aRet = DllCall("user32.dll", "bool", "GetWindowPlacement", "hwnd", $hWnd, "struct*", $tWindowPlacement)
If @error Or Not $aRet[0] Then Return SetError(@error + 10, @extended, 0)
Return $tWindowPlacement
EndFunc
Func _WinAPI_SetWindowPlacement($hWnd, $tWindowPlacement)
Local $aResult = DllCall("user32.dll", "bool", "SetWindowPlacement", "hwnd", $hWnd, "struct*", $tWindowPlacement)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_GetProcAddress($hModule, $vName)
Local $sType = "str"
If IsNumber($vName) Then $sType = "word"
Local $aResult = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", $hModule, $sType, $vName)
If @error Or Not $aResult[0] Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
Func _WinAPI_ReleaseCapture()
Local $aResult = DllCall("user32.dll", "bool", "ReleaseCapture")
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
EndFunc
Func _WinAPI_SetCapture($hWnd)
Local $aResult = DllCall("user32.dll", "hwnd", "SetCapture", "hwnd", $hWnd)
If @error Then Return SetError(@error, @extended, 0)
Return $aResult[0]
EndFunc
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
Func _WinAPI_EnumDisplayMonitors($hDC = 0, $tRECT = 0)
Local $hEnumProc = DllCallbackRegister('__EnumDisplayMonitorsProc', 'bool', 'handle;handle;ptr;lparam')
Dim $__g_vEnum[101][2] = [[0]]
Local $aRet = DllCall('user32.dll', 'bool', 'EnumDisplayMonitors', 'handle', $hDC, 'struct*', $tRECT, 'ptr', DllCallbackGetPtr($hEnumProc), 'lparam', 0)
If @error Or Not $aRet[0] Or Not $__g_vEnum[0][0] Then
$__g_vEnum = @error + 10
EndIf
DllCallbackFree($hEnumProc)
If $__g_vEnum Then Return SetError($__g_vEnum, 0, 0)
__Inc($__g_vEnum, -1)
Return $__g_vEnum
EndFunc
Func _WinAPI_GetPosFromRect($tRECT)
Local $aResult[4]
For $i = 0 To 3
$aResult[$i] = DllStructGetData($tRECT, $i + 1)
If @error Then Return SetError(@error, @extended, 0)
Next
For $i = 2 To 3
$aResult[$i] -= $aResult[$i - 2]
Next
Return $aResult
EndFunc
Func _WinAPI_MonitorFromWindow($hWnd, $iFlag = 1)
Local $aRet = DllCall('user32.dll', 'handle', 'MonitorFromWindow', 'hwnd', $hWnd, 'dword', $iFlag)
If @error Then Return SetError(@error, @extended, 0)
Return $aRet[0]
EndFunc
Func __EnumDisplayMonitorsProc($hMonitor, $hDC, $pRECT, $lParam)
#forceref $hDC, $lParam
__Inc($__g_vEnum)
$__g_vEnum[$__g_vEnum[0][0]][0] = $hMonitor
If Not $pRECT Then
$__g_vEnum[$__g_vEnum[0][0]][1] = 0
Else
$__g_vEnum[$__g_vEnum[0][0]][1] = DllStructCreate($tagRECT)
If Not _WinAPI_MoveMemory(DllStructGetPtr($__g_vEnum[$__g_vEnum[0][0]][1]), $pRECT, 16) Then Return 0
EndIf
Return 1
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
Func _ThrowError($txt, $exit = 0, $ret = "", $err = 0, $ext = 0, $time = 0)
If $exit = 0 Then
MsgBox(48, @ScriptName, $txt, $time)
Return SetError($err, $ext, $ret)
Else
MsgBox(16, @ScriptName, $txt, $time)
Exit($err)
EndIf
EndFunc
Local $source
Local $destination
Global $timer
Func VerifyDropbox()
If FileExists($DatabaseDir & "/.checkfile") Then
$bACDriveVerified = True
IniWrite($ini, 'Settings', 'ACDriveVerified', $bACDriveVerified)
Else
$bACDriveVerified = False
IniWrite($ini, 'Settings', 'ACDriveVerified', $bACDriveVerified)
SetError(50)
EndIf
EndFunc
Func SyncronizeDataFiles()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Backup Files"
$destination = $DatabaseDir & "\fin_backup_files"
$timer = TimerInit()
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files"
$destination = @ScriptDir & $CSVDataDir
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Synced AutoCharts Drive data with Autocharts Data")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullCatalystData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Backup Files\Catalyst"
$destination = $DatabaseDir & "\fin_backup_files\Catalyst"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Catalyst"
$destination = @ScriptDir & $CSVDataDir & "\Catalyst"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Pulled All Catalyst Data from AutoCharts Drive")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullCatalystFundData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Backup Files\Catalyst\" & $CurrentFund & "\"
$destination = $DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund & "\"
$destination = @ScriptDir & $CSVDataDir & "\Catalyst\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Pulled " & $CurrentFund & " Data from AutoCharts Drive")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullRationalData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Backup Files\Rational\"
$destination = $DatabaseDir & "\fin_backup_files\Rational\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Rational\"
$destination = @ScriptDir & $CSVDataDir & "\Rational\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Pulled Rational Data from AutoCharts Drive")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullRationalFundData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Backup Files\Rational\" & $CurrentFund & "\"
$destination = $DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund & "\"
$destination = @ScriptDir & $CSVDataDir & "\Rational\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Pulled " & $CurrentFund & " Data from AutoCharts Drive")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func PullStrategySharesFundData()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = $DropboxDir & "\Backup Files\StrategyShares\" & $CurrentFund & "\"
$destination = $DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
$source = $DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund & "\"
$destination = @ScriptDir & $CSVDataDir & "\StrategyShares\" & $CurrentFund & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Pulled " & $CurrentFund & " Data from AutoCharts Drive")
$source = $DatabaseDir & "\amCharts"
$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
_LogaInfo("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func UploadamCharts()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$source = "C:\Users\mrjak\Documents\GitHub\AutoCharts\assets\ChartBuilder\public\scripts\"
$destination = $DatabaseDir & "\amCharts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)
SplashOff()
_LogaInfo("Uploaded amCharts Scripts to Database")
EndFunc
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
Global $GUIThemeColor = "0x13161C"
Global $FontThemeColor = "0xFFFFFF"
Global $GUIBorderColor = "0x2D2D2D"
Global $ButtonBKColor = "0x00796b"
Global $ButtonTextColor = "0xFFFFFF"
Global $CB_Radio_Color = "0xFFFFFF"
Global $GUI_Theme_Name = "DarkTealV2"
Global $CB_Radio_Hover_Color = "0xD8D8D8"
Global $CB_Radio_CheckMark_Color = "0x1a1a1a"
Func _SetTheme($ThemeSelect = "DarkTeal")
$GUI_Theme_Name = $ThemeSelect
Switch($ThemeSelect)
Case "LightTeal"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0x00796b"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkTeal"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0x00796b"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkTealV2"
$GUIThemeColor = "0x13161C"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0x35635B"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkRuby"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0x712043"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkMidnightTeal"
$GUIThemeColor = "0x0A0D16"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x242B47"
$ButtonBKColor = "0x336058"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkMidnightCyan"
$GUIThemeColor = "0x0A0D16"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x242B47"
$ButtonBKColor = "0x0D5C63"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkMidnightBlue"
$GUIThemeColor = "0x0A0D16"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x242B47"
$ButtonBKColor = "0x1A4F70"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkMidnight"
$GUIThemeColor = "0x0A0D16"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x242B47"
$ButtonBKColor = "0x3C4D66"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkBlue"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x303030"
$ButtonBKColor = "0x1E648C"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkBlueV2"
$GUIThemeColor = "0x040D11"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x303030"
$ButtonBKColor = "0x1E648C"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightBlue"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0x244E80"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightCyan"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0x00838f"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkCyan"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0x00838f"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightGray"
$GUIThemeColor = "0xE9E9E9"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0x3F5863"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightGreen"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0x2E7D32"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkGreen"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0x5E8763"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkGreenV2"
$GUIThemeColor = "0x061319"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x242B47"
$ButtonBKColor = "0x5E8763"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightRed"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0xc62828"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkGray"
$GUIThemeColor = "0x1B2428"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x4F6772"
$ButtonBKColor = "0x607D8B"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkAmber"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0xffa000"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightOrange"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0xBC5E05"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkOrange"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0xC76810"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightPurple"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0x512DA8"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "DarkPurple"
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0x512DA8"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case "LightPink"
$GUIThemeColor = "0xF4F4F4"
$FontThemeColor = "0x000000"
$GUIBorderColor = "0xD8D8D8"
$ButtonBKColor = "0xE91E63"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xE8E8E8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
Case Else
ConsoleWrite("Metro-UDF-Error: Theme not found, using default theme." & @CRLF)
$GUIThemeColor = "0x191919"
$FontThemeColor = "0xFFFFFF"
$GUIBorderColor = "0x2D2D2D"
$ButtonBKColor = "0x00796b"
$ButtonTextColor = "0xFFFFFF"
$CB_Radio_Color = "0xFFFFFF"
$CB_Radio_Hover_Color = "0xD8D8D8"
$CB_Radio_CheckMark_Color = "0x1a1a1a"
$GUI_Theme_Name = "DarkTealV2"
EndSwitch
EndFunc
Func _StringSize($sText, $iSize = 8.5, $iWeight = 400, $iAttrib = 0, $sName = "", $iMaxWidth = 0, $hWnd = 0)
If $iSize = Default Then $iSize = 8.5
If $iWeight = Default Then $iWeight = 400
If $iAttrib = Default Then $iAttrib = 0
If $sName = "" Or $sName = Default Then $sName = _StringSize_DefaultFontName()
If Not IsString($sText) Then Return SetError(1, 1, 0)
If Not IsNumber($iSize) Then Return SetError(1, 2, 0)
If Not IsInt($iWeight) Then Return SetError(1, 3, 0)
If Not IsInt($iAttrib) Then Return SetError(1, 4, 0)
If Not IsString($sName) Then Return SetError(1, 5, 0)
If Not IsNumber($iMaxWidth) Then Return SetError(1, 6, 0)
If Not IsHwnd($hWnd) And $hWnd <> 0 Then Return SetError(1, 7, 0)
Local $aRet, $hDC, $hFont, $hLabel = 0, $hLabel_Handle
Local $iExpTab = BitAnd($iAttrib, 1)
$iAttrib = BitAnd($iAttrib, BitNot(1))
If IsHWnd($hWnd) Then
$hLabel = GUICtrlCreateLabel("", -10, -10, 10, 10)
$hLabel_Handle = GUICtrlGetHandle(-1)
GUICtrlSetFont(-1, $iSize, $iWeight, $iAttrib, $sName)
$aRet = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hLabel_Handle)
If @error Or $aRet[0] = 0 Then
GUICtrlDelete($hLabel)
Return SetError(2, 1, 0)
EndIf
$hDC = $aRet[0]
$aRet = DllCall("user32.dll", "lparam", "SendMessage", "hwnd", $hLabel_Handle, "int", 0x0031, "wparam", 0, "lparam", 0)
If @error Or $aRet[0] = 0 Then
GUICtrlDelete($hLabel)
Return SetError(2, _StringSize_Error_Close(2, $hDC), 0)
EndIf
$hFont = $aRet[0]
Else
$aRet = DllCall("user32.dll", "handle", "GetDC", "hwnd", $hWnd)
If @error Or $aRet[0] = 0 Then Return SetError(2, 1, 0)
$hDC = $aRet[0]
$aRet = DllCall("gdi32.dll", "int", "GetDeviceCaps", "handle", $hDC, "int", 90)
If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSize_Error_Close(3, $hDC), 0)
Local $iInfo = $aRet[0]
$aRet = DllCall("gdi32.dll", "handle", "CreateFontW", "int", -$iInfo * $iSize / 72, "int", 0, "int", 0, "int", 0, "int", $iWeight, "dword", BitAND($iAttrib, 2), "dword", BitAND($iAttrib, 4), "dword", BitAND($iAttrib, 8), "dword", 0, "dword", 0, "dword", 0, "dword", 5, "dword", 0, "wstr", $sName)
If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSize_Error_Close(4, $hDC), 0)
$hFont = $aRet[0]
EndIf
$aRet = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $hFont)
If @error Or $aRet[0] = 0 Then Return SetError(2, _StringSize_Error_Close(5, $hDC, $hFont, $hLabel), 0)
Local $hPrevFont = $aRet[0]
Local $avSize_Info[4], $iLine_Length, $iLine_Height = 0, $iLine_Count = 0, $iLine_Width = 0, $iWrap_Count, $iLast_Word, $sTest_Line
Local $tSize = DllStructCreate("int X;int Y")
DllStructSetData($tSize, "X", 0)
DllStructSetData($tSize, "Y", 0)
$sText = StringRegExpReplace($sText, "((?<!\x0d)\x0a|\x0d(?!\x0a))", @CRLF)
Local $asLines = StringSplit($sText, @CRLF, 1)
For $i = 1 To $asLines[0]
If $iExpTab Then
$asLines[$i] = StringReplace($asLines[$i], @TAB, " XXXXXXXX")
EndIf
$iLine_Length = StringLen($asLines[$i])
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $hDC, "wstr", $asLines[$i], "int", $iLine_Length, "ptr", DllStructGetPtr($tSize))
If @error Then Return SetError(2, _StringSize_Error_Close(6, $hDC, $hFont, $hLabel), 0)
If DllStructGetData($tSize, "X") > $iLine_Width Then $iLine_Width = DllStructGetData($tSize, "X")
If DllStructGetData($tSize, "Y") > $iLine_Height Then $iLine_Height = DllStructGetData($tSize, "Y")
Next
If $iMaxWidth <> 0 And $iLine_Width > $iMaxWidth Then
For $j = 1 To $asLines[0]
$iLine_Length = StringLen($asLines[$j])
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $hDC, "wstr", $asLines[$j], "int", $iLine_Length, "ptr", DllStructGetPtr($tSize))
If @error Then Return SetError(2, _StringSize_Error_Close(6, $hDC, $hFont, $hLabel), 0)
If DllStructGetData($tSize, "X") < $iMaxWidth - 4 Then
$iLine_Count += 1
$avSize_Info[0] &= $asLines[$j] & @CRLF
Else
$iWrap_Count = 0
While 1
$iLine_Width = 0
$iLast_Word = 0
For $i = 1 To StringLen($asLines[$j])
If StringMid($asLines[$j], $i, 1) = " " Then $iLast_Word = $i - 1
$sTest_Line = StringMid($asLines[$j], 1, $i)
$iLine_Length = StringLen($sTest_Line)
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $hDC, "wstr", $sTest_Line, "int", $iLine_Length, "ptr", DllStructGetPtr($tSize))
If @error Then Return SetError(2, _StringSize_Error_Close(6, $hDC, $hFont, $hLabel), 0)
$iLine_Width = DllStructGetData($tSize, "X")
If $iLine_Width >= $iMaxWidth - 4 Then ExitLoop
Next
If $i > StringLen($asLines[$j]) Then
$iWrap_Count += 1
$avSize_Info[0] &= $sTest_Line & @CRLF
ExitLoop
Else
$iWrap_Count += 1
If $iLast_Word = 0 Then Return SetError(3, _StringSize_Error_Close(0, $hDC, $hFont, $hLabel), 0)
$avSize_Info[0] &= StringLeft($sTest_Line, $iLast_Word) & @CRLF
$asLines[$j] = StringTrimLeft($asLines[$j], $iLast_Word)
$asLines[$j] = StringStripWS($asLines[$j], 1)
EndIf
WEnd
$iLine_Count += $iWrap_Count
EndIf
Next
If $iExpTab Then
$avSize_Info[0] = StringRegExpReplace($avSize_Info[0], "\x20?XXXXXXXX", @TAB)
EndIf
$avSize_Info[1] = $iLine_Height
$avSize_Info[2] = $iMaxWidth
$avSize_Info[3] =($iLine_Count * $iLine_Height) + 4
Else
Local $avSize_Info[4] = [$sText, $iLine_Height, $iLine_Width,($asLines[0] * $iLine_Height) + 4]
EndIf
DllCall("gdi32.dll", "handle", "SelectObject", "handle", $hDC, "handle", $hPrevFont)
DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hFont)
DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $hDC)
If $hLabel Then GUICtrlDelete($hLabel)
Return $avSize_Info
EndFunc
Func _StringSize_Error_Close($iExtCode, $hDC = 0, $hFont = 0, $hLabel = 0)
If $hFont <> 0 Then DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $hFont)
If $hDC <> 0 Then DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $hDC)
If $hLabel Then GUICtrlDelete($hLabel)
Return $iExtCode
EndFunc
Func _StringSize_DefaultFontName()
Local $tNONCLIENTMETRICS = DllStructCreate("uint;int;int;int;int;int;byte[60];int;int;byte[60];int;int;byte[60];byte[60];byte[60]")
DLLStructSetData($tNONCLIENTMETRICS, 1, DllStructGetSize($tNONCLIENTMETRICS))
DLLCall("user32.dll", "int", "SystemParametersInfo", "int", 41, "int", DllStructGetSize($tNONCLIENTMETRICS), "ptr", DllStructGetPtr($tNONCLIENTMETRICS), "int", 0)
Local $tLOGFONT = DllStructCreate("long;long;long;long;long;byte;byte;byte;byte;byte;byte;byte;byte;char[32]", DLLStructGetPtr($tNONCLIENTMETRICS, 13))
If IsString(DllStructGetData($tLOGFONT, 14)) Then
Return DllStructGetData($tLOGFONT, 14)
Else
Return "Tahoma"
EndIf
EndFunc
Global Const $GDIP_PXF32ARGB = 0x0026200A
Global Const $GDIP_SMOOTHINGMODE_DEFAULT = 0
Global Const $GDIP_SMOOTHINGMODE_ANTIALIAS8X8 = 5
Global $__g_hGDIPBrush = 0
Global $__g_hGDIPDll = 0
Global $__g_hGDIPPen = 0
Global $__g_iGDIPRef = 0
Global $__g_iGDIPToken = 0
Global $__g_bGDIP_V1_0 = True
Func _GDIPlus_BitmapCreateFromScan0($iWidth, $iHeight, $iPixelFormat = $GDIP_PXF32ARGB, $iStride = 0, $pScan0 = 0)
Local $aResult = DllCall($__g_hGDIPDll, "uint", "GdipCreateBitmapFromScan0", "int", $iWidth, "int", $iHeight, "int", $iStride, "int", $iPixelFormat, "struct*", $pScan0, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[6]
EndFunc
Func _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap, $iARGB = 0xFF000000)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateHBITMAPFromBitmap", "handle", $hBitmap, "handle*", 0, "dword", $iARGB)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[2]
EndFunc
Func _GDIPlus_BitmapDispose($hBitmap)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDisposeImage", "handle", $hBitmap)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_BrushCreateSolid($iARGB = 0xFF000000)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateSolidFill", "int", $iARGB, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[2]
EndFunc
Func _GDIPlus_BrushDispose($hBrush)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDeleteBrush", "handle", $hBrush)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_FontCreate($hFamily, $fSize, $iStyle = 0, $iUnit = 3)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateFont", "handle", $hFamily, "float", $fSize, "int", $iStyle, "int", $iUnit, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[5]
EndFunc
Func _GDIPlus_FontDispose($hFont)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDeleteFont", "handle", $hFont)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_FontFamilyCreate($sFamily, $pCollection = 0)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateFontFamilyFromName", "wstr", $sFamily, "ptr", $pCollection, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[3]
EndFunc
Func _GDIPlus_FontFamilyDispose($hFamily)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDeleteFontFamily", "handle", $hFamily)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsClear($hGraphics, $iARGB = 0xFF000000)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipGraphicsClear", "handle", $hGraphics, "dword", $iARGB)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsCreateFromHWND($hWnd)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateFromHWND", "hwnd", $hWnd, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[2]
EndFunc
Func _GDIPlus_GraphicsDispose($hGraphics)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDeleteGraphics", "handle", $hGraphics)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsDrawLine($hGraphics, $nX1, $nY1, $nX2, $nY2, $hPen = 0)
__GDIPlus_PenDefCreate($hPen)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDrawLine", "handle", $hGraphics, "handle", $hPen, "float", $nX1, "float", $nY1, "float", $nX2, "float", $nY2)
__GDIPlus_PenDefDispose()
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsDrawPath($hGraphics, $hPath, $hPen = 0)
__GDIPlus_PenDefCreate($hPen)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDrawPath", "handle", $hGraphics, "handle", $hPen, "handle", $hPath)
__GDIPlus_PenDefDispose()
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsDrawRect($hGraphics, $nX, $nY, $nWidth, $nHeight, $hPen = 0)
__GDIPlus_PenDefCreate($hPen)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDrawRectangle", "handle", $hGraphics, "handle", $hPen, "float", $nX, "float", $nY, "float", $nWidth, "float", $nHeight)
__GDIPlus_PenDefDispose()
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsDrawStringEx($hGraphics, $sString, $hFont, $tLayout, $hFormat, $hBrush)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDrawString", "handle", $hGraphics, "wstr", $sString, "int", -1, "handle", $hFont, "struct*", $tLayout, "handle", $hFormat, "handle", $hBrush)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsFillEllipse($hGraphics, $nX, $nY, $nWidth, $nHeight, $hBrush = 0)
__GDIPlus_BrushDefCreate($hBrush)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipFillEllipse", "handle", $hGraphics, "handle", $hBrush, "float", $nX, "float", $nY, "float", $nWidth, "float", $nHeight)
__GDIPlus_BrushDefDispose()
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsFillPath($hGraphics, $hPath, $hBrush = 0)
__GDIPlus_BrushDefCreate($hBrush)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipFillPath", "handle", $hGraphics, "handle", $hBrush, "handle", $hPath)
__GDIPlus_BrushDefDispose()
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsFillRect($hGraphics, $nX, $nY, $nWidth, $nHeight, $hBrush = 0)
__GDIPlus_BrushDefCreate($hBrush)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipFillRectangle", "handle", $hGraphics, "handle", $hBrush, "float", $nX, "float", $nY, "float", $nWidth, "float", $nHeight)
__GDIPlus_BrushDefDispose()
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsSetSmoothingMode($hGraphics, $iSmooth)
If $iSmooth < $GDIP_SMOOTHINGMODE_DEFAULT Or $iSmooth > $GDIP_SMOOTHINGMODE_ANTIALIAS8X8 Then $iSmooth = $GDIP_SMOOTHINGMODE_DEFAULT
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipSetSmoothingMode", "handle", $hGraphics, "int", $iSmooth)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_GraphicsSetTextRenderingHint($hGraphics, $iTextRenderingHint)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipSetTextRenderingHint", "handle", $hGraphics, "int", $iTextRenderingHint)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_ImageGetGraphicsContext($hImage)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipGetImageGraphicsContext", "handle", $hImage, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[2]
EndFunc
Func _GDIPlus_PathAddArc($hPath, $nX, $nY, $nWidth, $nHeight, $fStartAngle, $fSweepAngle)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipAddPathArc", "handle", $hPath, "float", $nX, "float", $nY, "float", $nWidth, "float", $nHeight, "float", $fStartAngle, "float", $fSweepAngle)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_PathCloseFigure($hPath)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipClosePathFigure", "handle", $hPath)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_PathCreate($iFillMode = 0)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreatePath", "int", $iFillMode, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[2]
EndFunc
Func _GDIPlus_PathDispose($hPath)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDeletePath", "handle", $hPath)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_PenCreate($iARGB = 0xFF000000, $nWidth = 1, $iUnit = 2)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreatePen1", "dword", $iARGB, "float", $nWidth, "int", $iUnit, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[4]
EndFunc
Func _GDIPlus_PenDispose($hPen)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDeletePen", "handle", $hPen)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_PenSetStartCap($hPen, $iLineCap)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipSetPenStartCap", "handle", $hPen, "int", $iLineCap)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_RectFCreate($nX = 0, $nY = 0, $nWidth = 0, $nHeight = 0)
Local $tRECTF = DllStructCreate($tagGDIPRECTF)
DllStructSetData($tRECTF, "X", $nX)
DllStructSetData($tRECTF, "Y", $nY)
DllStructSetData($tRECTF, "Width", $nWidth)
DllStructSetData($tRECTF, "Height", $nHeight)
Return $tRECTF
EndFunc
Func _GDIPlus_Shutdown()
If $__g_hGDIPDll = 0 Then Return SetError(-1, -1, False)
$__g_iGDIPRef -= 1
If $__g_iGDIPRef = 0 Then
DllCall($__g_hGDIPDll, "none", "GdiplusShutdown", "ulong_ptr", $__g_iGDIPToken)
DllClose($__g_hGDIPDll)
$__g_hGDIPDll = 0
EndIf
Return True
EndFunc
Func _GDIPlus_Startup($sGDIPDLL = Default, $bRetDllHandle = False)
$__g_iGDIPRef += 1
If $__g_iGDIPRef > 1 Then Return True
If $sGDIPDLL = Default Then $sGDIPDLL = "gdiplus.dll"
$__g_hGDIPDll = DllOpen($sGDIPDLL)
If $__g_hGDIPDll = -1 Then
$__g_iGDIPRef = 0
Return SetError(1, 2, False)
EndIf
Local $sVer = FileGetVersion($sGDIPDLL)
$sVer = StringSplit($sVer, ".")
If $sVer[1] > 5 Then $__g_bGDIP_V1_0 = False
Local $tInput = DllStructCreate($tagGDIPSTARTUPINPUT)
Local $tToken = DllStructCreate("ulong_ptr Data")
DllStructSetData($tInput, "Version", 1)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdiplusStartup", "struct*", $tToken, "struct*", $tInput, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
$__g_iGDIPToken = DllStructGetData($tToken, "Data")
If $bRetDllHandle Then Return $__g_hGDIPDll
Return SetExtended($sVer[1], True)
EndFunc
Func _GDIPlus_StringFormatCreate($iFormat = 0, $iLangID = 0)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipCreateStringFormat", "int", $iFormat, "word", $iLangID, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $aResult[0] Then Return SetError(10, $aResult[0], 0)
Return $aResult[3]
EndFunc
Func _GDIPlus_StringFormatDispose($hFormat)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipDeleteStringFormat", "handle", $hFormat)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_StringFormatSetAlign($hStringFormat, $iFlag)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipSetStringFormatAlign", "handle", $hStringFormat, "int", $iFlag)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func _GDIPlus_StringFormatSetLineAlign($hStringFormat, $iStringAlign)
Local $aResult = DllCall($__g_hGDIPDll, "int", "GdipSetStringFormatLineAlign", "handle", $hStringFormat, "int", $iStringAlign)
If @error Then Return SetError(@error, @extended, False)
If $aResult[0] Then Return SetError(10, $aResult[0], False)
Return True
EndFunc
Func __GDIPlus_BrushDefCreate(ByRef $hBrush)
If $hBrush = 0 Then
$__g_hGDIPBrush = _GDIPlus_BrushCreateSolid()
$hBrush = $__g_hGDIPBrush
EndIf
EndFunc
Func __GDIPlus_BrushDefDispose($iCurError = @error, $iCurExtended = @extended)
If $__g_hGDIPBrush <> 0 Then
_GDIPlus_BrushDispose($__g_hGDIPBrush)
$__g_hGDIPBrush = 0
EndIf
Return SetError($iCurError, $iCurExtended)
EndFunc
Func __GDIPlus_PenDefCreate(ByRef $hPen)
If $hPen = 0 Then
$__g_hGDIPPen = _GDIPlus_PenCreate()
$hPen = $__g_hGDIPPen
EndIf
EndFunc
Func __GDIPlus_PenDefDispose($iCurError = @error, $iCurExtended = @extended)
If $__g_hGDIPPen <> 0 Then
_GDIPlus_PenDispose($__g_hGDIPPen)
$__g_hGDIPPen = 0
EndIf
Return SetError($iCurError, $iCurExtended)
EndFunc
Local $_cHvr_aData[0]
Local Const $_cHvr_HDLLCOMCTL32 = _WinAPI_LoadLibrary('comctl32.dll')
Assert($_cHvr_HDLLCOMCTL32 <> 0, 'This UDF requires comctl32.dll')
Local Const $_cHvr_PDEFSUBCLASSPROC = _WinAPI_GetProcAddress($_cHvr_HDLLCOMCTL32, 'DefSubclassProc')
Local Const $_cHvr_PINTERNALSUBCLASS_DLL = DllCallbackRegister('_cHvr_iProc', 'NONE', 'HWND;UINT;WPARAM;LPARAM;DWORD')
Local Const $_cHvr_PINTERNALSUBCLASS = DllCallbackGetPtr($_cHvr_PINTERNALSUBCLASS_DLL)
OnAutoItExitRegister("_cHvr_Finalize")
Local Const $_cHvr_TSUBCLASSEXE = Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86')
Local Const $_cHvr_HEXECUTABLEHEAP = DllCall('kernel32.dll', 'HANDLE', 'HeapCreate', 'DWORD', 0x00040000, 'ULONG_PTR', 0, 'ULONG_PTR', 0)[0]
Assert($_cHvr_HEXECUTABLEHEAP <> 0, 'Failed to create executable heap object')
Local Const $_cHvr_PSUBCLASSEXE = _cHvr_ExecutableFromStruct(Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86'))
Func _cHvr_Register($idCtrl, $fnHovOff = '', $fnHoverOn = '', $fnClick = '', $fnDblClk = '', $HoverData = 0,$ClickData = 0,$fnRightClick = '')
Local $hWnd = GUICtrlGetHandle($idCtrl)
If(Not(IsHWnd($hWnd))) Then Return SetError(1, 0, -1)
Local $nIndex = _cHvr_GetNewIndex($hWnd)
Local $aData[13]
$aData[0] = $hWnd
$aData[1] = $idCtrl
$aData[3] = $fnHovOff
$aData[4] = $HoverData
$aData[5] = $fnHoverOn
$aData[6] = $HoverData
$aData[7] = $fnRightClick
$aData[8] = $ClickData
$aData[9] = $fnClick
$aData[10] = $ClickData
$aData[11] = $fnDblClk
$aData[12] = $ClickData
$_cHvr_aData[$nIndex] = $aData
_WinAPI_SetWindowSubclass($hWnd, $_cHvr_PSUBCLASSEXE, $hWnd, $nIndex)
Return $nIndex
EndFunc
Func _cHvr_iProc($hWnd, $uMsg, $wParam, $lParam, $cIndex)
Switch $uMsg
Case 0x0200
GUISetCursor(2, 1)
_cHvr_cMove($_cHvr_aData[$cIndex], $hWnd, $uMsg, $wParam, $lParam)
Case 0x0201
_cHvr_cDown($_cHvr_aData[$cIndex], $hWnd, $uMsg, $wParam, $lParam)
Case 0x0202
_cHvr_cUp($_cHvr_aData[$cIndex], $hWnd, $uMsg, $wParam, $lParam)
Return False
Case 0x0203
_cHvr_cDblClk($_cHvr_aData[$cIndex], $hWnd, $uMsg, $wParam, $lParam)
Case 0x0204
_cHvr_cRightClk($_cHvr_aData[$cIndex], $hWnd, $uMsg, $wParam, $lParam)
Case 0x02A3
_cHvr_cLeave($_cHvr_aData[$cIndex], $hWnd, $uMsg, $wParam, $lParam)
Case 0x0082
_cHvr_UnRegisterInternal($cIndex, $hWnd)
EndSwitch
Return True
EndFunc
Func _cHvr_cDown(ByRef $aCtrlData, $hWnd, $uMsg, ByRef $wParam, ByRef $lParam)
_WinAPI_SetCapture($hWnd)
_cHvr_CallFunc($aCtrlData, 9)
EndFunc
Func _cHvr_cMove(ByRef $aCtrlData, $hWnd, $uMsg, ByRef $wParam, ByRef $lParam)
If(_WinAPI_GetCapture() = $hWnd) Then
Local $bIn = _cHvr_IsInClient($hWnd, $lParam)
If Not $aCtrlData[2] Then
If $bIn Then
$aCtrlData[2] = 1
_cHvr_CallFunc($aCtrlData, 9)
EndIf
Else
If Not $bIn Then
$aCtrlData[2] = 0
_cHvr_CallFunc($aCtrlData, 3)
EndIf
EndIf
ElseIf Not $aCtrlData[2] Then
$aCtrlData[2] = 1
_cHvr_CallFunc($aCtrlData, 5)
Local $tTME = DllStructCreate('DWORD;DWORD;HWND;DWORD')
DllStructSetData($tTME, 1, DllStructGetSize($tTME))
DllStructSetData($tTME, 2, 2)
DllStructSetData($tTME, 3, $hWnd)
DllCall('user32.dll', 'BOOL', 'TrackMouseEvent', 'STRUCT*', $tTME)
EndIf
EndFunc
Func _cHvr_cUp(ByRef $aCtrlData, $hWnd, $uMsg, ByRef $wParam, ByRef $lParam)
Local $lRet = _WinAPI_DefSubclassProc($hWnd, $uMsg, $wParam, $lParam)
If(_WinAPI_GetCapture() = $hWnd) Then
_WinAPI_ReleaseCapture()
If _cHvr_IsInClient($hWnd, $lParam) Then
_cHvr_CallFunc($aCtrlData, 9)
EndIf
EndIf
Return $lRet
EndFunc
Func _cHvr_cDblClk(ByRef $aCtrlData, $hWnd, $uMsg, ByRef $wParam, ByRef $lParam)
_cHvr_CallFunc($aCtrlData, 11)
EndFunc
Func _cHvr_cRightClk(ByRef $aCtrlData, $hWnd, $uMsg, ByRef $wParam, ByRef $lParam)
_cHvr_CallFunc($aCtrlData, 7)
EndFunc
Func _cHvr_cLeave(ByRef $aCtrlData, $hWnd, $uMsg, ByRef $wParam, ByRef $lParam)
$aCtrlData[2] = 0
_cHvr_CallFunc($aCtrlData, 3)
EndFunc
Func _cHvr_CallFunc(ByRef $aCtrlData, $iCallType)
Call($aCtrlData[$iCallType], $aCtrlData[1], $aCtrlData[$iCallType + 1])
EndFunc
Func _cHvr_ArrayPush(ByRef $aStackArr, Const $vSrc1 = Default, Const $vSrc2 = Default, Const $vSrc3 = Default, Const $vSrc4 = Default, Const $vSrc5 = Default)
While(UBound($aStackArr) <($aStackArr[0] + @NumParams))
ReDim $aStackArr[UBound($aStackArr) * 2]
WEnd
If Not($vSrc1 = Default) Then
$aStackArr[0] += 1
$aStackArr[$aStackArr[0]] = $vSrc1
EndIf
If Not($vSrc2 = Default) Then
$aStackArr[0] += 1
$aStackArr[$aStackArr[0]] = $vSrc2
EndIf
If Not($vSrc3 = Default) Then
$aStackArr[0] += 1
$aStackArr[$aStackArr[0]] = $vSrc3
EndIf
If Not($vSrc4 = Default) Then
$aStackArr[0] += 1
$aStackArr[$aStackArr[0]] = $vSrc4
EndIf
If Not($vSrc5 = Default) Then
$aStackArr[0] += 1
$aStackArr[$aStackArr[0]] = $vSrc5
EndIf
EndFunc
Func _cHvr_IsInClient($hWnd, $lParam)
Local $iX = BitShift(BitShift($lParam, -16), 16)
Local $iY = BitShift($lParam, 16)
Local $aSize = WinGetClientSize($hWnd)
Return Not($iX < 0 Or $iY < 0 Or $iX > $aSize[0] Or $iY > $aSize[1])
EndFunc
Func _cHvr_CSCP_X86()
Local $sExe = 'align 1;'
Local $aOpCode[100]
$aOpCode[0] = 0
Local $nAddrOffset[5]
Local $nElemOffset[5]
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x55)
_cHvr_ArrayPush($aOpCode, 0x8B, 0xEC)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x53)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0x5D, 16)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x56)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0x75, 12)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x57)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0x7D, 20)
$sExe &= 'BYTE;BYTE;DWORD;'
_cHvr_ArrayPush($aOpCode, 0x81, 0xFE, 0x82)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x74, 0)
$nAddrOffset[0] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[0] = $aOpCode[0]
$sExe &= 'BYTE;BYTE;DWORD;'
_cHvr_ArrayPush($aOpCode, 0x81, 0xFE, 0x2A3)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x74, 0)
$nAddrOffset[1] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[1] = $aOpCode[0]
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8D, 0x86, -0x200)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x83, 0xF8, 3)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x77, 0)
$nAddrOffset[2] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[2] = $aOpCode[0]
$aOpCode[$nElemOffset[0]] = $nAddrOffset[2] - $nAddrOffset[0]
$aOpCode[$nElemOffset[1]] = $nAddrOffset[2] - $nAddrOffset[1]
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0x4D, 28)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0x55, 8)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x51)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x57)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x53)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x56)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x52)
$sExe &= 'BYTE;PTR;'
_cHvr_ArrayPush($aOpCode, 0xB8, $_cHvr_PINTERNALSUBCLASS)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0xFF, 0xD0)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x85, 0xC0)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x74, 0)
$nAddrOffset[3] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[3] = $aOpCode[0]
$aOpCode[$nElemOffset[2]] = $nAddrOffset[3] - $nAddrOffset[2]
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0x45, 8)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x57)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x53)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x56)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x50)
$sExe &= 'BYTE;PTR;'
_cHvr_ArrayPush($aOpCode, 0xB8, $_cHvr_PDEFSUBCLASSPROC)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0xFF, 0xD0)
$nAddrOffset[4] = DllStructGetSize(DllStructCreate($sExe))
$aOpCode[$nElemOffset[3]] = $nAddrOffset[4] - $nAddrOffset[3]
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x5F)
_cHvr_ArrayPush($aOpCode, 0x5E)
_cHvr_ArrayPush($aOpCode, 0x5B)
$sExe &= 'BYTE;BYTE;BYTE;WORD'
_cHvr_ArrayPush($aOpCode, 0x5D)
_cHvr_ArrayPush($aOpCode, 0xC2, 24)
Return _cHvr_PopulateOpcode($sExe, $aOpCode)
EndFunc
Func _cHvr_CSCP_X64()
Local $sExe = 'align 1;'
Local $aOpCode[100]
$aOpCode[0] = 0
Local $nAddrOffset[5]
Local $nElemOffset[5]
$sExe &= 'BYTE;BYTE;DWORD;'
_cHvr_ArrayPush($aOpCode, 0x81, 0xFA, 0x82)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x74, 0)
$nAddrOffset[0] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[0] = $aOpCode[0]
$sExe &= 'BYTE;BYTE;DWORD;'
_cHvr_ArrayPush($aOpCode, 0x81, 0xFA, 0x2A3)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x74, 0)
$nAddrOffset[1] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[1] = $aOpCode[0]
$sExe &= 'BYTE;BYTE;DWORD;'
_cHvr_ArrayPush($aOpCode, 0x8D, 0x82, -0x200)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x83, 0xF8, 3)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x77, 0)
$nAddrOffset[2] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[2] = $aOpCode[0]
$aOpCode[$nElemOffset[0]] = $nAddrOffset[2] - $nAddrOffset[0]
$aOpCode[$nElemOffset[1]] = $nAddrOffset[2] - $nAddrOffset[1]
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x89, 0x5C, 0x24, 8)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x89, 0x6C, 0x24, 16)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x89, 0x74, 0x24, 24)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x57)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x83, 0xEC, 48)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x49, 0x8B, 0xF9)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x49, 0x8B, 0xF0)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0xDA)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x8B, 0xE9)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x8B, 0x44, 0x24, 104)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x89, 0x44, 0x24, 32)
$sExe &= 'BYTE;BYTE;PTR;'
_cHvr_ArrayPush($aOpCode, 0x48, 0xB8, $_cHvr_PINTERNALSUBCLASS)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0xFF, 0xD0)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x85, 0xC0)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x74, 0)
$nAddrOffset[3] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[3] = $aOpCode[0]
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x4C, 0x8B, 0xCF)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x4C, 0x8B, 0xC6)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x8B, 0xD3)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x8B, 0xCD)
$aOpCode[$nElemOffset[3]] = DllStructGetSize(DllStructCreate($sExe)) - $nAddrOffset[3]
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x8B, 0x5C, 0x24, 64)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x8B, 0x6C, 0x24, 72)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x8B, 0x74, 0x24, 80)
$sExe &= 'BYTE;BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x83, 0xc4, 48)
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0x5F)
$sExe &= 'BYTE;BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x48, 0x85, 0xC0)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0x74, 0)
$nAddrOffset[4] = DllStructGetSize(DllStructCreate($sExe))
$nElemOffset[4] = $aOpCode[0]
$aOpCode[$nElemOffset[2]] = DllStructGetSize(DllStructCreate($sExe)) - $nAddrOffset[2]
$sExe &= 'BYTE;BYTE;PTR;'
_cHvr_ArrayPush($aOpCode, 0x48, 0xB8, $_cHvr_PDEFSUBCLASSPROC)
$sExe &= 'BYTE;BYTE;'
_cHvr_ArrayPush($aOpCode, 0xFF, 0xE0)
$aOpCode[$nElemOffset[4]] = DllStructGetSize(DllStructCreate($sExe)) - $nAddrOffset[4]
$sExe &= 'BYTE;'
_cHvr_ArrayPush($aOpCode, 0xC3)
Return _cHvr_PopulateOpcode($sExe, $aOpCode)
EndFunc
Func _cHvr_PopulateOpcode(ByRef $sExe, ByRef $aOpCode)
Local $tExe = DllStructCreate($sExe)
Assert(@error = 0, 'DllStrucCreate Failed With Error = ' & @error)
For $i = 1 To $aOpCode[0]
DllStructSetData($tExe, $i, $aOpCode[$i])
Next
Return $tExe
EndFunc
Func _cHvr_ExecutableFromStruct($tExe)
Local $pExe = DllCall('kernel32.dll', 'PTR', 'HeapAlloc', 'HANDLE', $_cHvr_HEXECUTABLEHEAP, 'DWORD', 8, 'ULONG_PTR', DllStructGetSize($tExe))[0]
Assert($pExe <> 0, 'Allocate memory failed')
DllCall("kernel32.dll", "none", "RtlMoveMemory", "PTR", $pExe, "PTR", DllStructGetPtr($tExe), "ULONG_PTR", DllStructGetSize($tExe))
Assert(@error = 0, 'Failed to copy memory')
Return $pExe
EndFunc
Func _cHvr_UnRegisterInternal($cIndex, $hWnd)
_WinAPI_RemoveWindowSubclass($hWnd, $_cHvr_PSUBCLASSEXE, $hWnd)
Local $aData=$_cHvr_aData[$cIndex]
$_cHvr_aData[$cIndex] = 0
Call( "_iControlDelete",$aData[1])
EndFunc
Func _cHvr_Finalize()
DllCallbackFree($_cHvr_PINTERNALSUBCLASS_DLL)
_WinAPI_FreeLibrary($_cHvr_HDLLCOMCTL32)
If($_cHvr_HEXECUTABLEHEAP <> 0) Then
If($_cHvr_PSUBCLASSEXE <> 0) Then
DllCall('kernel32.dll', 'BOOL', 'HeapFree', 'HANDLE', $_cHvr_HEXECUTABLEHEAP, 'DWORD', 0, 'PTR', $_cHvr_PSUBCLASSEXE)
EndIf
DllCall('kernel32.dll', 'BOOL', 'HeapDestroy', 'HANDLE', $_cHvr_HEXECUTABLEHEAP)
EndIf
EndFunc
Func Assert($bExpression, $sMsg = '', $sScript = @ScriptName, $sScriptPath = @ScriptFullPath, $iLine = @ScriptLineNumber, $iError = @error, $iExtend = @extended)
If(Not($bExpression)) Then
MsgBox(BitOR(1, 0x10), 'Assertion Error!', @CRLF & 'Script' & @TAB & ': ' & $sScript & @CRLF & 'Path' & @TAB & ': ' & $sScriptPath & @CRLF & 'Line' & @TAB & ': ' & $iLine & @CRLF & 'Error' & @TAB & ': ' &($iError > 0x7FFF ? Hex($iError) : $iError) &($iExtend <> 0 ? '  (Extended : ' &($iExtend > 0x7FFF ? Hex($iExtend) : $iExtend) & ')' : '') & @CRLF & 'Message' & @TAB & ': ' & $sMsg & @CRLF & @CRLF & 'OK: Exit Script' & @TAB & 'Cancel: Continue')
Exit
EndIf
EndFunc
Func _cHvr_GetNewIndex($hWnd)
For $i = 0 To UBound($_cHvr_aData) - 1 Step +1
If Not IsArray($_cHvr_aData[$i]) Then
Return $i
EndIf
Next
ReDim $_cHvr_aData[UBound($_cHvr_aData) + 1]
Return UBound($_cHvr_aData) - 1
EndFunc
Func _WinAPI_GetCapture()
Return DllCall("user32.dll", "HWND", "GetCapture")[0]
EndFunc
_GDIPlus_Startup()
Opt("WinWaitDelay", 0)
Global $Font_DPI_Ratio = _GetFontDPI_Ratio()[2], $gDPI = _GDIPlus_GraphicsGetDPIRatio()
Global $iHoverReg[0], $iGUI_LIST[0]
Global $iMsgBoxTimeout = 0
Global $GUI_TOP_MARGIN = Number(29 * $gDPI, 1) + Number(10 * $gDPI, 1)
Global Const $m_hDll = DllCallbackRegister('_iEffectControl', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
Global Const $m_pDll = DllCallbackGetPtr($m_hDll)
OnAutoItExitRegister('_iMExit')
Global Const $bMarg = 4 * $gDPI
Global $HIGHDPI_SUPPORT = False
Global $ControlBtnsAutoMode = True
Global $mOnEventMode = False
If Opt("GUIOnEventMode", 0) Then
Opt("GUIOnEventMode", 1)
$mOnEventMode = True
EndIf
Func _Metro_CreateGUI($Title, $Width, $Height, $Left = -1, $Top = -1, $AllowResize = False, $ParentGUI = "")
Local $GUI_Return
If $HIGHDPI_SUPPORT Then
$Width = Round($Width * $gDPI)
$Height = Round($Height * $gDPI)
EndIf
Local $gID
If $AllowResize Then
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$GUI_Return = GUICreate($Title, $Width, $Height, $Left, $Top, BitOR($WS_SIZEBOX, $WS_MINIMIZEBOX, $WS_MAXIMIZEBOX), -1, $ParentGUI)
$gID = _Metro_SetGUIOption($GUI_Return, True, True, $Width, $Height)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Else
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$GUI_Return = GUICreate($Title, $Width, $Height, $Left, $Top, -1, -1, $ParentGUI)
$gID = _Metro_SetGUIOption($GUI_Return, False, False, $Width, $Height)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
EndIf
_WinAPI_SetWindowSubclass($GUI_Return, $m_pDll, 1010, $gID)
WinMove($GUI_Return, "", Default, Default, $Width, $Height)
If Not $ParentGUI Then
Local $Center_GUI = _GetDesktopWorkArea($GUI_Return)
If($Left = -1) And($Top = -1) Then
WinMove($GUI_Return, "",($Center_GUI[2] - $Width) / 2,($Center_GUI[3] - $Height) / 2, $Width, $Height)
EndIf
Else
If($Left = -1) And($Top = -1) Then
Local $GUI_NewPos = _WinPos($ParentGUI, $Width, $Height)
WinMove($GUI_Return, "", $GUI_NewPos[0], $GUI_NewPos[1], $Width, $Height)
EndIf
EndIf
GUISetBkColor($GUIThemeColor)
_CreateBorder($GUI_Return, $Width, $Height, $GUIBorderColor)
Return($GUI_Return)
EndFunc
Func _Metro_SetGUIOption($mGUI, $AllowDragMove = False, $AllowResize = False, $Win_MinWidth = "", $Win_MinHeight = "")
Local $iGui_Count
For $iGUIs = 0 To UBound($iGUI_LIST) - 1 Step +1
If $iGUI_LIST[$iGUIs][0] = $mGUI Then
$iGui_Count = $iGUIs
ExitLoop
EndIf
Next
If($iGui_Count == "") Then
$iGui_Count = UBound($iGUI_LIST)
ReDim $iGUI_LIST[$iGui_Count + 1][16]
EndIf
$iGUI_LIST[$iGui_Count][0] = $mGUI
$iGUI_LIST[$iGui_Count][1] = $AllowDragMove
$iGUI_LIST[$iGui_Count][2] = $AllowResize
If $AllowResize Then
If $Win_MinWidth = "" Then
$Win_MinWidth = WinGetPos($mGUI, "")
If @error Then
$Win_MinWidth = 80 * $gDPI
Else
$Win_MinWidth = $Win_MinWidth[2]
EndIf
EndIf
If $Win_MinHeight = "" Then
$Win_MinHeight = WinGetPos($mGUI, "")
If @error Then
$Win_MinHeight = 50 * $gDPI
Else
$Win_MinHeight = $Win_MinHeight[3]
EndIf
EndIf
$iGUI_LIST[$iGui_Count][3] = $Win_MinWidth
$iGUI_LIST[$iGui_Count][4] = $Win_MinHeight
EndIf
Return $iGui_Count
EndFunc
Func _Metro_GUIDelete($GUI)
GUISetState(@SW_HIDE, $GUI)
_WinAPI_RemoveWindowSubclass($GUI, $m_pDll, 1010)
GUIDelete($GUI)
Local $CLEANED_GUI_LIST[0]
For $i_HR = 0 To UBound($iGUI_LIST) - 1 Step +1
If $iGUI_LIST[$i_HR][0] <> $GUI Then
ReDim $CLEANED_GUI_LIST[UBound($CLEANED_GUI_LIST) + 1][16]
For $i_Hx = 0 To 11 Step +1
$CLEANED_GUI_LIST[UBound($CLEANED_GUI_LIST) - 1][$i_Hx] = $iGUI_LIST[$i_HR][$i_Hx]
Next
EndIf
Next
$iGUI_LIST = $CLEANED_GUI_LIST
EndFunc
Func _iControlDelete($hControl)
For $i = 0 To UBound($iHoverReg) - 1
If $iHoverReg[$i][0] = $hControl Then
Switch($iHoverReg[$i][3])
Case "5", "7"
_WinAPI_DeleteObject($iHoverReg[$i][5])
_WinAPI_DeleteObject($iHoverReg[$i][6])
_WinAPI_DeleteObject($iHoverReg[$i][7])
_WinAPI_DeleteObject($iHoverReg[$i][8])
Case "6"
_WinAPI_DeleteObject($iHoverReg[$i][5])
_WinAPI_DeleteObject($iHoverReg[$i][6])
_WinAPI_DeleteObject($iHoverReg[$i][7])
_WinAPI_DeleteObject($iHoverReg[$i][8])
_WinAPI_DeleteObject($iHoverReg[$i][9])
_WinAPI_DeleteObject($iHoverReg[$i][10])
_WinAPI_DeleteObject($iHoverReg[$i][11])
_WinAPI_DeleteObject($iHoverReg[$i][12])
_WinAPI_DeleteObject($iHoverReg[$i][13])
_WinAPI_DeleteObject($iHoverReg[$i][14])
Case Else
_WinAPI_DeleteObject($iHoverReg[$i][5])
_WinAPI_DeleteObject($iHoverReg[$i][6])
EndSwitch
For $i2 = 0 To UBound($iHoverReg, 2) - 1
$iHoverReg[$i][$i2] = ""
Next
ExitLoop
EndIf
Next
EndFunc
Func _Metro_AddControlButtons($CloseBtn = True, $MaximizeBtn = True, $MinimizeBtn = True, $FullScreenBtn = False, $MenuBtn = False, $GUI_BG_Color = $GUIThemeColor, $GUI_Font_Color = $FontThemeColor, $tMargin = 2)
Local $ButtonsToCreate_Array[5]
$ButtonsToCreate_Array[0] = $CloseBtn
$ButtonsToCreate_Array[1] = $MaximizeBtn
$ButtonsToCreate_Array[2] = $MinimizeBtn
$ButtonsToCreate_Array[3] = $FullScreenBtn
$ButtonsToCreate_Array[4] = $MenuBtn
$GUI_BG_Color = "0xFF" & Hex($GUI_BG_Color, 6)
$GUI_Font_Color = "0xFF" & Hex($GUI_Font_Color, 6)
Return _iCreateControlButtons($ButtonsToCreate_Array, $GUI_BG_Color, $GUI_Font_Color, False, $tMargin)
EndFunc
Func _Metro_EnableHighDPIScaling($Enable = True)
$HIGHDPI_SUPPORT = $Enable
EndFunc
Func _Metro_FullscreenToggle($mGUI)
GUISetState(@SW_SHOW, $mGUI)
Local $iGui_Count = _iGetGUIID($mGUI)
If($iGui_Count == "") Then
ConsoleWrite("Fullscreen-Toggle failed: GUI not registered. Not created with _Metro_CreateGUI ?" & @CRLF)
Return SetError(1)
EndIf
If Not $iGUI_LIST[$iGui_Count][2] Then
ConsoleWrite("Fullscreen-Toggle failed: GUI is not registered for resizing. Please use _Metro_SetGUIOption to enable resizing." & @CRLF)
Return SetError(2)
EndIf
Local $mWin_State = WinGetState($mGUI)
Local $tRET = _WinAPI_GetWindowPlacement($mGUI)
Local $FullScreenPOS = _GetDesktopWorkArea($mGUI, True)
Local $CurrentPos = WinGetPos($mGUI)
Local $MaxBtn = _iGetCtrlHandlebyType("3", $mGUI)
Local $RestoreBtn = _iGetCtrlHandlebyType("4", $mGUI)
Local $FullScreenBtn = _iGetCtrlHandlebyType("9", $mGUI)
Local $FullscreenRsBtn = _iGetCtrlHandlebyType("10", $mGUI)
If $iGUI_LIST[$iGui_Count][11] Then
$iGUI_LIST[$iGui_Count][11] = False
If(BitAND($iGUI_LIST[$iGui_Count][9], 32) = 32) Then
GUISetState(@SW_MAXIMIZE)
$tRET = $iGUI_LIST[$iGui_Count][10]
DllStructSetData($tRET, "rcNormalPosition", $iGUI_LIST[$iGui_Count][5], 1)
DllStructSetData($tRET, "rcNormalPosition", $iGUI_LIST[$iGui_Count][6], 2)
DllStructSetData($tRET, "rcNormalPosition", $iGUI_LIST[$iGui_Count][7], 3)
DllStructSetData($tRET, "rcNormalPosition", $iGUI_LIST[$iGui_Count][8], 4)
_WinAPI_SetWindowPlacement($mGUI, $tRET)
If $MaxBtn Then
GUICtrlSetState($MaxBtn, 32)
GUICtrlSetState($RestoreBtn, 16)
EndIf
Else
WinMove($mGUI, "", $iGUI_LIST[$iGui_Count][5], $iGUI_LIST[$iGui_Count][6], $iGUI_LIST[$iGui_Count][7], $iGUI_LIST[$iGui_Count][8])
If $MaxBtn Then
GUICtrlSetState($RestoreBtn, 32)
GUICtrlSetState($MaxBtn, 16)
EndIf
EndIf
GUICtrlSetState($FullscreenRsBtn, 32)
GUICtrlSetState($FullScreenBtn, 16)
Else
If(BitAND($mWin_State, 32) = 32) Then
$CurrentPos[0] = DllStructGetData($tRET, "rcNormalPosition", 1)
$CurrentPos[1] = DllStructGetData($tRET, "rcNormalPosition", 2)
$CurrentPos[2] = DllStructGetData($tRET, "rcNormalPosition", 3)
$CurrentPos[3] = DllStructGetData($tRET, "rcNormalPosition", 4)
DllStructSetData($tRET, "rcNormalPosition", $FullScreenPOS[0], 1)
DllStructSetData($tRET, "rcNormalPosition", $FullScreenPOS[1], 2)
DllStructSetData($tRET, "rcNormalPosition", $FullScreenPOS[0] + $FullScreenPOS[2], 3)
DllStructSetData($tRET, "rcNormalPosition", $FullScreenPOS[1] + $FullScreenPOS[3], 4)
_WinAPI_SetWindowPlacement($mGUI, $tRET)
Sleep(50)
$iGUI_LIST[$iGui_Count][10] = $tRET
GUISetState(@SW_RESTORE)
Else
Sleep(50)
WinMove($mGUI, "", $FullScreenPOS[0], $FullScreenPOS[1], $FullScreenPOS[2], $FullScreenPOS[3])
EndIf
$iGUI_LIST[$iGui_Count][11] = True
GUICtrlSetState($FullScreenBtn, 32)
If $MaxBtn Then
GUICtrlSetState($MaxBtn, 32)
GUICtrlSetState($RestoreBtn, 32)
EndIf
GUICtrlSetState($FullscreenRsBtn, 16)
$iGUI_LIST[$iGui_Count][5] = $CurrentPos[0]
$iGUI_LIST[$iGui_Count][6] = $CurrentPos[1]
$iGUI_LIST[$iGui_Count][7] = $CurrentPos[2]
$iGUI_LIST[$iGui_Count][8] = $CurrentPos[3]
$iGUI_LIST[$iGui_Count][9] = $mWin_State
WinActivate("[CLASS:Shell_TrayWnd]")
WinActivate($mGUI)
EndIf
EndFunc
Func _Metro_AddControlButton_Back($GUI_BG_Color = $GUIThemeColor, $GUI_Font_Color = $FontThemeColor, $tMargin = 2)
Local $cbDPI = _HighDPICheck()
Local $CurrentGUI = GetCurrentGUI()
$GUI_BG_Color = "0xFF" & Hex($GUI_BG_Color, 6)
$GUI_Font_Color = "0xFF" & Hex($GUI_Font_Color, 6)
If StringInStr($GUI_Theme_Name, "Light") Then
Local $Hover_BK_Color = StringReplace(_AlterBrightness($GUI_BG_Color, -20), "0x", "0xFF")
Else
Local $Hover_BK_Color = StringReplace(_AlterBrightness($GUI_BG_Color, +20), "0x", "0xFF")
EndIf
Local $FrameSize = Round(1 * $cbDPI)
Local $hPen = _GDIPlus_PenCreate($GUI_Font_Color, Round(1 * $cbDPI))
If StringInStr($GUI_Theme_Name, "Light") Then
Local $hPen1 = _GDIPlus_PenCreate(StringReplace(_AlterBrightness($GUI_Font_Color, +60), "0x", "0xFF"), Round(1 * $cbDPI))
Else
Local $hPen1 = _GDIPlus_PenCreate(StringReplace(_AlterBrightness($GUI_Font_Color, -80), "0x", "0xFF"), Round(1 * $cbDPI))
EndIf
_GDIPlus_PenSetStartCap($hPen, 0x03)
_GDIPlus_PenSetStartCap($hPen1, 0x03)
Local $Control_Button_Array[16]
Local $CBw = Number(45 * $cbDPI, 1)
Local $CBh = Number(29 * $cbDPI, 1)
Local $cMarginR = Number($tMargin * $cbDPI, 1)
$Control_Button_Array[1] = False
$Control_Button_Array[2] = False
$Control_Button_Array[3] = "0"
$Control_Button_Array[15] = GetCurrentGUI()
Local $Control_Button_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
Local $Control_Button_Graphic2 = _iGraphicCreate($CBw, $CBh, $Hover_BK_Color, 0, 4)
Local $Control_Button_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
Local $mpX = $CBw / 2.95, $mpY = $CBh / 2.1
Local $apos1 = cAngle($mpX, $mpY, 135, 12 * $cbDPI)
Local $apos2 = cAngle($mpX, $mpY, 45, 12 * $cbDPI)
_GDIPlus_GraphicsDrawLine($Control_Button_Graphic1[0], $mpX, $mpY, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Control_Button_Graphic1[0], $mpX, $mpY, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Control_Button_Graphic2[0], $mpX, $mpY, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Control_Button_Graphic2[0], $mpX, $mpY, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Control_Button_Graphic3[0], $mpX, $mpY, $apos1[0], $apos1[1], $hPen1)
_GDIPlus_GraphicsDrawLine($Control_Button_Graphic3[0], $mpX, $mpY, $apos2[0], $apos2[1], $hPen1)
_GDIPlus_PenDispose($hPen)
_GDIPlus_PenDispose($hPen1)
$Control_Button_Array[0] = GUICtrlCreatePic("", $cMarginR, $cMarginR, $CBw, $CBh)
$Control_Button_Array[5] = _iGraphicCreateBitmapHandle($Control_Button_Array[0], $Control_Button_Graphic1)
$Control_Button_Array[6] = _iGraphicCreateBitmapHandle($Control_Button_Array[0], $Control_Button_Graphic2, False)
$Control_Button_Array[7] = _iGraphicCreateBitmapHandle($Control_Button_Array[0], $Control_Button_Graphic3, False)
GUICtrlSetResizing($Control_Button_Array[0], 768 + 32 + 2)
_cHvr_Register($Control_Button_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Control_Button_Array), $CurrentGUI)
Return $Control_Button_Array[0]
EndFunc
Func _Metro_MenuStart($mGUI, $mWidth, $ButtonsArray, $bFont = "Segoe UI", $bFontSize = 9, $bFontStyle = 0)
Local $Metro_MenuBtn = _iGetCtrlHandlebyType("8", $mGUI)
If Not $Metro_MenuBtn Then Return SetError(1)
GUICtrlSetState($Metro_MenuBtn, 128)
Local $iButtonsArray[UBound($ButtonsArray)]
Local $cbDPI = _HighDPICheck()
Local $blockclose = True
Local $mPos = WinGetPos($mGUI)
Local $cMarginR = Number(2 * $cbDPI, 1)
Local $CBh = Number(29 * $cbDPI, 1)
Local $mGuiHeight = $mPos[3] -($cMarginR * 2) - $CBh
Local $mGuiWidth = $mWidth * $cbDPI
Local $mGuiX = $mPos[0] + $cMarginR, $mGuiY = $mPos[1] + $cMarginR + $CBh
Local $AnimStep = $mGuiWidth / 10, $mGuiWidthAnim = $AnimStep
Local $MenuForm = GUICreate("", $mGuiWidthAnim, $mGuiHeight, $mGuiX, $mGuiY, $WS_POPUP, $WS_EX_MDICHILD, $mGUI)
Local $ButtonStep =(30 * $cbDPI)
If StringInStr($GUI_Theme_Name, "Light") Then
GUISetBkColor(_AlterBrightness($GUIThemeColor, -10), $MenuForm)
Else
GUISetBkColor(_AlterBrightness($GUIThemeColor, +10), $MenuForm)
EndIf
For $iB = 0 To UBound($ButtonsArray) - 1 Step +1
$iButtonsArray[$iB] = _iCreateMButton($ButtonsArray[$iB], 0, $ButtonStep * $iB +($iB * 2), $mGuiWidth - $cMarginR, 30 * $cbDPI, $GUIThemeColor, $FontThemeColor, $bFont, $bFontSize, $bFontStyle)
Next
GUISetState(@SW_SHOW, $MenuForm)
For $i = 0 To 8 Step +1
$mGuiWidthAnim = $mGuiWidthAnim + $AnimStep
WinMove($MenuForm, "", $mGuiX, $mGuiY, $mGuiWidthAnim, $mGuiHeight)
Sleep(1)
Next
If $mOnEventMode Then Opt("GUIOnEventMode", 0)
While 1
If Not $blockclose Then
If Not WinActive($MenuForm) Then
$mPos = WinGetPos($mGUI)
$mGuiX = $mPos[0] + $cMarginR
$mGuiY = $mPos[1] + $cMarginR + $CBh
For $i = 0 To 8 Step +1
$mGuiWidthAnim = $mGuiWidthAnim - $AnimStep
WinMove($MenuForm, "", $mGuiX, $mGuiY, $mGuiWidthAnim, $mGuiHeight)
Sleep(1)
Next
GUIDelete($MenuForm)
If $mOnEventMode Then Opt("GUIOnEventMode", 1)
GUICtrlSetState($Metro_MenuBtn, 64)
Return SetError(1, 0, "none")
EndIf
Else
$blockclose = False
EndIf
Local $imsg = GUIGetMsg()
For $iB = 0 To UBound($iButtonsArray) - 1 Step +1
If $imsg = $iButtonsArray[$iB] Then
$mPos = WinGetPos($mGUI)
$mGuiX = $mPos[0] + $cMarginR
$mGuiY = $mPos[1] + $cMarginR + $CBh
For $if = 0 To 8 Step +2
$mGuiWidthAnim = $mGuiWidthAnim - $AnimStep
WinMove($MenuForm, "", $mGuiX, $mGuiY, $mGuiWidthAnim, $mGuiHeight)
Sleep(1)
Next
GUIDelete($MenuForm)
If $mOnEventMode Then Opt("GUIOnEventMode", 1)
GUICtrlSetState($Metro_MenuBtn, 64)
Return $iB
EndIf
Next
WEnd
EndFunc
Func _iCreateMButton($Text, $Left, $Top, $Width, $Height, $BG_Color = $GUIThemeColor, $Font_Color = $FontThemeColor, $Font = "Arial", $Fontsize = 9, $FontStyle = 1)
Local $Button_Array[16]
If Not $HIGHDPI_SUPPORT Then
$Fontsize =($Fontsize / $Font_DPI_Ratio)
EndIf
$Button_Array[1] = False
$Button_Array[3] = "2"
$Button_Array[15] = GetCurrentGUI()
$BG_Color = StringReplace($BG_Color, "0x", "0xFF")
$Font_Color = StringReplace($Font_Color, "0x", "0xFF")
Local $Brush_BTN_FontColor = _GDIPlus_BrushCreateSolid($Font_Color)
If StringInStr($GUI_Theme_Name, "Light") Then
Local $BG_ColorD = StringReplace(_AlterBrightness($GUIThemeColor, -12), "0x", "0xFF")
$BG_Color = StringReplace(_AlterBrightness($GUIThemeColor, -25), "0x", "0xFF")
Else
Local $BG_ColorD = StringReplace(_AlterBrightness($GUIThemeColor, +12), "0x", "0xFF")
$BG_Color = StringReplace(_AlterBrightness($GUIThemeColor, +25), "0x", "0xFF")
EndIf
Local $Button_Graphic1 = _iGraphicCreate($Width, $Height, $BG_ColorD, 0, 5)
Local $Button_Graphic2 = _iGraphicCreate($Width, $Height, $BG_Color, 0, 5)
Local $hFormat = _GDIPlus_StringFormatCreate(), $hFamily = _GDIPlus_FontFamilyCreate($Font), $hFont = _GDIPlus_FontCreate($hFamily, $Fontsize, $FontStyle)
Local $tLayout = _GDIPlus_RectFCreate(0, 0, $Width, $Height)
_GDIPlus_StringFormatSetAlign($hFormat, 1)
_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic1[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic2[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_FontDispose($hFont)
_GDIPlus_FontFamilyDispose($hFamily)
_GDIPlus_StringFormatDispose($hFormat)
_GDIPlus_BrushDispose($Brush_BTN_FontColor)
$Button_Array[0] = GUICtrlCreatePic("", $Left, $Top, $Width, $Height)
$Button_Array[5] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic1)
$Button_Array[6] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic2, False)
GUICtrlSetResizing($Button_Array[0], 802)
_cHvr_Register($Button_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Button_Array))
Return $Button_Array[0]
EndFunc
Func _iCreateControlButtons($ButtonsToCreate_Array, $GUI_BG_Color = $GUIThemeColor, $GUI_Font_Color = "0xFFFFFF", $CloseButtonOnStyle = False, $tMargin = 2)
Local $cbDPI = _HighDPICheck()
Local $FrameSize = Round(1 * $cbDPI), $Hover_BK_Color
If StringInStr($GUI_Theme_Name, "Light") Then
$Hover_BK_Color = StringReplace(_AlterBrightness($GUI_BG_Color, -20), "0x", "0xFF")
Else
$Hover_BK_Color = StringReplace(_AlterBrightness($GUI_BG_Color, +20), "0x", "0xFF")
EndIf
Local $hPen = _GDIPlus_PenCreate($GUI_Font_Color, Round(1 * $cbDPI))
Local $hPen2 = _GDIPlus_PenCreate($GUI_Font_Color, Round(1 * $cbDPI))
Local $hPen3 = _GDIPlus_PenCreate("0xFFFFFFFF", Round(1 * $cbDPI))
If StringInStr($GUI_Theme_Name, "Light") Then
Local $hPen4 = _GDIPlus_PenCreate(StringReplace(_AlterBrightness($GUI_Font_Color, +90), "0x", "0xFF"), $FrameSize)
Else
Local $hPen4 = _GDIPlus_PenCreate(StringReplace(_AlterBrightness($GUI_Font_Color, -80), "0x", "0xFF"), $FrameSize)
EndIf
Local $hPen5 = _GDIPlus_PenCreate(StringReplace(_AlterBrightness("0xFFFFFF", -80), "0x", "0xFF"), $FrameSize)
If $GUI_BG_Color <> 0 Then
$GUI_BG_Color = "0xFF" & Hex($GUI_BG_Color, 6)
EndIf
Local $hBrush = _GDIPlus_BrushCreateSolid($GUI_BG_Color), $hBrush2 = _GDIPlus_BrushCreateSolid($Hover_BK_Color)
Local $Control_Buttons[16]
Local $Button_Close_Array[16]
Local $Button_Minimize_Array[16]
Local $Button_Maximize_Array[16]
Local $Button_Restore_Array[16]
Local $Button_Menu_Array[16]
Local $Button_FullScreen_Array[16]
Local $Button_FSRestore_Array[16]
Local $CBw = Number(45 * $cbDPI, 1)
Local $CBh = Number(29 * $cbDPI, 1)
Local $cMarginR = Number($tMargin * $cbDPI, 1)
Local $CurrentGUI = GetCurrentGUI()
Local $Win_POS = WinGetPos($CurrentGUI)
Local $PosCount = 0
If $ButtonsToCreate_Array[0] Then
$PosCount = $PosCount + 1
$Button_Close_Array[0] = GUICtrlCreatePic("", $Win_POS[2] - $cMarginR -($CBw * $PosCount), $cMarginR, $CBw, $CBh)
$Button_Close_Array[1] = False
$Button_Close_Array[2] = False
$Button_Close_Array[3] = "0"
$Button_Close_Array[15] = $CurrentGUI
EndIf
If $ButtonsToCreate_Array[1] Then
$PosCount = $PosCount + 1
$Button_Maximize_Array[0] = GUICtrlCreatePic("", $Win_POS[2] - $cMarginR -($CBw * $PosCount), $cMarginR, $CBw, $CBh)
$Button_Maximize_Array[1] = False
$Button_Maximize_Array[2] = False
$Button_Maximize_Array[3] = "3"
$Button_Maximize_Array[8] = True
$Button_Maximize_Array[15] = $CurrentGUI
$Button_Restore_Array[0] = GUICtrlCreatePic("", $Win_POS[2] - $cMarginR -($CBw * $PosCount), $cMarginR, $CBw, $CBh)
$Button_Restore_Array[1] = False
$Button_Restore_Array[2] = False
$Button_Restore_Array[3] = "4"
$Button_Restore_Array[8] = True
$Button_Restore_Array[15] = $CurrentGUI
If $ButtonsToCreate_Array[3] Then
$Button_FSRestore_Array[0] = GUICtrlCreatePic("", $Win_POS[2] - $cMarginR -($CBw * $PosCount), $cMarginR, $CBw, $CBh)
$Button_FSRestore_Array[1] = False
$Button_FSRestore_Array[2] = False
$Button_FSRestore_Array[3] = "10"
$Button_FSRestore_Array[15] = $CurrentGUI
EndIf
EndIf
If $ButtonsToCreate_Array[2] Then
$PosCount = $PosCount + 1
$Button_Minimize_Array[0] = GUICtrlCreatePic("", $Win_POS[2] - $cMarginR -($CBw * $PosCount), $cMarginR, $CBw, $CBh)
$Button_Minimize_Array[1] = False
$Button_Minimize_Array[2] = False
$Button_Minimize_Array[3] = "0"
$Button_Minimize_Array[15] = $CurrentGUI
EndIf
If $ButtonsToCreate_Array[3] Then
$PosCount = $PosCount + 1
$Button_FullScreen_Array[0] = GUICtrlCreatePic("", $Win_POS[2] - $cMarginR -($CBw * $PosCount), $cMarginR, $CBw, $CBh)
$Button_FullScreen_Array[1] = False
$Button_FullScreen_Array[2] = False
$Button_FullScreen_Array[3] = "9"
$Button_FullScreen_Array[15] = $CurrentGUI
If $Button_FSRestore_Array[15] <> $CurrentGUI Then
$Button_FSRestore_Array[0] = GUICtrlCreatePic("", $Win_POS[2] - $cMarginR -($CBw * $PosCount), $cMarginR, $CBw, $CBh)
$Button_FSRestore_Array[1] = False
$Button_FSRestore_Array[2] = False
$Button_FSRestore_Array[3] = "10"
$Button_FSRestore_Array[15] = $CurrentGUI
EndIf
EndIf
If $ButtonsToCreate_Array[4] Then
$Button_Menu_Array[0] = GUICtrlCreatePic("", $cMarginR, $cMarginR, $CBw, $CBh)
$Button_Menu_Array[1] = False
$Button_Menu_Array[2] = False
$Button_Menu_Array[3] = "8"
$Button_Menu_Array[15] = $CurrentGUI
EndIf
If $ButtonsToCreate_Array[0] Then
Local $Button_Close_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 4, 4), $Button_Close_Graphic2 = _iGraphicCreate($CBw, $CBh, "0xFFE81123", 4, 4), $Button_Close_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 4, 4)
EndIf
If $ButtonsToCreate_Array[1] Then
Local $Button_Maximize_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4), $Button_Maximize_Graphic2 = _iGraphicCreate($CBw, $CBh, $Hover_BK_Color, 0, 4), $Button_Maximize_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
Local $Button_Restore_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4), $Button_Restore_Graphic2 = _iGraphicCreate($CBw, $CBh, $Hover_BK_Color, 0, 4), $Button_Restore_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
EndIf
If $ButtonsToCreate_Array[2] Then
Local $Button_Minimize_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4), $Button_Minimize_Graphic2 = _iGraphicCreate($CBw, $CBh, $Hover_BK_Color, 0, 4), $Button_Minimize_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
EndIf
If $ButtonsToCreate_Array[3] Then
Local $Button_FullScreen_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4), $Button_FullScreen_Graphic2 = _iGraphicCreate($CBw, $CBh, $Hover_BK_Color, 0, 4), $Button_FullScreen_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
Local $Button_FSRestore_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4), $Button_FSRestore_Graphic2 = _iGraphicCreate($CBw, $CBh, $Hover_BK_Color, 0, 4), $Button_FSRestore_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
EndIf
If $ButtonsToCreate_Array[4] Then
Local $Button_Menu_Graphic1 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4), $Button_Menu_Graphic2 = _iGraphicCreate($CBw, $CBh, $Hover_BK_Color, 0, 4), $Button_Menu_Graphic3 = _iGraphicCreate($CBw, $CBh, $GUI_BG_Color, 0, 4)
EndIf
If $CloseButtonOnStyle Then
_GDIPlus_GraphicsClear($Button_Close_Graphic1[0], "0xFFB52231")
_GDIPlus_GraphicsClear($Button_Close_Graphic3[0], "0xFFB52231")
EndIf
If $ButtonsToCreate_Array[0] Then
If $CloseButtonOnStyle Then
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic1[0], 17 * $cbDPI, 9 * $cbDPI, 27 * $cbDPI, 19 * $cbDPI, $hPen3)
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic1[0], 27 * $cbDPI, 9 * $cbDPI, 17 * $cbDPI, 19 * $cbDPI, $hPen3)
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic3[0], 17 * $cbDPI, 9 * $cbDPI, 27 * $cbDPI, 19 * $cbDPI, $hPen5)
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic3[0], 27 * $cbDPI, 9 * $cbDPI, 17 * $cbDPI, 19 * $cbDPI, $hPen5)
Else
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic1[0], 17 * $cbDPI, 9 * $cbDPI, 27 * $cbDPI, 19 * $cbDPI, $hPen)
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic1[0], 27 * $cbDPI, 9 * $cbDPI, 17 * $cbDPI, 19 * $cbDPI, $hPen)
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic3[0], 17 * $cbDPI, 9 * $cbDPI, 27 * $cbDPI, 19 * $cbDPI, $hPen4)
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic3[0], 27 * $cbDPI, 9 * $cbDPI, 17 * $cbDPI, 19 * $cbDPI, $hPen4)
EndIf
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic2[0], 17 * $cbDPI, 9 * $cbDPI, 27 * $cbDPI, 19 * $cbDPI, $hPen3)
_GDIPlus_GraphicsDrawLine($Button_Close_Graphic2[0], 27 * $cbDPI, 9 * $cbDPI, 17 * $cbDPI, 19 * $cbDPI, $hPen3)
EndIf
If $ButtonsToCreate_Array[1] Then
_GDIPlus_GraphicsDrawRect($Button_Maximize_Graphic1[0], Round(17 * $cbDPI), 9 * $cbDPI, 9 * $cbDPI, 9 * $cbDPI, $hPen)
_GDIPlus_GraphicsDrawRect($Button_Maximize_Graphic2[0], Round(17 * $cbDPI), 9 * $cbDPI, 9 * $cbDPI, 9 * $cbDPI, $hPen2)
_GDIPlus_GraphicsDrawRect($Button_Maximize_Graphic3[0], Round(17 * $cbDPI), 9 * $cbDPI, 9 * $cbDPI, 9 * $cbDPI, $hPen4)
Local $kWH = Round(7 * $cbDPI), $resmargin = Round(2 * $cbDPI)
_GDIPlus_GraphicsDrawRect($Button_Restore_Graphic1[0], Round(17 * $cbDPI) + $resmargin,(11 * $cbDPI) - $resmargin, $kWH, $kWH, $hPen)
_GDIPlus_GraphicsFillRect($Button_Restore_Graphic1[0], Round(17 * $cbDPI), 11 * $cbDPI, $kWH, $kWH, $hBrush)
_GDIPlus_GraphicsDrawRect($Button_Restore_Graphic1[0], Round(17 * $cbDPI), 11 * $cbDPI, $kWH, $kWH, $hPen)
_GDIPlus_GraphicsDrawRect($Button_Restore_Graphic2[0], Round(17 * $cbDPI) + $resmargin,(11 * $cbDPI) - $resmargin, $kWH, $kWH, $hPen2)
_GDIPlus_GraphicsFillRect($Button_Restore_Graphic2[0], Round(17 * $cbDPI), 11 * $cbDPI, $kWH, $kWH, $hBrush2)
_GDIPlus_GraphicsDrawRect($Button_Restore_Graphic2[0], Round(17 * $cbDPI), 11 * $cbDPI, $kWH, $kWH, $hPen2)
_GDIPlus_GraphicsDrawRect($Button_Restore_Graphic3[0], Round(17 * $cbDPI) + $resmargin,(11 * $cbDPI) - $resmargin, $kWH, $kWH, $hPen4)
_GDIPlus_GraphicsFillRect($Button_Restore_Graphic3[0], Round(17 * $cbDPI), 11 * $cbDPI, $kWH, $kWH, $hBrush)
_GDIPlus_GraphicsDrawRect($Button_Restore_Graphic3[0], Round(17 * $cbDPI), 11 * $cbDPI, $kWH, $kWH, $hPen4)
EndIf
If $ButtonsToCreate_Array[2] Then
_GDIPlus_GraphicsDrawLine($Button_Minimize_Graphic1[0], 18 * $cbDPI, 14 * $cbDPI, 27 * $cbDPI, 14 * $cbDPI, $hPen)
_GDIPlus_GraphicsDrawLine($Button_Minimize_Graphic2[0], 18 * $cbDPI, 14 * $cbDPI, 27 * $cbDPI, 14 * $cbDPI, $hPen2)
_GDIPlus_GraphicsDrawLine($Button_Minimize_Graphic3[0], 18 * $cbDPI, 14 * $cbDPI, 27 * $cbDPI, 14 * $cbDPI, $hPen4)
EndIf
If $ButtonsToCreate_Array[3] Then
Local $Cutpoint =($FrameSize * 0.3)
Local $LowerLinePos[2], $UpperLinePos
$LowerLinePos[0] = Round($CBw / 2.9)
$LowerLinePos[1] = Round($CBh / 1.5)
$UpperLinePos = cAngle($LowerLinePos[0], $LowerLinePos[1], 135, $CBw / 2.5)
$UpperLinePos[0] = Round($UpperLinePos[0])
$UpperLinePos[1] = Round($UpperLinePos[1])
Local $apos1 = cAngle($LowerLinePos[0] + $Cutpoint, $LowerLinePos[1] + $Cutpoint, 180, 5 * $cbDPI)
Local $apos2 = cAngle($LowerLinePos[0] - $Cutpoint, $LowerLinePos[1] - $Cutpoint, 90, 5 * $cbDPI)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic1[0], $LowerLinePos[0] + $Cutpoint, $LowerLinePos[1] + $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic1[0], $LowerLinePos[0] - $Cutpoint, $LowerLinePos[1] - $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic2[0], $LowerLinePos[0] + $Cutpoint, $LowerLinePos[1] + $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic2[0], $LowerLinePos[0] - $Cutpoint, $LowerLinePos[1] - $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic3[0], $LowerLinePos[0] + $Cutpoint, $LowerLinePos[1] + $Cutpoint, $apos1[0], $apos1[1], $hPen4)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic3[0], $LowerLinePos[0] - $Cutpoint, $LowerLinePos[1] - $Cutpoint, $apos2[0], $apos2[1], $hPen4)
$apos1 = cAngle($UpperLinePos[0] + $Cutpoint, $UpperLinePos[1] + $Cutpoint, 270, 5 * $cbDPI)
$apos2 = cAngle($UpperLinePos[0] - $Cutpoint, $UpperLinePos[1] - $Cutpoint, 0, 5 * $cbDPI)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic1[0], $UpperLinePos[0] + $Cutpoint, $UpperLinePos[1] + $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic1[0], $UpperLinePos[0] - $Cutpoint, $UpperLinePos[1] - $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic2[0], $UpperLinePos[0] + $Cutpoint, $UpperLinePos[1] + $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic2[0], $UpperLinePos[0] - $Cutpoint, $UpperLinePos[1] - $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic3[0], $UpperLinePos[0] + $Cutpoint, $UpperLinePos[1] + $Cutpoint, $apos1[0], $apos1[1], $hPen4)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic3[0], $UpperLinePos[0] - $Cutpoint, $UpperLinePos[1] - $Cutpoint, $apos2[0], $apos2[1], $hPen4)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic1[0], $LowerLinePos[0] + $Cutpoint, $LowerLinePos[1] - $Cutpoint, $UpperLinePos[0], $UpperLinePos[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic2[0], $LowerLinePos[0] + $Cutpoint, $LowerLinePos[1] - $Cutpoint, $UpperLinePos[0], $UpperLinePos[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FullScreen_Graphic3[0], $LowerLinePos[0] + $Cutpoint, $LowerLinePos[1] - $Cutpoint, $UpperLinePos[0], $UpperLinePos[1], $hPen4)
$Cutpoint =($FrameSize * 0.3)
Local $mpX = Round($CBw / 2, 0), $mpY = Round($CBh / 2.35, 0)
$apos1 = cAngle($mpX - $Cutpoint, $mpY - $Cutpoint, 90, 4 * $cbDPI)
$apos2 = cAngle($mpX + $Cutpoint, $mpY + $Cutpoint, 180, 4 * $cbDPI)
Local $apos4 = cAngle($mpX + $Cutpoint, $mpY - $Cutpoint, 135, 8 * $cbDPI)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic1[0], $mpX - $Cutpoint, $mpY - $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic1[0], $mpX + $Cutpoint, $mpY + $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic2[0], $mpX - $Cutpoint, $mpY - $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic2[0], $mpX + $Cutpoint, $mpY + $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic3[0], $mpX - $Cutpoint, $mpY - $Cutpoint, $apos1[0], $apos1[1], $hPen4)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic3[0], $mpX + $Cutpoint, $mpY + $Cutpoint, $apos2[0], $apos2[1], $hPen4)
$Cutpoint =($FrameSize * 0.3)
Local $mpX1 = Round($CBw / 2.2, 0), $mpY1 = Round($CBh / 2, 0)
$apos1 = cAngle($mpX1 - $Cutpoint, $mpY1 - $Cutpoint, 360, 4 * $cbDPI)
$apos2 = cAngle($mpX1 + $Cutpoint, $mpY1 + $Cutpoint, 270, 4 * $cbDPI)
Local $apos3 = cAngle($mpX1 - $Cutpoint, $mpY1 + $Cutpoint, 315, 8 * $cbDPI)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic1[0], $mpX1 - $Cutpoint, $mpY1 - $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic1[0], $mpX1 + $Cutpoint, $mpY1 + $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic2[0], $mpX1 - $Cutpoint, $mpY1 - $Cutpoint, $apos1[0], $apos1[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic2[0], $mpX1 + $Cutpoint, $mpY1 + $Cutpoint, $apos2[0], $apos2[1], $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic3[0], $mpX1 - $Cutpoint, $mpY1 - $Cutpoint, $apos1[0], $apos1[1], $hPen4)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic3[0], $mpX1 + $Cutpoint, $mpY1 + $Cutpoint, $apos2[0], $apos2[1], $hPen4)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic1[0], $mpX1 - $Cutpoint, $mpY1 + $Cutpoint, $apos3[0] + $Cutpoint, $apos3[1] - $Cutpoint, $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic1[0], $mpX + $Cutpoint, $mpY - $Cutpoint, $apos4[0] - $Cutpoint, $apos4[1] + $Cutpoint, $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic2[0], $mpX1 - $Cutpoint, $mpY1 + $Cutpoint, $apos3[0] + $Cutpoint, $apos3[1] - $Cutpoint, $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic2[0], $mpX + $Cutpoint, $mpY - $Cutpoint, $apos4[0] - $Cutpoint, $apos4[1] + $Cutpoint, $hPen)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic3[0], $mpX1 - $Cutpoint, $mpY1 + $Cutpoint, $apos3[0] + $Cutpoint, $apos3[1] - $Cutpoint, $hPen4)
_GDIPlus_GraphicsDrawLine($Button_FSRestore_Graphic3[0], $mpX + $Cutpoint, $mpY - $Cutpoint, $apos4[0] - $Cutpoint, $apos4[1] + $Cutpoint, $hPen4)
EndIf
If $ButtonsToCreate_Array[4] Then
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic1[0], $CBw / 3, $CBh / 2.9,($CBw / 3) * 2, $CBh / 2.9, $hPen)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic1[0], $CBw / 3, $CBh / 2.9 +($FrameSize * 4),($CBw / 3) * 2, $CBh / 2.9 +($FrameSize * 4), $hPen)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic1[0], $CBw / 3, $CBh / 2.9 +($FrameSize * 8),($CBw / 3) * 2, $CBh / 2.9 +($FrameSize * 8), $hPen)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic2[0], $CBw / 3, $CBh / 2.9,($CBw / 3) * 2, $CBh / 2.9, $hPen)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic2[0], $CBw / 3, $CBh / 2.9 +($FrameSize * 4),($CBw / 3) * 2, $CBh / 2.9 +($FrameSize * 4), $hPen)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic2[0], $CBw / 3, $CBh / 2.9 +($FrameSize * 8),($CBw / 3) * 2, $CBh / 2.9 +($FrameSize * 8), $hPen)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic3[0], $CBw / 3, $CBh / 2.9,($CBw / 3) * 2, $CBh / 2.9, $hPen4)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic3[0], $CBw / 3, $CBh / 2.9 +($FrameSize * 4),($CBw / 3) * 2, $CBh / 2.9 +($FrameSize * 4), $hPen4)
_GDIPlus_GraphicsDrawLine($Button_Menu_Graphic3[0], $CBw / 3, $CBh / 2.9 +($FrameSize * 8),($CBw / 3) * 2, $CBh / 2.9 +($FrameSize * 8), $hPen4)
EndIf
_GDIPlus_PenDispose($hPen)
_GDIPlus_PenDispose($hPen2)
_GDIPlus_PenDispose($hPen3)
_GDIPlus_PenDispose($hPen4)
_GDIPlus_PenDispose($hPen5)
_GDIPlus_BrushDispose($hBrush)
_GDIPlus_BrushDispose($hBrush2)
If $ButtonsToCreate_Array[0] Then
$Button_Close_Array[5] = _iGraphicCreateBitmapHandle($Button_Close_Array[0], $Button_Close_Graphic1)
$Button_Close_Array[6] = _iGraphicCreateBitmapHandle($Button_Close_Array[0], $Button_Close_Graphic2, False)
$Button_Close_Array[7] = _iGraphicCreateBitmapHandle($Button_Close_Array[0], $Button_Close_Graphic3, False)
GUICtrlSetResizing($Button_Close_Array[0], 768 + 32 + 4)
$Control_Buttons[0] = $Button_Close_Array[0]
_cHvr_Register($Button_Close_Array[0], "_iHoverOff", "_iHoverOn", '', "", _iAddHover($Button_Close_Array), $CurrentGUI)
EndIf
If $ButtonsToCreate_Array[1] Then
$Button_Maximize_Array[5] = _iGraphicCreateBitmapHandle($Button_Maximize_Array[0], $Button_Maximize_Graphic1)
$Button_Maximize_Array[6] = _iGraphicCreateBitmapHandle($Button_Maximize_Array[0], $Button_Maximize_Graphic2, False)
$Button_Maximize_Array[7] = _iGraphicCreateBitmapHandle($Button_Maximize_Array[0], $Button_Maximize_Graphic3, False)
$Button_Restore_Array[5] = _iGraphicCreateBitmapHandle($Button_Restore_Array[0], $Button_Restore_Graphic1)
$Button_Restore_Array[6] = _iGraphicCreateBitmapHandle($Button_Restore_Array[0], $Button_Restore_Graphic2, False)
$Button_Restore_Array[7] = _iGraphicCreateBitmapHandle($Button_Restore_Array[0], $Button_Restore_Graphic3, False)
GUICtrlSetResizing($Button_Maximize_Array[0], 768 + 32 + 4)
GUICtrlSetResizing($Button_Restore_Array[0], 768 + 32 + 4)
$Control_Buttons[1] = $Button_Maximize_Array[0]
$Control_Buttons[2] = $Button_Restore_Array[0]
GUICtrlSetState($Button_Restore_Array[0], 32)
_cHvr_Register($Button_Maximize_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Button_Maximize_Array), $CurrentGUI)
_cHvr_Register($Button_Restore_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Button_Restore_Array), $CurrentGUI)
EndIf
If $ButtonsToCreate_Array[2] Then
$Button_Minimize_Array[5] = _iGraphicCreateBitmapHandle($Button_Minimize_Array[0], $Button_Minimize_Graphic1)
$Button_Minimize_Array[6] = _iGraphicCreateBitmapHandle($Button_Minimize_Array[0], $Button_Minimize_Graphic2, False)
$Button_Minimize_Array[7] = _iGraphicCreateBitmapHandle($Button_Minimize_Array[0], $Button_Minimize_Graphic3, False)
GUICtrlSetResizing($Button_Minimize_Array[0], 768 + 32 + 4)
$Control_Buttons[3] = $Button_Minimize_Array[0]
_cHvr_Register($Button_Minimize_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Button_Minimize_Array), $CurrentGUI)
EndIf
If $ButtonsToCreate_Array[3] Then
$Button_FullScreen_Array[5] = _iGraphicCreateBitmapHandle($Button_FullScreen_Array[0], $Button_FullScreen_Graphic1)
$Button_FullScreen_Array[6] = _iGraphicCreateBitmapHandle($Button_FullScreen_Array[0], $Button_FullScreen_Graphic2, False)
$Button_FullScreen_Array[7] = _iGraphicCreateBitmapHandle($Button_FullScreen_Array[0], $Button_FullScreen_Graphic3, False)
$Button_FSRestore_Array[5] = _iGraphicCreateBitmapHandle($Button_FSRestore_Array[0], $Button_FSRestore_Graphic1)
$Button_FSRestore_Array[6] = _iGraphicCreateBitmapHandle($Button_FSRestore_Array[0], $Button_FSRestore_Graphic2, False)
$Button_FSRestore_Array[7] = _iGraphicCreateBitmapHandle($Button_FSRestore_Array[0], $Button_FSRestore_Graphic3, False)
GUICtrlSetResizing($Button_FullScreen_Array[0], 768 + 32 + 4)
GUICtrlSetResizing($Button_FSRestore_Array[0], 768 + 32 + 4)
GUICtrlSetState($Button_FSRestore_Array[0], 32)
$Control_Buttons[4] = $Button_FullScreen_Array[0]
$Control_Buttons[5] = $Button_FSRestore_Array[0]
_cHvr_Register($Button_FullScreen_Array[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _iAddHover($Button_FullScreen_Array), $CurrentGUI)
_cHvr_Register($Button_FSRestore_Array[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _iAddHover($Button_FSRestore_Array), $CurrentGUI)
EndIf
If $ButtonsToCreate_Array[4] Then
$Button_Menu_Array[5] = _iGraphicCreateBitmapHandle($Button_Menu_Array[0], $Button_Menu_Graphic1)
$Button_Menu_Array[6] = _iGraphicCreateBitmapHandle($Button_Menu_Array[0], $Button_Menu_Graphic2, False)
$Button_Menu_Array[7] = _iGraphicCreateBitmapHandle($Button_Menu_Array[0], $Button_Menu_Graphic3, False)
GUICtrlSetResizing($Button_Menu_Array[0], 768 + 32 + 2)
$Control_Buttons[6] = $Button_Menu_Array[0]
_cHvr_Register($Button_Menu_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Button_Menu_Array), $CurrentGUI)
EndIf
Return $Control_Buttons
EndFunc
Func _Metro_CreateButton($Text, $Left, $Top, $Width, $Height, $BG_Color = $ButtonBKColor, $Font_Color = $ButtonTextColor, $Font = "Arial", $Fontsize = 10, $FontStyle = 1, $FrameColor = "0xFFFFFF")
Local $Button_Array[16]
Local $btnDPI = _HighDPICheck()
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Width = Round($Width * $gDPI)
$Height = Round($Height * $gDPI)
Else
$Fontsize =($Fontsize / $Font_DPI_Ratio)
EndIf
$Button_Array[1] = False
$Button_Array[3] = "2"
$Button_Array[15] = GetCurrentGUI()
Local $FrameSize = Round(4 * $btnDPI)
If Not(Mod($FrameSize, 2) = 0) Then $FrameSize = $FrameSize - 1
$BG_Color = "0xFF" & Hex($BG_Color, 6)
$Font_Color = "0xFF" & Hex($Font_Color, 6)
$FrameColor = "0xFF" & Hex($FrameColor, 6)
Local $Brush_BTN_FontColor = _GDIPlus_BrushCreateSolid($Font_Color)
Local $Brush_BTN_FontColorDis = _GDIPlus_BrushCreateSolid(StringReplace(_AlterBrightness($Font_Color, -30), "0x", "0xFF"))
Local $Pen_BTN_FrameHoverColor = _GDIPlus_PenCreate($FrameColor, $FrameSize)
Local $Button_Graphic1 = _iGraphicCreate($Width, $Height, $BG_Color, 0, 5)
Local $Button_Graphic2 = _iGraphicCreate($Width, $Height, $BG_Color, 0, 5)
Local $Button_Graphic3 = _iGraphicCreate($Width, $Height, $BG_Color, 0, 5)
Local $hFormat = _GDIPlus_StringFormatCreate(), $hFamily = _GDIPlus_FontFamilyCreate($Font), $hFont = _GDIPlus_FontCreate($hFamily, $Fontsize, $FontStyle)
Local $tLayout = _GDIPlus_RectFCreate(0, 0, $Width, $Height)
_GDIPlus_StringFormatSetAlign($hFormat, 1)
_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic1[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic2[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic3[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColorDis)
_GDIPlus_GraphicsDrawRect($Button_Graphic2[0], 0, 0, $Width, $Height, $Pen_BTN_FrameHoverColor)
_GDIPlus_FontDispose($hFont)
_GDIPlus_FontFamilyDispose($hFamily)
_GDIPlus_StringFormatDispose($hFormat)
_GDIPlus_BrushDispose($Brush_BTN_FontColor)
_GDIPlus_BrushDispose($Brush_BTN_FontColorDis)
_GDIPlus_PenDispose($Pen_BTN_FrameHoverColor)
$Button_Array[0] = GUICtrlCreatePic("", $Left, $Top, $Width, $Height)
$Button_Array[5] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic1)
$Button_Array[6] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic2, False)
$Button_Array[7] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic3, False)
GUICtrlSetResizing($Button_Array[0], 768)
_cHvr_Register($Button_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Button_Array))
Return $Button_Array[0]
EndFunc
Func _Metro_CreateButtonEx($Text, $Left, $Top, $Width, $Height, $BG_Color = $ButtonBKColor, $Font_Color = $ButtonTextColor, $Font = "Arial", $Fontsize = 10, $FontStyle = 1, $FrameColor = "0xFFFFFF")
Local $Button_Array[16]
Local $btnDPI = _HighDPICheck()
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Width = Round($Width * $gDPI)
$Height = Round($Height * $gDPI)
Else
$Fontsize =($Fontsize / $Font_DPI_Ratio)
EndIf
$Button_Array[1] = False
$Button_Array[3] = "2"
$Button_Array[15] = GetCurrentGUI()
Local $FrameSize = Round(2 * $btnDPI)
If Not(Mod($FrameSize, 2) = 0) Then $FrameSize = $FrameSize - 1
$BG_Color = "0xFF" & Hex($BG_Color, 6)
$Font_Color = "0xFF" & Hex($Font_Color, 6)
$FrameColor = "0xFF" & Hex($FrameColor, 6)
Local $Brush_BTN_FontColor = _GDIPlus_BrushCreateSolid($Font_Color)
Local $Pen_BTN_FrameHoverColor = _GDIPlus_PenCreate($FrameColor, $FrameSize)
Local $Pen_BTN_FrameHoverColorDis = _GDIPlus_PenCreate(StringReplace(_AlterBrightness($Font_Color, -30), "0x", "0xFF"), $FrameSize)
Local $Brush_BTN_FontColorDis = _GDIPlus_BrushCreateSolid(StringReplace(_AlterBrightness($Font_Color, -30), "0x", "0xFF"))
Local $Button_Graphic1 = _iGraphicCreate($Width, $Height, $BG_Color, 0, 5)
Local $Button_Graphic2 = _iGraphicCreate($Width, $Height, StringReplace(_AlterBrightness($BG_Color, 25), "0x", "0xFF"), 0, 5)
Local $Button_Graphic3 = _iGraphicCreate($Width, $Height, $BG_Color, 0, 5)
Local $hFormat = _GDIPlus_StringFormatCreate(), $hFamily = _GDIPlus_FontFamilyCreate($Font), $hFont = _GDIPlus_FontCreate($hFamily, $Fontsize, $FontStyle)
Local $tLayout = _GDIPlus_RectFCreate(0, 0, $Width, $Height)
_GDIPlus_StringFormatSetAlign($hFormat, 1)
_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic1[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic2[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Button_Graphic3[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColorDis)
_GDIPlus_GraphicsDrawRect($Button_Graphic1[0], 0, 0, $Width, $Height, $Pen_BTN_FrameHoverColor)
_GDIPlus_GraphicsDrawRect($Button_Graphic2[0], 0, 0, $Width, $Height, $Pen_BTN_FrameHoverColor)
_GDIPlus_GraphicsDrawRect($Button_Graphic3[0], 0, 0, $Width, $Height, $Pen_BTN_FrameHoverColorDis)
_GDIPlus_FontDispose($hFont)
_GDIPlus_FontFamilyDispose($hFamily)
_GDIPlus_StringFormatDispose($hFormat)
_GDIPlus_BrushDispose($Brush_BTN_FontColor)
_GDIPlus_BrushDispose($Brush_BTN_FontColorDis)
_GDIPlus_PenDispose($Pen_BTN_FrameHoverColor)
_GDIPlus_PenDispose($Pen_BTN_FrameHoverColorDis)
$Button_Array[0] = GUICtrlCreatePic("", $Left, $Top, $Width, $Height)
$Button_Array[5] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic1)
$Button_Array[6] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic2, False)
$Button_Array[7] = _iGraphicCreateBitmapHandle($Button_Array[0], $Button_Graphic3, False)
GUICtrlSetResizing($Button_Array[0], 768)
_cHvr_Register($Button_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Button_Array))
Return $Button_Array[0]
EndFunc
Func _Metro_CreateToggle($Text, $Left, $Top, $Width, $Height, $BG_Color = $GUIThemeColor, $Font_Color = $FontThemeColor, $Font = "Segoe UI", $Fontsize = "11")
Local $Text1 = $Text
If $Height < 20 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. height is 20px for metro toggles.")
EndIf
If $Width < 46 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. width for metro toggles must be at least 46px without any text!")
EndIf
If Not(Mod($Height, 2) = 0) Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The toggle height should be an even number to prevent any misplacing.")
EndIf
Local $pDPI = _HighDPICheck()
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Width = Round($Width * $gDPI)
$Height = Round($Height * $gDPI)
If Not(Mod($Height, 2) = 0) Then $Height = $Height + 1
Else
$Fontsize =($Fontsize / $Font_DPI_Ratio)
EndIf
Local $Toggle_Array[16]
$Toggle_Array[1] = False
$Toggle_Array[2] = False
$Toggle_Array[3] = "6"
$Toggle_Array[15] = GetCurrentGUI()
Local $TopMargCalc = Number(20 * $pDPI, 1)
If Not(Mod($TopMargCalc, 2) = 0) Then $TopMargCalc = $TopMargCalc + 1
Local $TopMargCalc1 = Number(12 * $pDPI, 1)
If Not(Mod($TopMargCalc1, 2) = 0) Then $TopMargCalc1 = $TopMargCalc1 + 1
Local $TopMargin = Number((($Height - $TopMargCalc) / 2), 1)
Local $TopMarginCircle = Number((($Height - $TopMargCalc1) / 2), 1)
Local $iRadius = 10 * $pDPI
Local $hFWidth = Number(50 * $pDPI, 1)
If Not(Mod($hFWidth, 2) = 0) Then $hFWidth = $hFWidth + 1
Local $togSizeW = Number(46 * $pDPI, 1)
If Not(Mod($togSizeW, 2) = 0) Then $togSizeW = $togSizeW + 1
Local $togSizeH = Number(20 * $pDPI, 1)
If Not(Mod($togSizeH, 2) = 0) Then $togSizeH = $togSizeH + 1
Local $tog_calc1 = Number(2 * $pDPI, 1)
Local $tog_calc2 = Number(3 * $pDPI, 1)
Local $tog_calc3 = Number(11 * $pDPI, 1)
Local $tog_calc5 = Number(6 * $pDPI, 1)
$BG_Color = "0xFF" & Hex($BG_Color, 6)
$Font_Color = "0xFF" & Hex($Font_Color, 6)
Local $Brush_BTN_FontColor = _GDIPlus_BrushCreateSolid($Font_Color)
Local $Brush_BTN_FontColor1 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_Color, "0x", "0xFF"))
If StringInStr($GUI_Theme_Name, "Light") Then
Local $BoxFrameCol = StringReplace(_AlterBrightness($Font_Color, +65), "0x", "0xFF")
Local $BoxFrameCol1 = StringReplace(_AlterBrightness($Font_Color, +65), "0x", "0xFF")
Local $Font_Color1 = StringReplace(_AlterBrightness($Font_Color, +70), "0x", "0xFF")
Else
Local $BoxFrameCol = StringReplace(_AlterBrightness($Font_Color, -45), "0x", "0xFF")
Local $BoxFrameCol1 = StringReplace(_AlterBrightness($Font_Color, -45), "0x", "0xFF")
Local $Font_Color1 = StringReplace(_AlterBrightness($Font_Color, -30), "0x", "0xFF")
EndIf
Local $BrushInnerUC = _GDIPlus_BrushCreateSolid($BG_Color)
Local $BrushCircleUC = _GDIPlus_BrushCreateSolid($Font_Color)
Local $BrushCircleHoverUC = _GDIPlus_BrushCreateSolid($BoxFrameCol1)
Local $hPenDefaultUC = _GDIPlus_PenCreate($Font_Color, 2 * $pDPI)
Local $hPenHoverUC = _GDIPlus_PenCreate($BoxFrameCol1, 2 * $pDPI)
Local $BrushInnerC = _GDIPlus_BrushCreateSolid(StringReplace($ButtonBKColor, "0x", "0xFF"))
Local $BrushInnerCHover = _GDIPlus_BrushCreateSolid(StringReplace(_AlterBrightness($ButtonBKColor, +15), "0x", "0xFF"))
Local $BrushCircleC = _GDIPlus_BrushCreateSolid(StringReplace($ButtonTextColor, "0x", "0xFF"))
Local $hPenDefaultC = _GDIPlus_PenCreate(StringReplace($ButtonBKColor, "0x", "0xFF"), 2 * $pDPI)
Local $hPenHoverC = _GDIPlus_PenCreate(StringReplace(_AlterBrightness($ButtonBKColor, +15), "0x", "0xFF"), 2 * $pDPI)
Local $Toggle_Graphic1 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic2 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic3 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic4 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic5 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic6 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic7 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic8 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic9 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5), $Toggle_Graphic10 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $hFormat = _GDIPlus_StringFormatCreate(), $hFamily = _GDIPlus_FontFamilyCreate($Font), $hFont = _GDIPlus_FontCreate($hFamily, $Fontsize, 0)
Local $tLayout = _GDIPlus_RectFCreate($hFWidth +(10 * $pDPI), 0, $Width - $hFWidth, $Height)
_GDIPlus_StringFormatSetAlign($hFormat, 0)
_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
If StringInStr($Text, "|@|") Then
$Text1 = StringRegExp($Text, "\|@\|(.+)", 1)
If Not @error Then $Text1 = $Text1[0]
$Text = StringRegExp($Text, "^(.+)\|@\|", 1)
If Not @error Then $Text = $Text[0]
EndIf
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic1[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic2[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic3[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic4[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic5[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic6[0], $Text1, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic7[0], $Text1, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic8[0], $Text1, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic9[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Toggle_Graphic10[0], $Text1, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
Local $hPath1 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath1, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath1, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath1, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath1, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath1)
_GDIPlus_GraphicsFillPath($Toggle_Graphic1[0], $hPath1, $BrushInnerUC)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic1[0], $hPath1, $hPenDefaultUC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic1[0], 6 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleUC)
Local $hPath2 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath2, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath2, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath2, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath2, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath2)
_GDIPlus_GraphicsFillPath($Toggle_Graphic9[0], $hPath2, $BrushInnerUC)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic9[0], $hPath2, $hPenHoverUC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic9[0], 6 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleHoverUC)
Local $hPath3 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath3, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath3, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath3, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath3, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath3)
_GDIPlus_GraphicsFillPath($Toggle_Graphic2[0], $hPath3, $BrushInnerUC)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic2[0], $hPath3, $hPenHoverUC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic2[0], 10 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleHoverUC)
Local $hPath4 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath4, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath4, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath4, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath4, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath4)
_GDIPlus_GraphicsFillPath($Toggle_Graphic3[0], $hPath4, $BrushInnerUC)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic3[0], $hPath4, $hPenHoverUC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic3[0], 14 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleHoverUC)
Local $hPath5 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath5, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath5, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath5, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath5, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath5)
_GDIPlus_GraphicsFillPath($Toggle_Graphic4[0], $hPath5, $BrushInnerUC)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic4[0], $hPath5, $hPenHoverUC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic4[0], 18 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleHoverUC)
Local $hPath6 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath6, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath6, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath6, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath6, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath6)
_GDIPlus_GraphicsFillPath($Toggle_Graphic5[0], $hPath6, $BrushInnerUC)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic5[0], $hPath6, $hPenHoverUC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic5[0], 22 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleHoverUC)
Local $hPath7 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath7, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath7, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath7, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath7, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath7)
_GDIPlus_GraphicsFillPath($Toggle_Graphic6[0], $hPath7, $BrushInnerCHover)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic6[0], $hPath7, $hPenHoverC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic6[0], 26 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleC)
Local $hPath8 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath8, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath8, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath8, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath8, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath8)
_GDIPlus_GraphicsFillPath($Toggle_Graphic7[0], $hPath8, $BrushInnerCHover)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic7[0], $hPath8, $hPenHoverC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic7[0], 30 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleC)
Local $hPath9 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath9, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath9, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath9, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath9, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath9)
_GDIPlus_GraphicsFillPath($Toggle_Graphic8[0], $hPath9, $BrushInnerC)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic8[0], $hPath9, $hPenDefaultC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic8[0], 34 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleC)
Local $hPath10 = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath10, 0 + $hFWidth -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath10, 0 + $hFWidth -($iRadius * 2), $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath10, 1 * $pDPI, $TopMargin +(20 * $pDPI) -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath10, 1 * $pDPI, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath10)
_GDIPlus_GraphicsFillPath($Toggle_Graphic10[0], $hPath10, $BrushInnerCHover)
_GDIPlus_GraphicsDrawPath($Toggle_Graphic10[0], $hPath10, $hPenHoverC)
_GDIPlus_GraphicsFillEllipse($Toggle_Graphic10[0], 34 * $pDPI, $TopMarginCircle, 12 * $pDPI, 12 * $pDPI, $BrushCircleC)
_GDIPlus_FontDispose($hFont)
_GDIPlus_FontFamilyDispose($hFamily)
_GDIPlus_StringFormatDispose($hFormat)
_GDIPlus_BrushDispose($Brush_BTN_FontColor)
_GDIPlus_BrushDispose($Brush_BTN_FontColor1)
_GDIPlus_BrushDispose($BrushInnerUC)
_GDIPlus_BrushDispose($BrushCircleUC)
_GDIPlus_BrushDispose($BrushCircleHoverUC)
_GDIPlus_BrushDispose($BrushInnerC)
_GDIPlus_BrushDispose($BrushInnerCHover)
_GDIPlus_BrushDispose($BrushCircleC)
_GDIPlus_PenDispose($hPenDefaultUC)
_GDIPlus_PenDispose($hPenHoverUC)
_GDIPlus_PenDispose($hPenDefaultC)
_GDIPlus_PenDispose($hPenHoverC)
_GDIPlus_PathDispose($hPath1)
_GDIPlus_PathDispose($hPath2)
_GDIPlus_PathDispose($hPath3)
_GDIPlus_PathDispose($hPath4)
_GDIPlus_PathDispose($hPath5)
_GDIPlus_PathDispose($hPath6)
_GDIPlus_PathDispose($hPath7)
_GDIPlus_PathDispose($hPath8)
_GDIPlus_PathDispose($hPath9)
_GDIPlus_PathDispose($hPath10)
$Toggle_Array[0] = GUICtrlCreatePic("", $Left, $Top, $Width, $Height)
$Toggle_Array[5] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic1)
$Toggle_Array[6] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic2, False)
$Toggle_Array[7] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic3, False)
$Toggle_Array[8] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic4, False)
$Toggle_Array[9] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic5, False)
$Toggle_Array[10] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic6, False)
$Toggle_Array[11] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic7, False)
$Toggle_Array[12] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic8, False)
$Toggle_Array[13] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic9, False)
$Toggle_Array[14] = _iGraphicCreateBitmapHandle($Toggle_Array[0], $Toggle_Graphic10, False)
GUICtrlSetResizing($Toggle_Array[0], 768)
_cHvr_Register($Toggle_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Toggle_Array))
Return $Toggle_Array[0]
EndFunc
Func _Metro_ToggleIsChecked($Toggle)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Toggle Then
If $iHoverReg[$i][2] Then
Return True
Else
Return False
EndIf
EndIf
Next
EndFunc
Func _Metro_ToggleUnCheck($Toggle, $NoAnimation = False)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Toggle Then
If $iHoverReg[$i][2] Then
If Not $NoAnimation Then
For $i2 = 12 To 6 Step -1
_WinAPI_DeleteObject(GUICtrlSendMsg($Toggle, 0x0172, 0, $iHoverReg[$i][$i2]))
Sleep(1)
Next
_WinAPI_DeleteObject(GUICtrlSendMsg($Toggle, 0x0172, 0, $iHoverReg[$i][13]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($Toggle, 0x0172, 0, $iHoverReg[$i][13]))
EndIf
$iHoverReg[$i][1] = True
$iHoverReg[$i][2] = False
ExitLoop
EndIf
EndIf
Next
EndFunc
Func _Metro_ToggleCheck($Toggle, $NoAnimation = False)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Toggle Then
If Not $iHoverReg[$i][2] Then
If Not $NoAnimation Then
For $i2 = 6 To 11 Step +1
_WinAPI_DeleteObject(GUICtrlSendMsg($Toggle, 0x0172, 0, $iHoverReg[$i][$i2]))
Sleep(1)
Next
_WinAPI_DeleteObject(GUICtrlSendMsg($Toggle, 0x0172, 0, $iHoverReg[$i][12]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($Toggle, 0x0172, 0, $iHoverReg[$i][12]))
EndIf
$iHoverReg[$i][2] = True
$iHoverReg[$i][1] = True
ExitLoop
EndIf
EndIf
Next
EndFunc
Func _Metro_CreateRadio($RadioGroup, $Text, $Left, $Top, $Width, $Height, $BG_Color = $GUIThemeColor, $Font_Color = $FontThemeColor, $Font = "Segoe UI", $Fontsize = "11", $FontStyle = 0, $RadioCircleSize = 22, $ExStyle = False)
If $Height < 22 And $RadioCircleSize > 21 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. height is 22px for metro radios.")
EndIf
Local $rDPI = _HighDPICheck()
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Width = Round($Width * $gDPI)
$Height = Round($Height * $gDPI)
If Mod($Width, 2) <> 0 Then $Width = $Width - 1
If Mod($Height, 2) <> 0 Then $Height = $Height - 1
$RadioCircleSize = $RadioCircleSize * $gDPI
If Mod($RadioCircleSize, 2) <> 0 Then $RadioCircleSize = $RadioCircleSize - 1
Else
$Fontsize =($Fontsize / $Font_DPI_Ratio)
EndIf
Local $Radio_Array[16]
$Radio_Array[1] = False
$Radio_Array[2] = False
$Radio_Array[3] = "7"
$Radio_Array[4] = $RadioGroup
$Radio_Array[15] = GetCurrentGUI()
Local $TopMargin =($Height - $RadioCircleSize) / 2
If $BG_Color <> 0 Then $BG_Color = "0xFF" & Hex($BG_Color, 6)
$Font_Color = "0xFF" & Hex($Font_Color, 6)
Local $Brush_BTN_FontColor = _GDIPlus_BrushCreateSolid($Font_Color)
Local $BoxFrameCol = StringReplace($CB_Radio_Hover_Color, "0x", "0xFF")
Local $Brush1 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_Color, "0x", "0xFF"))
If $ExStyle Then
Local $Brush2 = _GDIPlus_BrushCreateSolid(StringReplace($ButtonBKColor, "0x", "0xFF"))
Else
Local $Brush2 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_CheckMark_Color, "0x", "0xFF"))
EndIf
Local $Brush3 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_Hover_Color, "0x", "0xFF"))
Local $Radio_Graphic1 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $Radio_Graphic2 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $Radio_Graphic3 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $Radio_Graphic4 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $hFormat = _GDIPlus_StringFormatCreate(), $hFamily = _GDIPlus_FontFamilyCreate($Font), $hFont = _GDIPlus_FontCreate($hFamily, $Fontsize, $FontStyle)
Local $tLayout = _GDIPlus_RectFCreate($RadioCircleSize +(4 * $rDPI), 0, $Width - $RadioCircleSize +(4 * $rDPI), $Height)
_GDIPlus_StringFormatSetAlign($hFormat, 0)
_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
$tLayout.Y = 1
_GDIPlus_GraphicsDrawStringEx($Radio_Graphic1[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Radio_Graphic2[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Radio_Graphic3[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Radio_Graphic4[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
Local $radSize1 = 1 * $rDPI
Local $radSize2 = 5 * $rDPI
Local $radSize3 = 11 * $rDPI
_GDIPlus_GraphicsFillEllipse($Radio_Graphic1[0], 0, $TopMargin, $RadioCircleSize - $radSize1, $RadioCircleSize - $radSize1, $Brush1)
_GDIPlus_GraphicsFillEllipse($Radio_Graphic3[0], 0, $TopMargin, $RadioCircleSize - $radSize1, $RadioCircleSize - $radSize1, $Brush3)
_GDIPlus_GraphicsFillEllipse($Radio_Graphic2[0], 0, $TopMargin, $RadioCircleSize - $radSize1, $RadioCircleSize - $radSize1, $Brush1)
_GDIPlus_GraphicsFillEllipse($Radio_Graphic2[0], $radSize2, $TopMargin + $radSize2, $RadioCircleSize - $radSize3, $RadioCircleSize - $radSize3, $Brush2)
_GDIPlus_GraphicsFillEllipse($Radio_Graphic4[0], 0, $TopMargin, $RadioCircleSize - $radSize1, $RadioCircleSize - $radSize1, $Brush3)
_GDIPlus_GraphicsFillEllipse($Radio_Graphic4[0], $radSize2, $TopMargin + $radSize2, $RadioCircleSize - $radSize3, $RadioCircleSize - $radSize3, $Brush2)
_GDIPlus_FontDispose($hFont)
_GDIPlus_FontFamilyDispose($hFamily)
_GDIPlus_StringFormatDispose($hFormat)
_GDIPlus_BrushDispose($Brush_BTN_FontColor)
_GDIPlus_BrushDispose($Brush1)
_GDIPlus_BrushDispose($Brush2)
_GDIPlus_BrushDispose($Brush3)
$Radio_Array[0] = GUICtrlCreatePic("", $Left, $Top, $Width, $Height)
$Radio_Array[5] = _iGraphicCreateBitmapHandle($Radio_Array[0], $Radio_Graphic1)
$Radio_Array[7] = _iGraphicCreateBitmapHandle($Radio_Array[0], $Radio_Graphic2, False)
$Radio_Array[6] = _iGraphicCreateBitmapHandle($Radio_Array[0], $Radio_Graphic3, False)
$Radio_Array[8] = _iGraphicCreateBitmapHandle($Radio_Array[0], $Radio_Graphic4, False)
GUICtrlSetResizing($Radio_Array[0], 768)
_cHvr_Register($Radio_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Radio_Array))
Return $Radio_Array[0]
EndFunc
Func _Metro_CreateRadioEx($RadioGroup, $Text, $Left, $Top, $Width, $Height, $BG_Color = $GUIThemeColor, $Font_Color = $FontThemeColor, $Font = "Segoe UI", $Fontsize = "11", $FontStyle = 0, $RadioCircleSize = 22)
Return _Metro_CreateRadio($RadioGroup, $Text, $Left, $Top, $Width, $Height, $BG_Color, $Font_Color, $Font, $Fontsize, $FontStyle, $RadioCircleSize, True)
EndFunc
Func _Metro_RadioCheck($RadioGroup, $Radio, $NoHoverEffect = False)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Radio Then
$iHoverReg[$i][1] = True
$iHoverReg[$i][2] = True
If $NoHoverEffect Then
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$i][0], 0x0172, 0, $iHoverReg[$i][7]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$i][0], 0x0172, 0, $iHoverReg[$i][8]))
EndIf
Else
If $iHoverReg[$i][4] = $RadioGroup Then
$iHoverReg[$i][2] = False
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$i][0], 0x0172, 0, $iHoverReg[$i][5]))
EndIf
EndIf
Next
EndFunc
Func _Metro_RadioIsChecked($RadioGroup, $Radio)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Radio Then
If $iHoverReg[$i][4] = $RadioGroup Then
If $iHoverReg[$i][2] Then
Return True
Else
Return False
EndIf
EndIf
EndIf
Next
Return False
EndFunc
Func _Metro_CreateCheckbox($Text, $Left, $Top, $Width, $Height, $BG_Color = $GUIThemeColor, $Font_Color = $FontThemeColor, $Font = "Segoe UI", $Fontsize = "11", $FontStyle = 0, $cb_style = 1)
If $Height < 24 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. height is 24px for metro checkboxes.")
EndIf
Local $chDPI = _HighDPICheck()
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Width = Round($Width * $gDPI)
$Height = Round($Height * $gDPI)
If Mod($Width, 2) <> 0 Then $Width = $Width + 1
Else
$Fontsize =($Fontsize / $Font_DPI_Ratio)
EndIf
Local $Checkbox_Array[16]
$Checkbox_Array[1] = False
$Checkbox_Array[2] = False
$Checkbox_Array[3] = "5"
$Checkbox_Array[15] = GetCurrentGUI()
Local $chbh = Round(22 * $chDPI)
Local $TopMargin =($Height - $chbh) / 2
Local $CheckBox_Text_Margin = $chbh +($TopMargin * 1.3)
Local $FrameSize
If $cb_style = 0 Then
$FrameSize = $chbh / 7
Else
$FrameSize = $chbh / 8
EndIf
If $BG_Color <> 0 Then
$BG_Color = "0xFF" & Hex($BG_Color, 6)
EndIf
$Font_Color = "0xFF" & Hex($Font_Color, 6)
Local $Brush_BTN_FontColor = _GDIPlus_BrushCreateSolid($Font_Color)
If $cb_style = 0 Then
Local $Brush1 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_Color, "0x", "0xFF"))
Local $Brush3 = $Brush1
Local $Brush2 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_Hover_Color, "0x", "0xFF"))
Local $Brush4 = $Brush2
Local $PenX = _GDIPlus_PenCreate(StringReplace($CB_Radio_CheckMark_Color, "0x", "0xFF"), $FrameSize)
Else
Local $Brush1 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_Color, "0x", "0xFF"))
Local $Brush2 = _GDIPlus_BrushCreateSolid(StringReplace($CB_Radio_Hover_Color, "0x", "0xFF"))
Local $Brush3 = _GDIPlus_BrushCreateSolid(StringReplace($ButtonBKColor, "0x", "0xFF"))
Local $Brush4 = _GDIPlus_BrushCreateSolid(StringReplace(_AlterBrightness($ButtonBKColor, +10), "0x", "0xFF"))
Local $PenX = _GDIPlus_PenCreate(StringReplace($CB_Radio_Color, "0x", "0xFF"), $FrameSize)
EndIf
Local $Checkbox_Graphic1 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $Checkbox_Graphic2 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $Checkbox_Graphic3 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $Checkbox_Graphic4 = _iGraphicCreate($Width, $Height, $BG_Color, 5, 5)
Local $hFormat = _GDIPlus_StringFormatCreate(), $hFamily = _GDIPlus_FontFamilyCreate($Font), $hFont = _GDIPlus_FontCreate($hFamily, $Fontsize, $FontStyle)
Local $tLayout = _GDIPlus_RectFCreate($CheckBox_Text_Margin, 0, $Width - $CheckBox_Text_Margin, $Height)
_GDIPlus_StringFormatSetAlign($hFormat, 1)
_GDIPlus_StringFormatSetLineAlign($hFormat, 1)
$tLayout.Y = 1
_GDIPlus_GraphicsDrawStringEx($Checkbox_Graphic1[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Checkbox_Graphic2[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Checkbox_Graphic3[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
_GDIPlus_GraphicsDrawStringEx($Checkbox_Graphic4[0], $Text, $hFont, $tLayout, $hFormat, $Brush_BTN_FontColor)
Local $iRadius = Round(2 * $chDPI)
Local $hPath = _GDIPlus_PathCreate()
_GDIPlus_PathAddArc($hPath, $chbh -($iRadius * 2), $TopMargin, $iRadius * 2, $iRadius * 2, 270, 90)
_GDIPlus_PathAddArc($hPath, $chbh -($iRadius * 2), $TopMargin + $chbh -($iRadius * 2), $iRadius * 2, $iRadius * 2, 0, 90)
_GDIPlus_PathAddArc($hPath, 0, $TopMargin + $chbh -($iRadius * 2), $iRadius * 2, $iRadius * 2, 90, 90)
_GDIPlus_PathAddArc($hPath, 0, $TopMargin, $iRadius * 2, $iRadius * 2, 180, 90)
_GDIPlus_PathCloseFigure($hPath)
_GDIPlus_GraphicsFillPath($Checkbox_Graphic1[0], $hPath, $Brush1)
_GDIPlus_GraphicsFillPath($Checkbox_Graphic3[0], $hPath, $Brush2)
_GDIPlus_GraphicsFillPath($Checkbox_Graphic2[0], $hPath, $Brush3)
_GDIPlus_GraphicsFillPath($Checkbox_Graphic4[0], $hPath, $Brush4)
Local $Cutpoint =($FrameSize * 0.70) / 2
Local $mpX = $chbh / 2.60
Local $mpY = $TopMargin + $chbh / 1.3
Local $apos1 = cAngle($mpX - $Cutpoint, $mpY, 135, $chbh / 1.35)
Local $apos2 = cAngle($mpX, $mpY - $Cutpoint, 225, $chbh / 3)
_GDIPlus_GraphicsDrawLine($Checkbox_Graphic2[0], $mpX - $Cutpoint, $mpY, $apos1[0], $apos1[1], $PenX)
_GDIPlus_GraphicsDrawLine($Checkbox_Graphic2[0], $mpX, $mpY - $Cutpoint, $apos2[0], $apos2[1], $PenX)
_GDIPlus_GraphicsDrawLine($Checkbox_Graphic4[0], $mpX - $Cutpoint, $mpY, $apos1[0], $apos1[1], $PenX)
_GDIPlus_GraphicsDrawLine($Checkbox_Graphic4[0], $mpX, $mpY - $Cutpoint, $apos2[0], $apos2[1], $PenX)
_GDIPlus_FontDispose($hFont)
_GDIPlus_FontFamilyDispose($hFamily)
_GDIPlus_StringFormatDispose($hFormat)
_GDIPlus_BrushDispose($Brush_BTN_FontColor)
_GDIPlus_BrushDispose($Brush1)
_GDIPlus_BrushDispose($Brush2)
_GDIPlus_BrushDispose($Brush3)
_GDIPlus_BrushDispose($Brush4)
_GDIPlus_PenDispose($PenX)
$Checkbox_Array[0] = GUICtrlCreatePic("", $Left, $Top, $Width, $Height)
$Checkbox_Array[5] = _iGraphicCreateBitmapHandle($Checkbox_Array[0], $Checkbox_Graphic1)
$Checkbox_Array[7] = _iGraphicCreateBitmapHandle($Checkbox_Array[0], $Checkbox_Graphic2, False)
$Checkbox_Array[6] = _iGraphicCreateBitmapHandle($Checkbox_Array[0], $Checkbox_Graphic3, False)
$Checkbox_Array[8] = _iGraphicCreateBitmapHandle($Checkbox_Array[0], $Checkbox_Graphic4, False)
GUICtrlSetResizing($Checkbox_Array[0], 768)
_cHvr_Register($Checkbox_Array[0], "_iHoverOff", "_iHoverOn", "", "", _iAddHover($Checkbox_Array))
Return $Checkbox_Array[0]
EndFunc
Func _Metro_CheckboxIsChecked($Checkbox)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Checkbox Then
If $iHoverReg[$i][2] Then
Return True
Else
Return False
EndIf
EndIf
Next
EndFunc
Func _Metro_CheckboxUnCheck($Checkbox)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Checkbox Then
$iHoverReg[$i][2] = False
$iHoverReg[$i][1] = True
_WinAPI_DeleteObject(GUICtrlSendMsg($Checkbox, 0x0172, 0, $iHoverReg[$i][6]))
EndIf
Next
EndFunc
Func _Metro_CheckboxCheck($Checkbox, $NoHoverEffect = False)
For $i = 0 To(UBound($iHoverReg) - 1) Step +1
If $iHoverReg[$i][0] = $Checkbox Then
$iHoverReg[$i][2] = True
$iHoverReg[$i][1] = True
If $NoHoverEffect Then
_WinAPI_DeleteObject(GUICtrlSendMsg($Checkbox, 0x0172, 0, $iHoverReg[$i][7]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($Checkbox, 0x0172, 0, $iHoverReg[$i][8]))
EndIf
EndIf
Next
EndFunc
Func _Metro_MsgBox($Flag, $Title, $Text, $mWidth = 600, $Fontsize = 11, $ParentGUI = "", $Timeout = 0)
Local $1stButton, $2ndButton, $3rdButton, $1stButtonText = "-", $2ndButtonText = "-", $3rdButtonText = "-", $Buttons_Count = 1
Switch $Flag
Case 0
$Buttons_Count = 1
$1stButtonText = "OK"
Case 1
$Buttons_Count = 2
$1stButtonText = "OK"
$2ndButtonText = "Cancel"
Case 2
$Buttons_Count = 3
$1stButtonText = "Abort"
$2ndButtonText = "Retry"
$3rdButtonText = "Ignore"
Case 3
$Buttons_Count = 3
$1stButtonText = "Yes"
$2ndButtonText = "No"
$3rdButtonText = "Cancel"
Case 4
$Buttons_Count = 2
$1stButtonText = "Yes"
$2ndButtonText = "No"
Case 5
$Buttons_Count = 2
$1stButtonText = "Retry"
$2ndButtonText = "Cancel"
Case 6
$Buttons_Count = 3
$1stButtonText = "Cancel"
$2ndButtonText = "Retry"
$3rdButtonText = "Continue"
Case Else
$Buttons_Count = 1
$1stButtonText = "OK"
EndSwitch
If($Buttons_Count = 1) And($mWidth < 180) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 180px for the selected message style/flag.")
If($Buttons_Count = 2) And($mWidth < 240) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 240px for the selected message style/flag.")
If($Buttons_Count = 3) And($mWidth < 360) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 360px for the selected message style/flag.")
Local $msgbDPI = _HighDPICheck()
If $HIGHDPI_SUPPORT Then
$mWidth = Round($mWidth * $gDPI)
Else
$Fontsize =($Fontsize / $Font_DPI_Ratio)
EndIf
Local $LabelSize = _StringSize($Text, $Fontsize, 400, 0, "Arial", $mWidth -(30 * $msgbDPI))
Local $mHeight = 120 +($LabelSize[3] / $msgbDPI)
Local $MsgBox_Form = _Metro_CreateGUI($Title, $mWidth / $msgbDPI, $mHeight, -1, -1, False, $ParentGUI)
$mHeight = $mHeight * $msgbDPI
GUICtrlCreateLabel(" " & $Title, 2 * $msgbDPI, 2 * $msgbDPI, $mWidth -(4 * $msgbDPI), 30 * $msgbDPI, 0x0200, 0x00100000)
GUICtrlSetBkColor(-1, _AlterBrightness($GUIThemeColor, 30))
GUICtrlSetColor(-1, $FontThemeColor)
_GUICtrlSetFont(-1, 11, 600, 0, "Arial", 5)
GUICtrlCreateLabel($Text, 15 * $msgbDPI, 50 * $msgbDPI, $LabelSize[2], $LabelSize[3], -1, 0x00100000)
GUICtrlSetBkColor(-1, $GUIThemeColor)
GUICtrlSetColor(-1, $FontThemeColor)
GUICtrlSetFont(-1, $Fontsize, 400, 0, "Arial", 5)
Local $1stButton_Left =(($mWidth / $msgbDPI) -($Buttons_Count * 100) -(($Buttons_Count - 1) * 20)) / 2
Local $1stButton_Left1 =($mWidth -($Buttons_Count *(100 * $msgbDPI)) -(($Buttons_Count - 1) *(20 * $msgbDPI))) / 2
Local $2ndButton_Left = $1stButton_Left + 120
Local $3rdButton_Left = $2ndButton_Left + 120
GUICtrlCreateLabel("", 2 * $msgbDPI, $mHeight -(53 * $msgbDPI), $1stButton_Left1 -(4 * $msgbDPI),(50 * $msgbDPI), -1, 0x00100000)
GUICtrlCreateLabel("", $mWidth - $1stButton_Left1 +(2 * $msgbDPI), $mHeight -(53 * $msgbDPI), $1stButton_Left1 -(4 * $msgbDPI),(50 * $msgbDPI), -1, 0x00100000)
Local $cEnter = GUICtrlCreateDummy()
Local $aAccelKeys[1][2] = [["{ENTER}", $cEnter]]
Local $1stButton = _Metro_CreateButton($1stButtonText, $1stButton_Left,($mHeight / $msgbDPI) - 50, 100, 34, $ButtonBKColor, $ButtonTextColor)
Local $2ndButton = _Metro_CreateButton($2ndButtonText, $2ndButton_Left,($mHeight / $msgbDPI) - 50, 100, 34, $ButtonBKColor, $ButtonTextColor)
If $Buttons_Count < 2 Then GUICtrlSetState($2ndButton, 32)
Local $3rdButton = _Metro_CreateButton($3rdButtonText, $3rdButton_Left,($mHeight / $msgbDPI) - 50, 100, 34, $ButtonBKColor, $ButtonTextColor)
If $Buttons_Count < 3 Then GUICtrlSetState($3rdButton, 32)
Switch $Flag
Case 0, 1, 5
GUICtrlSetState($1stButton, 512)
Case 2, 4, 6
GUICtrlSetState($2ndButton, 512)
Case 3
GUICtrlSetState($3rdButton, 512)
Case Else
GUICtrlSetState($1stButton, 512)
EndSwitch
GUISetAccelerators($aAccelKeys, $MsgBox_Form)
GUISetState(@SW_SHOW)
If $Timeout <> 0 Then
$iMsgBoxTimeout = $Timeout
AdlibRegister("_iMsgBoxTimeout", 1000)
EndIf
If $mOnEventMode Then Opt("GUIOnEventMode", 0)
While 1
If $Timeout <> 0 Then
If $iMsgBoxTimeout <= 0 Then
AdlibUnRegister("_iMsgBoxTimeout")
_Metro_GUIDelete($MsgBox_Form)
If $mOnEventMode Then Opt("GUIOnEventMode", 1)
Return SetError(1)
EndIf
EndIf
Local $nMsg = GUIGetMsg()
Switch $nMsg
Case -3, $1stButton
_Metro_GUIDelete($MsgBox_Form)
If $mOnEventMode Then Opt("GUIOnEventMode", 1)
Return $1stButtonText
Case $2ndButton
_Metro_GUIDelete($MsgBox_Form)
If $mOnEventMode Then Opt("GUIOnEventMode", 1)
Return $2ndButtonText
Case $3rdButton
_Metro_GUIDelete($MsgBox_Form)
If $mOnEventMode Then Opt("GUIOnEventMode", 1)
Return $3rdButtonText
Case $cEnter
_Metro_GUIDelete($MsgBox_Form)
Local $ReturnText
Switch $Flag
Case 0, 1, 5
$ReturnText = $1stButtonText
Case 2, 4, 6
$ReturnText = $2ndButtonText
Case 3
$ReturnText = $3rdButtonText
Case Else
$ReturnText = $1stButtonText
EndSwitch
If $mOnEventMode Then Opt("GUIOnEventMode", 1)
Return $ReturnText
EndSwitch
WEnd
EndFunc
Func _Metro_CreateProgress($Left, $Top, $Width, $Height, $EnableBorder = False, $Backgroud_Color = $CB_Radio_Color, $Progress_Color = $ButtonBKColor)
Local $Progress_Array[8]
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Width = Round($Width * $gDPI)
$Height = Round($Height * $gDPI)
EndIf
$Progress_Array[1] = $Width
$Progress_Array[2] = $Height
$Progress_Array[3] = "0xFF" & Hex($Backgroud_Color, 6)
$Progress_Array[4] = "0xFF" & Hex($Progress_Color, 6)
$Progress_Array[5] = StringReplace($CB_Radio_Hover_Color, "0x", "0xFF")
$Progress_Array[7] = $EnableBorder
Local $ProgressBGPen = _GDIPlus_PenCreate($Progress_Array[5], 2)
Local $Progress_Graphic = _iGraphicCreate($Width, $Height, $Progress_Array[3], 1, 5)
If $EnableBorder Then
_GDIPlus_GraphicsDrawRect($Progress_Graphic[0], 0, 0, $Width, $Height, $ProgressBGPen)
EndIf
_GDIPlus_PenDispose($ProgressBGPen)
$Progress_Array[0] = GUICtrlCreatePic("", $Left, $Top, $Width, $Height)
$Progress_Array[6] = _iGraphicCreateBitmapHandle($Progress_Array[0], $Progress_Graphic)
GUICtrlSetResizing($Progress_Array[0], 768)
Return $Progress_Array
EndFunc
Func _Metro_SetProgress(ByRef $Progress, $Percent)
Local $ProgressBGPen = _GDIPlus_PenCreate($Progress[5], 2)
Local $ProgressBGBrush = _GDIPlus_BrushCreateSolid($Progress[4])
Local $Progress_Graphic = _iGraphicCreate($Progress[1], $Progress[2], $Progress[3], 1, 5)
If $Percent > 100 Then $Percent = 100
If $Progress[7] Then
Local $ProgressWidth =(($Progress[1] - 2) / 100) * $Percent
_GDIPlus_GraphicsDrawRect($Progress_Graphic[0], 0, 0, $Progress[1], $Progress[2], $ProgressBGPen)
_GDIPlus_GraphicsFillRect($Progress_Graphic[0], 1, 1, $ProgressWidth, $Progress[2] - 2, $ProgressBGBrush)
Else
Local $ProgressWidth =(($Progress[1]) / 100) * $Percent
_GDIPlus_GraphicsFillRect($Progress_Graphic[0], 0, 0, $ProgressWidth, $Progress[2], $ProgressBGBrush)
EndIf
_GDIPlus_PenDispose($ProgressBGPen)
_GDIPlus_BrushDispose($ProgressBGBrush)
Local $SetProgress = _iGraphicCreateBitmapHandle($Progress[0], $Progress_Graphic)
_WinAPI_DeleteObject($Progress[6])
$Progress[6] = $SetProgress
EndFunc
Func _Metro_AddHSeperator($Left, $Top, $Width, $Size, $Color = $GUIBorderColor)
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Width = Round($Width * $gDPI)
$Size = Round($Size * $gDPI)
EndIf
Local $Seperator = GUICtrlCreateLabel("", $Left, $Top, $Width, $Size)
GUICtrlSetBkColor(-1, $Color)
GUICtrlSetState(-1, 128)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
Return $Seperator
EndFunc
Func _Metro_AddVSeperator($Left, $Top, $Height, $Size, $Color = $GUIBorderColor)
If $HIGHDPI_SUPPORT Then
$Left = Round($Left * $gDPI)
$Top = Round($Top * $gDPI)
$Height = Round($Height * $gDPI)
$Size = Round($Size * $gDPI)
EndIf
Local $Seperator = GUICtrlCreateLabel("", $Left, $Top, $Size, $Height)
GUICtrlSetBkColor(-1, $Color)
GUICtrlSetState(-1, 128)
GUICtrlSetResizing(-1, 32 + 64 + 256 + 2)
Return $Seperator
EndFunc
Func _iAddHover($Button_ADD)
Local $HRS
For $i = 0 To UBound($iHoverReg) - 1 Step +1
If $iHoverReg[$i][0] = "" Then
$HRS = $i
ExitLoop
EndIf
Next
If $HRS == "" Then
$HRS = UBound($iHoverReg)
ReDim $iHoverReg[$HRS + 1][16]
EndIf
For $i = 0 To 15
$iHoverReg[$HRS][$i] = $Button_ADD[$i]
Next
Return $HRS
EndFunc
Func _iGraphicCreate($hWidth, $hHeight, $BackgroundColor = 0, $Smoothingmode = 4, $TextCleartype = 0)
Local $Picture_Array[2]
$Picture_Array[1] = _GDIPlus_BitmapCreateFromScan0($hWidth, $hHeight, $GDIP_PXF32ARGB)
$Picture_Array[0] = _GDIPlus_ImageGetGraphicsContext($Picture_Array[1])
_GDIPlus_GraphicsSetSmoothingMode($Picture_Array[0], $Smoothingmode)
_GDIPlus_GraphicsSetTextRenderingHint($Picture_Array[0], $TextCleartype)
If $BackgroundColor <> 0 Then _GDIPlus_GraphicsClear($Picture_Array[0], $BackgroundColor)
Return $Picture_Array
EndFunc
Func _iGraphicCreateBitmapHandle($hPicture, $Picture_Array, $hVisible = True)
Local $cBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($Picture_Array[1])
If $hVisible Then _WinAPI_DeleteObject(GUICtrlSendMsg($hPicture, 0x0172, 0, $cBitmap))
_GDIPlus_GraphicsDispose($Picture_Array[0])
_GDIPlus_BitmapDispose($Picture_Array[1])
Return $cBitmap
EndFunc
Func GetCurrentGUI()
Local $dummyCtrl = GUICtrlCreateLabel("", 0, 0, 0, 0)
Local $hCurrent = _WinAPI_GetParent(GUICtrlGetHandle($dummyCtrl))
GUICtrlDelete($dummyCtrl)
Return $hCurrent
EndFunc
Func _HighDPICheck()
If $HIGHDPI_SUPPORT Then
Return $gDPI
Else
Return 1
EndIf
EndFunc
Func cAngle($x1, $y1, $Ang, $Length)
Local $Return[2]
$Return[0] = $x1 +($Length * Sin($Ang / 180 * 3.14159265358979))
$Return[1] = $y1 +($Length * Cos($Ang / 180 * 3.14159265358979))
Return $Return
EndFunc
Func _GUICtrlSetFont($icontrolID, $iSize, $iweight = 400, $iattribute = 0, $sfontname = "", $iquality = 5)
If $HIGHDPI_SUPPORT Then
GUICtrlSetFont($icontrolID, $iSize, $iweight, $iattribute, $sfontname, $iquality)
Else
GUICtrlSetFont($icontrolID, $iSize / $Font_DPI_Ratio, $iweight, $iattribute, $sfontname, $iquality)
EndIf
EndFunc
Func _GetFontDPI_Ratio()
Local $a1[3]
Local $iDPI, $iDPIRat, $Logpixelsy = 90, $hWnd = 0
Local $hDC = DllCall("user32.dll", "long", "GetDC", "long", $hWnd)
Local $aRet = DllCall("gdi32.dll", "long", "GetDeviceCaps", "long", $hDC[0], "long", $Logpixelsy)
$hDC = DllCall("user32.dll", "long", "ReleaseDC", "long", $hWnd, "long", $hDC)
$iDPI = $aRet[0]
Select
Case $iDPI = 0
$iDPI = 96
$iDPIRat = 94
Case $iDPI < 84
$iDPIRat = $iDPI / 105
Case $iDPI < 121
$iDPIRat = $iDPI / 96
Case $iDPI < 145
$iDPIRat = $iDPI / 95
Case Else
$iDPIRat = $iDPI / 94
EndSelect
$a1[0] = 2
$a1[1] = $iDPI
$a1[2] = $iDPIRat
Return $a1
EndFunc
Func _iMsgBoxTimeout()
$iMsgBoxTimeout -= 1
EndFunc
Func _AlterBrightness($StartCol, $adjust, $Select = 7)
Local $red = $adjust *(BitAND(1, $Select) <> 0) + BitAND($StartCol, 0xff0000) / 0x10000
Local $grn = $adjust *(BitAND(2, $Select) <> 0) + BitAND($StartCol, 0x00ff00) / 0x100
Local $blu = $adjust *(BitAND(4, $Select) <> 0) + BitAND($StartCol, 0x0000FF)
Return "0x" & Hex(String(limitCol($red) * 0x10000 + limitCol($grn) * 0x100 + limitCol($blu)), 6)
EndFunc
Func limitCol($cc)
If $cc > 255 Then Return 255
If $cc < 0 Then Return 0
Return $cc
EndFunc
Func _CreateBorder($mGUI, $guiW, $guiH, $bordercolor = 0xFFFFFF)
Local $cLeft, $cRight, $cTop, $cBottom
Local $gID = _iGetGUIID($mGUI)
$cTop = GUICtrlCreateLabel("", 0, 0, $guiW, 1)
GUICtrlSetColor(-1, $bordercolor)
GUICtrlSetBkColor(-1, $bordercolor)
GUICtrlSetResizing(-1, 544)
GUICtrlSetState(-1, 128)
$cBottom = GUICtrlCreateLabel("", 0, $guiH - 1, $guiW, 1)
GUICtrlSetColor(-1, $bordercolor)
GUICtrlSetBkColor(-1, $bordercolor)
GUICtrlSetResizing(-1, 576)
GUICtrlSetState(-1, 128)
$cLeft = GUICtrlCreateLabel("", 0, 1, 1, $guiH - 1)
GUICtrlSetColor(-1, $bordercolor)
GUICtrlSetBkColor(-1, $bordercolor)
GUICtrlSetResizing(-1, 256 + 2)
GUICtrlSetState(-1, 128)
$cRight = GUICtrlCreateLabel("", $guiW - 1, 1, 1, $guiH - 1)
GUICtrlSetColor(-1, $bordercolor)
GUICtrlSetBkColor(-1, $bordercolor)
GUICtrlSetResizing(-1, 256 + 4)
GUICtrlSetState(-1, 128)
If $gID <> "" Then
$iGUI_LIST[$gID][12] = $cTop
$iGUI_LIST[$gID][13] = $cBottom
$iGUI_LIST[$gID][14] = $cLeft
$iGUI_LIST[$gID][15] = $cRight
EndIf
EndFunc
Func _WinPos($ParentWin, $Win_Wi, $Win_Hi)
Local $Win_SetPos[2]
$Win_SetPos[0] = "-1"
$Win_SetPos[1] = "-1"
Local $Win_POS = WinGetPos($ParentWin)
If Not @error Then
$Win_SetPos[0] =($Win_POS[0] +(($Win_POS[2] - $Win_Wi) / 2))
$Win_SetPos[1] =($Win_POS[1] +(($Win_POS[3] - $Win_Hi) / 2))
EndIf
Return $Win_SetPos
EndFunc
Func _GDIPlus_GraphicsGetDPIRatio($iDPIDef = 96)
_GDIPlus_Startup()
Local $hGfx = _GDIPlus_GraphicsCreateFromHWND(0)
If @error Then Return SetError(1, @extended, 0)
Local $aResult
#forcedef $__g_hGDIPDll, $ghGDIPDll
$aResult = DllCall($__g_hGDIPDll, "int", "GdipGetDpiX", "handle", $hGfx, "float*", 0)
If @error Then Return SetError(2, @extended, 0)
Local $iDPI = $aResult[2]
_GDIPlus_GraphicsDispose($hGfx)
_GDIPlus_Shutdown()
Return $iDPI / $iDPIDef
EndFunc
Func _iHoverOn($idCtrl, $vData)
Switch $iHoverReg[$vData][3]
Case 5, 7
If $iHoverReg[$vData][2] Then
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][8]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][6]))
EndIf
Case "6"
If $iHoverReg[$vData][2] Then
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][14]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][13]))
EndIf
Case Else
_WinAPI_DeleteObject(GUICtrlSendMsg($idCtrl, 0x0172, 0, $iHoverReg[$vData][6]))
EndSwitch
EndFunc
Func _iHoverOff($idCtrl, $vData)
Switch $iHoverReg[$vData][3]
Case 0, 3, 4, 8, 9, 10
If WinActive($iHoverReg[$vData][15]) Then
_WinAPI_DeleteObject(GUICtrlSendMsg($idCtrl, 0x0172, 0, $iHoverReg[$vData][5]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($idCtrl, 0x0172, 0, $iHoverReg[$vData][7]))
EndIf
Case 5, 7
If $iHoverReg[$vData][2] Then
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][7]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][5]))
EndIf
Case "6"
If $iHoverReg[$vData][2] Then
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][12]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$vData][0], 0x0172, 0, $iHoverReg[$vData][5]))
EndIf
Case Else
_WinAPI_DeleteObject(GUICtrlSendMsg($idCtrl, 0x0172, 0, $iHoverReg[$vData][5]))
EndSwitch
EndFunc
Func _iGetCtrlHandlebyType($Type, $hWnd)
For $i = 0 To UBound($iHoverReg) - 1
If($Type = $iHoverReg[$i][3]) And($hWnd = $iHoverReg[$i][15]) Then Return $iHoverReg[$i][0]
Next
Return False
EndFunc
Func _iEffectControl($hWnd, $imsg, $wParam, $lParam, $iID, $gID)
Switch $imsg
Case 0x00AF, 0x0085, 0x00AE, 0x0083, 0x0086
Return -1
Case 0x031A
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(2, 4))
_WinAPI_SetWindowPos($hWnd, 0, 0, 0, 0, 0, $SWP_FRAMECHANGED + $SWP_NOMOVE + $SWP_NOSIZE + $SWP_NOREDRAW)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Return 0
Case 0x0005
If Not $iGUI_LIST[$gID][11] Then
Switch $wParam
Case 2
Local $wSize = _GetDesktopWorkArea($hWnd)
Local $wPos = WinGetPos($hWnd)
WinMove($hWnd, "", $wPos[0] - 1, $wPos[1] - 1, $wSize[2], $wSize[3])
For $iC = 0 To UBound($iHoverReg) - 1
If $hWnd = $iHoverReg[$iC][15] Then
Switch $iHoverReg[$iC][3]
Case 3
GUICtrlSetState($iHoverReg[$iC][0], 32)
$iHoverReg[$iC][8] = False
Case 4
GUICtrlSetState($iHoverReg[$iC][0], 16)
$iHoverReg[$iC][8] = True
EndSwitch
EndIf
Next
Case 0
For $iC = 0 To UBound($iHoverReg) - 1
If $hWnd = $iHoverReg[$iC][15] Then
Switch $iHoverReg[$iC][3]
Case 3
If Not $iHoverReg[$iC][8] Then
GUICtrlSetState($iHoverReg[$iC][0], 16)
$iHoverReg[$iC][8] = True
EndIf
Case 4
If $iHoverReg[$iC][8] Then
GUICtrlSetState($iHoverReg[$iC][0], 32)
$iHoverReg[$iC][8] = False
EndIf
EndSwitch
EndIf
Next
EndSwitch
EndIf
Case 0x0024
Local $tMinMax = DllStructCreate("int;int;int;int;int;int;int;int;int;dword", $lParam)
Local $WrkSize = _GetDesktopWorkArea($hWnd)
DllStructSetData($tMinMax, 3, $WrkSize[2])
DllStructSetData($tMinMax, 4, $WrkSize[3])
DllStructSetData($tMinMax, 5, $WrkSize[0] + 1)
DllStructSetData($tMinMax, 6, $WrkSize[1] + 1)
DllStructSetData($tMinMax, 7, $iGUI_LIST[$gID][3])
DllStructSetData($tMinMax, 8, $iGUI_LIST[$gID][4])
Case 0x0084
If $iGUI_LIST[$gID][2] And Not $iGUI_LIST[$gID][11] Then
Local $iSide = 0, $iTopBot = 0, $Cur
Local $wPos = WinGetPos($hWnd)
Local $curInf = GUIGetCursorInfo($hWnd)
If Not @error Then
If $curInf[0] < $bMarg Then $iSide = 1
If $curInf[0] > $wPos[2] - $bMarg Then $iSide = 2
If $curInf[1] < $bMarg Then $iTopBot = 3
If $curInf[1] > $wPos[3] - $bMarg Then $iTopBot = 6
$Cur = $iSide + $iTopBot
Else
$Cur = 0
EndIf
If WinGetState($hWnd) <> 47 Then
Local $Return_HT = 2, $Set_Cur = 2
Switch $Cur
Case 1
$Set_Cur = 13
$Return_HT = 10
Case 2
$Set_Cur = 13
$Return_HT = 11
Case 3
$Set_Cur = 11
$Return_HT = 12
Case 4
$Set_Cur = 12
$Return_HT = 13
Case 5
$Set_Cur = 10
$Return_HT = 14
Case 6
$Set_Cur = 11
$Return_HT = 15
Case 7
$Set_Cur = 10
$Return_HT = 16
Case 8
$Set_Cur = 12
$Return_HT = 17
EndSwitch
GUISetCursor($Set_Cur, 1)
If $Return_HT <> 2 Then Return $Return_HT
EndIf
If Abs(BitAND(BitShift($lParam, 16), 0xFFFF) - $wPos[1]) <(28 * $gDPI) Then Return $HTCAPTION
EndIf
Case 0x0201
If $iGUI_LIST[$gID][1] And Not $iGUI_LIST[$gID][11] And Not(WinGetState($hWnd) = 47) Then
Local $aCurInfo = GUIGetCursorInfo($hWnd)
If($aCurInfo[4] = 0) Then
DllCall("user32.dll", "int", "ReleaseCapture")
DllCall("user32.dll", "long", "SendMessageA", "hwnd", $hWnd, "int", 0x00A1, "int", 2, "int", 0)
Return 0
EndIf
EndIf
Case 0x001C
For $iC = 0 To UBound($iHoverReg) - 1
Switch $iHoverReg[$iC][3]
Case 0, 3, 4, 8, 9, 10
If $wParam Then
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$iC][0], 0x0172, 0, $iHoverReg[$iC][5]))
Else
_WinAPI_DeleteObject(GUICtrlSendMsg($iHoverReg[$iC][0], 0x0172, 0, $iHoverReg[$iC][7]))
EndIf
EndSwitch
Next
Case 0x0020
If MouseGetCursor() <> 2 Then
Local $curInf = GUIGetCursorInfo($hWnd)
If Not @error And $curInf[4] <> 0 Then
Local $iSide = 0, $iTopBot = 0, $Cur = 0
Local $wPos = WinGetPos($hWnd)
If $curInf[0] < $bMarg Then $iSide = 1
If $curInf[0] > $wPos[2] - $bMarg Then $iSide = 2
If $curInf[1] < $bMarg Then $iTopBot = 3
If $curInf[1] > $wPos[3] - $bMarg Then $iTopBot = 6
$Cur = $iSide + $iTopBot
If $Cur = 0 Then
If $curInf[4] <> $iGUI_LIST[$gID][12] And $curInf[4] <> $iGUI_LIST[$gID][13] And $curInf[4] <> $iGUI_LIST[$gID][14] And $curInf[4] <> $iGUI_LIST[$gID][15] Then
GUISetCursor(2, 0, $hWnd)
EndIf
EndIf
EndIf
EndIf
EndSwitch
Return DllCall("comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $hWnd, "uint", $imsg, "wparam", $wParam, "lparam", $lParam)[0]
EndFunc
Func _iMExit()
For $i_HR = 0 To UBound($iGUI_LIST) - 1 Step +1
_Metro_GUIDelete($iGUI_LIST[$i_HR][0])
Next
DllCallbackFree($m_hDll)
_GDIPlus_Shutdown()
EndFunc
Func _GetDesktopWorkArea($hWnd, $FullScreen = False)
Local $MonSizePos[4], $MonNumb = 1
$MonSizePos[0] = 0
$MonSizePos[1] = 0
$MonSizePos[2] = @DesktopWidth
$MonSizePos[3] = @DesktopHeight
Local $aPos, $MonList = _WinAPI_EnumDisplayMonitors()
If @error Then Return $MonSizePos
ReDim $MonList[$MonList[0][0] + 1][5]
For $i = 1 To $MonList[0][0]
$aPos = _WinAPI_GetPosFromRect($MonList[$i][1])
For $j = 0 To 3
$MonList[$i][$j + 1] = $aPos[$j]
Next
Next
Local $GUI_Monitor = _WinAPI_MonitorFromWindow($hWnd)
Local $TaskbarMon = _WinAPI_MonitorFromWindow(WinGetHandle("[CLASS:Shell_TrayWnd]"))
For $iM = 1 To $MonList[0][0] Step +1
If $MonList[$iM][0] = $GUI_Monitor Then
If $FullScreen Then
$MonSizePos[0] = $MonList[$iM][1]
$MonSizePos[1] = $MonList[$iM][2]
Else
$MonSizePos[0] = 0
$MonSizePos[1] = 0
EndIf
$MonSizePos[2] = $MonList[$iM][3]
$MonSizePos[3] = $MonList[$iM][4]
$MonNumb = $iM
EndIf
Next
Local $TaskBarAH = DllCall("shell32.dll", "int", "SHAppBarMessage", "int", 0x00000004, "ptr*", 0)
If Not @error Then
$TaskBarAH = $TaskBarAH[0]
Else
$TaskBarAH = 0
EndIf
If $TaskbarMon = $GUI_Monitor Then
Local $TaskBarPos = WinGetPos("[CLASS:Shell_TrayWnd]")
If @error Then Return $MonSizePos
If $FullScreen Then Return $MonSizePos
If($TaskBarPos[0] = $MonList[$MonNumb][1] - 2) Or($TaskBarPos[1] = $MonList[$MonNumb][2] - 2) Then
$TaskBarPos[0] += 2
$TaskBarPos[1] += 2
$TaskBarPos[2] -= 4
$TaskBarPos[3] -= 4
EndIf
If $TaskBarPos[2] = $MonSizePos[2] Then
If $TaskBarAH = 1 Then
If($TaskBarPos[1] > 0) Then
$MonSizePos[3] -= 1
Else
$MonSizePos[1] += 1
$MonSizePos[3] -= 1
EndIf
Return $MonSizePos
EndIf
$MonSizePos[3] = $MonSizePos[3] - $TaskBarPos[3]
If($TaskBarPos[0] = $MonList[$MonNumb][1]) And($TaskBarPos[1] = $MonList[$MonNumb][2]) Then $MonSizePos[1] = $TaskBarPos[3]
Else
If $TaskBarAH = 1 Then
If($TaskBarPos[0] > 0) Then
$MonSizePos[2] -= 1
Else
$MonSizePos[0] += 1
$MonSizePos[2] -= 1
EndIf
Return $MonSizePos
EndIf
$MonSizePos[2] = $MonSizePos[2] - $TaskBarPos[2]
If($TaskBarPos[0] = $MonList[$MonNumb][1]) And($TaskBarPos[1] = $MonList[$MonNumb][2]) Then $MonSizePos[0] = $TaskBarPos[2]
EndIf
EndIf
Return $MonSizePos
EndFunc
Func _iGetGUIID($mGUI)
For $iG = 0 To UBound($iGUI_LIST) - 1
If $iGUI_LIST[$iG][0] = $mGUI Then
Return $iG
EndIf
Next
Return SetError(1, 0, "")
EndFunc
Func _iFullscreenToggleBtn($idCtrl, $hWnd)
If $ControlBtnsAutoMode Then _Metro_FullscreenToggle($hWnd)
EndFunc
Global Enum $__hGUIDisableHWnd, $__hGUIDisableHWndPrevious, $__iGUIDisableMax
Global $__aGUIDisable[$__iGUIDisableMax]
Func _GUIDisable($hWnd, $iAnimate = Default, $iBrightness = Default, $bColor = 0x000000)
If $iAnimate = Default Then
$iAnimate = 1
EndIf
If $iBrightness = Default Then
$iBrightness = 5
EndIf
If $hWnd = -1 And $__aGUIDisable[$__hGUIDisableHWnd] = 0 Then
Local $iLabel = GUICtrlCreateLabel('', -99, -99, 1, 1)
$hWnd = _WinAPI_GetParent(GUICtrlGetHandle($iLabel))
If @error Then
Return SetError(1, 0 * GUICtrlDelete($iLabel), 0)
EndIf
GUICtrlDelete($iLabel)
EndIf
If IsHWnd($__aGUIDisable[$__hGUIDisableHWnd]) Then
GUIDelete($__aGUIDisable[$__hGUIDisableHWnd])
GUISwitch($__aGUIDisable[$__hGUIDisableHWndPrevious])
$__aGUIDisable[$__hGUIDisableHWnd] = 0
$__aGUIDisable[$__hGUIDisableHWndPrevious] = 0
Else
$__aGUIDisable[$__hGUIDisableHWndPrevious] = $hWnd
Local $iLeft = 0, $iTop = 0
Local $iStyle = GUIGetStyle($__aGUIDisable[$__hGUIDisableHWndPrevious])
Local $sCurrentTheme = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes', 'CurrentTheme')
Local $iIsClassicTheme = Number(StringInStr($sCurrentTheme, 'Basic.theme', 2) = 0 And StringInStr($sCurrentTheme, 'Ease of Access Themes', 2) > 0)
Local $aWinGetPos = WinGetClientSize($__aGUIDisable[$__hGUIDisableHWndPrevious])
$__aGUIDisable[$__hGUIDisableHWnd] = GUICreate('', $aWinGetPos[0], $aWinGetPos[1], $iLeft + 3, $iTop + 3, $WS_POPUP, $WS_EX_MDICHILD, $__aGUIDisable[$__hGUIDisableHWndPrevious])
GUISetBkColor($bColor, $__aGUIDisable[$__hGUIDisableHWnd])
WinSetTrans($__aGUIDisable[$__hGUIDisableHWnd], '', Round($iBrightness *(255 / 100)))
If not $iAnimate Then
GUISetState(@SW_SHOW, $__aGUIDisable[$__hGUIDisableHWnd])
EndIf
GUISetState(@SW_DISABLE, $__aGUIDisable[$__hGUIDisableHWnd])
GUISwitch($__aGUIDisable[$__hGUIDisableHWndPrevious])
EndIf
Return $__aGUIDisable[$__hGUIDisableHWnd]
EndFunc
_Metro_EnableHighDPIScaling()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)
Sleep(2000)
SplashOff()
CheckForFreshInstall()
OpenMainGUI()
Func OpenMainGUI()
Global $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
_LogaInfo("Set AutoCharts Drive directory to | " & $DropboxDir)
Global $INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
_LogaInfo("Set UserName to | " & $INPT_Name)
Global $Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
_LogaInfo("Set current quarter to | " & $Select_Quarter)
Global $INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
_LogaInfo("Set current year to | " & $INPT_CurYear)
Global $bDBVerified = IniRead($ini, 'Settings', 'DBVerified', '')
_LogaInfo("AutoCharts Drive directory verified? | " & $bDBVerified)
Global $Select_Theme = IniRead($ini, 'Settings', 'UITheme', '')
_LogaInfo("Set theme to | " & $Select_Theme)
_SetTheme($Select_Theme)
Global $Form1 = _Metro_CreateGUI("AutoCharts 3.4.1", 540, 700, -1, -1, True)
GUISetIcon(@ScriptDir & "\assets\GUI_Menus\programicon_hxv_icon.ico")
$Control_Buttons = _Metro_AddControlButtons(True, True, True, True, True)
$GUI_CLOSE_BUTTON = $Control_Buttons[0]
$GUI_MAXIMIZE_BUTTON = $Control_Buttons[1]
$GUI_RESTORE_BUTTON = $Control_Buttons[2]
$GUI_MINIMIZE_BUTTON = $Control_Buttons[3]
$GUI_FULLSCREEN_BUTTON = $Control_Buttons[4]
$GUI_FSRestore_BUTTON = $Control_Buttons[5]
$GUI_MENU_BUTTON = $Control_Buttons[6]
$Pic1 = GUICtrlCreatePic(@ScriptDir & "\assets\GUI_Menus\main-img.bmp", 0, 35, 540, 158, BitOR($GUI_SS_DEFAULT_PIC, $SS_CENTERIMAGE))
$HSeperator1 = _Metro_AddHSeperator(50, 240, 440, 1)
Local $Label_Main = GUICtrlCreateLabel("Please Select a Fund Family", 50, 275, 440, 50)
GUICtrlSetColor(-1, $FontThemeColor)
GUICtrlSetFont(-1, 20, 400, 0, "Segoe UI")
$TAB_Catalyst = _Metro_CreateButton("Catalyst Funds", 50, 350, 140, 40)
$TAB_Rational = _Metro_CreateButton("Rational Funds", 200, 350, 140, 40)
$TAB_StrategyShares = _Metro_CreateButton("Strategy Shares", 350, 350, 140, 40)
$HSeperator2 = _Metro_AddHSeperator(50, 570, 440, 1)
Local $BTN_Settings = _Metro_CreateButton("Settings", 50, 600, 100, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)
Local $BTN_About = _Metro_CreateButton("About", 170, 600, 100, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)
Local $Label_Version = GUICtrlCreateLabel("v3.4.1", 450, 620, 50, 50, $SS_RIGHT)
GUICtrlSetColor(-1, $FontThemeColor)
GUICtrlSetFont(-1, 15, 400, 0, "Segoe UI")
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
_Metro_GUIDelete($Form1)
Exit
Case $GUI_MAXIMIZE_BUTTON
GUISetState(@SW_MAXIMIZE, $Form1)
Case $GUI_MINIMIZE_BUTTON
GUISetState(@SW_MINIMIZE, $Form1)
Case $GUI_RESTORE_BUTTON
GUISetState(@SW_RESTORE, $Form1)
Case $GUI_FULLSCREEN_BUTTON, $GUI_FSRestore_BUTTON
ConsoleWrite("Fullscreen toggled" & @CRLF)
Case $GUI_MENU_BUTTON
Local $MenuButtonsArray[5] = ["Archive Factsheets", "Settings", "Sync Options", "Help", "Exit"]
Local $MenuSelect = _Metro_MenuStart($Form1, 150, $MenuButtonsArray)
Switch $MenuSelect
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
EndFunc
Func _CatalystFundsGUI()
Local $Form2 = _Metro_CreateGUI("Catalyst Funds GUI", 540, 620, -1, -1, False, $Form1)
Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]
Local $ACX = _Metro_CreateToggle("ACX", 50, 70, 130, 30)
Local $ATR = _Metro_CreateToggle("ATR", 50, 120, 130, 30)
Local $BUY = _Metro_CreateToggle("BUY", 50, 170, 130, 30)
Local $CAX = _Metro_CreateToggle("CAX", 50, 220, 130, 30)
Local $CFR = _Metro_CreateToggle("CFR", 50, 270, 130, 30)
Local $CLP = _Metro_CreateToggle("CLP", 50, 320, 130, 30)
Local $CLT = _Metro_CreateToggle("CLT", 50, 370, 130, 30)
Local $vSeperator1 = _Metro_AddVSeperator(180, 85, 300, 1)
Local $CPE = _Metro_CreateToggle("CPE", 220, 70, 130, 30)
Local $CWX = _Metro_CreateToggle("CWX", 220, 120, 130, 30)
Local $DCX = _Metro_CreateToggle("DCX", 220, 170, 130, 30)
Local $EIX = _Metro_CreateToggle("EIX", 220, 220, 130, 30)
Local $HII = _Metro_CreateToggle("HII", 220, 270, 130, 30)
Local $IIX = _Metro_CreateToggle("IIX", 220, 320, 130, 30)
Local $INS = _Metro_CreateToggle("INS", 220, 370, 130, 30)
Local $vSeperator2 = _Metro_AddVSeperator(350, 85, 300, 1)
Local $IOX = _Metro_CreateToggle("IOX", 390, 70, 130, 30)
Local $MBX = _Metro_CreateToggle("MBX", 390, 120, 130, 30)
Local $MLX = _Metro_CreateToggle("MLX", 390, 170, 130, 30)
Local $SHI = _Metro_CreateToggle("SHI", 390, 220, 130, 30)
Local $TEZ = _Metro_CreateToggle("TEZ", 390, 270, 130, 30)
Local $TRI = _Metro_CreateToggle("TRI", 390, 320, 130, 30)
Local $TRX = _Metro_CreateToggle("TRX", 390, 370, 130, 30)
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
_Metro_GUIDelete($Form2)
Return 0
Case $ACX
If _Metro_ToggleIsChecked($ACX) Then
_Metro_ToggleUnCheck($ACX)
$aCatalystCheck[0] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($ACX)
$aCatalystCheck[0] = "ACX"
ConsoleWrite($aCatalystCheck[0] & " Toggle checked!" & @CRLF)
EndIf
Case $ATR
If _Metro_ToggleIsChecked($ATR) Then
_Metro_ToggleUnCheck($ATR)
$aCatalystCheck[1] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($ATR)
$aCatalystCheck[1] = "ATR"
ConsoleWrite($aCatalystCheck[1] & " Toggle checked!" & @CRLF)
EndIf
Case $BUY
If _Metro_ToggleIsChecked($BUY) Then
_Metro_ToggleUnCheck($BUY)
$aCatalystCheck[2] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($BUY)
$aCatalystCheck[2] = "BUY"
ConsoleWrite($aCatalystCheck[2] & " Toggle checked!" & @CRLF)
EndIf
Case $CAX
If _Metro_ToggleIsChecked($CAX) Then
_Metro_ToggleUnCheck($CAX)
$aCatalystCheck[3] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($CAX)
$aCatalystCheck[3] = "CAX"
ConsoleWrite($aCatalystCheck[3] & " Toggle checked!" & @CRLF)
EndIf
Case $CFR
If _Metro_ToggleIsChecked($CFR) Then
_Metro_ToggleUnCheck($CFR)
$aCatalystCheck[4] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($CFR)
$aCatalystCheck[4] = "CFR"
ConsoleWrite($aCatalystCheck[4] & " Toggle checked!" & @CRLF)
EndIf
Case $CLP
If _Metro_ToggleIsChecked($CLP) Then
_Metro_ToggleUnCheck($CLP)
$aCatalystCheck[5] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($CLP)
$aCatalystCheck[5] = "CLP"
ConsoleWrite($aCatalystCheck[5] & " Toggle checked!" & @CRLF)
EndIf
Case $CLT
If _Metro_ToggleIsChecked($CLT) Then
_Metro_ToggleUnCheck($CLT)
$aCatalystCheck[6] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($CLT)
$aCatalystCheck[6] = "CLT"
ConsoleWrite($aCatalystCheck[6] & " Toggle checked!" & @CRLF)
EndIf
Case $CPE
If _Metro_ToggleIsChecked($CPE) Then
_Metro_ToggleUnCheck($CPE)
$aCatalystCheck[7] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($CPE)
$aCatalystCheck[7] = "CPE"
ConsoleWrite($aCatalystCheck[7] & " Toggle checked!" & @CRLF)
EndIf
Case $CWX
If _Metro_ToggleIsChecked($CWX) Then
_Metro_ToggleUnCheck($CWX)
$aCatalystCheck[8] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($CWX)
$aCatalystCheck[8] = "CWX"
ConsoleWrite($aCatalystCheck[8] & " Toggle checked!" & @CRLF)
EndIf
Case $DCX
If _Metro_ToggleIsChecked($DCX) Then
_Metro_ToggleUnCheck($DCX)
$aCatalystCheck[9] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($DCX)
$aCatalystCheck[9] = "DCX"
ConsoleWrite($aCatalystCheck[9] & " Toggle checked!" & @CRLF)
EndIf
Case $EIX
If _Metro_ToggleIsChecked($EIX) Then
_Metro_ToggleUnCheck($EIX)
$aCatalystCheck[10] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($EIX)
$aCatalystCheck[10] = "EIX"
ConsoleWrite($aCatalystCheck[10] & " Toggle checked!" & @CRLF)
EndIf
Case $HII
If _Metro_ToggleIsChecked($HII) Then
_Metro_ToggleUnCheck($HII)
$aCatalystCheck[11] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($HII)
$aCatalystCheck[11] = "HII"
ConsoleWrite($aCatalystCheck[11] & " Toggle checked!" & @CRLF)
EndIf
Case $IIX
If _Metro_ToggleIsChecked($IIX) Then
_Metro_ToggleUnCheck($IIX)
$aCatalystCheck[12] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($IIX)
$aCatalystCheck[12] = "IIX"
ConsoleWrite($aCatalystCheck[12] & " Toggle checked!" & @CRLF)
EndIf
Case $INS
If _Metro_ToggleIsChecked($INS) Then
_Metro_ToggleUnCheck($INS)
$aCatalystCheck[13] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($INS)
$aCatalystCheck[13] = "INS"
ConsoleWrite($aCatalystCheck[13] & " Toggle checked!" & @CRLF)
EndIf
Case $IOX
If _Metro_ToggleIsChecked($IOX) Then
_Metro_ToggleUnCheck($IOX)
$aCatalystCheck[14] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($IOX)
$aCatalystCheck[14] = "IOX"
ConsoleWrite($aCatalystCheck[14] & " Toggle checked!" & @CRLF)
EndIf
Case $MBX
If _Metro_ToggleIsChecked($MBX) Then
_Metro_ToggleUnCheck($MBX)
$aCatalystCheck[15] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($MBX)
$aCatalystCheck[15] = "MBX"
ConsoleWrite($aCatalystCheck[15] & " Toggle checked!" & @CRLF)
EndIf
Case $MLX
If _Metro_ToggleIsChecked($MLX) Then
_Metro_ToggleUnCheck($MLX)
$aCatalystCheck[16] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($MLX)
$aCatalystCheck[16] = "MLX"
ConsoleWrite($aCatalystCheck[16] & " Toggle checked!" & @CRLF)
EndIf
Case $SHI
If _Metro_ToggleIsChecked($SHI) Then
_Metro_ToggleUnCheck($SHI)
$aCatalystCheck[17] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($SHI)
$aCatalystCheck[17] = "SHI"
ConsoleWrite($aCatalystCheck[17] & " Toggle checked!" & @CRLF)
EndIf
Case $TEZ
If _Metro_ToggleIsChecked($TEZ) Then
_Metro_ToggleUnCheck($TEZ)
$aCatalystCheck[18] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($TEZ)
$aCatalystCheck[18] = "TEZ"
ConsoleWrite($aCatalystCheck[18] & " Toggle checked!" & @CRLF)
EndIf
Case $TRI
If _Metro_ToggleIsChecked($TRI) Then
_Metro_ToggleUnCheck($TRI)
$aCatalystCheck[19] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($TRI)
$aCatalystCheck[19] = "TRI"
ConsoleWrite($aCatalystCheck[19] & " Toggle checked!" & @CRLF)
EndIf
Case $TRX
If _Metro_ToggleIsChecked($TRX) Then
_Metro_ToggleUnCheck($TRX)
$aCatalystCheck[20] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($TRX)
$aCatalystCheck[20] = "TRX"
ConsoleWrite($aCatalystCheck[20] & " Toggle checked!" & @CRLF)
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
_Metro_GUIDelete($Form2)
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
_LogaInfo("############################### END OF RUN - CATALYST ###############################")
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
EndFunc
Func _RationalFundsGUI()
Local $Form3 = _Metro_CreateGUI("Rational Funds GUI", 540, 620, -1, -1, False, $Form1)
Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]
Local $HBA = _Metro_CreateToggle("HBA", 50, 70, 130, 30)
Local $HDC = _Metro_CreateToggle("HDC", 50, 120, 130, 30)
Local $HRS = _Metro_CreateToggle("HRS", 50, 170, 130, 30)
Local $HSU = _Metro_CreateToggle("HSU", 50, 220, 130, 30)
Local $IGO = _Metro_CreateToggle("IGO", 50, 270, 130, 30)
Local $PBX = _Metro_CreateToggle("PBX", 50, 320, 130, 30)
Local $RDM = _Metro_CreateToggle("RDM", 50, 370, 130, 30)
Local $RFX = _Metro_CreateToggle("RFX", 220, 70, 130, 30)
Local $vSeperator1 = _Metro_AddVSeperator(180, 85, 300, 1)
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
_Metro_GUIDelete($Form3)
Return 0
Case $HBA
If _Metro_ToggleIsChecked($HBA) Then
_Metro_ToggleUnCheck($HBA)
$aRationalCheck[0] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($HBA)
$aRationalCheck[0] = "HBA"
ConsoleWrite($aRationalCheck[0] & " Toggle checked!" & @CRLF)
EndIf
Case $HDC
If _Metro_ToggleIsChecked($HDC) Then
_Metro_ToggleUnCheck($HDC)
$aRationalCheck[1] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($HDC)
$aRationalCheck[1] = "HDC"
ConsoleWrite($aRationalCheck[1] & " Toggle checked!" & @CRLF)
EndIf
Case $HRS
If _Metro_ToggleIsChecked($HRS) Then
_Metro_ToggleUnCheck($HRS)
$aRationalCheck[2] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($HRS)
$aRationalCheck[2] = "HRS"
ConsoleWrite($aRationalCheck[2] & " Toggle checked!" & @CRLF)
EndIf
Case $HSU
If _Metro_ToggleIsChecked($HSU) Then
_Metro_ToggleUnCheck($HSU)
$aRationalCheck[3] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($HSU)
$aRationalCheck[3] = "HSU"
ConsoleWrite($aRationalCheck[3] & " Toggle checked!" & @CRLF)
EndIf
Case $IGO
If _Metro_ToggleIsChecked($IGO) Then
_Metro_ToggleUnCheck($IGO)
$aRationalCheck[4] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($IGO)
$aRationalCheck[4] = "IGO"
ConsoleWrite($aRationalCheck[4] & " Toggle checked!" & @CRLF)
EndIf
Case $PBX
If _Metro_ToggleIsChecked($PBX) Then
_Metro_ToggleUnCheck($PBX)
$aRationalCheck[5] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($PBX)
$aRationalCheck[5] = "PBX"
ConsoleWrite($aRationalCheck[5] & " Toggle checked!" & @CRLF)
EndIf
Case $RDM
If _Metro_ToggleIsChecked($RDM) Then
_Metro_ToggleUnCheck($RDM)
$aRationalCheck[6] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($RDM)
$aRationalCheck[6] = "RDM"
ConsoleWrite($aRationalCheck[6] & " Toggle checked!" & @CRLF)
EndIf
Case $RFX
If _Metro_ToggleIsChecked($RFX) Then
_Metro_ToggleUnCheck($RFX)
$aRationalCheck[7] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($RFX)
$aRationalCheck[7] = "RFX"
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
_LogaInfo("############################### END OF RUN - RATIONAL ###############################")
GUICtrlSetData($ProgressBar, 0)
Global $aRationalCheck[8]
_GUIDisable($Form3, 0, 30)
_Metro_MsgBox(0, "Finished", "The process has finished.", 500, 11, $Form3)
_GUIDisable($Form3)
_Metro_GUIDelete($Form3)
Return 0
Case $BTN_Rational_UpdateExpenseRatio
$FundFamily = "Rational"
$FamilySwitch = $aRationalCheck
GUICtrlSetData($ProgressBar, 10)
ImportDatalinker()
PullRationalData()
RunExpenseRatios()
_LogaInfo("############################### END OF RUN - RATIONAL ###############################")
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
EndFunc
Func _StrategySharesFundsGUI()
Local $Form4 = _Metro_CreateGUI("Strategy Shares Funds GUI", 540, 620, -1, -1, False, $Form1)
Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]
Local $GLDB = _Metro_CreateToggle("GLDB", 50, 70, 130, 30)
Local $HNDL = _Metro_CreateToggle("HNDL", 50, 120, 130, 30)
Local $ROMO = _Metro_CreateToggle("ROMO", 50, 170, 130, 30)
Local $FIVR = _Metro_CreateToggle("FIVR", 50, 220, 130, 30)
Local $TENH = _Metro_CreateToggle("TENH", 50, 270, 130, 30)
Local $NZRO = _Metro_CreateToggle("NZRO", 50, 320, 130, 30)
Local $vSeperator1 = _Metro_AddVSeperator(180, 85, 300, 1)
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
_Metro_GUIDelete($Form4)
Return 0
Case $GLDB
If _Metro_ToggleIsChecked($GLDB) Then
_Metro_ToggleUnCheck($GLDB)
$aStrategyCheck[0] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($GLDB)
$aStrategyCheck[0] = "GLDB"
ConsoleWrite($aStrategyCheck[0] & " Toggle checked!" & @CRLF)
EndIf
Case $HNDL
If _Metro_ToggleIsChecked($HNDL) Then
_Metro_ToggleUnCheck($HNDL)
$aStrategyCheck[1] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($HNDL)
$aStrategyCheck[1] = "HNDL"
ConsoleWrite($aStrategyCheck[1] & " Toggle checked!" & @CRLF)
EndIf
Case $ROMO
If _Metro_ToggleIsChecked($ROMO) Then
_Metro_ToggleUnCheck($ROMO)
$aStrategyCheck[2] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($ROMO)
$aStrategyCheck[2] = "ROMO"
ConsoleWrite($aStrategyCheck[2] & " Toggle checked!" & @CRLF)
EndIf
Case $FIVR
If _Metro_ToggleIsChecked($FIVR) Then
_Metro_ToggleUnCheck($FIVR)
$aStrategyCheck[3] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($FIVR)
$aStrategyCheck[3] = "FIVR"
ConsoleWrite($aStrategyCheck[3] & " Toggle checked!" & @CRLF)
EndIf
Case $TENH
If _Metro_ToggleIsChecked($TENH) Then
_Metro_ToggleUnCheck($TENH)
$aStrategyCheck[4] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($TENH)
$aStrategyCheck[4] = "TENH"
ConsoleWrite($aStrategyCheck[4] & " Toggle checked!" & @CRLF)
EndIf
Case $NZRO
If _Metro_ToggleIsChecked($NZRO) Then
_Metro_ToggleUnCheck($NZRO)
$aStrategyCheck[5] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_Metro_ToggleCheck($NZRO)
$aStrategyCheck[5] = "NZRO"
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
RunCSVConvert()
CreateCharts()
_LogaInfo("############################### END OF RUN - STRATEGY SHARES ###############################")
Global $aStrategyCheck[6]
GUICtrlSetData($ProgressBar, 0)
_GUIDisable($Form4, 0, 30)
_Metro_MsgBox(0, "Finished", "The process has finished.", 500, 11, $Form4)
_GUIDisable($Form4)
_Metro_GUIDelete($Form4)
Return 0
EndSwitch
WEnd
EndFunc
Func _SettingsGUI()
$DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
$INPT_Name = IniRead($ini, 'Settings', 'UserName', '')
$Select_Quarter = IniRead($ini, 'Settings', 'CurrentQuarter', '')
$INPT_CurYear = IniRead($ini, 'Settings', 'CurrentYear', '')
Global $Form5 = _Metro_CreateGUI("AutoCharts Settings", 540, 620, -1, -1, False, $Form1)
Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]
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
Local $Radio_Q1 = _Metro_CreateRadioEx("1", "Q1", 50, 300, 100, 30)
If $Select_Quarter = "Q1" Then
_Metro_RadioCheck("1", $Radio_Q1)
EndIf
Local $Radio_Q2 = _Metro_CreateRadioEx("1", "Q2", 160, 300, 100, 30)
If $Select_Quarter = "Q2" Then
_Metro_RadioCheck("1", $Radio_Q2)
EndIf
Local $Radio_Q3 = _Metro_CreateRadioEx("1", "Q3", 270, 300, 100, 30)
If $Select_Quarter = "Q3" Then
_Metro_RadioCheck("1", $Radio_Q3)
EndIf
Local $Radio_Q4 = _Metro_CreateRadioEx("1", "Q4", 380, 300, 100, 30)
If $Select_Quarter = "Q4" Then
_Metro_RadioCheck("1", $Radio_Q4)
EndIf
Local $Label_CurYear = GUICtrlCreateLabel("Current Year:", 50, 375, 440, 40)
GUICtrlSetColor(-1, $FontThemeColor)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Local $INPT_CurYear_BOX = GUICtrlCreateInput($INPT_CurYear, 50, 400, 440, 30)
GUICtrlSetFont(-1, 11, 500, 0, "Segoe UI")
Local $Radio_DarkBlue = _Metro_CreateRadioEx("2", "Blue", 50, 480, 100, 30)
If $Select_Theme = "DarkBlue" Then
_Metro_RadioCheck("2", $Radio_DarkBlue)
EndIf
Local $Radio_LightBlue = _Metro_CreateRadioEx("2", "Blue 2", 160, 480, 100, 30)
If $Select_Theme = "LightBlue" Then
_Metro_RadioCheck("2", $Radio_LightBlue)
EndIf
Local $Radio_DarkPurple = _Metro_CreateRadioEx("2", "Purple", 270, 480, 100, 30)
If $Select_Theme = "DarkPurple" Then
_Metro_RadioCheck("2", $Radio_DarkPurple)
EndIf
Local $Radio_LightPurple = _Metro_CreateRadioEx("2", "Purple 2", 380, 480, 100, 30)
If $Select_Theme = "LightPurple" Then
_Metro_RadioCheck("2", $Radio_LightPurple)
EndIf
Local $BTN_Save = _Metro_CreateButton("Save Settings", 50, 550, 210, 40)
Local $BTN_Cancel = _Metro_CreateButton("Cancel", 280, 550, 210, 40, 0xE9E9E9, $ButtonBKColor, "Segoe UI", 10, 1, $ButtonBKColor)
Local $BTN_Back = _Metro_AddControlButton_Back()
GUISetState(@SW_SHOW)
While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE, $BTN_Back, $GUI_CLOSE_BUTTON, $BTN_Cancel
_Metro_GUIDelete($Form5)
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
$Select_Quarter = "Q1"
$DATA_UserSettings = "Q1"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
EndIf
If _Metro_RadioIsChecked(1, $Radio_Q2) Then
$Select_Quarter = "Q2"
$DATA_UserSettings = "Q2"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
EndIf
If _Metro_RadioIsChecked(1, $Radio_Q3) Then
$Select_Quarter = "Q3"
$DATA_UserSettings = "Q3"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
EndIf
If _Metro_RadioIsChecked(1, $Radio_Q4) Then
$Select_Quarter = "Q4"
$DATA_UserSettings = "Q4"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $DATA_UserSettings)
EndIf
If _Metro_RadioIsChecked(2, $Radio_DarkBlue) Then
$Select_Theme = "DarkBlue"
_SetTheme("DarkBlue")
$DATA_UserSettings = "DarkBlue"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $DATA_UserSettings)
EndIf
If _Metro_RadioIsChecked(2, $Radio_LightBlue) Then
$Select_Theme = "LightBlue"
_SetTheme("LightBlue")
$DATA_UserSettings = "LightBlue"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $DATA_UserSettings)
EndIf
If _Metro_RadioIsChecked(2, $Radio_DarkPurple) Then
$Select_Theme = "DarkPurple"
_SetTheme("DarkPurple")
$DATA_UserSettings = "DarkPurple"
$iSettingsConfirm = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $DATA_UserSettings)
EndIf
If _Metro_RadioIsChecked(2, $Radio_LightPurple) Then
$Select_Theme = "LightPurple"
_SetTheme("LightPurple")
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
_Metro_GUIDelete($Form5)
_Metro_GUIDelete($Form1)
OpenMainGUI()
EndIf
EndSwitch
WEnd
EndFunc
Func _HelpGUI()
Global $Form6 = _Metro_CreateGUI("AutoCharts Help", 540, 500, -1, -1, False, $Form1)
Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]
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
_Metro_GUIDelete($Form6)
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
EndFunc
Func _SyncGUI()
Global $Form7 = _Metro_CreateGUI("AutoCharts Sync Options", 540, 500, -1, -1, False, $Form1)
Local $Control_Buttons_2 = _Metro_AddControlButtons(True, False, False, False)
Local $GUI_CLOSE_BUTTON = $Control_Buttons_2[0]
Local $BTN_SyncAll = _Metro_CreateButton("Pull Data from AutoCharts Drive", 50, 100, 440, 40)
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
_Metro_GUIDelete($Form7)
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
EndFunc
Func BrowseForDBPath()
Local Const $sMessage = "Select a folder"
Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
If @error Then
_GUIDisable($Form5, 0, 50)
_Metro_MsgBox($MB_SYSTEMMODAL, "Error", "No folder was selected.")
_GUIDisable($Form5)
GUICtrlSetData($INPT_DropboxFolder, "")
Else
GUICtrlSetData($INPT_DropboxFolder, $sFileSelectFolder)
EndIf
EndFunc
Func UploadDatalinker()
If $INPT_Name = "Jakob" Then
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 17.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir, 1)
If @error Then
_GUIDisable($Form7, 0, 30)
_Metro_MsgBox(0, "Error!", "There was an error uploading your Datalinker file to the database.", 500, 11, $Form7)
_GUIDisable($Form7)
_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir)
Else
_GUIDisable($Form7, 0, 30)
_Metro_MsgBox(0, "Success!", "Datalinker File has been uploaded to the database.", 500, 11, $Form7)
_GUIDisable($Form7)
_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir)
EndIf
Else
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 17.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir & "\" & $INPT_Name & "_Datalinker.xml", 1)
If @error Then
_GUIDisable($Form7, 0, 30)
_Metro_MsgBox(0, "Error!", "There was an error uploading your Datalinker file to the database.", 500, 11, $Form7)
_GUIDisable($Form7)
_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir)
Else
_GUIDisable($Form7, 0, 30)
_Metro_MsgBox(0, "Success!", "Datalinker File has been uploaded to the database.", 500, 11, $Form7)
_GUIDisable($Form7)
_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir)
EndIf
EndIf
EndFunc
Func ImportDatalinker()
FileCopy($DatabaseDir & "\DataLinker.xml", @ScriptDir & "\Datalinker_TEMP1.xml", 1)
If @error Then
_GUIDisable($Form7, 0, 30)
_Metro_MsgBox(0, "Error!", "Unable to copy datalinker.xml file to script directory", 500, 11, $Form7)
_GUIDisable($Form7)
_LogaError("Error! Unable to copy datalinker.xml file to script directory")
Else
_LogaInfo("Datalinker File Imported to AutoCharts Directory")
EndIf
Local $file = @ScriptDir & "\Datalinker_TEMP1.xml"
Local $text = FileRead($file)
FileCopy(@ScriptDir & "\Datalinker_TEMP1.xml", @AppDataDir & "\Adobe\InDesign\Version 17.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
_GUIDisable($Form7, 0, 30)
_Metro_MsgBox(0, "Error!", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file", 500, 11, $Form7)
_GUIDisable($Form7)
_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
_LogaInfo("Datalinker File Imported to InDesign successfully")
EndIf
FileDelete(@ScriptDir & "\Datalinker_Updated2.xml")
FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
_LogaInfo("Datalinker File Imported to InDesign successfully")
EndFunc
Func CreateAutoChartsDocFolder()
If FileExists(@MyDocumentsDir & "\AutoCharts\vbs\Excel_to_CSV_All_Worksheets.vbs") Then
_LogaInfo("Checking for " & @MyDocumentsDir & "\AutoCharts\vbs\Excel_to_CSV_All_Worksheets.vbs")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Checking for " & @MyDocumentsDir & "\AutoCharts\vbs\Excel_to_CSV_All_Worksheets.vbs")
_LogaInfo("File Exists. Moving on")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | VBS script has already moved to " & $INPT_Name & "'s documents folder. Moving on")
Else
DirCopy(@ScriptDir & "\VBS_Scripts", @MyDocumentsDir & "\AutoCharts\vbs", 0)
_LogaInfo("File did not exist. Creating directory " & @MyDocumentsDir & "\AutoCharts\vbs\")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | File did not exist. Creating directory " & @MyDocumentsDir & "\AutoCharts\vbs\")
EndIf
EndFunc
Func CheckForFreshInstall()
If Not FileExists(@MyDocumentsDir & "\AutoCharts\settings.ini") Then
_LogaInfo("Brand new install detected.")
_Metro_MsgBox(0, "Thanks for installing AutoCharts!", "Thanks for installing AutoCharts!" & @CRLF & @CRLF & "Before you begin, please open the settings and set your AutoCharts drive.")
Else
$CopySettings = FileCopy(@MyDocumentsDir & "\AutoCharts\settings.ini", @ScriptDir & "\settings.ini", 1)
If $CopySettings = 0 Then
_ThrowError("Could not save file to documents folder", 0, 0, 0, 3)
_LogaError("Could not save file to documents folder")
EndIf
EndIf
EndFunc
Func CheckForUpdate()
RunWait(@ScriptDir & "/AutoCharts_Updater.exe")
EndFunc
CheckForFreshInstall()
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
_Metro_MsgBox(0, "Error!", "A quarter has not been selected in the settings tab.")
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
_GUIDisable($Form6, 0, 50)
_Metro_MsgBox($MB_SYSTEMMODAL, "Success", "Log file cleared.")
_GUIDisable($Form6)
EndIf
If @error = 1 Then
_GUIDisable($Form6, 0, 50)
_Metro_MsgBox(0, "Error", "There was an error with clearing the log.")
_GUIDisable($Form6)
EndIf
EndFunc
Func RunCSVConvert()
For $a = 0 To(UBound($FamilySwitch) - 1)
If $FamilySwitch[$a] <> "" Then
$CurrentFund = $FamilySwitch[$a]
GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund)
_Metro_SetProgress($ProgressBar, 15)
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
CreateAutoChartsDocFolder()
If Not FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & "*.xlsx", @MyDocumentsDir & "/AutoCharts/vbs/") Then
_GUIDisable($Form1, 0, 50)
_Metro_MsgBox(0, "Error", "Could not copy backup file " & $DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & ".xlsx")
_GUIDisable($Form1)
_LogaError("Could not copy backup file " & $DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & ".xlsx")
ExitLoop
EndIf
RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & ".xlsx", @TempDir, @SW_HIDE)
GUICtrlSetData($UpdateLabel, $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")
_LogaInfo("Converted " & $CurrentFund & ".xlsx file to csv")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & ".xlsx file to csv")
If $FundFamily = "Catalyst" Then
If _Metro_CheckboxIsChecked($CB_Brochure_Catalyst) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
RunCSVConvert4Brochure()
EndIf
EndIf
If _Metro_CheckboxIsChecked($CB_FactSheet_Catalyst) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
RunCSVConvert4Institution()
EndIf
EndIf
If _Metro_CheckboxIsChecked($CB_Presentation_Catalyst) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
RunCSVConvert4Presentation()
EndIf
EndIf
EndIf
If $FundFamily = "Rational" Then
If _Metro_CheckboxIsChecked($CB_Brochure_Rational) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
RunCSVConvert4Brochure()
EndIf
EndIf
If _Metro_CheckboxIsChecked($CB_FactSheet_Rational) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
RunCSVConvert4Institution()
EndIf
EndIf
If _Metro_CheckboxIsChecked($CB_Presentation_Rational) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
RunCSVConvert4Presentation()
EndIf
EndIf
EndIf
If $FundFamily = "StrategyShares" Then
If _Metro_CheckboxIsChecked($CB_Brochure_SS) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
RunCSVConvert4Brochure()
EndIf
EndIf
If _Metro_CheckboxIsChecked($CB_FactSheet_SS) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
RunCSVConvert4Institution()
EndIf
EndIf
If _Metro_CheckboxIsChecked($CB_Presentation_SS) Then
If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
RunCSVConvert4Presentation()
EndIf
EndIf
EndIf
_Metro_SetProgress($ProgressBar, 25)
$CSVCopy = FileCopy(@MyDocumentsDir & "/AutoCharts/vbs/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1)
If $CSVCopy = 0 Then
_ThrowError("Could not save CSV files to program directory.", 1, 0, 0, 3)
_LogaError("Could not save CSV files to program directory.")
EndIf
$CSVMove = FileMove(@MyDocumentsDir & "/AutoCharts/vbs/*.csv", $DatabaseDir & "\csv\" & $FundFamily & "\" & $CurrentFund & "\*.csv", 1)
If $CSVMove = 0 Then
_ThrowError("Could not save CSV files to AutoCharts Database.", 0, 0, 0, 3)
_LogaError("Could not save CSV files to AutoCharts Database.")
EndIf
_LogaInfo("Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in AutoCharts Drive")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in AutoCharts Drive")
_Metro_SetProgress($ProgressBar, 30)
$XLSXDelete = FileDelete(@MyDocumentsDir & "/AutoCharts/vbs/*.xlsx")
If $XLSXDelete = 0 Then
_ThrowError("Cound not clear excel files from VBS directory.", 0, 0, 0, 3)
_LogaError("Cound not clear excel files from VBS directory.")
EndIf
_LogaInfo("Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
_Metro_SetProgress($ProgressBar, 55)
Else
ContinueLoop
EndIf
Next
EndFunc
Func RunCSVConvert4Institution()
RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-institutional.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("Converted " & $CurrentFund & "-institutional.xlsx file to csv")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & "-institutional.xlsx file to csv")
EndFunc
Func RunCSVConvert4Brochure()
RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-brochure.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("Converted " & $CurrentFund & "-brochure.xlsx file to csv")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & "-brochure.xlsx file to csv")
EndFunc
Func RunCSVConvert4Presentation()
RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-presentation.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("Converted " & $CurrentFund & "-presentation.xlsx file to csv")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & "-presentation.xlsx file to csv")
EndFunc
Func HTMLChartEditor()
Local $file = @ScriptDir & "\assets\ChartBuilder\public\index_TEMPLATE.html"
Local $text = FileRead($file)
$tout1 = StringReplace($text, '<script src="/scripts/CHANGEME.js"></script>', '<script src="/scripts/' & $CurrentFund & '.js"></script>')
FileWrite(@ScriptDir & "\assets\ChartBuilder\public\index.html", $tout1)
_LogaInfo("~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")
_LogaInfo("Created HTML file for " & $CurrentFund & " chart generation")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Created HTML file for " & $CurrentFund & " chart generation")
_LogaInfo("Initializing Local Server for amCharts")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Initializing Local Server for amCharts")
EndFunc
Func CreateCharts()
For $a = 0 To(UBound($FamilySwitch) - 1)
If $FamilySwitch[$a] <> "" Then
$CurrentFund = $FamilySwitch[$a]
Call("HTMLChartEditor")
RunWait(@ComSpec & " /c node --unhandled-rejections=strict server.js", @ScriptDir & "/assets/ChartBuilder/", @SW_HIDE)
_Metro_SetProgress($ProgressBar, 70)
_LogaInfo($CurrentFund & " charts generated in SVG format using amCharts")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Charts generated in SVG format using amCharts")
FileDelete(@ScriptDir & "\assets\ChartBuilder\public\index.html")
FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $DatabaseDir & "\images\charts\" & $FundFamily & "\" & $CurrentFund & "\*.svg", 1)
_Metro_SetProgress($ProgressBar, 92)
_LogaInfo($CurrentFund & " charts moved to the funds InDesign Links folder")
GUICtrlSetData($UpdateLabel, $CurrentFund & " | Charts moved to the funds InDesign Links folder")
Else
ContinueLoop
EndIf
_Metro_SetProgress($ProgressBar, 100)
Next
EndFunc
Func RunExpenseRatios()
If $FundFamily = "Catalyst" Then
GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")
_Metro_SetProgress($ProgressBar, 60)
FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\Catalyst_ExpenseRatios.xlsx", @MyDocumentsDir & "/AutoCharts/vbs/")
RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs Catalyst_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("~~~~~~~~~~~~ Updating Catalyst Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")
_LogaInfo("Updated Catalyst Expense Ratios")
GUICtrlSetData($UpdateLabel, "Updated Catalyst Expense Ratios")
FileMove(@MyDocumentsDir & "/AutoCharts/vbs/Catalyst_ExpenseRatios.csv", $DatabaseDir & "\csv\" & $FundFamily & "\Catalyst_ExpenseRatios.csv", 1)
FileDelete(@MyDocumentsDir & "/AutoCharts/vbs/*.xlsx")
EndIf
If $FundFamily = "Rational" Then
GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
_Metro_SetProgress($ProgressBar, 60)
FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\Rational_ExpenseRatios.xlsx", @MyDocumentsDir & "/AutoCharts/vbs/")
RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs Rational_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
_LogaInfo("~~~~~~~~~~~~ Updating Rational Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
_LogaInfo("Updated Rational Expense Ratios")
GUICtrlSetData($UpdateLabel, "Updated Rational Expense Ratios")
FileMove(@MyDocumentsDir & "/AutoCharts/vbs/Rational_ExpenseRatios.csv", $DatabaseDir & "\csv\" & $FundFamily & "\Rational_ExpenseRatios.csv", 1)
FileDelete(@MyDocumentsDir & "/AutoCharts/vbs/*.xlsx")
EndIf
_Metro_SetProgress($ProgressBar, 100)
EndFunc
Func CreateFactSheetArchive()
Local $Archive
Local Const $sMessage = "Select Save Location"
Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
If @error Then
_GUIDisable($Form1, 0, 50)
_Metro_MsgBox(0, "Error", "No folder was selected.")
_GUIDisable($Form1)
Else
_GUIDisable($Form1, 0, 50)
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$Archive = $sFileSelectFolder & "\FactSheets_" & $Select_Quarter & "-" & $INPT_CurYear & "\"
DirCreate($Archive)
DirCopy($DatabaseDir & "\fin_backup_files", $Archive, 1)
DirCopy($DropboxDir & "\FactSheets", $Archive, 1)
SplashOff()
_Metro_MsgBox(0, "Success", "Created Factsheet Archive at " & $Archive)
_GUIDisable($Form1)
_LogaInfo("Created Factsheet Archive at " & $Archive)
EndIf
EndFunc
