#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
Global $0[24]
Global $1[8]
Global $2[3]
Global $3
Global $4
Global $5 = 'settings.ini'
Global $6 = IniRead($5, 'Settings', 'UserName', '')
Global $7 = IniRead($5, 'Settings', 'CurrentQuarter', '')
Global $8 = IniRead($5, 'Settings', 'CurrentYear', '')
Global $9 = ""
Global $a = IniRead($5, 'Settings', 'DBVerified', 'False')
Global $b = IniRead($5, 'Settings', 'UITheme', '')
Global $c = 9999
Global $d = "\assets\ChartBuilder\public\Data\Backups\"
Global $e = IniRead($5, 'Settings', 'DropboxDir', '')
Global $f = $e & "\Marketing Team Files\AutoCharts_Database"
Global $g[11]
Global Const $h = "struct;uint Mask;int Item;int SubItem;uint State;uint StateMask;ptr Text;int TextMax;int Image;lparam Param;" & "int Indent;int GroupID;uint Columns;ptr pColumns;ptr piColFmt;int iGroup;endstruct"
#Au3Stripper_Ignore_Funcs=__ArrayDisplay_SortCallBack
Func __ArrayDisplay_SortCallBack($i, $j, $k)
If $g[3] = $g[4] Then
If Not $g[7] Then
$g[5] *= -1
$g[7] = 1
EndIf
Else
$g[7] = 1
EndIf
$g[6] = $g[3]
Local $l = _a($k, $i, $g[3])
Local $m = _a($k, $j, $g[3])
If $g[8] = 1 Then
If(StringIsFloat($l) Or StringIsInt($l)) Then $l = Number($l)
If(StringIsFloat($m) Or StringIsInt($m)) Then $m = Number($m)
EndIf
Local $n
If $g[8] < 2 Then
$n = 0
If $l < $m Then
$n = -1
ElseIf $l > $m Then
$n = 1
EndIf
Else
$n = DllCall('shlwapi.dll', 'int', 'StrCmpLogicalW', 'wstr', $l, 'wstr', $m)[0]
EndIf
$n = $n * $g[5]
Return $n
EndFunc
Func _a($k, $o, $p = 0)
Local $q = DllStructCreate("wchar Text[4096]")
Local $r = DllStructGetPtr($q)
Local $s = DllStructCreate($h)
DllStructSetData($s, "SubItem", $p)
DllStructSetData($s, "TextMax", 4096)
DllStructSetData($s, "Text", $r)
If IsHWnd($k) Then
DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $k, "uint", 0x1073, "wparam", $o, "struct*", $s)
Else
Local $t = DllStructGetPtr($s)
GUICtrlSendMsg($k, 0x1073, $o, $t)
EndIf
Return DllStructGetData($q, "Text")
EndFunc
Global Enum $u, $v, $w, $x, $y, $0z, $10, $11
Func _e(ByRef $12, $13, $14 = 0, $15 = "|", $16 = @CRLF, $17 = $u)
If $14 = Default Then $14 = 0
If $15 = Default Then $15 = "|"
If $16 = Default Then $16 = @CRLF
If $17 = Default Then $17 = $u
If Not IsArray($12) Then Return SetError(1, 0, -1)
Local $18 = UBound($12, 1)
Local $19 = 0
Switch $17
Case $w
$19 = Int
Case $x
$19 = Number
Case $y
$19 = Ptr
Case $0z
$19 = Hwnd
Case $10
$19 = String
Case $11
$19 = "Boolean"
EndSwitch
Switch UBound($12, 0)
Case 1
If $17 = $v Then
ReDim $12[$18 + 1]
$12[$18] = $13
Return $18
EndIf
If IsArray($13) Then
If UBound($13, 0) <> 1 Then Return SetError(5, 0, -1)
$19 = 0
Else
Local $1a = StringSplit($13, $15, 2 + 1)
If UBound($1a, 1) = 1 Then
$1a[0] = $13
EndIf
$13 = $1a
EndIf
Local $1b = UBound($13, 1)
ReDim $12[$18 + $1b]
For $1c = 0 To $1b - 1
If String($19) = "Boolean" Then
Switch $13[$1c]
Case "True", "1"
$12[$18 + $1c] = True
Case "False", "0", ""
$12[$18 + $1c] = False
EndSwitch
ElseIf IsFunc($19) Then
$12[$18 + $1c] = $19($13[$1c])
Else
$12[$18 + $1c] = $13[$1c]
EndIf
Next
Return $18 + $1b - 1
Case 2
Local $1d = UBound($12, 2)
If $14 < 0 Or $14 > $1d - 1 Then Return SetError(4, 0, -1)
Local $1e, $1f = 0, $1g
If IsArray($13) Then
If UBound($13, 0) <> 2 Then Return SetError(5, 0, -1)
$1e = UBound($13, 1)
$1f = UBound($13, 2)
$19 = 0
Else
Local $1h = StringSplit($13, $16, 2 + 1)
$1e = UBound($1h, 1)
Local $1a[$1e][0], $1i
For $1c = 0 To $1e - 1
$1i = StringSplit($1h[$1c], $15, 2 + 1)
$1g = UBound($1i)
If $1g > $1f Then
$1f = $1g
ReDim $1a[$1e][$1f]
EndIf
For $1j = 0 To $1g - 1
$1a[$1c][$1j] = $1i[$1j]
Next
Next
$13 = $1a
EndIf
If UBound($13, 2) + $14 > UBound($12, 2) Then Return SetError(3, 0, -1)
ReDim $12[$18 + $1e][$1d]
For $1k = 0 To $1e - 1
For $1j = 0 To $1d - 1
If $1j < $14 Then
$12[$1k + $18][$1j] = ""
ElseIf $1j - $14 > $1f - 1 Then
$12[$1k + $18][$1j] = ""
Else
If String($19) = "Boolean" Then
Switch $13[$1k][$1j - $14]
Case "True", "1"
$12[$1k + $18][$1j] = True
Case "False", "0", ""
$12[$1k + $18][$1j] = False
EndSwitch
ElseIf IsFunc($19) Then
$12[$1k + $18][$1j] = $19($13[$1k][$1j - $14])
Else
$12[$1k + $18][$1j] = $13[$1k][$1j - $14]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($12, 1) - 1
EndFunc
Func _1j($1l)
Local $1m = FileOpen($1l, BitOR(2, 8))
If $1m = -1 Then Return SetError(1, 0, 0)
Local $1n = FileWrite($1m, "")
FileClose($1m)
If Not $1n Then Return SetError(2, 0, 0)
Return 1
EndFunc
Global Const $1o = 0xB1
Func _20($k, $1p, $1q = 0, $1r = 0, $1s = 0, $1t = "wparam", $1u = "lparam", $1v = "lresult")
Local $1w = DllCall("user32.dll", $1v, "SendMessageW", "hwnd", $k, "uint", $1p, $1t, $1q, $1u, $1r)
If @error Then Return SetError(@error, @extended, "")
If $1s >= 0 And $1s <= 4 Then Return $1w[$1s]
Return $1w
EndFunc
Global $1x[16][55535 + 2 + 1]
Func _22($k)
Local $1y, $1z = -1, $20 = True
If Not WinExists($k) Then Return SetError(-1, -1, 0)
For $o = 0 To 16 - 1
If $1x[$o][0] <> 0 Then
If Not WinExists($1x[$o][0]) Then
For $21 = 0 To UBound($1x, 2) - 1
$1x[$o][$21] = 0
Next
$1x[$o][1] = 10000
$20 = False
EndIf
EndIf
Next
For $o = 0 To 16 - 1
If $1x[$o][0] = $k Then
$1z = $o
ExitLoop
EndIf
Next
If $1z = -1 Then
For $o = 0 To 16 - 1
If $1x[$o][0] = 0 Then
$1x[$o][0] = $k
$1x[$o][1] = 10000
$20 = False
$1z = $o
ExitLoop
EndIf
Next
EndIf
If $1z = -1 And $20 Then Return SetError(16, 0, 0)
If $1x[$1z][1] = 10000 + 55535 Then
For $22 = 2 To UBound($1x, 2) - 1
If $1x[$1z][$22] = 0 Then
$1y =($22 - 2) + 10000
$1x[$1z][$22] = $1y
Return $1y
EndIf
Next
Return SetError(-1, 55535, 0)
EndIf
$1y = $1x[$1z][1]
$1x[$1z][1] += 1
$1x[$1z][($1y - 10000) + 2] = $1y
Return $1y
EndFunc
Global Const $23 = "struct;long Left;long Top;long Right;long Bottom;endstruct"
Global Const $24 = "struct;float X;float Y;float Width;float Height;endstruct"
Global Const $25 = "uint Version;ptr Callback;bool NoThread;bool NoCodecs"
Global Const $26 = "uint length;uint flags;uint showCmd;long ptMinPosition[2];long ptMaxPosition[2];long rcNormalPosition[4]"
Global $27, $28 = 0
Global Const $29 = 'struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct'
Global Const $2a = _2p()
Func _25($2b)
Local $1w = DllCall("kernel32.dll", "bool", "FreeLibrary", "handle", $2b)
If @error Then Return SetError(@error, @extended, False)
Return $1w[0]
EndFunc
Func _28($2c)
Local $2d = "wstr"
If $2c = "" Then
$2c = 0
$2d = "ptr"
EndIf
Local $1w = DllCall("kernel32.dll", "handle", "GetModuleHandleW", $2d, $2c)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _2c($2e)
Local $1w = DllCall("kernel32.dll", "handle", "LoadLibraryW", "wstr", $2e)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _2n(ByRef $2f, $2g = 100)
Select
Case UBound($2f, 2)
If $2g < 0 Then
ReDim $2f[$2f[0][0] + 1][UBound($2f, 2)]
Else
$2f[0][0] += 1
If $2f[0][0] > UBound($2f) - 1 Then
ReDim $2f[$2f[0][0] + $2g][UBound($2f, 2)]
EndIf
EndIf
Case UBound($2f, 1)
If $2g < 0 Then
ReDim $2f[$2f[0] + 1]
Else
$2f[0] += 1
If $2f[0] > UBound($2f) - 1 Then
ReDim $2f[$2f[0] + $2g]
EndIf
EndIf
Case Else
Return 0
EndSelect
Return 1
EndFunc
Func _2p()
Local $2h = DllStructCreate($29)
DllStructSetData($2h, 1, DllStructGetSize($2h))
Local $2i = DllCall('kernel32.dll', 'bool', 'GetVersionExW', 'struct*', $2h)
If @error Or Not $2i[0] Then Return SetError(@error, @extended, 0)
Return BitOR(BitShift(DllStructGetData($2h, 2), -8), DllStructGetData($2h, 3))
EndFunc
Func _33($2j)
Return BitShift($2j, 16)
EndFunc
Func _38($2j)
Return BitAND($2j, 0xFFFF)
EndFunc
Func _4a($2k)
Local $1w = DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $2k)
If @error Then Return SetError(@error, @extended, False)
Return $1w[0]
EndFunc
Func _4j($2l)
Local $1w = DllCall("gdi32.dll", "handle", "GetStockObject", "int", $2l)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _4v($2m, $2n)
Local $2i = DllCall('kernel32.dll', 'bool', 'IsBadReadPtr', 'struct*', $2m, 'uint_ptr', $2n)
If @error Then Return SetError(@error, @extended, False)
Return $2i[0]
EndFunc
Func _4x($2m, $2n)
Local $2i = DllCall('kernel32.dll', 'bool', 'IsBadWritePtr', 'struct*', $2m, 'uint_ptr', $2n)
If @error Then Return SetError(@error, @extended, False)
Return $2i[0]
EndFunc
Func _50($2o, $2p, $2n)
If _4v($2p, $2n) Then Return SetError(10, @extended, 0)
If _4x($2o, $2n) Then Return SetError(11, @extended, 0)
DllCall('ntdll.dll', 'none', 'RtlMoveMemory', 'struct*', $2o, 'struct*', $2p, 'ulong_ptr', $2n)
If @error Then Return SetError(@error, @extended, 0)
Return 1
EndFunc
Func _8a($k)
Local $2i = DllCall('user32.dll', 'int', 'HideCaret', 'hwnd', $k)
If @error Then Return SetError(@error, @extended, False)
Return $2i[0]
EndFunc
Func _90($2q, $2r, $2s, $2t, $2u, $2v, $2w, $2x, $2y, $2z = 0, $30 = 0, $31 = 0)
If $30 = 0 Then $30 = _28("")
Local $1w = DllCall("user32.dll", "hwnd", "CreateWindowExW", "dword", $2q, "wstr", $2r, "wstr", $2s, "dword", $2t, "int", $2u, "int", $2v, "int", $2w, "int", $2x, "hwnd", $2y, "handle", $2z, "handle", $30, "struct*", $31)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _98($k)
If Not IsHWnd($k) Then $k = GUICtrlGetHandle($k)
Local $1w = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $k, "wstr", "", "int", 4096)
If @error Or Not $1w[0] Then Return SetError(@error, @extended, '')
Return SetExtended($1w[0], $1w[2])
EndFunc
Func _9a($k)
Local $1w = DllCall("user32.dll", "hwnd", "GetParent", "hwnd", $k)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _9m($k, $32)
Local $33 = Opt("GUIDataSeparatorChar")
Local $34 = StringSplit($32, $33)
If Not IsHWnd($k) Then $k = GUICtrlGetHandle($k)
Local $35 = _98($k)
For $21 = 1 To UBound($34) - 1
If StringUpper(StringMid($35, 1, StringLen($34[$21]))) = StringUpper($34[$21]) Then Return True
Next
Return False
EndFunc
Func _9q($k)
Local $1w = DllCall("user32.dll", "hwnd", "SetFocus", "hwnd", $k)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _9t($k, $36, $2u, $2v, $37, $38, $39)
Local $1w = DllCall("user32.dll", "bool", "SetWindowPos", "hwnd", $k, "hwnd", $36, "int", $2u, "int", $2v, "int", $37, "int", $38, "uint", $39)
If @error Then Return SetError(@error, @extended, False)
Return $1w[0]
EndFunc
If UBound($cmdline) > 1 Then
If $cmdline[1] <> "" Then _gi()
EndIf
Func _g5($3a)
$3b = FileOpen($3a, 26)
$3c = Chr(80) & Chr(75) & Chr(5) & Chr(6) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0) & Chr(0)
FileWrite($3b, $3c)
If @error Then Return SetError(1,0,0)
FileClose($3b)
While Not FileExists($3a)
Sleep(10)
Wend
Return $3a
EndFunc
Func _g7($3d, $3e, $3f = 1)
Local $3g = _gk()
If $3g <> 0 Then Return SetError($3g, 0, 0)
If not _gm($3d) then Return SetError(4,0)
If Not FileExists($3d) Then Return SetError(1, 0, 0)
If StringRight($3e, 1) <> "\" Then $3e &= "\"
$3h = _gc($3d)
$3i = ObjCreate("Shell.Application")
$3j = $3i.NameSpace($3d).CopyHere($3i.Namespace($3e))
While 1
If $3f = 1 then _gn()
If _gc($3d) =($3h+1) Then ExitLoop
Sleep(10)
WEnd
Return SetError(0,0,1)
EndFunc
Func _gb($3d, $3a, $3k, $3f = 1)
Local $3g = _gk()
If $3g <> 0 Then Return SetError($3g, 0, 0)
If not _gm($3d) then Return SetError(4,0)
If Not FileExists($3d) Then Return SetError(1, 0, 0)
If Not FileExists($3k) Then DirCreate($3k)
$3i = ObjCreate("Shell.Application")
$3l = $3i.NameSpace($3d).Parsename($3a)
$3i.NameSpace($3k).Copyhere($3l)
While 1
If $3f = 1 then _gn()
If FileExists($3k & "\" & $3a) Then
return SetError(0, 0, 1)
ExitLoop
EndIf
Sleep(500)
WEnd
EndFunc
Func _gc($3d)
Local $3g = _gk()
If $3g <> 0 Then Return SetError($3g, 0, 0)
If not _gm($3d) then Return SetError(4,0)
If Not FileExists($3d) Then Return SetError(1, 0, 0)
$3m = _ge($3d)
Return UBound($3m) - 1
EndFunc
Func _ge($3d)
local $12[1]
Local $3g = _gk()
If $3g <> 0 Then Return SetError($3g, 0, 0)
If not _gm($3d) then Return SetError(4,0)
If Not FileExists($3d) Then Return SetError(1, 0, 0)
$3i = ObjCreate("Shell.Application")
$3n = $3i.Namespace($3d).Items
For $3o in $3n
_e($12,$3o.name)
Next
$12[0] = UBound($12) - 1
Return $12
EndFunc
Func _gi()
$3p = StringSplit($cmdline[1], ",")
$3q = $3p[1]
$3r = $3p[2]
_gb($3q, $3r, @TempDir & "\", 4+16)
If @error Then Return SetError(@error,0,0)
ShellExecute(@TempDir & "\" & $3r)
EndFunc
Func _gk()
If Not FileExists(@SystemDir & "\zipfldr.dll") Then Return 2
If Not RegRead("HKEY_CLASSES_ROOT\CLSID\{E88DCCE0-B7B3-11d1-A9F0-00AA0060FA31}", "") Then Return 3
Return 0
EndFunc
Func _gm($3s)
if StringInStr($3s,":\") then
Return True
Else
Return False
EndIf
Endfunc
Func _gn()
If ControlGetHandle("[CLASS:#32770]", "", "[CLASS:SysAnimate32; INSTANCE:1]") <> "" And WinGetState("[CLASS:#32770]") <> @SW_HIDE Then
$k = WinGetHandle("[CLASS:#32770]")
WinSetState($k, "", @SW_HIDE)
EndIf
EndFunc
Global Const $3t = 0x400 + 76
Global Const $3u = 0x400 + 95
Global Const $3v = 0x400 + 63
Global Const $3w = 0x400 + 67
Global Const $3x = 0x400 + 68
Global Const $3y = 0x400 + 97
Func _i2($3z)
Local $1w = DllCall("user32.dll", "uint", "RegisterClipboardFormatW", "wstr", $3z)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Global $40, $41, $42 = 1440
Global $43, $44
Global $45 = DllCallbackRegister("_kx", "dword", "long_ptr;ptr;long;ptr")
Global $46 = DllCallbackRegister("_ky", "dword", "long_ptr;ptr;long;ptr")
Global $47 = DllCallbackRegister("_kz", "dword", "long_ptr;ptr;long;ptr")
Global $48 = DllCallbackRegister("_l0", "dword", "long_ptr;ptr;long;ptr")
Global $49
Global $4a = DllStructCreate("ptr pIntf; dword  Refcount")
Global $4b, $4c
Global $4d = DllOpen("OLE32.DLL")
Global $4e = DllCallbackRegister("_l9", "long", "ptr;dword;dword")
Global $4f = DllCallbackRegister("_la", "long", "ptr")
Global $4g = DllCallbackRegister("_lb", "long", "ptr")
Global $4h = DllCallbackRegister("_ll", "long", "ptr;ptr")
Global $4i = DllCallbackRegister("_lc", "long", "ptr;dword;dword;dword")
Global $4j = DllCallbackRegister("_ld", "long", "ptr;long")
Global $4k = DllCallbackRegister("_le", "long", "ptr;dword;ptr;long")
Global $4l = DllCallbackRegister("_lf", "long", "ptr;ptr")
Global $4m = DllCallbackRegister("_lg", "long", "ptr;ptr;dword;dword;dword;ptr")
Global $4n = DllCallbackRegister("_lh", "long", "ptr;long")
Global $4o = DllCallbackRegister("_li", "long", "ptr;ptr;dword;ptr")
Global $4p = DllCallbackRegister("_lj", "long", "ptr;dword;dword;dword")
Global $4q = DllCallbackRegister("_lk", "long", "ptr;short;ptr;ptr;ptr")
Global Const $4r = "struct;uint cbSize;dword dwMask;dword dwEffects;long yHeight;long yOffset;INT crCharColor;" & "byte bCharSet;byte bPitchAndFamily;wchar szFaceName[32];endstruct"
Global Const $4s = $4r & ";word wWeight;short sSpacing;INT crBackColor;dword lcid;dword dwReserved;" & "short sStyle;word wKerning;byte bUnderlineType;byte bAnimation;byte bRevAuthor;byte bReserved1"
Global Const $4t = "dword flags;uint codepage"
Global Const $4u = "dword flags;uint codepage"
Func _i6($k, $4v)
If Not _9m($k, $40) Then Return SetError(101, 0, False)
Local $2n = _iu($k)
_kn($k, $2n, $2n)
Local $4w = DllStructCreate($4u)
DllStructSetData($4w, 1, 2)
Local $4x
If StringLeft($4v, 5) <> "{\rtf" And StringLeft($4v, 5) <> "{urtf" Then
DllStructSetData($4w, 2, 1200)
$4x = _20($k, $3y, $4w, $4v, 0, "struct*", "wstr")
Else
DllStructSetData($4w, 2, 0)
$4x = _20($k, $3y, $4w, $4v, 0, "struct*", "STR")
EndIf
If Not $4x Then Return SetError(700, 0, False)
Return True
EndFunc
Func _ie($k, $4v, $4y, $4z, $2w = 150, $2x = 150, $2t = -1, $2q = -1)
If Not IsHWnd($k) Then Return SetError(1, 0, 0)
If Not IsString($4v) Then Return SetError(2, 0, 0)
If Not _l2($2w, ">0,-1") Then Return SetError(105, 0, 0)
If Not _l2($2x, ">0,-1") Then Return SetError(106, 0, 0)
If Not _l2($2t, ">=0,-1") Then Return SetError(107, 0, 0)
If Not _l2($2q, ">=0,-1") Then Return SetError(108, 0, 0)
If $2w = -1 Then $2w = 150
If $2x = -1 Then $2x = 150
If $2t = -1 Then $2t = BitOR(4096, 4)
If BitAND($2t, 4) <> 0 Then $2t = BitOR($2t, 4096)
If $2q = -1 Then $2q = 0x200
$2t = BitOR($2t, 0x40000000, 0x10000000)
If BitAND($2t, 2048) = 0 Then $2t = BitOR($2t, 0x00010000)
Local $1y = _22($k)
If @error Then Return SetError(@error, @extended, 0)
_kw()
Local $50 = _90($2q, $40, "", $2t, $4y, $4z, $2w, $2x, $k, $1y)
If $50 = 0 Then Return SetError(700, 0, False)
_l8($50)
_20($50, 0x0030, _4j(17), True)
_i6($50, $4v)
Return $50
EndFunc
Func _ig($k)
If Not _9m($k, $40) Then Return SetError(101, 0, False)
_20($k, $1o, -1, 0)
Return True
EndFunc
Func _ip($k, $51)
If Not _9m($k, $40) Then Return SetError(101, 0, 0)
If Not _l2($51) Then Return SetError(102, 0, 0)
Return _20($k, $3t, 5, $51)
EndFunc
Func _iu($k, $52 = True, $53 = False)
If Not _9m($k, $40) Then Return SetError(101, 0, 0)
If Not IsBool($52) Then Return SetError(102, 0, 0)
If Not IsBool($53) Then Return SetError(103, 0, 0)
Local $54 = DllStructCreate($4t)
Local $39 = BitOR(1,($52 ? 2 : 4))
$39 = BitOR($39,($53 ? 0 : 16))
DllStructSetData($54, 1, $39)
DllStructSetData($54, 2,($53 ? 0 : 1200))
Local $4x = _20($k, $3u, $54, 0, 0, "struct*")
Return $4x
EndFunc
Func _jp($k, $4v)
If Not _9m($k, $40) Then Return SetError(101, 0, False)
If $4v = "" Then Return SetError(102, 0, False)
Local $4w = DllStructCreate($4u)
DllStructSetData($4w, 1, 2)
_ig($k)
Local $4x
If StringLeft($4v, 5) <> "{\rtf" And StringLeft($4v, 5) <> "{urtf" Then
DllStructSetData($4w, 2, 1200)
$4x = _20($k, $3y, $4w, $4v, 0, "struct*", "wstr")
Else
DllStructSetData($4w, 2, 0)
$4x = _20($k, $3y, $4w, $4v, 0, "struct*", "STR")
EndIf
If Not $4x Then Return SetError(103, 0, False)
Return True
EndFunc
Func _k2($k, $55 = Default)
If Not _9m($k, $40) Then Return SetError(101, 0, False)
Local $56 = DllStructCreate($4s)
DllStructSetData($56, 1, DllStructGetSize($56))
If $55 = Default Then
DllStructSetData($56, 3, 0x4000000)
$55 = 0
Else
If BitAND($55, 0xff000000) Then Return SetError(1022, 0, False)
EndIf
DllStructSetData($56, 2, 0x4000000)
DllStructSetData($56, 12, $55)
Return _20($k, $3x, 0x1, $56, 0, "wparam", "struct*") <> 0
EndFunc
Func _k3($k, $57 = Default)
If Not _9m($k, $40) Then Return SetError(101, 0, False)
Local $56 = DllStructCreate($4r)
DllStructSetData($56, 1, DllStructGetSize($56))
If $57 = Default Then
DllStructSetData($56, 3, 0x40000000)
$57 = 0
Else
If BitAND($57, 0xff000000) Then Return SetError(1022, 0, False)
EndIf
DllStructSetData($56, 2, 0x40000000)
DllStructSetData($56, 6, $57)
Return _20($k, $3x, 0x1, $56, 0, "wparam", "struct*") <> 0
EndFunc
Func _k4($k, $58 = Default)
If Not _9m($k, $40) Then Return SetError(101, 0, False)
Local $59 = False
If $58 = Default Then
$59 = True
$58 = 0
Else
If BitAND($58, 0xff000000) Then Return SetError(1022, 0, False)
EndIf
_20($k, $3w, $59, $58)
Return True
EndFunc
Func _k9($k, $5a = Default, $2s = Default, $5b = Default, $5c = Default)
Local $5d = 0
If Not _9m($k, $40) Then Return SetError(101, 0, False)
If Not($5a = Default Or _l2($5a, ">0")) Then Return SetError(102, 0, False)
If $2s <> Default Then
Local $5e = StringSplit($2s, " ")
For $1c = 1 To UBound($5e) - 1
If Not StringIsAlpha($5e[$1c]) Then Return SetError(103, 0, False)
Next
EndIf
If Not($5b = Default Or _l2($5b)) Then Return SetError(104, 0, False)
If Not($5c = Default Or _l2($5c)) Then Return SetError(105, 0, False)
Local $56 = DllStructCreate($4s)
DllStructSetData($56, 1, DllStructGetSize($56))
If $5a <> Default Then
$5d = 0x80000000
DllStructSetData($56, 4, Int($5a * 20))
EndIf
If $2s <> Default Then
If StringLen($2s) > 32 - 1 Then SetError(-1, 0, False)
$5d = BitOR($5d, 0x20000000)
DllStructSetData($56, 9, $2s)
EndIf
If $5b <> Default Then
$5d = BitOR($5d, 0x8000000)
DllStructSetData($56, 7, $5b)
EndIf
If $5c <> Default Then
$5d = BitOR($5d, 0x2000000)
DllStructSetData($56, 13, $5c)
EndIf
DllStructSetData($56, 2, $5d)
Local $4x = _20($k, $3x, 0x1, $56, 0, "wparam", "struct*")
If Not $4x Then Return SetError(@error + 200, 0, False)
Return True
EndFunc
Func _kn($k, $5f, $5g, $5h = False)
If Not _9m($k, $40) Then Return SetError(101, 0, False)
If Not _l2($5f, ">=0,-1") Then Return SetError(102, 0, False)
If Not _l2($5g, ">=0,-1") Then Return SetError(103, 0, False)
If Not IsBool($5h) Then Return SetError(104, 0, False)
_20($k, $1o, $5f, $5g)
If $5h Then _20($k, $3v, $5h)
_9q($k)
Return True
EndFunc
Func _kw()
Local $5i = DllCall("kernel32.dll", "ptr", "LoadLibraryW", "wstr", "MSFTEDIT.DLL")
If $5i[0] <> 0 Then
$40 = "RichEdit50W"
$41 = 4.1
Else
$5i = DllCall("kernel32.dll", "ptr", "LoadLibraryW", "wstr", "RICHED20.DLL")
$41 = FileGetVersion(@SystemDir & "\riched20.dll", "ProductVersion")
Switch $41
Case 3.0
$40 = "RichEdit20W"
Case 5.0
$40 = "RichEdit50W"
Case 6.0
$40 = "RichEdit60W"
EndSwitch
EndIf
$43 = _i2("Rich Text Format")
$44 = _i2("Rich Text Format with Objects")
EndFunc
Func _kx($5j, $5k, $5l, $5m)
Local $5n = DllStructCreate("long", $5m)
DllStructSetData($5n, 1, 0)
Local $5o = DllStructCreate("char[" & $5l & "]", $5k)
Local $5p = FileRead($5j, $5l - 1)
If @error Then Return 1
DllStructSetData($5o, 1, $5p)
DllStructSetData($5n, 1, StringLen($5p))
Return 0
EndFunc
Func _ky($5q, $5k, $5l, $5m)
#forceref $5q
Local $5n = DllStructCreate("long", $5m)
DllStructSetData($5n, 1, 0)
Local $5r = DllStructCreate("char[" & $5l & "]", $5k)
Local $5s = StringLeft($49, $5l - 1)
If $5s = "" Then Return 1
DllStructSetData($5r, 1, $5s)
Local $5t = StringLen($5s)
DllStructSetData($5n, 1, $5t)
$49 = StringMid($49, $5t + 1)
Return 0
EndFunc
Func _kz($5j, $5k, $5l, $5m)
Local $5n = DllStructCreate("long", $5m)
DllStructSetData($5n, 1, 0)
Local $5o = DllStructCreate("char[" & $5l & "]", $5k)
Local $5u = DllStructGetData($5o, 1)
FileWrite($5j, $5u)
DllStructSetData($5n, 1, StringLen($5u))
Return 0
EndFunc
Func _l0($5q, $5k, $5l, $5m)
#forceref $5q
Local $5n = DllStructCreate("long", $5m)
DllStructSetData($5n, 1, 0)
Local $5o = DllStructCreate("char[" & $5l & "]", $5k)
Local $5u = DllStructGetData($5o, 1)
$49 &= $5u
Return 0
EndFunc
Func _l2($5v, $5w = "")
If Not(IsNumber($5v) Or StringIsInt($5v) Or StringIsFloat($5v)) Then Return False
Switch $5w
Case ">0"
If $5v <= 0 Then Return False
Case ">=0"
If $5v < 0 Then Return False
Case ">0,-1"
If Not($5v > 0 Or $5v = -1) Then Return False
Case ">=0,-1"
If Not($5v >= 0 Or $5v = -1) Then Return False
EndSwitch
Return True
EndFunc
Func _l8($k)
If Not IsHWnd($k) Then Return SetError(101, 0, False)
If Not $4c Then
$4b = DllStructCreate("ptr[20]")
DllStructSetData($4b, 1, DllCallbackGetPtr($4e), 1)
DllStructSetData($4b, 1, DllCallbackGetPtr($4f), 2)
DllStructSetData($4b, 1, DllCallbackGetPtr($4g), 3)
DllStructSetData($4b, 1, DllCallbackGetPtr($4h), 4)
DllStructSetData($4b, 1, DllCallbackGetPtr($4i), 5)
DllStructSetData($4b, 1, DllCallbackGetPtr($4j), 6)
DllStructSetData($4b, 1, DllCallbackGetPtr($4k), 7)
DllStructSetData($4b, 1, DllCallbackGetPtr($4l), 8)
DllStructSetData($4b, 1, DllCallbackGetPtr($4m), 9)
DllStructSetData($4b, 1, DllCallbackGetPtr($4n), 10)
DllStructSetData($4b, 1, DllCallbackGetPtr($4o), 11)
DllStructSetData($4b, 1, DllCallbackGetPtr($4p), 12)
DllStructSetData($4b, 1, DllCallbackGetPtr($4q), 13)
DllStructSetData($4a, 1, DllStructGetPtr($4b))
DllStructSetData($4a, 2, 1)
$4c = DllStructGetPtr($4a)
EndIf
Local Const $5x = 0x400 + 70
If _20($k, $5x, 0, $4c) = 0 Then Return SetError(700, 0, False)
Return True
EndFunc
Func _l9($5y, $5z, $60)
#forceref $5y, $5z, $60
Return 0
EndFunc
Func _la($5y)
Local $61 = DllStructCreate("ptr;dword", $5y)
DllStructSetData($61, 2, DllStructGetData($61, 2) + 1)
Return DllStructGetData($61, 2)
EndFunc
Func _lb($5y)
Local $61 = DllStructCreate("ptr;dword", $5y)
If DllStructGetData($61, 2) > 0 Then
DllStructSetData($61, 2, DllStructGetData($61, 2) - 1)
Return DllStructGetData($61, 2)
EndIf
EndFunc
Func _lc($5y, $62, $63, $64)
#forceref $5y, $62, $63, $64
Return 0x80004001
EndFunc
Func _ld($5y, $65)
#forceref $5y, $65
Return 0x80004001
EndFunc
Func _le($5y, $66, $67, $68)
#forceref $5y, $66, $67, $68
Return 0
EndFunc
Func _lf($5y, $69)
#forceref $5y, $69
Return 0x80004001
EndFunc
Func _lg($5y, $6a, $6b, $6c, $6d, $6e)
#forceref $5y, $6a, $6b, $6c, $6d, $6e
Return 0
EndFunc
Func _lh($5y, $6f)
#forceref $5y, $6f
Return 0x80004001
EndFunc
Func _li($5y, $6g, $6c, $6h)
#forceref $5y, $6g, $6c, $6h
Return 0x80004001
EndFunc
Func _lj($5y, $6i, $6j, $6k)
#forceref $5y, $6i, $6j, $6k
Return 0x80004001
EndFunc
Func _lk($5y, $6l, $69, $6g, $6m)
#forceref $5y, $6l, $69, $6g, $6m
Return 0x80004001
EndFunc
Func _ll($5y, $6n)
#forceref $5y
Local $6o = DllCall($4d, "dword", "CreateILockBytesOnHGlobal", "hwnd", 0, "int", 1, "ptr*", 0)
Local $6p = $6o[3]
$6o = $6o[0]
If $6o Then Return $6o
$6o = DllCall($4d, "dword", "StgCreateDocfileOnILockBytes", "ptr", $6p, "dword", BitOR(0x10, 2, 0x1000), "dword", 0, "ptr*", 0)
Local $67 = DllStructCreate("ptr", $6n)
DllStructSetData($67, 1, $6o[4])
$6o = $6o[0]
If $6o Then
Local $6q = DllStructCreate("ptr", $6p)
Local $6r = DllStructCreate("ptr[3]", DllStructGetData($6q, 1))
Local $6s = DllStructGetData($6r, 3)
DllCallAddress("long", $6s, "ptr", $6p)
EndIf
Return $6o
EndFunc
Global Const $6t = Ptr(-1)
Global Const $6u = Ptr(-1)
Global Const $6v = BitShift(0x0100, 8)
Global Const $6w = BitShift(0x2000, 8)
Global Const $6x = BitShift(0x8000, 8)
Func _n0($k)
Local $6y = DllStructCreate($26)
DllStructSetData($6y, "length", DllStructGetSize($6y))
Local $2i = DllCall("user32.dll", "bool", "GetWindowPlacement", "hwnd", $k, "struct*", $6y)
If @error Or Not $2i[0] Then Return SetError(@error + 10, @extended, 0)
Return $6y
EndFunc
Func _nm($k, $6y)
Local $1w = DllCall("user32.dll", "bool", "SetWindowPlacement", "hwnd", $k, "struct*", $6y)
If @error Then Return SetError(@error, @extended, False)
Return $1w[0]
EndFunc
Func _ov($2b, $6z)
Local $70 = "str"
If IsNumber($6z) Then $70 = "word"
Local $1w = DllCall("kernel32.dll", "ptr", "GetProcAddress", "handle", $2b, $70, $6z)
If @error Or Not $1w[0] Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _py()
Local $1w = DllCall("user32.dll", "bool", "ReleaseCapture")
If @error Then Return SetError(@error, @extended, False)
Return $1w[0]
EndFunc
Func _q1($k)
Local $1w = DllCall("user32.dll", "hwnd", "SetCapture", "hwnd", $k)
If @error Then Return SetError(@error, @extended, 0)
Return $1w[0]
EndFunc
Func _qn($k, $1p, $1q, $1r)
Local $2i = DllCall('comctl32.dll', 'lresult', 'DefSubclassProc', 'hwnd', $k, 'uint', $1p, 'wparam', $1q, 'lparam', $1r)
If @error Then Return SetError(@error, @extended, 0)
Return $2i[0]
EndFunc
Func _qt($k, $71, $72)
Local $2i = DllCall('comctl32.dll', 'bool', 'RemoveWindowSubclass', 'hwnd', $k, 'ptr', $71, 'uint_ptr', $72)
If @error Then Return SetError(@error, @extended, False)
Return $2i[0]
EndFunc
Func _qv($k, $71, $72, $73 = 0)
Local $2i = DllCall('comctl32.dll', 'bool', 'SetWindowSubclass', 'hwnd', $k, 'ptr', $71, 'uint_ptr', $72, 'dword_ptr', $73)
If @error Then Return SetError(@error, @extended, 0)
Return $2i[0]
EndFunc
Func _ug($74 = 0, $75 = 0)
Local $76 = DllCallbackRegister('_ys', 'bool', 'handle;handle;ptr;lparam')
Dim $27[101][2] = [[0]]
Local $2i = DllCall('user32.dll', 'bool', 'EnumDisplayMonitors', 'handle', $74, 'struct*', $75, 'ptr', DllCallbackGetPtr($76), 'lparam', 0)
If @error Or Not $2i[0] Or Not $27[0][0] Then
$27 = @error + 10
EndIf
DllCallbackFree($76)
If $27 Then Return SetError($27, 0, 0)
_2n($27, -1)
Return $27
EndFunc
Func _vp($75)
Local $1w[4]
For $1c = 0 To 3
$1w[$1c] = DllStructGetData($75, $1c + 1)
If @error Then Return SetError(@error, @extended, 0)
Next
For $1c = 2 To 3
$1w[$1c] -= $1w[$1c - 2]
Next
Return $1w
EndFunc
Func _wo($k, $77 = 1)
Local $2i = DllCall('user32.dll', 'handle', 'MonitorFromWindow', 'hwnd', $k, 'dword', $77)
If @error Then Return SetError(@error, @extended, 0)
Return $2i[0]
EndFunc
Func _ys($78, $74, $79, $1r)
#forceref $74, $1r
_2n($27)
$27[$27[0][0]][0] = $78
If Not $79 Then
$27[$27[0][0]][1] = 0
Else
$27[$27[0][0]][1] = DllStructCreate($23)
If Not _50(DllStructGetPtr($27[$27[0][0]][1]), $79, 16) Then Return 0
EndIf
Return 1
EndFunc
Global $7a = 0
Global $7b[0]
Global $7c[0]
Global $7d = 0
Global $7e = 0
Global $7f = False
Global $7g = -1
Global Const $7h = BitOR(64, 32, 16, 8, 4, 2, 1)
Global Enum $7i, $7j, $7k, $7l, $7m, $7n, $7o, $7p, $7q, $7r, $7s, $7t, $7u, $7v, $7w, $7x, $7y, $7z, $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f, $8g, $8h, $8i, $8j, $8k, $8l, $8m, $8n, $8o, $8p, $8q, $8r, $8s, $8t, $8u, $8v, $8w, $8x, $8y, $8z, $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a
$7g = -1
OnAutoItExitRegister('_11s')
Func _119($9b, $9c = 1, Const $9d = @error, Const $9e = @extended)
SetError($9d, $9e)
_11v($9b, 8, $9c)
SetError($9d, $9e)
EndFunc
Func _11b($9b, $9c = 1, Const $9d = @error, Const $9e = @extended)
SetError($9d, $9e)
_11v($9b, 2, $9c)
SetError($9d, $9e)
EndFunc
Func _11k($9c = 1)
Local $5j = 0
If IsDllStruct($9c) Then
$5j = $9c.hFile
Else
If $9c > $7a Or $9c <= 0 Then Return
$5j =($7c[$9c - 1])[$7o]
EndIf
$5j = Int($5j)
FileFlush($5j)
FileClose($5j)
EndFunc
Func _11q($9f = "")
If Not $7d Then
$7d = DllCallbackRegister('_11r', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
$7e = DllCallbackGetPtr($7d)
EndIf
Local $9g = DllStructCreate("uint __InstanceIndex;ulong __LogIndex;wchar Name[512];uint Level;" & "bool LogToFile;bool LogFileAutoFlush;handle hFile;bool LogToGUI;bool ShowGUIOnCompiled;bool LogToStdError;" & "handle __hGUI;handle __hRichEdit;int AppendType;bool GUIShowLevelSymbol;int GUIBkColor;uint Trans;int Left;int Top;int Width;int Height;" & "wchar FilePath[512];wchar Format[512];wchar EndOfLine[128];" & "wchar TraceSymbol[2];wchar TraceFontName[512];wchar TraceString[512];int TraceFontColor;Int TraceFontBkColor;int TraceFontSize;int TraceCharSet;" & "wchar DebugSymbol[2];wchar DebugFontName[512];wchar DebugString[512];int DebugFontColor;Int DebugFontBkColor;int DebugFontSize;int DebugCharSet;" & "wchar InfoSymbol[2];wchar InfoFontName[512];wchar InfoString[512];int InfoFontColor;Int InfoFontBkColor;int InfoFontSize;int InfoCharSet;" & "wchar WarnSymbol[2];wchar WarnFontName[512];wchar WarnString[512];int WarnFontColor;Int WarnFontBkColor;int WarnFontSize;int WarnCharSet;" & "wchar ErrorSymbol[2];wchar ErrorFontName[512];wchar ErrorString[512];int ErrorFontColor;Int ErrorFontBkColor;int ErrorFontSize;int ErrorCharSet;" & "wchar FatalSymbol[2];wchar FatalFontName[512];wchar FatalString[512];int FatalFontColor;Int FatalFontBkColor;int FatalFontSize;int FatalCharSet;")
$7a += 1
$9g.__InstanceIndex = $7a
$9g.__LogIndex = 1
_124($9g)
_123($9g, $9f)
Local $9h = _125($9g)
If IsArray($9h) Then
If $9h[$7p] Then
Local $9i = _121($9h[$7k], $9h[$80], $9h[$81], $9h[$7y], $9h[$7z], $9h[$7v], $9h[$7x], $9h[$7r])
$9g.__hGUI = $9i[0]
$9g.__hRichEdit = $9i[1]
_120($9g, $9h)
_qv($9h[$7s], $7e, 76797165, 0)
EndIf
If $9h[$7m] Then
If Not $9h[$7n] Then $9h[$7o] = FileOpen($9h[$82], 2)
$9g.hFile = $9h[$7o]
_120($9g, $9h)
EndIf
EndIf
ReDim $7b[$7a]
ReDim $7c[$7a]
$7b[$7a - 1] = $9g
$7c[$7a - 1] = $9h
Return $7b[$7a - 1]
EndFunc
Func _11r($k, $1p, $1q, $1r, $9j, $73)
#forceref $9j, $73
Local Const $9k = 0xF060
If $1p = 0x0005 Then
Local $9l = _122($k)
If $9l Then
Local $9m = _38($1r)
Local $9n = _33($1r)
_9t($9l, 0, 0, 0, $9m - 1, $9n - 1, BitOR(0x0010, 0x0004))
Return 'GUI_RUNDEFMSG'
EndIf
EndIf
If $1p = 0x0112 And $1q = $9k Then
GUISetState(@SW_HIDE, $k)
Return 'GUI_RUNDEFMSG'
EndIf
Return _qn($k, $1p, $1q, $1r)
EndFunc
Func _11s()
Local $9o = 0
For $1c = 0 To $7a - 1
_11k(($7c[$1c])[$7o])
$9o =($7c[$1c])[$7s]
If WinExists($9o) Then _qt($9o, $7e, 76797165)
Next
If $7d Then DllCallbackFree($7d)
EndFunc
Func _11t($9h, $9p, $9b, Const $9d = @error, Const $9e = @extended)
Local $9q = $9h[$83]
If StringInStr($9q, "{Symbol}", 2) Then
Select
Case $9p = 32
$9q = StringReplace($9q, "{Symbol}", $9h[$85])
Case $9p = 16
$9q = StringReplace($9q, "{Symbol}", $9h[$8c])
Case $9p = 8
$9q = StringReplace($9q, "{Symbol}", $9h[$8j])
Case $9p = 4
$9q = StringReplace($9q, "{Symbol}", $9h[$8q])
Case $9p = 2
$9q = StringReplace($9q, "{Symbol}", $9h[$8x])
Case $9p = 1
$9q = StringReplace($9q, "{Symbol}", $9h[$94])
Case Else
EndSelect
EndIf
Select
Case StringInStr($9q, "{LongDateTime}", 2)
$9q = StringReplace($9q, "{LongDateTime}", StringFormat("%02d\\%02d\\%04d %02d:%02d:%02d", @MDAY, @MON, @YEAR, @HOUR, @MIN, @SEC))
Case StringInStr($9q, "{DateTime}", 2)
$9q = StringReplace($9q, "{DateTime}", StringFormat("%02d\\%02d\\%04d %02d:%02d", @MDAY, @MON, @YEAR, @HOUR, @MIN))
Case StringInStr($9q, "{Date}", 2)
$9q = StringReplace($9q, "{Date}", StringFormat("%02d\\%02d\\%04d", @MDAY, @MON, @YEAR))
Case StringInStr($9q, "{Time}", 2)
$9q = StringReplace($9q, "{Time}", StringFormat("%02d:%02d:%02d", @HOUR, @MIN, @SEC))
Case Else
EndSelect
If StringInStr($9q, "{LevelName}", 2) Then
Select
Case $9p = 32
$9q = StringReplace($9q, "{LevelName}", $9h[$87])
Case $9p = 16
$9q = StringReplace($9q, "{LevelName}", $9h[$8e])
Case $9p = 8
$9q = StringReplace($9q, "{LevelName}", $9h[$8l])
Case $9p = 4
$9q = StringReplace($9q, "{LevelName}", $9h[$8s])
Case $9p = 2
$9q = StringReplace($9q, "{LevelName}", $9h[$8z])
Case $9p = 1
$9q = StringReplace($9q, "{LevelName}", $9h[$96])
Case Else
EndSelect
EndIf
If StringInStr($9q, "{Message}", 2) Then
$9q = StringReplace($9q, "{Message}", $9b)
EndIf
If StringInStr($9q, "{LogaName}", 2) Then
$9q = StringReplace($9q, "{LogaName}", $9h[$7k])
EndIf
If StringInStr($9q, "{LogIndex}", 2) Then
$9q = StringReplace($9q, "{LogIndex}", StringFormat("%010s", $9h[$7j]))
EndIf
If StringInStr($9q, "{error}",2) Then
$9q = StringReplace($9q, "{error}", $9d)
EndIf
If StringInStr($9q, "{extended}",2) Then
$9q = StringReplace($9q, "{extended}", $9e)
EndIf
Return $9q & $9h[$84]
EndFunc
Func _11u($9h, $9p)
Local $9r[5] = ["Consolas", 10, 0x000000, 0xFFFFFF, 1]
Select
Case $9p = 32
$9r[0] = $9h[$86]
$9r[1] = $9h[$8a]
$9r[2] = $9h[$88]
$9r[3] = $9h[$89]
$9r[4] = $9h[$8b]
Case $9p = 16
$9r[0] = $9h[$8d]
$9r[1] = $9h[$8h]
$9r[2] = $9h[$8f]
$9r[3] = $9h[$8g]
$9r[4] = $9h[$8i]
Case $9p = 8
$9r[0] = $9h[$8k]
$9r[1] = $9h[$8o]
$9r[2] = $9h[$8m]
$9r[3] = $9h[$8n]
$9r[4] = $9h[$8p]
Case $9p = 4
$9r[0] = $9h[$8r]
$9r[1] = $9h[$8v]
$9r[2] = $9h[$8t]
$9r[3] = $9h[$8u]
$9r[4] = $9h[$8w]
Case $9p = 2
$9r[0] = $9h[$8y]
$9r[1] = $9h[$92]
$9r[2] = $9h[$90]
$9r[3] = $9h[$91]
$9r[4] = $9h[$93]
Case $9p = 1
$9r[0] = $9h[$95]
$9r[1] = $9h[$99]
$9r[2] = $9h[$97]
$9r[3] = $9h[$98]
$9r[4] = $9h[$9a]
Case Else
EndSelect
Return $9r
EndFunc
Func _11v($9b, $9p, $9c = 1, Const $9d = @error, Const $9e = @extended)
If IsDllStruct($9c) Then
$9c = $9c.__InstanceIndex
Else
If $7a = 0 Then _11q()
If $9c > $7a Then $9c = 1
If $9c <= 0 Then $9c = 1
EndIf
Local $9h = $7c[$9c - 1]
Local $9s = $9h[$7l]
If $9h[$7i] = -1 Then Return SetError(0, 0, 0)
If $9s = 0 Then Return SetError(0, 0, 0)
If Not BitAND($7g, $9p) Then
Return SetError(0, 0, 0)
EndIf
If $7g = -1 Then
If Not BitAND($9s, $9p) Then
Return SetError(0, 0, 0)
EndIf
EndIf
SetError($9d,$9e)
Local $9q = _11t($9h, $9p, $9b)
ConsoleWrite($9q)
If $9h[$7q] Then ConsoleWriteError($9q)
$9h[$7j] += 1
$7c[$9c - 1] = $9h
If $9h[$7p] And((Not @Compiled) Or $9h[$7r] Or $7f) Then
Local $9t = _11u($9h, $9p)
Local $9u = $9t[0]
Local $9v = $9t[1]
Local $9w = "0x" & $9t[2]
Local $9x = "0x" & $9t[3]
Local $9y = $9t[4]
If $9h[$7w] Then
_11w($9h[$7t], $9q, $9u, $9v, $9w, $9x, $9y, $9h[$7u])
Else
Local $9z = StringMid($9q, 1)
Local $a0 = $9h[$8c] & "|" & $9h[$85] & "|" & $9h[$8q] & "|" & $9h[$8j] & "|" & $9h[$8x] & "|" & $9h[$94]
$a0 = StringRegExpReplace($a0, '+', '\+')
If StringRegExp($9z, $a0) Then $9q = StringMid($9q, 2)
_11w($9h[$7t], $9q, $9u, $9v, $9w, $9x, $9y, $9h[$7u])
EndIf
EndIf
If $9h[$7m] Then
If $9h[$7n] Then
FileWrite($9h[$82], $9q)
Else
FileWrite(Int($9h[$7o]), $9q)
EndIf
EndIf
EndFunc
Func _11w($k, $4v, $a1, $a2, $9w, $9x, $9y, $a3)
ConsoleWrite($a1 & @CRLF)
Local $2n = _iu($k, True, True)
Local $a4 = _ip($k, $2n)
If $a3 = 1 Then
_i6($k, $4v)
_kn($k, $a4 - 1, $2n + StringLen($4v), False)
Else
_kn($k, 0, 0, True)
_jp($k, $4v)
_kn($k, 0, StringLen($4v) - 1, True)
EndIf
_k9($k, $a2, $a1, $9y)
_k3($k, $9w)
_k2($k, $9x)
_ig($k)
_8a($k)
EndFunc
Func _120($9g, ByRef $9h)
If IsArray($9h) Then
$9h[$7i] = $9g.__InstanceIndex
$9h[$7j] = $9g.__LogIndex
$9h[$7k] = $9g.Name
$9h[$7l] = $9g.Level
$9h[$7m] = $9g.LogToFile
$9h[$7n] = $9g.LogFileAutoFlush
$9h[$7o] = $9g.hFile
$9h[$7p] = $9g.LogToGUI
$9h[$7q] = $9g.LogToStdError
$9h[$7r] = $9g.ShowGUIOnCompiled
$9h[$7s] = $9g.__hGUI
$9h[$7t] = $9g.__hRichEdit
$9h[$7u] = $9g.AppendType
$9h[$7w] = $9g.GUIShowLevelSymbol
$9h[$7v] = Hex($9g.GUIBkColor)
$9h[$7x] = $9g.Trans
$9h[$7y] = $9g.Left
$9h[$7z] = $9g.Top
$9h[$80] = $9g.Width
$9h[$81] = $9g.Height
$9h[$82] = $9g.FilePath
$9h[$83] = $9g.Format
$9h[$84] = $9g.EndOfLine
$9h[$85] = $9g.TraceSymbol
$9h[$86] = $9g.TraceFontName
$9h[$87] = $9g.TraceString
$9h[$88] = Hex($9g.TraceFontColor)
$9h[$89] =($9g.TraceFontBkColor = -1) ? $9h[$7v] : Hex($9g.TraceFontBkColor)
$9h[$8a] = $9g.TraceFontSize
$9h[$8b] = $9g.TraceCharSet
$9h[$8c] = $9g.DebugSymbol
$9h[$8d] = $9g.DebugFontName
$9h[$8e] = $9g.DebugString
$9h[$8f] = Hex($9g.DebugFontColor)
$9h[$8g] =($9g.DebugFontBkColor = -1) ? $9h[$7v] : Hex($9g.DebugFontBkColor)
$9h[$8h] = $9g.DebugFontSize
$9h[$8i] = $9g.DebugCharSet
$9h[$8j] = $9g.InfoSymbol
$9h[$8k] = $9g.InfoFontName
$9h[$8l] = $9g.InfoString
$9h[$8m] = Hex($9g.InfoFontColor)
$9h[$8n] =($9g.InfoFontBkColor = -1) ? $9h[$7v] : Hex($9g.InfoFontBkColor)
$9h[$8o] = $9g.InfoFontSize
$9h[$8p] = $9g.InfoCharSet
$9h[$8q] = $9g.WarnSymbol
$9h[$8r] = $9g.WarnFontName
$9h[$8s] = $9g.WarnString
$9h[$8t] = Hex($9g.WarnFontColor)
$9h[$8u] =($9g.WarnFontBkColor = -1) ? $9h[$7v] : Hex($9g.WarnFontBkColor)
$9h[$8v] = $9g.WarnFontSize
$9h[$8w] = $9g.WarnCharSet
$9h[$8x] = $9g.ErrorSymbol
$9h[$8y] = $9g.ErrorFontName
$9h[$8z] = $9g.ErrorString
$9h[$90] = Hex($9g.ErrorFontColor)
$9h[$91] =($9g.ErrorFontBkColor = -1) ? $9h[$7v] : Hex($9g.ErrorFontBkColor)
$9h[$92] = $9g.ErrorFontSize
$9h[$93] = $9g.ErrorCharSet
$9h[$94] = $9g.FatalSymbol
$9h[$95] = $9g.FatalFontName
$9h[$96] = $9g.FatalString
$9h[$97] = Hex($9g.FatalFontColor)
$9h[$98] =($9g.FatalFontBkColor = -1) ? $9h[$7v] : Hex($9g.FatalFontBkColor)
$9h[$99] = $9g.FatalFontSize
$9h[$9a] = $9g.FatalCharSet
EndIf
EndFunc
Func _121($a5, $2w, $2x, $4y, $4z, $a6, $a7, $a8)
Local $9o = GUICreate($a5, $2w, $2x, $4y, $4z, BitOR(0x00040000, 0x00020000), 0x00000008)
Local $9l = _ie($9o, "", 0, 0, $2w, $2x, 2048 + 0x00100000 + 4 + 0x00200000 + 64)
_8a($9l)
GUISetBkColor($a6, $9o)
_k4($9l, $a6)
WinSetTrans($9o, "", $a7)
Local $9r[2] = [$9o, $9l]
If((Not @Compiled) Or $a8 Or $7f) Then
GUISetState(@SW_SHOW, $9o)
EndIf
Return $9r
EndFunc
Func _122($k)
Local $9l = 0
For $1c = 0 To $7a - 1
If($7c[$1c])[$7s] = $k Then
$9l =($7c[$1c])[$7t]
ExitLoop
EndIf
Next
Return $9l
EndFunc
Func _123($9g, $9f)
Local Const $a9 = "Name|Level|LogToFile|LogFileAutoFlush|LogToGUI|ShowGUIOnCompiled|LogToStdError|GUIShowLevelSymbol|GUIBkColor|" & "Trans|Left|Top|Width|Height|FilePath|Format|EndOfLine|AppendType|" & "TraceSymbol|TraceFontName|TraceString|TraceFontColor|TraceFontBkColor|TraceFontSize|TraceCharSet|" & "DebugSymbol|DebugFontName|DebugString|DebugFontColor|DebugFontBkColor|DebugFontSize|DebugCharSet|" & "InfoSymbol|InfoFontName|InfoString|InfoFontColor|InfoFontBkColor|InfoFontSize|InfoCharSet|" & "WarnSymbol|WarnFontName|WarnString|WarnFontColor|WarnFontBkColor|WarnFontSize|WarnCharSet|" & "ErrorSymbol|ErrorFontName|ErrorString|ErrorFontColor|ErrorFontBkColor|ErrorFontSize|ErrorCharSet|" & "FatalSymbol|FatalFontName|FatalString|FatalFontColor|FatalFontBkColor|FatalFontSize|FatalCharSet|"
If $9f = "" Then Return
If IsDllStruct($9g) Then
Local $aa = StringRegExp($9f, '(?>' & $a9 & ')="[^"]*"', 3)
Local $ab = ""
Local $ac = ""
Local $ad = ""
Local $ae = ""
Local $af = ""
For $1c = 0 To UBound($aa) - 1
$ab = StringRegExp($aa[$1c], '^[^=]+', 3)
$ad = StringRegExp($aa[$1c], '"([^"]*)"', 3)
If IsArray($ab) And IsArray($ad) Then
$ac = $ab[0]
$ae = $ad[0]
$af = StringRegExp($ae, "true|false|0[xX][0-9a-fA-F]+|^\d+$|^\$") ? $ae : '"' & $ae & '"'
If StringRegExp($ac, $a9) Then
Execute('DllStructSetData($tLoga,"' & $ac & '",' & $af & ')')
EndIf
EndIf
Next
EndIf
EndFunc
Func _124($9g)
If IsDllStruct($9g) Then
$9g.Name = StringFormat("%s%05s", "Loga-", $9g.__InstanceIndex)
$9g.Level = $7h
$9g.LogToFile = True
$9g.LogFileAutoFlush = True
$9g.hFile = 0
$9g.LogToGUI = False
$9g.LogToStdError = False
$9g.ShowGUIOnCompiled = False
$9g.__hGUI = 0
$9g.___hRichEdit = 0
$9g.AppendType = 1
$9g.GUIShowLevelSymbol = False
$9g.GUIBkColor = 0xFFFFFF
$9g.Trans = 255
$9g.Left = 1
$9g.Top = 1
$9g.Width = 600
$9g.Height = 300
$9g.FilePath = @ScriptDir & "\" & @YEAR & @MON & @MDAY & @HOUR & @MIN & "-Loga-" & $9g.__InstanceIndex & ".log"
$9g.Format = "{Symbol}{LogIndex} {LevelName} {LongDateTime} {Message}"
$9g.EndOfLine = @CRLF
$9g.TraceSymbol = ">"
$9g.TraceFontName = "Consolas"
$9g.TraceString = StringFormat("%-7s", "[Trace]")
$9g.TraceFontColor = 0x000000
$9g.TraceFontBkColor = -1
$9g.TraceFontSize = 10
$9g.TraceCharSet = 1
$9g.DebugSymbol = ">"
$9g.DebugFontName = "Consolas"
$9g.DebugString = StringFormat("%-7s", "[Debug]")
$9g.DebugFontColor = 0x000000
$9g.DebugFontBkColor = -1
$9g.DebugFontSize = 10
$9g.DebugCharSet = 1
$9g.InfoSymbol = "+"
$9g.InfoFontName = "Consolas"
$9g.InfoString = StringFormat("%-7s", "[Info]")
$9g.InfoFontColor = 0x000000
$9g.InfoFontBkColor = -1
$9g.InfoFontSize = 10
$9g.InfoCharSet = 1
$9g.WarnSymbol = "-"
$9g.WarnFontName = "Consolas"
$9g.WarnString = StringFormat("%-7s", "[Warn]")
$9g.WarnFontColor = 0x000000
$9g.WarnFontBkColor = -1
$9g.WarnFontSize = 10
$9g.WarnCharSet = 1
$9g.ErrorSymbol = "!"
$9g.ErrorFontName = "Consolas"
$9g.ErrorString = StringFormat("%-7s", "[Error]")
$9g.ErrorFontColor = 0x000000
$9g.ErrorFontBkColor = -1
$9g.ErrorFontSize = 10
$9g.ErrorCharSet = 1
$9g.FatalSymbol = "!"
$9g.FatalFontName = "Consolas"
$9g.FatalString = StringFormat("%-7s", "[Fatal]")
$9g.FatalFontColor = 0x000000
$9g.FatalFontBkColor = -1
$9g.FatalFontSize = 10
$9g.FatalCharSet = 1
EndIf
EndFunc
Func _125($9g)
If IsDllStruct($9g) Then
Local $9h[65]
$9h[$7i] = $9g.__InstanceIndex
$9h[$7k] = $9g.Name
$9h[$7l] = $9g.Level
$9h[$7m] = $9g.LogToFile
$9h[$7n] = $9g.LogFileAutoFlush
$9h[$7o] = $9g.hFile
$9h[$7p] = $9g.LogToGUI
$9h[$7q] = $9g.LogToStdError
$9h[$7r] = $9g.ShowGUIOnCompiled
$9h[$7s] = $9g.__hGUI
$9h[$7t] = $9g.__hRichEdit
$9h[$7w] = $9g.GUIShowLevelSymbol
$9h[$7v] = $9g.GUIBkColor
$9h[$7x] = $9g.Trans
$9h[$7y] = $9g.Left
$9h[$7z] = $9g.Top
$9h[$80] = $9g.Width
$9h[$81] = $9g.Height
$9h[$82] = $9g.FilePath
$9h[$83] = $9g.Format
$9h[$84] = $9g.EndOfLine
$9h[$85] = $9g.TraceSymbol
$9h[$86] = $9g.TraceFontName
$9h[$87] = $9g.TraceString
$9h[$88] = $9g.TraceFontColor
$9h[$89] = $9g.TraceFontBkColor
$9h[$8a] = $9g.TraceFontSize
$9h[$8b] = $9g.TraceCharSet
$9h[$8c] = $9g.DebugSymbol
$9h[$8d] = $9g.DebugFontName
$9h[$8e] = $9g.DebugString
$9h[$8f] = $9g.DebugFontColor
$9h[$8g] = $9g.DebugFontBkColor
$9h[$8h] = $9g.DebugFontSize
$9h[$8i] = $9g.DebugCharSet
$9h[$8j] = $9g.InfoSymbol
$9h[$8k] = $9g.InfoFontName
$9h[$8l] = $9g.InfoString
$9h[$8m] = $9g.InfoFontColor
$9h[$8n] = $9g.InfoFontBkColor
$9h[$8o] = $9g.InfoFontSize
$9h[$8p] = $9g.InfoCharSet
$9h[$8q] = $9g.WarnSymbol
$9h[$8r] = $9g.WarnFontName
$9h[$8s] = $9g.WarnString
$9h[$8t] = $9g.WarnFontColor
$9h[$8u] = $9g.WarnFontBkColor
$9h[$8v] = $9g.WarnFontSize
$9h[$8w] = $9g.WarnCharSet
$9h[$8x] = $9g.ErrorSymbol
$9h[$8y] = $9g.ErrorFontName
$9h[$8z] = $9g.ErrorString
$9h[$90] = $9g.ErrorFontColor
$9h[$91] = $9g.ErrorFontBkColor
$9h[$92] = $9g.ErrorFontSize
$9h[$93] = $9g.ErrorCharSet
$9h[$94] = $9g.FatalSymbol
$9h[$95] = $9g.FatalFontName
$9h[$96] = $9g.FatalString
$9h[$97] = $9g.FatalFontColor
$9h[$98] = $9g.FatalFontBkColor
$9h[$99] = $9g.FatalFontSize
$9h[$9a] = $9g.FatalCharSet
EndIf
Return $9h
EndFunc
Global $ag = 'FilePath="AutoCharts.log"'
Global $ah = _11q($ag)
Local $ai
Local $aj
Global $ak
Func _126()
If FileExists($e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\.checkfile") Then
$a = True
IniWrite($5, 'Settings', 'DBVerified', $a)
Else
$a = False
IniWrite($5, 'Settings', 'DBVerified', $a)
SetError(50)
EndIf
EndFunc
Func _127()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$ai = $e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files"
$aj = $f & "\fin_backup_files"
$ak = TimerInit()
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "")
$ai = $f & "\fin_backup_files"
$aj = @ScriptDir & $d
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Synced Dropbox data with Autocharts Data")
$ai = $f & "\amCharts"
$aj = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func _128()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$ai = $e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst"
$aj = $f & "\fin_backup_files\Catalyst"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$ai = $f & "\fin_backup_files\Catalyst"
$aj = @ScriptDir & $d & "\Catalyst"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Pulled All Catalyst Data from Dropbox")
$ai = $f & "\amCharts"
$aj = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func _129()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$ai = $e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst\" & $4 & "\"
$aj = $f & "\fin_backup_files\Catalyst\" & $4 & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$ai = $f & "\fin_backup_files\Catalyst\" & $4 & "\"
$aj = @ScriptDir & $d & "\Catalyst\" & $4 & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Pulled " & $4 & " Data from Dropbox")
$ai = $f & "\amCharts"
$aj = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func _12a()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$ai = $e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational\"
$aj = $f & "\fin_backup_files\Rational\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$ai = $f & "\fin_backup_files\Rational\"
$aj = @ScriptDir & $d & "\Rational\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Pulled Rational Data from Dropbox")
$ai = $f & "\amCharts"
$aj = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func _12b()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$ai = $e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational\" & $4 & "\"
$aj = $f & "\fin_backup_files\Rational\" & $4 & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$ai = $f & "\fin_backup_files\Rational\" & $4 & "\"
$aj = @ScriptDir & $d & "\Rational\" & $4 & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Pulled " & $4 & " Data from Dropbox")
$ai = $f & "\amCharts"
$aj = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func _12c()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$ai = $e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\StrategyShares\" & $4 & "\"
$aj = $f & "\fin_backup_files\StrategyShares\" & $4 & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
$ai = $f & "\fin_backup_files\StrategyShares\" & $4 & "\"
$aj = @ScriptDir & $d & "\StrategyShares\" & $4 & "\"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Pulled " & $4 & " Data from Dropbox")
$ai = $f & "\amCharts"
$aj = @ScriptDir & "\assets\ChartBuilder\public\scripts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
_119("Downloaded amChart Scripts from Database")
SplashOff()
EndFunc
Func _12d()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)
$ai = "C:\Users\mrjak\Documents\GitHub\AutoCharts\assets\ChartBuilder\public\scripts"
$aj = $f & "\amCharts"
RunWait(@ComSpec & " /c " & "xcopy " & '"' & $ai & '"' & ' "' & $aj & '"' & " /E /C /D /Y /H /J", "", @SW_HIDE)
SplashOff()
_119("Uploaded amCharts Scripts to Database")
EndFunc
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete
Global $al = "0x13161C"
Global $am = "0xFFFFFF"
Global $an = "0x2D2D2D"
Global $ao = "0x00796b"
Global $ap = "0xFFFFFF"
Global $aq = "0xFFFFFF"
Global $ar = "DarkTealV2"
Global $as = "0xD8D8D8"
Global $at = "0x1a1a1a"
Func _12e($au = "DarkTeal")
$ar = $au
Switch($au)
Case "LightTeal"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0x00796b"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "DarkTeal"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0x00796b"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkTealV2"
$al = "0x13161C"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0x35635B"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkRuby"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0x712043"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkMidnightTeal"
$al = "0x0A0D16"
$am = "0xFFFFFF"
$an = "0x242B47"
$ao = "0x336058"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkMidnightCyan"
$al = "0x0A0D16"
$am = "0xFFFFFF"
$an = "0x242B47"
$ao = "0x0D5C63"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkMidnightBlue"
$al = "0x0A0D16"
$am = "0xFFFFFF"
$an = "0x242B47"
$ao = "0x1A4F70"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkMidnight"
$al = "0x0A0D16"
$am = "0xFFFFFF"
$an = "0x242B47"
$ao = "0x3C4D66"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkBlue"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x303030"
$ao = "0x1E648C"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkBlueV2"
$al = "0x040D11"
$am = "0xFFFFFF"
$an = "0x303030"
$ao = "0x1E648C"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "LightBlue"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0x244E80"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "LightCyan"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0x00838f"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "DarkCyan"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0x00838f"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "LightGray"
$al = "0xE9E9E9"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0x3F5863"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "LightGreen"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0x2E7D32"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "DarkGreen"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0x5E8763"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkGreenV2"
$al = "0x061319"
$am = "0xFFFFFF"
$an = "0x242B47"
$ao = "0x5E8763"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "LightRed"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0xc62828"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "DarkGray"
$al = "0x1B2428"
$am = "0xFFFFFF"
$an = "0x4F6772"
$ao = "0x607D8B"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "DarkAmber"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0xffa000"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "LightOrange"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0xBC5E05"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "DarkOrange"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0xC76810"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "LightPurple"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0x512DA8"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case "DarkPurple"
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0x512DA8"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
Case "LightPink"
$al = "0xF4F4F4"
$am = "0x000000"
$an = "0xD8D8D8"
$ao = "0xE91E63"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xE8E8E8"
$at = "0x1a1a1a"
Case Else
ConsoleWrite("Metro-UDF-Error: Theme not found, using default theme." & @CRLF)
$al = "0x191919"
$am = "0xFFFFFF"
$an = "0x2D2D2D"
$ao = "0x00796b"
$ap = "0xFFFFFF"
$aq = "0xFFFFFF"
$as = "0xD8D8D8"
$at = "0x1a1a1a"
$ar = "DarkTealV2"
EndSwitch
EndFunc
Func _12f($4v, $av = 8.5, $aw = 400, $ax = 0, $2s = "", $ay = 0, $k = 0)
If $av = Default Then $av = 8.5
If $aw = Default Then $aw = 400
If $ax = Default Then $ax = 0
If $2s = "" Or $2s = Default Then $2s = _12h()
If Not IsString($4v) Then Return SetError(1, 1, 0)
If Not IsNumber($av) Then Return SetError(1, 2, 0)
If Not IsInt($aw) Then Return SetError(1, 3, 0)
If Not IsInt($ax) Then Return SetError(1, 4, 0)
If Not IsString($2s) Then Return SetError(1, 5, 0)
If Not IsNumber($ay) Then Return SetError(1, 6, 0)
If Not IsHwnd($k) And $k <> 0 Then Return SetError(1, 7, 0)
Local $2i, $74, $az, $b0 = 0, $b1
Local $b2 = BitAnd($ax, 1)
$ax = BitAnd($ax, BitNot(1))
If IsHWnd($k) Then
$b0 = GUICtrlCreateLabel("", -10, -10, 10, 10)
$b1 = GUICtrlGetHandle(-1)
GUICtrlSetFont(-1, $av, $aw, $ax, $2s)
$2i = DllCall("user32.dll", "handle", "GetDC", "hwnd", $b1)
If @error Or $2i[0] = 0 Then
GUICtrlDelete($b0)
Return SetError(2, 1, 0)
EndIf
$74 = $2i[0]
$2i = DllCall("user32.dll", "lparam", "SendMessage", "hwnd", $b1, "int", 0x0031, "wparam", 0, "lparam", 0)
If @error Or $2i[0] = 0 Then
GUICtrlDelete($b0)
Return SetError(2, _12g(2, $74), 0)
EndIf
$az = $2i[0]
Else
$2i = DllCall("user32.dll", "handle", "GetDC", "hwnd", $k)
If @error Or $2i[0] = 0 Then Return SetError(2, 1, 0)
$74 = $2i[0]
$2i = DllCall("gdi32.dll", "int", "GetDeviceCaps", "handle", $74, "int", 90)
If @error Or $2i[0] = 0 Then Return SetError(2, _12g(3, $74), 0)
Local $b3 = $2i[0]
$2i = DllCall("gdi32.dll", "handle", "CreateFontW", "int", -$b3 * $av / 72, "int", 0, "int", 0, "int", 0, "int", $aw, "dword", BitAND($ax, 2), "dword", BitAND($ax, 4), "dword", BitAND($ax, 8), "dword", 0, "dword", 0, "dword", 0, "dword", 5, "dword", 0, "wstr", $2s)
If @error Or $2i[0] = 0 Then Return SetError(2, _12g(4, $74), 0)
$az = $2i[0]
EndIf
$2i = DllCall("gdi32.dll", "handle", "SelectObject", "handle", $74, "handle", $az)
If @error Or $2i[0] = 0 Then Return SetError(2, _12g(5, $74, $az, $b0), 0)
Local $b4 = $2i[0]
Local $b5[4], $b6, $b7 = 0, $b8 = 0, $b9 = 0, $ba, $bb, $bc
Local $bd = DllStructCreate("int X;int Y")
DllStructSetData($bd, "X", 0)
DllStructSetData($bd, "Y", 0)
$4v = StringRegExpReplace($4v, "((?<!\x0d)\x0a|\x0d(?!\x0a))", @CRLF)
Local $be = StringSplit($4v, @CRLF, 1)
For $1c = 1 To $be[0]
If $b2 Then
$be[$1c] = StringReplace($be[$1c], @TAB, " XXXXXXXX")
EndIf
$b6 = StringLen($be[$1c])
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $74, "wstr", $be[$1c], "int", $b6, "ptr", DllStructGetPtr($bd))
If @error Then Return SetError(2, _12g(6, $74, $az, $b0), 0)
If DllStructGetData($bd, "X") > $b9 Then $b9 = DllStructGetData($bd, "X")
If DllStructGetData($bd, "Y") > $b7 Then $b7 = DllStructGetData($bd, "Y")
Next
If $ay <> 0 And $b9 > $ay Then
For $1j = 1 To $be[0]
$b6 = StringLen($be[$1j])
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $74, "wstr", $be[$1j], "int", $b6, "ptr", DllStructGetPtr($bd))
If @error Then Return SetError(2, _12g(6, $74, $az, $b0), 0)
If DllStructGetData($bd, "X") < $ay - 4 Then
$b8 += 1
$b5[0] &= $be[$1j] & @CRLF
Else
$ba = 0
While 1
$b9 = 0
$bb = 0
For $1c = 1 To StringLen($be[$1j])
If StringMid($be[$1j], $1c, 1) = " " Then $bb = $1c - 1
$bc = StringMid($be[$1j], 1, $1c)
$b6 = StringLen($bc)
DllCall("gdi32.dll", "bool", "GetTextExtentPoint32W", "handle", $74, "wstr", $bc, "int", $b6, "ptr", DllStructGetPtr($bd))
If @error Then Return SetError(2, _12g(6, $74, $az, $b0), 0)
$b9 = DllStructGetData($bd, "X")
If $b9 >= $ay - 4 Then ExitLoop
Next
If $1c > StringLen($be[$1j]) Then
$ba += 1
$b5[0] &= $bc & @CRLF
ExitLoop
Else
$ba += 1
If $bb = 0 Then Return SetError(3, _12g(0, $74, $az, $b0), 0)
$b5[0] &= StringLeft($bc, $bb) & @CRLF
$be[$1j] = StringTrimLeft($be[$1j], $bb)
$be[$1j] = StringStripWS($be[$1j], 1)
EndIf
WEnd
$b8 += $ba
EndIf
Next
If $b2 Then
$b5[0] = StringRegExpReplace($b5[0], "\x20?XXXXXXXX", @TAB)
EndIf
$b5[1] = $b7
$b5[2] = $ay
$b5[3] =($b8 * $b7) + 4
Else
Local $b5[4] = [$4v, $b7, $b9,($be[0] * $b7) + 4]
EndIf
DllCall("gdi32.dll", "handle", "SelectObject", "handle", $74, "handle", $b4)
DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $az)
DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $74)
If $b0 Then GUICtrlDelete($b0)
Return $b5
EndFunc
Func _12g($bf, $74 = 0, $az = 0, $b0 = 0)
If $az <> 0 Then DllCall("gdi32.dll", "bool", "DeleteObject", "handle", $az)
If $74 <> 0 Then DllCall("user32.dll", "int", "ReleaseDC", "hwnd", 0, "handle", $74)
If $b0 Then GUICtrlDelete($b0)
Return $bf
EndFunc
Func _12h()
Local $bg = DllStructCreate("uint;int;int;int;int;int;byte[60];int;int;byte[60];int;int;byte[60];byte[60];byte[60]")
DLLStructSetData($bg, 1, DllStructGetSize($bg))
DLLCall("user32.dll", "int", "SystemParametersInfo", "int", 41, "int", DllStructGetSize($bg), "ptr", DllStructGetPtr($bg), "int", 0)
Local $bh = DllStructCreate("long;long;long;long;long;byte;byte;byte;byte;byte;byte;byte;byte;char[32]", DLLStructGetPtr($bg, 13))
If IsString(DllStructGetData($bh, 14)) Then
Return DllStructGetData($bh, 14)
Else
Return "Tahoma"
EndIf
EndFunc
Global Const $bi = 0x0026200A
Global $bj = 0
Global $bk = 0
Global $bl = 0
Global $bm = 0
Global $bn = 0
Global $bo = True
Func _12z($2w, $2x, $bp = $bi, $bq = 0, $br = 0)
Local $1w = DllCall($bk, "uint", "GdipCreateBitmapFromScan0", "int", $2w, "int", $2x, "int", $bq, "int", $bp, "struct*", $br, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[6]
EndFunc
Func _131($bs, $bt = 0xFF000000)
Local $1w = DllCall($bk, "int", "GdipCreateHBITMAPFromBitmap", "handle", $bs, "handle*", 0, "dword", $bt)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[2]
EndFunc
Func _132($bs)
Local $1w = DllCall($bk, "int", "GdipDisposeImage", "handle", $bs)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _13b($bt = 0xFF000000)
Local $1w = DllCall($bk, "int", "GdipCreateSolidFill", "int", $bt, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[2]
EndFunc
Func _13c($bu)
Local $1w = DllCall($bk, "int", "GdipDeleteBrush", "handle", $bu)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _141($bv, $bw, $2t = 0, $bx = 3)
Local $1w = DllCall($bk, "int", "GdipCreateFont", "handle", $bv, "float", $bw, "int", $2t, "int", $bx, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[5]
EndFunc
Func _142($az)
Local $1w = DllCall($bk, "int", "GdipDeleteFont", "handle", $az)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _143($by, $bz = 0)
Local $1w = DllCall($bk, "int", "GdipCreateFontFamilyFromName", "wstr", $by, "ptr", $bz, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[3]
EndFunc
Func _145($bv)
Local $1w = DllCall($bk, "int", "GdipDeleteFontFamily", "handle", $bv)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _14f($c0, $bt = 0xFF000000)
Local $1w = DllCall($bk, "int", "GdipGraphicsClear", "handle", $c0, "dword", $bt)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _14h($k)
Local $1w = DllCall($bk, "int", "GdipCreateFromHWND", "hwnd", $k, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[2]
EndFunc
Func _14i($c0)
Local $1w = DllCall($bk, "int", "GdipDeleteGraphics", "handle", $c0)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _14u($c0, $c1, $c2, $c3, $c4, $c5 = 0)
_1b9($c5)
Local $1w = DllCall($bk, "int", "GdipDrawLine", "handle", $c0, "handle", $c5, "float", $c1, "float", $c2, "float", $c3, "float", $c4)
_1ba()
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _14v($c0, $c6, $c5 = 0)
_1b9($c5)
Local $1w = DllCall($bk, "int", "GdipDrawPath", "handle", $c0, "handle", $c5, "handle", $c6)
_1ba()
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _14y($c0, $c7, $c8, $c9, $ca, $c5 = 0)
_1b9($c5)
Local $1w = DllCall($bk, "int", "GdipDrawRectangle", "handle", $c0, "handle", $c5, "float", $c7, "float", $c8, "float", $c9, "float", $ca)
_1ba()
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _150($c0, $3c, $az, $cb, $cc, $bu)
Local $1w = DllCall($bk, "int", "GdipDrawString", "handle", $c0, "wstr", $3c, "int", -1, "handle", $az, "struct*", $cb, "handle", $cc, "handle", $bu)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _153($c0, $c7, $c8, $c9, $ca, $bu = 0)
_1b5($bu)
Local $1w = DllCall($bk, "int", "GdipFillEllipse", "handle", $c0, "handle", $bu, "float", $c7, "float", $c8, "float", $c9, "float", $ca)
_1b6()
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _154($c0, $c6, $bu = 0)
_1b5($bu)
Local $1w = DllCall($bk, "int", "GdipFillPath", "handle", $c0, "handle", $bu, "handle", $c6)
_1b6()
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _157($c0, $c7, $c8, $c9, $ca, $bu = 0)
_1b5($bu)
Local $1w = DllCall($bk, "int", "GdipFillRectangle", "handle", $c0, "handle", $bu, "float", $c7, "float", $c8, "float", $c9, "float", $ca)
_1b6()
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _15v($c0, $cd)
If $cd < 0 Or $cd > 5 Then $cd = 0
Local $1w = DllCall($bk, "int", "GdipSetSmoothingMode", "handle", $c0, "int", $cd)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _15w($c0, $ce)
Local $1w = DllCall($bk, "int", "GdipSetTextRenderingHint", "handle", $c0, "int", $ce)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _16d($cf)
Local $1w = DllCall($bk, "int", "GdipGetImageGraphicsContext", "handle", $cf, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[2]
EndFunc
Func _17v($c6, $c7, $c8, $c9, $ca, $cg, $ch)
Local $1w = DllCall($bk, "int", "GdipAddPathArc", "handle", $c6, "float", $c7, "float", $c8, "float", $c9, "float", $ca, "float", $cg, "float", $ch)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _18w($c6)
Local $1w = DllCall($bk, "int", "GdipClosePathFigure", "handle", $c6)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _18x($ci = 0)
Local $1w = DllCall($bk, "int", "GdipCreatePath", "int", $ci, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[2]
EndFunc
Func _18z($c6)
Local $1w = DllCall($bk, "int", "GdipDeletePath", "handle", $c6)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _19o($bt = 0xFF000000, $c9 = 1, $bx = 2)
Local $1w = DllCall($bk, "int", "GdipCreatePen1", "dword", $bt, "float", $c9, "int", $bx, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[4]
EndFunc
Func _19q($c5)
Local $1w = DllCall($bk, "int", "GdipDeletePen", "handle", $c5)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _1ac($c5, $cj)
Local $1w = DllCall($bk, "int", "GdipSetPenStartCap", "handle", $c5, "int", $cj)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _1af($c7 = 0, $c8 = 0, $c9 = 0, $ca = 0)
Local $ck = DllStructCreate($24)
DllStructSetData($ck, "X", $c7)
DllStructSetData($ck, "Y", $c8)
DllStructSetData($ck, "Width", $c9)
DllStructSetData($ck, "Height", $ca)
Return $ck
EndFunc
Func _1au()
If $bk = 0 Then Return SetError(-1, -1, False)
$bm -= 1
If $bm = 0 Then
DllCall($bk, "none", "GdiplusShutdown", "ulong_ptr", $bn)
DllClose($bk)
$bk = 0
EndIf
Return True
EndFunc
Func _1av($cl = Default, $cm = False)
$bm += 1
If $bm > 1 Then Return True
If $cl = Default Then $cl = "gdiplus.dll"
$bk = DllOpen($cl)
If $bk = -1 Then
$bm = 0
Return SetError(1, 2, False)
EndIf
Local $cn = FileGetVersion($cl)
$cn = StringSplit($cn, ".")
If $cn[1] > 5 Then $bo = False
Local $co = DllStructCreate($25)
Local $cp = DllStructCreate("ulong_ptr Data")
DllStructSetData($co, "Version", 1)
Local $1w = DllCall($bk, "int", "GdiplusStartup", "struct*", $cp, "struct*", $co, "ptr", 0)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
$bn = DllStructGetData($cp, "Data")
If $cm Then Return $bk
Return SetExtended($cn[1], True)
EndFunc
Func _1aw($cq = 0, $cr = 0)
Local $1w = DllCall($bk, "int", "GdipCreateStringFormat", "int", $cq, "word", $cr, "handle*", 0)
If @error Then Return SetError(@error, @extended, 0)
If $1w[0] Then Return SetError(10, $1w[0], 0)
Return $1w[3]
EndFunc
Func _1ax($cc)
Local $1w = DllCall($bk, "int", "GdipDeleteStringFormat", "handle", $cc)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _1az($cs, $77)
Local $1w = DllCall($bk, "int", "GdipSetStringFormatAlign", "handle", $cs, "int", $77)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _1b0($cs, $ct)
Local $1w = DllCall($bk, "int", "GdipSetStringFormatLineAlign", "handle", $cs, "int", $ct)
If @error Then Return SetError(@error, @extended, False)
If $1w[0] Then Return SetError(10, $1w[0], False)
Return True
EndFunc
Func _1b5(ByRef $bu)
If $bu = 0 Then
$bj = _13b()
$bu = $bj
EndIf
EndFunc
Func _1b6($cu = @error, $cv = @extended)
If $bj <> 0 Then
_13c($bj)
$bj = 0
EndIf
Return SetError($cu, $cv)
EndFunc
Func _1b9(ByRef $c5)
If $c5 = 0 Then
$bl = _19o()
$c5 = $bl
EndIf
EndFunc
Func _1ba($cu = @error, $cv = @extended)
If $bl <> 0 Then
_19q($bl)
$bl = 0
EndIf
Return SetError($cu, $cv)
EndFunc
Local $cw[0]
Local Const $cx = _2c('comctl32.dll')
_1ch($cx <> 0, 'This UDF requires comctl32.dll')
Local Const $cy = _ov($cx, 'DefSubclassProc')
Local Const $cz = DllCallbackRegister('_1c3', 'NONE', 'HWND;UINT;WPARAM;LPARAM;DWORD')
Local Const $d0 = DllCallbackGetPtr($cz)
OnAutoItExitRegister("_1cg")
Local Const $d1 = Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86')
Local Const $d2 = DllCall('kernel32.dll', 'HANDLE', 'HeapCreate', 'DWORD', 0x00040000, 'ULONG_PTR', 0, 'ULONG_PTR', 0)[0]
_1ch($d2 <> 0, 'Failed to create executable heap object')
Local Const $d3 = _1ce(Call(@AutoItX64 ? '_cHvr_CSCP_X64' : '_cHvr_CSCP_X86'))
Func _1c2($d4, $d5 = '', $d6 = '', $d7 = '', $d8 = '', $d9 = 0,$da = 0,$db = '')
Local $k = GUICtrlGetHandle($d4)
If(Not(IsHWnd($k))) Then Return SetError(1, 0, -1)
Local $dc = _1ci($k)
Local $2f[13]
$2f[0] = $k
$2f[1] = $d4
$2f[3] = $d5
$2f[4] = $d9
$2f[5] = $d6
$2f[6] = $d9
$2f[7] = $db
$2f[8] = $da
$2f[9] = $d7
$2f[10] = $da
$2f[11] = $d8
$2f[12] = $da
$cw[$dc] = $2f
_qv($k, $d3, $k, $dc)
Return $dc
EndFunc
Func _1c3($k, $dd, $1q, $1r, $de)
Switch $dd
Case 0x0200
GUISetCursor(2, 1)
_1c5($cw[$de], $k, $dd, $1q, $1r)
Case 0x0201
_1c4($cw[$de], $k, $dd, $1q, $1r)
Case 0x0202
_1c6($cw[$de], $k, $dd, $1q, $1r)
Return False
Case 0x0203
_1c7($cw[$de], $k, $dd, $1q, $1r)
Case 0x0204
_1c8($cw[$de], $k, $dd, $1q, $1r)
Case 0x02A3
_1c9($cw[$de], $k, $dd, $1q, $1r)
Case 0x0082
_1cf($de, $k)
EndSwitch
Return True
EndFunc
Func _1c4(ByRef $df, $k, $dd, ByRef $1q, ByRef $1r)
_q1($k)
_1ca($df, 9)
EndFunc
Func _1c5(ByRef $df, $k, $dd, ByRef $1q, ByRef $1r)
If(_1cj() = $k) Then
Local $dg = _1cc($k, $1r)
If Not $df[2] Then
If $dg Then
$df[2] = 1
_1ca($df, 9)
EndIf
Else
If Not $dg Then
$df[2] = 0
_1ca($df, 3)
EndIf
EndIf
ElseIf Not $df[2] Then
$df[2] = 1
_1ca($df, 5)
Local $dh = DllStructCreate('DWORD;DWORD;HWND;DWORD')
DllStructSetData($dh, 1, DllStructGetSize($dh))
DllStructSetData($dh, 2, 2)
DllStructSetData($dh, 3, $k)
DllCall('user32.dll', 'BOOL', 'TrackMouseEvent', 'STRUCT*', $dh)
EndIf
EndFunc
Func _1c6(ByRef $df, $k, $dd, ByRef $1q, ByRef $1r)
Local $di = _qn($k, $dd, $1q, $1r)
If(_1cj() = $k) Then
_py()
If _1cc($k, $1r) Then
_1ca($df, 9)
EndIf
EndIf
Return $di
EndFunc
Func _1c7(ByRef $df, $k, $dd, ByRef $1q, ByRef $1r)
_1ca($df, 11)
EndFunc
Func _1c8(ByRef $df, $k, $dd, ByRef $1q, ByRef $1r)
_1ca($df, 7)
EndFunc
Func _1c9(ByRef $df, $k, $dd, ByRef $1q, ByRef $1r)
$df[2] = 0
_1ca($df, 3)
EndFunc
Func _1ca(ByRef $df, $dj)
Call($df[$dj], $df[1], $df[$dj + 1])
EndFunc
Func _1cb(ByRef $dk, Const $dl = Default, Const $dm = Default, Const $dn = Default, Const $do = Default, Const $dp = Default)
While(UBound($dk) <($dk[0] + @NumParams))
ReDim $dk[UBound($dk) * 2]
WEnd
If Not($dl = Default) Then
$dk[0] += 1
$dk[$dk[0]] = $dl
EndIf
If Not($dm = Default) Then
$dk[0] += 1
$dk[$dk[0]] = $dm
EndIf
If Not($dn = Default) Then
$dk[0] += 1
$dk[$dk[0]] = $dn
EndIf
If Not($do = Default) Then
$dk[0] += 1
$dk[$dk[0]] = $do
EndIf
If Not($dp = Default) Then
$dk[0] += 1
$dk[$dk[0]] = $dp
EndIf
EndFunc
Func _1cc($k, $1r)
Local $2u = BitShift(BitShift($1r, -16), 16)
Local $2v = BitShift($1r, 16)
Local $dq = WinGetClientSize($k)
Return Not($2u < 0 Or $2v < 0 Or $2u > $dq[0] Or $2v > $dq[1])
EndFunc
Func _cHvr_CSCP_X86()
Local $dr = 'align 1;'
Local $ds[100]
$ds[0] = 0
Local $dt[5]
Local $du[5]
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x55)
_1cb($ds, 0x8B, 0xEC)
$dr &= 'BYTE;'
_1cb($ds, 0x53)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x8B, 0x5D, 16)
$dr &= 'BYTE;'
_1cb($ds, 0x56)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x8B, 0x75, 12)
$dr &= 'BYTE;'
_1cb($ds, 0x57)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x8B, 0x7D, 20)
$dr &= 'BYTE;BYTE;DWORD;'
_1cb($ds, 0x81, 0xFE, 0x82)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x74, 0)
$dt[0] = DllStructGetSize(DllStructCreate($dr))
$du[0] = $ds[0]
$dr &= 'BYTE;BYTE;DWORD;'
_1cb($ds, 0x81, 0xFE, 0x2A3)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x74, 0)
$dt[1] = DllStructGetSize(DllStructCreate($dr))
$du[1] = $ds[0]
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x8D, 0x86, -0x200)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x83, 0xF8, 3)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x77, 0)
$dt[2] = DllStructGetSize(DllStructCreate($dr))
$du[2] = $ds[0]
$ds[$du[0]] = $dt[2] - $dt[0]
$ds[$du[1]] = $dt[2] - $dt[1]
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x8B, 0x4D, 28)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x8B, 0x55, 8)
$dr &= 'BYTE;'
_1cb($ds, 0x51)
$dr &= 'BYTE;'
_1cb($ds, 0x57)
$dr &= 'BYTE;'
_1cb($ds, 0x53)
$dr &= 'BYTE;'
_1cb($ds, 0x56)
$dr &= 'BYTE;'
_1cb($ds, 0x52)
$dr &= 'BYTE;PTR;'
_1cb($ds, 0xB8, $d0)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0xFF, 0xD0)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x85, 0xC0)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x74, 0)
$dt[3] = DllStructGetSize(DllStructCreate($dr))
$du[3] = $ds[0]
$ds[$du[2]] = $dt[3] - $dt[2]
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x8B, 0x45, 8)
$dr &= 'BYTE;'
_1cb($ds, 0x57)
$dr &= 'BYTE;'
_1cb($ds, 0x53)
$dr &= 'BYTE;'
_1cb($ds, 0x56)
$dr &= 'BYTE;'
_1cb($ds, 0x50)
$dr &= 'BYTE;PTR;'
_1cb($ds, 0xB8, $cy)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0xFF, 0xD0)
$dt[4] = DllStructGetSize(DllStructCreate($dr))
$ds[$du[3]] = $dt[4] - $dt[3]
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x5F)
_1cb($ds, 0x5E)
_1cb($ds, 0x5B)
$dr &= 'BYTE;BYTE;BYTE;WORD'
_1cb($ds, 0x5D)
_1cb($ds, 0xC2, 24)
Return _1cd($dr, $ds)
EndFunc
Func _cHvr_CSCP_X64()
Local $dr = 'align 1;'
Local $ds[100]
$ds[0] = 0
Local $dt[5]
Local $du[5]
$dr &= 'BYTE;BYTE;DWORD;'
_1cb($ds, 0x81, 0xFA, 0x82)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x74, 0)
$dt[0] = DllStructGetSize(DllStructCreate($dr))
$du[0] = $ds[0]
$dr &= 'BYTE;BYTE;DWORD;'
_1cb($ds, 0x81, 0xFA, 0x2A3)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x74, 0)
$dt[1] = DllStructGetSize(DllStructCreate($dr))
$du[1] = $ds[0]
$dr &= 'BYTE;BYTE;DWORD;'
_1cb($ds, 0x8D, 0x82, -0x200)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x83, 0xF8, 3)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x77, 0)
$dt[2] = DllStructGetSize(DllStructCreate($dr))
$du[2] = $ds[0]
$ds[$du[0]] = $dt[2] - $dt[0]
$ds[$du[1]] = $dt[2] - $dt[1]
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x89, 0x5C, 0x24, 8)
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x89, 0x6C, 0x24, 16)
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x89, 0x74, 0x24, 24)
$dr &= 'BYTE;'
_1cb($ds, 0x57)
$dr &= 'BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x83, 0xEC, 48)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x49, 0x8B, 0xF9)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x49, 0x8B, 0xF0)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x8B, 0xDA)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x8B, 0xE9)
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x8B, 0x44, 0x24, 104)
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x89, 0x44, 0x24, 32)
$dr &= 'BYTE;BYTE;PTR;'
_1cb($ds, 0x48, 0xB8, $d0)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0xFF, 0xD0)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x85, 0xC0)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x74, 0)
$dt[3] = DllStructGetSize(DllStructCreate($dr))
$du[3] = $ds[0]
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x4C, 0x8B, 0xCF)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x4C, 0x8B, 0xC6)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x8B, 0xD3)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x8B, 0xCD)
$ds[$du[3]] = DllStructGetSize(DllStructCreate($dr)) - $dt[3]
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x8B, 0x5C, 0x24, 64)
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x8B, 0x6C, 0x24, 72)
$dr &= 'BYTE;BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x8B, 0x74, 0x24, 80)
$dr &= 'BYTE;BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x83, 0xc4, 48)
$dr &= 'BYTE;'
_1cb($ds, 0x5F)
$dr &= 'BYTE;BYTE;BYTE;'
_1cb($ds, 0x48, 0x85, 0xC0)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0x74, 0)
$dt[4] = DllStructGetSize(DllStructCreate($dr))
$du[4] = $ds[0]
$ds[$du[2]] = DllStructGetSize(DllStructCreate($dr)) - $dt[2]
$dr &= 'BYTE;BYTE;PTR;'
_1cb($ds, 0x48, 0xB8, $cy)
$dr &= 'BYTE;BYTE;'
_1cb($ds, 0xFF, 0xE0)
$ds[$du[4]] = DllStructGetSize(DllStructCreate($dr)) - $dt[4]
$dr &= 'BYTE;'
_1cb($ds, 0xC3)
Return _1cd($dr, $ds)
EndFunc
Func _1cd(ByRef $dr, ByRef $ds)
Local $dv = DllStructCreate($dr)
_1ch(@error = 0, 'DllStrucCreate Failed With Error = ' & @error)
For $1c = 1 To $ds[0]
DllStructSetData($dv, $1c, $ds[$1c])
Next
Return $dv
EndFunc
Func _1ce($dv)
Local $dw = DllCall('kernel32.dll', 'PTR', 'HeapAlloc', 'HANDLE', $d2, 'DWORD', 8, 'ULONG_PTR', DllStructGetSize($dv))[0]
_1ch($dw <> 0, 'Allocate memory failed')
DllCall("kernel32.dll", "none", "RtlMoveMemory", "PTR", $dw, "PTR", DllStructGetPtr($dv), "ULONG_PTR", DllStructGetSize($dv))
_1ch(@error = 0, 'Failed to copy memory')
Return $dw
EndFunc
Func _1cf($de, $k)
_qt($k, $d3, $k)
Local $2f=$cw[$de]
$cw[$de] = 0
Call( "_iControlDelete",$2f[1])
EndFunc
Func _1cg()
DllCallbackFree($cz)
_25($cx)
If($d2 <> 0) Then
If($d3 <> 0) Then
DllCall('kernel32.dll', 'BOOL', 'HeapFree', 'HANDLE', $d2, 'DWORD', 0, 'PTR', $d3)
EndIf
DllCall('kernel32.dll', 'BOOL', 'HeapDestroy', 'HANDLE', $d2)
EndIf
EndFunc
Func _1ch($dx, $dy = '', $dz = @ScriptName, $e0 = @ScriptFullPath, $e1 = @ScriptLineNumber, $e2 = @error, $e3 = @extended)
If(Not($dx)) Then
MsgBox(BitOR(1, 0x10), 'Assertion Error!', @CRLF & 'Script' & @TAB & ': ' & $dz & @CRLF & 'Path' & @TAB & ': ' & $e0 & @CRLF & 'Line' & @TAB & ': ' & $e1 & @CRLF & 'Error' & @TAB & ': ' &($e2 > 0x7FFF ? Hex($e2) : $e2) &($e3 <> 0 ? '  (Extended : ' &($e3 > 0x7FFF ? Hex($e3) : $e3) & ')' : '') & @CRLF & 'Message' & @TAB & ': ' & $dy & @CRLF & @CRLF & 'OK: Exit Script' & @TAB & 'Cancel: Continue')
Exit
EndIf
EndFunc
Func _1ci($k)
For $1c = 0 To UBound($cw) - 1 Step +1
If Not IsArray($cw[$1c]) Then
Return $1c
EndIf
Next
ReDim $cw[UBound($cw) + 1]
Return UBound($cw) - 1
EndFunc
Func _1cj()
Return DllCall("user32.dll", "HWND", "GetCapture")[0]
EndFunc
_1av()
Opt("WinWaitDelay", 0)
Global $e4 = _1dx()[2], $e5 = _1e4()
Global $e6[0], $e7[0]
Global $e8 = 0
Global $e9 = Number(29 * $e5, 1) + Number(10 * $e5, 1)
Global Const $ea = DllCallbackRegister('_1e6', 'lresult', 'hwnd;uint;wparam;lparam;uint_ptr;dword_ptr')
Global Const $eb = DllCallbackGetPtr($ea)
OnAutoItExitRegister('_1e7')
Global Const $ec = 4 * $e5
Global $ed = False
Global $ee = True
Global $ef = False
If Opt("GUIOnEventMode", 0) Then
Opt("GUIOnEventMode", 1)
$ef = True
EndIf
Func _1ck($eg, $eh, $ei, $ej = -1, $ek = -1, $el = False, $em = "")
Local $en
If $ed Then
$eh = Round($eh * $e5)
$ei = Round($ei * $e5)
EndIf
Local $eo
If $el Then
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$en = GUICreate($eg, $eh, $ei, $ej, $ek, BitOR(0x00040000, 0x00020000, 0x00010000), -1, $em)
$eo = _1cl($en, True, True, $eh, $ei)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Else
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
$en = GUICreate($eg, $eh, $ei, $ej, $ek, -1, -1, $em)
$eo = _1cl($en, False, False, $eh, $ei)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
EndIf
_qv($en, $eb, 1010, $eo)
WinMove($en, "", Default, Default, $eh, $ei)
If Not $em Then
Local $ep = _1e8($en)
If($ej = -1) And($ek = -1) Then
WinMove($en, "",($ep[2] - $eh) / 2,($ep[3] - $ei) / 2, $eh, $ei)
EndIf
Else
If($ej = -1) And($ek = -1) Then
Local $eq = _1e3($em, $eh, $ei)
WinMove($en, "", $eq[0], $eq[1], $eh, $ei)
EndIf
EndIf
GUISetBkColor($al)
_1e2($en, $eh, $ei, $an)
Return($en)
EndFunc
Func _1cl($er, $es = False, $el = False, $et = "", $eu = "")
Local $ev
For $ew = 0 To UBound($e7) - 1 Step +1
If $e7[$ew][0] = $er Then
$ev = $ew
ExitLoop
EndIf
Next
If($ev == "") Then
$ev = UBound($e7)
ReDim $e7[$ev + 1][16]
EndIf
$e7[$ev][0] = $er
$e7[$ev][1] = $es
$e7[$ev][2] = $el
If $el Then
If $et = "" Then
$et = WinGetPos($er, "")
If @error Then
$et = 80 * $e5
Else
$et = $et[2]
EndIf
EndIf
If $eu = "" Then
$eu = WinGetPos($er, "")
If @error Then
$eu = 50 * $e5
Else
$eu = $eu[3]
EndIf
EndIf
$e7[$ev][3] = $et
$e7[$ev][4] = $eu
EndIf
Return $ev
EndFunc
Func _1cm($ex)
GUISetState(@SW_HIDE, $ex)
_qt($ex, $eb, 1010)
GUIDelete($ex)
Local $ey[0]
For $ez = 0 To UBound($e7) - 1 Step +1
If $e7[$ez][0] <> $ex Then
ReDim $ey[UBound($ey) + 1][16]
For $f0 = 0 To 11 Step +1
$ey[UBound($ey) - 1][$f0] = $e7[$ez][$f0]
Next
EndIf
Next
$e7 = $ey
EndFunc
Func _iControlDelete($f1)
For $1c = 0 To UBound($e6) - 1
If $e6[$1c][0] = $f1 Then
Switch($e6[$1c][3])
Case "5", "7"
_4a($e6[$1c][5])
_4a($e6[$1c][6])
_4a($e6[$1c][7])
_4a($e6[$1c][8])
Case "6"
_4a($e6[$1c][5])
_4a($e6[$1c][6])
_4a($e6[$1c][7])
_4a($e6[$1c][8])
_4a($e6[$1c][9])
_4a($e6[$1c][10])
_4a($e6[$1c][11])
_4a($e6[$1c][12])
_4a($e6[$1c][13])
_4a($e6[$1c][14])
Case Else
_4a($e6[$1c][5])
_4a($e6[$1c][6])
EndSwitch
For $f2 = 0 To UBound($e6, 2) - 1
$e6[$1c][$f2] = ""
Next
ExitLoop
EndIf
Next
EndFunc
Func _1cn($f3 = True, $f4 = True, $f5 = True, $f6 = False, $f7 = False, $f8 = $al, $f9 = $am, $fa = 2)
Local $fb[5]
$fb[0] = $f3
$fb[1] = $f4
$fb[2] = $f5
$fb[3] = $f6
$fb[4] = $f7
$f8 = "0xFF" & Hex($f8, 6)
$f9 = "0xFF" & Hex($f9, 6)
Return _1cv($fb, $f8, $f9, False, $fa)
EndFunc
Func _1co($fc = True)
$ed = $fc
EndFunc
Func _1cq($er)
GUISetState(@SW_SHOW, $er)
Local $ev = _1e9($er)
If($ev == "") Then
ConsoleWrite("Fullscreen-Toggle failed: GUI not registered. Not created with _Metro_CreateGUI ?" & @CRLF)
Return SetError(1)
EndIf
If Not $e7[$ev][2] Then
ConsoleWrite("Fullscreen-Toggle failed: GUI is not registered for resizing. Please use _Metro_SetGUIOption to enable resizing." & @CRLF)
Return SetError(2)
EndIf
Local $fd = WinGetState($er)
Local $fe = _n0($er)
Local $ff = _1e8($er, True)
Local $fg = WinGetPos($er)
Local $fh = _1e5("3", $er)
Local $fi = _1e5("4", $er)
Local $f6 = _1e5("9", $er)
Local $fj = _1e5("10", $er)
If $e7[$ev][11] Then
$e7[$ev][11] = False
If(BitAND($e7[$ev][9], 32) = 32) Then
GUISetState(@SW_MAXIMIZE)
$fe = $e7[$ev][10]
DllStructSetData($fe, "rcNormalPosition", $e7[$ev][5], 1)
DllStructSetData($fe, "rcNormalPosition", $e7[$ev][6], 2)
DllStructSetData($fe, "rcNormalPosition", $e7[$ev][7], 3)
DllStructSetData($fe, "rcNormalPosition", $e7[$ev][8], 4)
_nm($er, $fe)
If $fh Then
GUICtrlSetState($fh, 32)
GUICtrlSetState($fi, 16)
EndIf
Else
WinMove($er, "", $e7[$ev][5], $e7[$ev][6], $e7[$ev][7], $e7[$ev][8])
If $fh Then
GUICtrlSetState($fi, 32)
GUICtrlSetState($fh, 16)
EndIf
EndIf
GUICtrlSetState($fj, 32)
GUICtrlSetState($f6, 16)
Else
If(BitAND($fd, 32) = 32) Then
$fg[0] = DllStructGetData($fe, "rcNormalPosition", 1)
$fg[1] = DllStructGetData($fe, "rcNormalPosition", 2)
$fg[2] = DllStructGetData($fe, "rcNormalPosition", 3)
$fg[3] = DllStructGetData($fe, "rcNormalPosition", 4)
DllStructSetData($fe, "rcNormalPosition", $ff[0], 1)
DllStructSetData($fe, "rcNormalPosition", $ff[1], 2)
DllStructSetData($fe, "rcNormalPosition", $ff[0] + $ff[2], 3)
DllStructSetData($fe, "rcNormalPosition", $ff[1] + $ff[3], 4)
_nm($er, $fe)
Sleep(50)
$e7[$ev][10] = $fe
GUISetState(@SW_RESTORE)
Else
Sleep(50)
WinMove($er, "", $ff[0], $ff[1], $ff[2], $ff[3])
EndIf
$e7[$ev][11] = True
GUICtrlSetState($f6, 32)
If $fh Then
GUICtrlSetState($fh, 32)
GUICtrlSetState($fi, 32)
EndIf
GUICtrlSetState($fj, 16)
$e7[$ev][5] = $fg[0]
$e7[$ev][6] = $fg[1]
$e7[$ev][7] = $fg[2]
$e7[$ev][8] = $fg[3]
$e7[$ev][9] = $fd
WinActivate("[CLASS:Shell_TrayWnd]")
WinActivate($er)
EndIf
EndFunc
Func _1cr($f8 = $al, $f9 = $am, $fa = 2)
Local $fk = _1du()
Local $fl = _1dt()
$f8 = "0xFF" & Hex($f8, 6)
$f9 = "0xFF" & Hex($f9, 6)
If StringInStr($ar, "Light") Then
Local $fm = StringReplace(_1e0($f8, -20), "0x", "0xFF")
Else
Local $fm = StringReplace(_1e0($f8, +20), "0x", "0xFF")
EndIf
Local $fn = Round(1 * $fk)
Local $c5 = _19o($f9, Round(1 * $fk))
If StringInStr($ar, "Light") Then
Local $fo = _19o(StringReplace(_1e0($f9, +60), "0x", "0xFF"), Round(1 * $fk))
Else
Local $fo = _19o(StringReplace(_1e0($f9, -80), "0x", "0xFF"), Round(1 * $fk))
EndIf
_1ac($c5, 0x03)
_1ac($fo, 0x03)
Local $fp[16]
Local $fq = Number(45 * $fk, 1)
Local $fr = Number(29 * $fk, 1)
Local $fs = Number($fa * $fk, 1)
$fp[1] = False
$fp[2] = False
$fp[3] = "0"
$fp[15] = _1dt()
Local $ft = _1dr($fq, $fr, $f8, 0, 4)
Local $fu = _1dr($fq, $fr, $fm, 0, 4)
Local $fv = _1dr($fq, $fr, $f8, 0, 4)
Local $fw = $fq / 2.95, $fx = $fr / 2.1
Local $fy = _1dv($fw, $fx, 135, 12 * $fk)
Local $fz = _1dv($fw, $fx, 45, 12 * $fk)
_14u($ft[0], $fw, $fx, $fy[0], $fy[1], $c5)
_14u($ft[0], $fw, $fx, $fz[0], $fz[1], $c5)
_14u($fu[0], $fw, $fx, $fy[0], $fy[1], $c5)
_14u($fu[0], $fw, $fx, $fz[0], $fz[1], $c5)
_14u($fv[0], $fw, $fx, $fy[0], $fy[1], $fo)
_14u($fv[0], $fw, $fx, $fz[0], $fz[1], $fo)
_19q($c5)
_19q($fo)
$fp[0] = GUICtrlCreatePic("", $fs, $fs, $fq, $fr)
$fp[5] = _1ds($fp[0], $ft)
$fp[6] = _1ds($fp[0], $fu, False)
$fp[7] = _1ds($fp[0], $fv, False)
GUICtrlSetResizing($fp[0], 768 + 32 + 2)
_1c2($fp[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($fp), $fl)
Return $fp[0]
EndFunc
Func _1cs($er, $g0, $g1, $g2 = "Segoe UI", $g3 = 9, $g4 = 0)
Local $g5 = _1e5("8", $er)
If Not $g5 Then Return SetError(1)
GUICtrlSetState($g5, 128)
Local $g6[UBound($g1)]
Local $fk = _1du()
Local $g7 = True
Local $g8 = WinGetPos($er)
Local $fs = Number(2 * $fk, 1)
Local $fr = Number(29 * $fk, 1)
Local $g9 = $g8[3] -($fs * 2) - $fr
Local $ga = $g0 * $fk
Local $gb = $g8[0] + $fs, $gc = $g8[1] + $fs + $fr
Local $gd = $ga / 10, $ge = $gd
Local $gf = GUICreate("", $ge, $g9, $gb, $gc, 0x80000000, 0x00000040, $er)
Local $gg =(30 * $fk)
If StringInStr($ar, "Light") Then
GUISetBkColor(_1e0($al, -10), $gf)
Else
GUISetBkColor(_1e0($al, +10), $gf)
EndIf
For $gh = 0 To UBound($g1) - 1 Step +1
$g6[$gh] = _1ct($g1[$gh], 0, $gg * $gh +($gh * 2), $ga - $fs, 30 * $fk, $al, $am, $g2, $g3, $g4)
Next
GUISetState(@SW_SHOW, $gf)
For $1c = 0 To 8 Step +1
$ge = $ge + $gd
WinMove($gf, "", $gb, $gc, $ge, $g9)
Sleep(1)
Next
If $ef Then Opt("GUIOnEventMode", 0)
While 1
If Not $g7 Then
If Not WinActive($gf) Then
$g8 = WinGetPos($er)
$gb = $g8[0] + $fs
$gc = $g8[1] + $fs + $fr
For $1c = 0 To 8 Step +1
$ge = $ge - $gd
WinMove($gf, "", $gb, $gc, $ge, $g9)
Sleep(1)
Next
GUIDelete($gf)
If $ef Then Opt("GUIOnEventMode", 1)
GUICtrlSetState($g5, 64)
Return SetError(1, 0, "none")
EndIf
Else
$g7 = False
EndIf
Local $1p = GUIGetMsg()
For $gh = 0 To UBound($g6) - 1 Step +1
If $1p = $g6[$gh] Then
$g8 = WinGetPos($er)
$gb = $g8[0] + $fs
$gc = $g8[1] + $fs + $fr
For $gi = 0 To 8 Step +2
$ge = $ge - $gd
WinMove($gf, "", $gb, $gc, $ge, $g9)
Sleep(1)
Next
GUIDelete($gf)
If $ef Then Opt("GUIOnEventMode", 1)
GUICtrlSetState($g5, 64)
Return $gh
EndIf
Next
WEnd
EndFunc
Func _1ct($gj, $ej, $ek, $eh, $ei, $gk = $al, $gl = $am, $gm = "Arial", $9v = 9, $gn = 1)
Local $go[16]
If Not $ed Then
$9v =($9v / $e4)
EndIf
$go[1] = False
$go[3] = "2"
$go[15] = _1dt()
$gk = StringReplace($gk, "0x", "0xFF")
$gl = StringReplace($gl, "0x", "0xFF")
Local $gp = _13b($gl)
If StringInStr($ar, "Light") Then
Local $gq = StringReplace(_1e0($al, -12), "0x", "0xFF")
$gk = StringReplace(_1e0($al, -25), "0x", "0xFF")
Else
Local $gq = StringReplace(_1e0($al, +12), "0x", "0xFF")
$gk = StringReplace(_1e0($al, +25), "0x", "0xFF")
EndIf
Local $gr = _1dr($eh, $ei, $gq, 0, 5)
Local $gs = _1dr($eh, $ei, $gk, 0, 5)
Local $cc = _1aw(), $bv = _143($gm), $az = _141($bv, $9v, $gn)
Local $cb = _1af(0, 0, $eh, $ei)
_1az($cc, 1)
_1b0($cc, 1)
_150($gr[0], $gj, $az, $cb, $cc, $gp)
_150($gs[0], $gj, $az, $cb, $cc, $gp)
_142($az)
_145($bv)
_1ax($cc)
_13c($gp)
$go[0] = GUICtrlCreatePic("", $ej, $ek, $eh, $ei)
$go[5] = _1ds($go[0], $gr)
$go[6] = _1ds($go[0], $gs, False)
GUICtrlSetResizing($go[0], 802)
_1c2($go[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($go))
Return $go[0]
EndFunc
Func _1cv($fb, $f8 = $al, $f9 = "0xFFFFFF", $gt = False, $fa = 2)
Local $fk = _1du()
Local $fn = Round(1 * $fk), $fm
If StringInStr($ar, "Light") Then
$fm = StringReplace(_1e0($f8, -20), "0x", "0xFF")
Else
$fm = StringReplace(_1e0($f8, +20), "0x", "0xFF")
EndIf
Local $c5 = _19o($f9, Round(1 * $fk))
Local $gu = _19o($f9, Round(1 * $fk))
Local $gv = _19o("0xFFFFFFFF", Round(1 * $fk))
If StringInStr($ar, "Light") Then
Local $gw = _19o(StringReplace(_1e0($f9, +90), "0x", "0xFF"), $fn)
Else
Local $gw = _19o(StringReplace(_1e0($f9, -80), "0x", "0xFF"), $fn)
EndIf
Local $gx = _19o(StringReplace(_1e0("0xFFFFFF", -80), "0x", "0xFF"), $fn)
If $f8 <> 0 Then
$f8 = "0xFF" & Hex($f8, 6)
EndIf
Local $bu = _13b($f8), $gy = _13b($fm)
Local $gz[16]
Local $h0[16]
Local $h1[16]
Local $h2[16]
Local $h3[16]
Local $h4[16]
Local $h5[16]
Local $h6[16]
Local $fq = Number(45 * $fk, 1)
Local $fr = Number(29 * $fk, 1)
Local $fs = Number($fa * $fk, 1)
Local $fl = _1dt()
Local $h7 = WinGetPos($fl)
Local $h8 = 0
If $fb[0] Then
$h8 = $h8 + 1
$h0[0] = GUICtrlCreatePic("", $h7[2] - $fs -($fq * $h8), $fs, $fq, $fr)
$h0[1] = False
$h0[2] = False
$h0[3] = "0"
$h0[15] = $fl
EndIf
If $fb[1] Then
$h8 = $h8 + 1
$h2[0] = GUICtrlCreatePic("", $h7[2] - $fs -($fq * $h8), $fs, $fq, $fr)
$h2[1] = False
$h2[2] = False
$h2[3] = "3"
$h2[8] = True
$h2[15] = $fl
$h3[0] = GUICtrlCreatePic("", $h7[2] - $fs -($fq * $h8), $fs, $fq, $fr)
$h3[1] = False
$h3[2] = False
$h3[3] = "4"
$h3[8] = True
$h3[15] = $fl
If $fb[3] Then
$h6[0] = GUICtrlCreatePic("", $h7[2] - $fs -($fq * $h8), $fs, $fq, $fr)
$h6[1] = False
$h6[2] = False
$h6[3] = "10"
$h6[15] = $fl
EndIf
EndIf
If $fb[2] Then
$h8 = $h8 + 1
$h1[0] = GUICtrlCreatePic("", $h7[2] - $fs -($fq * $h8), $fs, $fq, $fr)
$h1[1] = False
$h1[2] = False
$h1[3] = "0"
$h1[15] = $fl
EndIf
If $fb[3] Then
$h8 = $h8 + 1
$h5[0] = GUICtrlCreatePic("", $h7[2] - $fs -($fq * $h8), $fs, $fq, $fr)
$h5[1] = False
$h5[2] = False
$h5[3] = "9"
$h5[15] = $fl
If $h6[15] <> $fl Then
$h6[0] = GUICtrlCreatePic("", $h7[2] - $fs -($fq * $h8), $fs, $fq, $fr)
$h6[1] = False
$h6[2] = False
$h6[3] = "10"
$h6[15] = $fl
EndIf
EndIf
If $fb[4] Then
$h4[0] = GUICtrlCreatePic("", $fs, $fs, $fq, $fr)
$h4[1] = False
$h4[2] = False
$h4[3] = "8"
$h4[15] = $fl
EndIf
If $fb[0] Then
Local $h9 = _1dr($fq, $fr, $f8, 4, 4), $ha = _1dr($fq, $fr, "0xFFE81123", 4, 4), $hb = _1dr($fq, $fr, $f8, 4, 4)
EndIf
If $fb[1] Then
Local $hc = _1dr($fq, $fr, $f8, 0, 4), $hd = _1dr($fq, $fr, $fm, 0, 4), $he = _1dr($fq, $fr, $f8, 0, 4)
Local $hf = _1dr($fq, $fr, $f8, 0, 4), $hg = _1dr($fq, $fr, $fm, 0, 4), $hh = _1dr($fq, $fr, $f8, 0, 4)
EndIf
If $fb[2] Then
Local $hi = _1dr($fq, $fr, $f8, 0, 4), $hj = _1dr($fq, $fr, $fm, 0, 4), $hk = _1dr($fq, $fr, $f8, 0, 4)
EndIf
If $fb[3] Then
Local $hl = _1dr($fq, $fr, $f8, 0, 4), $hm = _1dr($fq, $fr, $fm, 0, 4), $hn = _1dr($fq, $fr, $f8, 0, 4)
Local $ho = _1dr($fq, $fr, $f8, 0, 4), $hp = _1dr($fq, $fr, $fm, 0, 4), $hq = _1dr($fq, $fr, $f8, 0, 4)
EndIf
If $fb[4] Then
Local $hr = _1dr($fq, $fr, $f8, 0, 4), $hs = _1dr($fq, $fr, $fm, 0, 4), $ht = _1dr($fq, $fr, $f8, 0, 4)
EndIf
If $gt Then
_14f($h9[0], "0xFFB52231")
_14f($hb[0], "0xFFB52231")
EndIf
If $fb[0] Then
If $gt Then
_14u($h9[0], 17 * $fk, 9 * $fk, 27 * $fk, 19 * $fk, $gv)
_14u($h9[0], 27 * $fk, 9 * $fk, 17 * $fk, 19 * $fk, $gv)
_14u($hb[0], 17 * $fk, 9 * $fk, 27 * $fk, 19 * $fk, $gx)
_14u($hb[0], 27 * $fk, 9 * $fk, 17 * $fk, 19 * $fk, $gx)
Else
_14u($h9[0], 17 * $fk, 9 * $fk, 27 * $fk, 19 * $fk, $c5)
_14u($h9[0], 27 * $fk, 9 * $fk, 17 * $fk, 19 * $fk, $c5)
_14u($hb[0], 17 * $fk, 9 * $fk, 27 * $fk, 19 * $fk, $gw)
_14u($hb[0], 27 * $fk, 9 * $fk, 17 * $fk, 19 * $fk, $gw)
EndIf
_14u($ha[0], 17 * $fk, 9 * $fk, 27 * $fk, 19 * $fk, $gv)
_14u($ha[0], 27 * $fk, 9 * $fk, 17 * $fk, 19 * $fk, $gv)
EndIf
If $fb[1] Then
_14y($hc[0], Round(17 * $fk), 9 * $fk, 9 * $fk, 9 * $fk, $c5)
_14y($hd[0], Round(17 * $fk), 9 * $fk, 9 * $fk, 9 * $fk, $gu)
_14y($he[0], Round(17 * $fk), 9 * $fk, 9 * $fk, 9 * $fk, $gw)
Local $hu = Round(7 * $fk), $hv = Round(2 * $fk)
_14y($hf[0], Round(17 * $fk) + $hv,(11 * $fk) - $hv, $hu, $hu, $c5)
_157($hf[0], Round(17 * $fk), 11 * $fk, $hu, $hu, $bu)
_14y($hf[0], Round(17 * $fk), 11 * $fk, $hu, $hu, $c5)
_14y($hg[0], Round(17 * $fk) + $hv,(11 * $fk) - $hv, $hu, $hu, $gu)
_157($hg[0], Round(17 * $fk), 11 * $fk, $hu, $hu, $gy)
_14y($hg[0], Round(17 * $fk), 11 * $fk, $hu, $hu, $gu)
_14y($hh[0], Round(17 * $fk) + $hv,(11 * $fk) - $hv, $hu, $hu, $gw)
_157($hh[0], Round(17 * $fk), 11 * $fk, $hu, $hu, $bu)
_14y($hh[0], Round(17 * $fk), 11 * $fk, $hu, $hu, $gw)
EndIf
If $fb[2] Then
_14u($hi[0], 18 * $fk, 14 * $fk, 27 * $fk, 14 * $fk, $c5)
_14u($hj[0], 18 * $fk, 14 * $fk, 27 * $fk, 14 * $fk, $gu)
_14u($hk[0], 18 * $fk, 14 * $fk, 27 * $fk, 14 * $fk, $gw)
EndIf
If $fb[3] Then
Local $hw =($fn * 0.3)
Local $hx[2], $hy
$hx[0] = Round($fq / 2.9)
$hx[1] = Round($fr / 1.5)
$hy = _1dv($hx[0], $hx[1], 135, $fq / 2.5)
$hy[0] = Round($hy[0])
$hy[1] = Round($hy[1])
Local $fy = _1dv($hx[0] + $hw, $hx[1] + $hw, 180, 5 * $fk)
Local $fz = _1dv($hx[0] - $hw, $hx[1] - $hw, 90, 5 * $fk)
_14u($hl[0], $hx[0] + $hw, $hx[1] + $hw, $fy[0], $fy[1], $c5)
_14u($hl[0], $hx[0] - $hw, $hx[1] - $hw, $fz[0], $fz[1], $c5)
_14u($hm[0], $hx[0] + $hw, $hx[1] + $hw, $fy[0], $fy[1], $c5)
_14u($hm[0], $hx[0] - $hw, $hx[1] - $hw, $fz[0], $fz[1], $c5)
_14u($hn[0], $hx[0] + $hw, $hx[1] + $hw, $fy[0], $fy[1], $gw)
_14u($hn[0], $hx[0] - $hw, $hx[1] - $hw, $fz[0], $fz[1], $gw)
$fy = _1dv($hy[0] + $hw, $hy[1] + $hw, 270, 5 * $fk)
$fz = _1dv($hy[0] - $hw, $hy[1] - $hw, 0, 5 * $fk)
_14u($hl[0], $hy[0] + $hw, $hy[1] + $hw, $fy[0], $fy[1], $c5)
_14u($hl[0], $hy[0] - $hw, $hy[1] - $hw, $fz[0], $fz[1], $c5)
_14u($hm[0], $hy[0] + $hw, $hy[1] + $hw, $fy[0], $fy[1], $c5)
_14u($hm[0], $hy[0] - $hw, $hy[1] - $hw, $fz[0], $fz[1], $c5)
_14u($hn[0], $hy[0] + $hw, $hy[1] + $hw, $fy[0], $fy[1], $gw)
_14u($hn[0], $hy[0] - $hw, $hy[1] - $hw, $fz[0], $fz[1], $gw)
_14u($hl[0], $hx[0] + $hw, $hx[1] - $hw, $hy[0], $hy[1], $c5)
_14u($hm[0], $hx[0] + $hw, $hx[1] - $hw, $hy[0], $hy[1], $c5)
_14u($hn[0], $hx[0] + $hw, $hx[1] - $hw, $hy[0], $hy[1], $gw)
$hw =($fn * 0.3)
Local $fw = Round($fq / 2, 0), $fx = Round($fr / 2.35, 0)
$fy = _1dv($fw - $hw, $fx - $hw, 90, 4 * $fk)
$fz = _1dv($fw + $hw, $fx + $hw, 180, 4 * $fk)
Local $hz = _1dv($fw + $hw, $fx - $hw, 135, 8 * $fk)
_14u($ho[0], $fw - $hw, $fx - $hw, $fy[0], $fy[1], $c5)
_14u($ho[0], $fw + $hw, $fx + $hw, $fz[0], $fz[1], $c5)
_14u($hp[0], $fw - $hw, $fx - $hw, $fy[0], $fy[1], $c5)
_14u($hp[0], $fw + $hw, $fx + $hw, $fz[0], $fz[1], $c5)
_14u($hq[0], $fw - $hw, $fx - $hw, $fy[0], $fy[1], $gw)
_14u($hq[0], $fw + $hw, $fx + $hw, $fz[0], $fz[1], $gw)
$hw =($fn * 0.3)
Local $i0 = Round($fq / 2.2, 0), $i1 = Round($fr / 2, 0)
$fy = _1dv($i0 - $hw, $i1 - $hw, 360, 4 * $fk)
$fz = _1dv($i0 + $hw, $i1 + $hw, 270, 4 * $fk)
Local $i2 = _1dv($i0 - $hw, $i1 + $hw, 315, 8 * $fk)
_14u($ho[0], $i0 - $hw, $i1 - $hw, $fy[0], $fy[1], $c5)
_14u($ho[0], $i0 + $hw, $i1 + $hw, $fz[0], $fz[1], $c5)
_14u($hp[0], $i0 - $hw, $i1 - $hw, $fy[0], $fy[1], $c5)
_14u($hp[0], $i0 + $hw, $i1 + $hw, $fz[0], $fz[1], $c5)
_14u($hq[0], $i0 - $hw, $i1 - $hw, $fy[0], $fy[1], $gw)
_14u($hq[0], $i0 + $hw, $i1 + $hw, $fz[0], $fz[1], $gw)
_14u($ho[0], $i0 - $hw, $i1 + $hw, $i2[0] + $hw, $i2[1] - $hw, $c5)
_14u($ho[0], $fw + $hw, $fx - $hw, $hz[0] - $hw, $hz[1] + $hw, $c5)
_14u($hp[0], $i0 - $hw, $i1 + $hw, $i2[0] + $hw, $i2[1] - $hw, $c5)
_14u($hp[0], $fw + $hw, $fx - $hw, $hz[0] - $hw, $hz[1] + $hw, $c5)
_14u($hq[0], $i0 - $hw, $i1 + $hw, $i2[0] + $hw, $i2[1] - $hw, $gw)
_14u($hq[0], $fw + $hw, $fx - $hw, $hz[0] - $hw, $hz[1] + $hw, $gw)
EndIf
If $fb[4] Then
_14u($hr[0], $fq / 3, $fr / 2.9,($fq / 3) * 2, $fr / 2.9, $c5)
_14u($hr[0], $fq / 3, $fr / 2.9 +($fn * 4),($fq / 3) * 2, $fr / 2.9 +($fn * 4), $c5)
_14u($hr[0], $fq / 3, $fr / 2.9 +($fn * 8),($fq / 3) * 2, $fr / 2.9 +($fn * 8), $c5)
_14u($hs[0], $fq / 3, $fr / 2.9,($fq / 3) * 2, $fr / 2.9, $c5)
_14u($hs[0], $fq / 3, $fr / 2.9 +($fn * 4),($fq / 3) * 2, $fr / 2.9 +($fn * 4), $c5)
_14u($hs[0], $fq / 3, $fr / 2.9 +($fn * 8),($fq / 3) * 2, $fr / 2.9 +($fn * 8), $c5)
_14u($ht[0], $fq / 3, $fr / 2.9,($fq / 3) * 2, $fr / 2.9, $gw)
_14u($ht[0], $fq / 3, $fr / 2.9 +($fn * 4),($fq / 3) * 2, $fr / 2.9 +($fn * 4), $gw)
_14u($ht[0], $fq / 3, $fr / 2.9 +($fn * 8),($fq / 3) * 2, $fr / 2.9 +($fn * 8), $gw)
EndIf
_19q($c5)
_19q($gu)
_19q($gv)
_19q($gw)
_19q($gx)
_13c($bu)
_13c($gy)
If $fb[0] Then
$h0[5] = _1ds($h0[0], $h9)
$h0[6] = _1ds($h0[0], $ha, False)
$h0[7] = _1ds($h0[0], $hb, False)
GUICtrlSetResizing($h0[0], 768 + 32 + 4)
$gz[0] = $h0[0]
_1c2($h0[0], "_iHoverOff", "_iHoverOn", '', "", _1dq($h0), $fl)
EndIf
If $fb[1] Then
$h2[5] = _1ds($h2[0], $hc)
$h2[6] = _1ds($h2[0], $hd, False)
$h2[7] = _1ds($h2[0], $he, False)
$h3[5] = _1ds($h3[0], $hf)
$h3[6] = _1ds($h3[0], $hg, False)
$h3[7] = _1ds($h3[0], $hh, False)
GUICtrlSetResizing($h2[0], 768 + 32 + 4)
GUICtrlSetResizing($h3[0], 768 + 32 + 4)
$gz[1] = $h2[0]
$gz[2] = $h3[0]
GUICtrlSetState($h3[0], 32)
_1c2($h2[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($h2), $fl)
_1c2($h3[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($h3), $fl)
EndIf
If $fb[2] Then
$h1[5] = _1ds($h1[0], $hi)
$h1[6] = _1ds($h1[0], $hj, False)
$h1[7] = _1ds($h1[0], $hk, False)
GUICtrlSetResizing($h1[0], 768 + 32 + 4)
$gz[3] = $h1[0]
_1c2($h1[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($h1), $fl)
EndIf
If $fb[3] Then
$h5[5] = _1ds($h5[0], $hl)
$h5[6] = _1ds($h5[0], $hm, False)
$h5[7] = _1ds($h5[0], $hn, False)
$h6[5] = _1ds($h6[0], $ho)
$h6[6] = _1ds($h6[0], $hp, False)
$h6[7] = _1ds($h6[0], $hq, False)
GUICtrlSetResizing($h5[0], 768 + 32 + 4)
GUICtrlSetResizing($h6[0], 768 + 32 + 4)
GUICtrlSetState($h6[0], 32)
$gz[4] = $h5[0]
$gz[5] = $h6[0]
_1c2($h5[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _1dq($h5), $fl)
_1c2($h6[0], "_iHoverOff", "_iHoverOn", "_iFullscreenToggleBtn", "", _1dq($h6), $fl)
EndIf
If $fb[4] Then
$h4[5] = _1ds($h4[0], $hr)
$h4[6] = _1ds($h4[0], $hs, False)
$h4[7] = _1ds($h4[0], $ht, False)
GUICtrlSetResizing($h4[0], 768 + 32 + 2)
$gz[6] = $h4[0]
_1c2($h4[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($h4), $fl)
EndIf
Return $gz
EndFunc
Func _1cw($gj, $ej, $ek, $eh, $ei, $gk = $ao, $gl = $ap, $gm = "Arial", $9v = 10, $gn = 1, $i3 = "0xFFFFFF")
Local $go[16]
Local $i4 = _1du()
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$eh = Round($eh * $e5)
$ei = Round($ei * $e5)
Else
$9v =($9v / $e4)
EndIf
$go[1] = False
$go[3] = "2"
$go[15] = _1dt()
Local $fn = Round(4 * $i4)
If Not(Mod($fn, 2) = 0) Then $fn = $fn - 1
$gk = "0xFF" & Hex($gk, 6)
$gl = "0xFF" & Hex($gl, 6)
$i3 = "0xFF" & Hex($i3, 6)
Local $gp = _13b($gl)
Local $i5 = _13b(StringReplace(_1e0($gl, -30), "0x", "0xFF"))
Local $i6 = _19o($i3, $fn)
Local $gr = _1dr($eh, $ei, $gk, 0, 5)
Local $gs = _1dr($eh, $ei, $gk, 0, 5)
Local $i7 = _1dr($eh, $ei, $gk, 0, 5)
Local $cc = _1aw(), $bv = _143($gm), $az = _141($bv, $9v, $gn)
Local $cb = _1af(0, 0, $eh, $ei)
_1az($cc, 1)
_1b0($cc, 1)
_150($gr[0], $gj, $az, $cb, $cc, $gp)
_150($gs[0], $gj, $az, $cb, $cc, $gp)
_150($i7[0], $gj, $az, $cb, $cc, $i5)
_14y($gs[0], 0, 0, $eh, $ei, $i6)
_142($az)
_145($bv)
_1ax($cc)
_13c($gp)
_13c($i5)
_19q($i6)
$go[0] = GUICtrlCreatePic("", $ej, $ek, $eh, $ei)
$go[5] = _1ds($go[0], $gr)
$go[6] = _1ds($go[0], $gs, False)
$go[7] = _1ds($go[0], $i7, False)
GUICtrlSetResizing($go[0], 768)
_1c2($go[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($go))
Return $go[0]
EndFunc
Func _1cx($gj, $ej, $ek, $eh, $ei, $gk = $ao, $gl = $ap, $gm = "Arial", $9v = 10, $gn = 1, $i3 = "0xFFFFFF")
Local $go[16]
Local $i4 = _1du()
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$eh = Round($eh * $e5)
$ei = Round($ei * $e5)
Else
$9v =($9v / $e4)
EndIf
$go[1] = False
$go[3] = "2"
$go[15] = _1dt()
Local $fn = Round(2 * $i4)
If Not(Mod($fn, 2) = 0) Then $fn = $fn - 1
$gk = "0xFF" & Hex($gk, 6)
$gl = "0xFF" & Hex($gl, 6)
$i3 = "0xFF" & Hex($i3, 6)
Local $gp = _13b($gl)
Local $i6 = _19o($i3, $fn)
Local $i8 = _19o(StringReplace(_1e0($gl, -30), "0x", "0xFF"), $fn)
Local $i5 = _13b(StringReplace(_1e0($gl, -30), "0x", "0xFF"))
Local $gr = _1dr($eh, $ei, $gk, 0, 5)
Local $gs = _1dr($eh, $ei, StringReplace(_1e0($gk, 25), "0x", "0xFF"), 0, 5)
Local $i7 = _1dr($eh, $ei, $gk, 0, 5)
Local $cc = _1aw(), $bv = _143($gm), $az = _141($bv, $9v, $gn)
Local $cb = _1af(0, 0, $eh, $ei)
_1az($cc, 1)
_1b0($cc, 1)
_150($gr[0], $gj, $az, $cb, $cc, $gp)
_150($gs[0], $gj, $az, $cb, $cc, $gp)
_150($i7[0], $gj, $az, $cb, $cc, $i5)
_14y($gr[0], 0, 0, $eh, $ei, $i6)
_14y($gs[0], 0, 0, $eh, $ei, $i6)
_14y($i7[0], 0, 0, $eh, $ei, $i8)
_142($az)
_145($bv)
_1ax($cc)
_13c($gp)
_13c($i5)
_19q($i6)
_19q($i8)
$go[0] = GUICtrlCreatePic("", $ej, $ek, $eh, $ei)
$go[5] = _1ds($go[0], $gr)
$go[6] = _1ds($go[0], $gs, False)
$go[7] = _1ds($go[0], $i7, False)
GUICtrlSetResizing($go[0], 768)
_1c2($go[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($go))
Return $go[0]
EndFunc
Func _1d1($gj, $ej, $ek, $eh, $ei, $gk = $al, $gl = $am, $gm = "Segoe UI", $9v = "11")
Local $i9 = $gj
If $ei < 20 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. height is 20px for metro toggles.")
EndIf
If $eh < 46 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. width for metro toggles must be at least 46px without any text!")
EndIf
If Not(Mod($ei, 2) = 0) Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The toggle height should be an even number to prevent any misplacing.")
EndIf
Local $ia = _1du()
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$eh = Round($eh * $e5)
$ei = Round($ei * $e5)
If Not(Mod($ei, 2) = 0) Then $ei = $ei + 1
Else
$9v =($9v / $e4)
EndIf
Local $ib[16]
$ib[1] = False
$ib[2] = False
$ib[3] = "6"
$ib[15] = _1dt()
Local $ic = Number(20 * $ia, 1)
If Not(Mod($ic, 2) = 0) Then $ic = $ic + 1
Local $id = Number(12 * $ia, 1)
If Not(Mod($id, 2) = 0) Then $id = $id + 1
Local $ie = Number((($ei - $ic) / 2), 1)
Local $if = Number((($ei - $id) / 2), 1)
Local $ig = 10 * $ia
Local $ih = Number(50 * $ia, 1)
If Not(Mod($ih, 2) = 0) Then $ih = $ih + 1
Local $ii = Number(46 * $ia, 1)
If Not(Mod($ii, 2) = 0) Then $ii = $ii + 1
Local $ij = Number(20 * $ia, 1)
If Not(Mod($ij, 2) = 0) Then $ij = $ij + 1
Local $ik = Number(2 * $ia, 1)
Local $il = Number(3 * $ia, 1)
Local $im = Number(11 * $ia, 1)
Local $in = Number(6 * $ia, 1)
$gk = "0xFF" & Hex($gk, 6)
$gl = "0xFF" & Hex($gl, 6)
Local $gp = _13b($gl)
Local $io = _13b(StringReplace($aq, "0x", "0xFF"))
If StringInStr($ar, "Light") Then
Local $ip = StringReplace(_1e0($gl, +65), "0x", "0xFF")
Local $iq = StringReplace(_1e0($gl, +65), "0x", "0xFF")
Local $ir = StringReplace(_1e0($gl, +70), "0x", "0xFF")
Else
Local $ip = StringReplace(_1e0($gl, -45), "0x", "0xFF")
Local $iq = StringReplace(_1e0($gl, -45), "0x", "0xFF")
Local $ir = StringReplace(_1e0($gl, -30), "0x", "0xFF")
EndIf
Local $is = _13b($gk)
Local $it = _13b($gl)
Local $iu = _13b($iq)
Local $iv = _19o($gl, 2 * $ia)
Local $iw = _19o($iq, 2 * $ia)
Local $ix = _13b(StringReplace($ao, "0x", "0xFF"))
Local $iy = _13b(StringReplace(_1e0($ao, +15), "0x", "0xFF"))
Local $iz = _13b(StringReplace($ap, "0x", "0xFF"))
Local $j0 = _19o(StringReplace($ao, "0x", "0xFF"), 2 * $ia)
Local $j1 = _19o(StringReplace(_1e0($ao, +15), "0x", "0xFF"), 2 * $ia)
Local $j2 = _1dr($eh, $ei, $gk, 5, 5), $j3 = _1dr($eh, $ei, $gk, 5, 5), $j4 = _1dr($eh, $ei, $gk, 5, 5), $j5 = _1dr($eh, $ei, $gk, 5, 5), $j6 = _1dr($eh, $ei, $gk, 5, 5), $j7 = _1dr($eh, $ei, $gk, 5, 5), $j8 = _1dr($eh, $ei, $gk, 5, 5), $j9 = _1dr($eh, $ei, $gk, 5, 5), $ja = _1dr($eh, $ei, $gk, 5, 5), $jb = _1dr($eh, $ei, $gk, 5, 5)
Local $cc = _1aw(), $bv = _143($gm), $az = _141($bv, $9v, 0)
Local $cb = _1af($ih +(10 * $ia), 0, $eh - $ih, $ei)
_1az($cc, 0)
_1b0($cc, 1)
If StringInStr($gj, "|@|") Then
$i9 = StringRegExp($gj, "\|@\|(.+)", 1)
If Not @error Then $i9 = $i9[0]
$gj = StringRegExp($gj, "^(.+)\|@\|", 1)
If Not @error Then $gj = $gj[0]
EndIf
_150($j2[0], $gj, $az, $cb, $cc, $gp)
_150($j3[0], $gj, $az, $cb, $cc, $gp)
_150($j4[0], $gj, $az, $cb, $cc, $gp)
_150($j5[0], $gj, $az, $cb, $cc, $gp)
_150($j6[0], $gj, $az, $cb, $cc, $gp)
_150($j7[0], $i9, $az, $cb, $cc, $gp)
_150($j8[0], $i9, $az, $cb, $cc, $gp)
_150($j9[0], $i9, $az, $cb, $cc, $gp)
_150($ja[0], $gj, $az, $cb, $cc, $gp)
_150($jb[0], $i9, $az, $cb, $cc, $gp)
Local $jc = _18x()
_17v($jc, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jc, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jc, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jc, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jc)
_154($j2[0], $jc, $is)
_14v($j2[0], $jc, $iv)
_153($j2[0], 6 * $ia, $if, 12 * $ia, 12 * $ia, $it)
Local $jd = _18x()
_17v($jd, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jd, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jd, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jd, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jd)
_154($ja[0], $jd, $is)
_14v($ja[0], $jd, $iw)
_153($ja[0], 6 * $ia, $if, 12 * $ia, 12 * $ia, $iu)
Local $je = _18x()
_17v($je, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($je, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($je, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($je, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($je)
_154($j3[0], $je, $is)
_14v($j3[0], $je, $iw)
_153($j3[0], 10 * $ia, $if, 12 * $ia, 12 * $ia, $iu)
Local $jf = _18x()
_17v($jf, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jf, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jf, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jf, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jf)
_154($j4[0], $jf, $is)
_14v($j4[0], $jf, $iw)
_153($j4[0], 14 * $ia, $if, 12 * $ia, 12 * $ia, $iu)
Local $jg = _18x()
_17v($jg, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jg, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jg, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jg, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jg)
_154($j5[0], $jg, $is)
_14v($j5[0], $jg, $iw)
_153($j5[0], 18 * $ia, $if, 12 * $ia, 12 * $ia, $iu)
Local $jh = _18x()
_17v($jh, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jh, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jh, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jh, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jh)
_154($j6[0], $jh, $is)
_14v($j6[0], $jh, $iw)
_153($j6[0], 22 * $ia, $if, 12 * $ia, 12 * $ia, $iu)
Local $ji = _18x()
_17v($ji, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($ji, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($ji, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($ji, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($ji)
_154($j7[0], $ji, $iy)
_14v($j7[0], $ji, $j1)
_153($j7[0], 26 * $ia, $if, 12 * $ia, 12 * $ia, $iz)
Local $jj = _18x()
_17v($jj, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jj, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jj, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jj, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jj)
_154($j8[0], $jj, $iy)
_14v($j8[0], $jj, $j1)
_153($j8[0], 30 * $ia, $if, 12 * $ia, 12 * $ia, $iz)
Local $jk = _18x()
_17v($jk, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jk, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jk, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jk, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jk)
_154($j9[0], $jk, $ix)
_14v($j9[0], $jk, $j0)
_153($j9[0], 34 * $ia, $if, 12 * $ia, 12 * $ia, $iz)
Local $jl = _18x()
_17v($jl, 0 + $ih -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($jl, 0 + $ih -($ig * 2), $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($jl, 1 * $ia, $ie +(20 * $ia) -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($jl, 1 * $ia, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($jl)
_154($jb[0], $jl, $iy)
_14v($jb[0], $jl, $j1)
_153($jb[0], 34 * $ia, $if, 12 * $ia, 12 * $ia, $iz)
_142($az)
_145($bv)
_1ax($cc)
_13c($gp)
_13c($io)
_13c($is)
_13c($it)
_13c($iu)
_13c($ix)
_13c($iy)
_13c($iz)
_19q($iv)
_19q($iw)
_19q($j0)
_19q($j1)
_18z($jc)
_18z($jd)
_18z($je)
_18z($jf)
_18z($jg)
_18z($jh)
_18z($ji)
_18z($jj)
_18z($jk)
_18z($jl)
$ib[0] = GUICtrlCreatePic("", $ej, $ek, $eh, $ei)
$ib[5] = _1ds($ib[0], $j2)
$ib[6] = _1ds($ib[0], $j3, False)
$ib[7] = _1ds($ib[0], $j4, False)
$ib[8] = _1ds($ib[0], $j5, False)
$ib[9] = _1ds($ib[0], $j6, False)
$ib[10] = _1ds($ib[0], $j7, False)
$ib[11] = _1ds($ib[0], $j8, False)
$ib[12] = _1ds($ib[0], $j9, False)
$ib[13] = _1ds($ib[0], $ja, False)
$ib[14] = _1ds($ib[0], $jb, False)
GUICtrlSetResizing($ib[0], 768)
_1c2($ib[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($ib))
Return $ib[0]
EndFunc
Func _1d5($jm)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $jm Then
If $e6[$1c][2] Then
Return True
Else
Return False
EndIf
EndIf
Next
EndFunc
Func _1d7($jm, $jn = False)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $jm Then
If $e6[$1c][2] Then
If Not $jn Then
For $f2 = 12 To 6 Step -1
_4a(GUICtrlSendMsg($jm, 0x0172, 0, $e6[$1c][$f2]))
Sleep(1)
Next
_4a(GUICtrlSendMsg($jm, 0x0172, 0, $e6[$1c][13]))
Else
_4a(GUICtrlSendMsg($jm, 0x0172, 0, $e6[$1c][13]))
EndIf
$e6[$1c][1] = True
$e6[$1c][2] = False
ExitLoop
EndIf
EndIf
Next
EndFunc
Func _1d8($jm, $jn = False)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $jm Then
If Not $e6[$1c][2] Then
If Not $jn Then
For $f2 = 6 To 11 Step +1
_4a(GUICtrlSendMsg($jm, 0x0172, 0, $e6[$1c][$f2]))
Sleep(1)
Next
_4a(GUICtrlSendMsg($jm, 0x0172, 0, $e6[$1c][12]))
Else
_4a(GUICtrlSendMsg($jm, 0x0172, 0, $e6[$1c][12]))
EndIf
$e6[$1c][2] = True
$e6[$1c][1] = True
ExitLoop
EndIf
EndIf
Next
EndFunc
Func _1d9($jo, $gj, $ej, $ek, $eh, $ei, $gk = $al, $gl = $am, $gm = "Segoe UI", $9v = "11", $gn = 0, $jp = 22, $jq = False)
If $ei < 22 And $jp > 21 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. height is 22px for metro radios.")
EndIf
Local $jr = _1du()
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$eh = Round($eh * $e5)
$ei = Round($ei * $e5)
If Mod($eh, 2) <> 0 Then $eh = $eh - 1
If Mod($ei, 2) <> 0 Then $ei = $ei - 1
$jp = $jp * $e5
If Mod($jp, 2) <> 0 Then $jp = $jp - 1
Else
$9v =($9v / $e4)
EndIf
Local $js[16]
$js[1] = False
$js[2] = False
$js[3] = "7"
$js[4] = $jo
$js[15] = _1dt()
Local $ie =($ei - $jp) / 2
If $gk <> 0 Then $gk = "0xFF" & Hex($gk, 6)
$gl = "0xFF" & Hex($gl, 6)
Local $gp = _13b($gl)
Local $ip = StringReplace($as, "0x", "0xFF")
Local $jt = _13b(StringReplace($aq, "0x", "0xFF"))
If $jq Then
Local $ju = _13b(StringReplace($ao, "0x", "0xFF"))
Else
Local $ju = _13b(StringReplace($at, "0x", "0xFF"))
EndIf
Local $jv = _13b(StringReplace($as, "0x", "0xFF"))
Local $jw = _1dr($eh, $ei, $gk, 5, 5)
Local $jx = _1dr($eh, $ei, $gk, 5, 5)
Local $jy = _1dr($eh, $ei, $gk, 5, 5)
Local $jz = _1dr($eh, $ei, $gk, 5, 5)
Local $cc = _1aw(), $bv = _143($gm), $az = _141($bv, $9v, $gn)
Local $cb = _1af($jp +(4 * $jr), 0, $eh - $jp +(4 * $jr), $ei)
_1az($cc, 0)
_1b0($cc, 1)
$cb.Y = 1
_150($jw[0], $gj, $az, $cb, $cc, $gp)
_150($jx[0], $gj, $az, $cb, $cc, $gp)
_150($jy[0], $gj, $az, $cb, $cc, $gp)
_150($jz[0], $gj, $az, $cb, $cc, $gp)
Local $k0 = 1 * $jr
Local $k1 = 5 * $jr
Local $k2 = 11 * $jr
_153($jw[0], 0, $ie, $jp - $k0, $jp - $k0, $jt)
_153($jy[0], 0, $ie, $jp - $k0, $jp - $k0, $jv)
_153($jx[0], 0, $ie, $jp - $k0, $jp - $k0, $jt)
_153($jx[0], $k1, $ie + $k1, $jp - $k2, $jp - $k2, $ju)
_153($jz[0], 0, $ie, $jp - $k0, $jp - $k0, $jv)
_153($jz[0], $k1, $ie + $k1, $jp - $k2, $jp - $k2, $ju)
_142($az)
_145($bv)
_1ax($cc)
_13c($gp)
_13c($jt)
_13c($ju)
_13c($jv)
$js[0] = GUICtrlCreatePic("", $ej, $ek, $eh, $ei)
$js[5] = _1ds($js[0], $jw)
$js[7] = _1ds($js[0], $jx, False)
$js[6] = _1ds($js[0], $jy, False)
$js[8] = _1ds($js[0], $jz, False)
GUICtrlSetResizing($js[0], 768)
_1c2($js[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($js))
Return $js[0]
EndFunc
Func _1da($jo, $gj, $ej, $ek, $eh, $ei, $gk = $al, $gl = $am, $gm = "Segoe UI", $9v = "11", $gn = 0, $jp = 22)
Return _1d9($jo, $gj, $ej, $ek, $eh, $ei, $gk, $gl, $gm, $9v, $gn, $jp, True)
EndFunc
Func _1db($jo, $k3, $k4 = False)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $k3 Then
$e6[$1c][1] = True
$e6[$1c][2] = True
If $k4 Then
_4a(GUICtrlSendMsg($e6[$1c][0], 0x0172, 0, $e6[$1c][7]))
Else
_4a(GUICtrlSendMsg($e6[$1c][0], 0x0172, 0, $e6[$1c][8]))
EndIf
Else
If $e6[$1c][4] = $jo Then
$e6[$1c][2] = False
_4a(GUICtrlSendMsg($e6[$1c][0], 0x0172, 0, $e6[$1c][5]))
EndIf
EndIf
Next
EndFunc
Func _1dc($jo, $k3)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $k3 Then
If $e6[$1c][4] = $jo Then
If $e6[$1c][2] Then
Return True
Else
Return False
EndIf
EndIf
EndIf
Next
Return False
EndFunc
Func _1dd($gj, $ej, $ek, $eh, $ei, $gk = $al, $gl = $am, $gm = "Segoe UI", $9v = "11", $gn = 0, $k5 = 1)
If $ei < 24 Then
If(@Compiled = 0) Then MsgBox(48, "Metro UDF", "The min. height is 24px for metro checkboxes.")
EndIf
Local $k6 = _1du()
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$eh = Round($eh * $e5)
$ei = Round($ei * $e5)
If Mod($eh, 2) <> 0 Then $eh = $eh + 1
Else
$9v =($9v / $e4)
EndIf
Local $k7[16]
$k7[1] = False
$k7[2] = False
$k7[3] = "5"
$k7[15] = _1dt()
Local $k8 = Round(22 * $k6)
Local $ie =($ei - $k8) / 2
Local $k9 = $k8 +($ie * 1.3)
Local $fn
If $k5 = 0 Then
$fn = $k8 / 7
Else
$fn = $k8 / 8
EndIf
If $gk <> 0 Then
$gk = "0xFF" & Hex($gk, 6)
EndIf
$gl = "0xFF" & Hex($gl, 6)
Local $gp = _13b($gl)
If $k5 = 0 Then
Local $jt = _13b(StringReplace($aq, "0x", "0xFF"))
Local $jv = $jt
Local $ju = _13b(StringReplace($as, "0x", "0xFF"))
Local $ka = $ju
Local $kb = _19o(StringReplace($at, "0x", "0xFF"), $fn)
Else
Local $jt = _13b(StringReplace($aq, "0x", "0xFF"))
Local $ju = _13b(StringReplace($as, "0x", "0xFF"))
Local $jv = _13b(StringReplace($ao, "0x", "0xFF"))
Local $ka = _13b(StringReplace(_1e0($ao, +10), "0x", "0xFF"))
Local $kb = _19o(StringReplace($aq, "0x", "0xFF"), $fn)
EndIf
Local $kc = _1dr($eh, $ei, $gk, 5, 5)
Local $kd = _1dr($eh, $ei, $gk, 5, 5)
Local $ke = _1dr($eh, $ei, $gk, 5, 5)
Local $kf = _1dr($eh, $ei, $gk, 5, 5)
Local $cc = _1aw(), $bv = _143($gm), $az = _141($bv, $9v, $gn)
Local $cb = _1af($k9, 0, $eh - $k9, $ei)
_1az($cc, 1)
_1b0($cc, 1)
$cb.Y = 1
_150($kc[0], $gj, $az, $cb, $cc, $gp)
_150($kd[0], $gj, $az, $cb, $cc, $gp)
_150($ke[0], $gj, $az, $cb, $cc, $gp)
_150($kf[0], $gj, $az, $cb, $cc, $gp)
Local $ig = Round(2 * $k6)
Local $c6 = _18x()
_17v($c6, $k8 -($ig * 2), $ie, $ig * 2, $ig * 2, 270, 90)
_17v($c6, $k8 -($ig * 2), $ie + $k8 -($ig * 2), $ig * 2, $ig * 2, 0, 90)
_17v($c6, 0, $ie + $k8 -($ig * 2), $ig * 2, $ig * 2, 90, 90)
_17v($c6, 0, $ie, $ig * 2, $ig * 2, 180, 90)
_18w($c6)
_154($kc[0], $c6, $jt)
_154($ke[0], $c6, $ju)
_154($kd[0], $c6, $jv)
_154($kf[0], $c6, $ka)
Local $hw =($fn * 0.70) / 2
Local $fw = $k8 / 2.60
Local $fx = $ie + $k8 / 1.3
Local $fy = _1dv($fw - $hw, $fx, 135, $k8 / 1.35)
Local $fz = _1dv($fw, $fx - $hw, 225, $k8 / 3)
_14u($kd[0], $fw - $hw, $fx, $fy[0], $fy[1], $kb)
_14u($kd[0], $fw, $fx - $hw, $fz[0], $fz[1], $kb)
_14u($kf[0], $fw - $hw, $fx, $fy[0], $fy[1], $kb)
_14u($kf[0], $fw, $fx - $hw, $fz[0], $fz[1], $kb)
_142($az)
_145($bv)
_1ax($cc)
_13c($gp)
_13c($jt)
_13c($ju)
_13c($jv)
_13c($ka)
_19q($kb)
$k7[0] = GUICtrlCreatePic("", $ej, $ek, $eh, $ei)
$k7[5] = _1ds($k7[0], $kc)
$k7[7] = _1ds($k7[0], $kd, False)
$k7[6] = _1ds($k7[0], $ke, False)
$k7[8] = _1ds($k7[0], $kf, False)
GUICtrlSetResizing($k7[0], 768)
_1c2($k7[0], "_iHoverOff", "_iHoverOn", "", "", _1dq($k7))
Return $k7[0]
EndFunc
Func _1dg($kg)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $kg Then
If $e6[$1c][2] Then
Return True
Else
Return False
EndIf
EndIf
Next
EndFunc
Func _1dh($kg)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $kg Then
$e6[$1c][2] = False
$e6[$1c][1] = True
_4a(GUICtrlSendMsg($kg, 0x0172, 0, $e6[$1c][6]))
EndIf
Next
EndFunc
Func _1di($kg, $k4 = False)
For $1c = 0 To(UBound($e6) - 1) Step +1
If $e6[$1c][0] = $kg Then
$e6[$1c][2] = True
$e6[$1c][1] = True
If $k4 Then
_4a(GUICtrlSendMsg($kg, 0x0172, 0, $e6[$1c][7]))
Else
_4a(GUICtrlSendMsg($kg, 0x0172, 0, $e6[$1c][8]))
EndIf
EndIf
Next
EndFunc
Func _1dk($3f, $eg, $gj, $g0 = 600, $9v = 11, $em = "", $kh = 0)
Local $ki, $kj, $kk, $kl = "-", $km = "-", $kn = "-", $ko = 1
Switch $3f
Case 0
$ko = 1
$kl = "OK"
Case 1
$ko = 2
$kl = "OK"
$km = "Cancel"
Case 2
$ko = 3
$kl = "Abort"
$km = "Retry"
$kn = "Ignore"
Case 3
$ko = 3
$kl = "Yes"
$km = "No"
$kn = "Cancel"
Case 4
$ko = 2
$kl = "Yes"
$km = "No"
Case 5
$ko = 2
$kl = "Retry"
$km = "Cancel"
Case 6
$ko = 3
$kl = "Cancel"
$km = "Retry"
$kn = "Continue"
Case Else
$ko = 1
$kl = "OK"
EndSwitch
If($ko = 1) And($g0 < 180) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 180px for the selected message style/flag.")
If($ko = 2) And($g0 < 240) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 240px for the selected message style/flag.")
If($ko = 3) And($g0 < 360) Then MsgBox(16, "MetroUDF", "Error: Messagebox width has to be at least 360px for the selected message style/flag.")
Local $kp = _1du()
If $ed Then
$g0 = Round($g0 * $e5)
Else
$9v =($9v / $e4)
EndIf
Local $kq = _12f($gj, $9v, 400, 0, "Arial", $g0 -(30 * $kp))
Local $kr = 120 +($kq[3] / $kp)
Local $ks = _1ck($eg, $g0 / $kp, $kr, -1, -1, False, $em)
$kr = $kr * $kp
GUICtrlCreateLabel(" " & $eg, 2 * $kp, 2 * $kp, $g0 -(4 * $kp), 30 * $kp, 0x0200, 0x00100000)
GUICtrlSetBkColor(-1, _1e0($al, 30))
GUICtrlSetColor(-1, $am)
_1dw(-1, 11, 600, 0, "Arial", 5)
GUICtrlCreateLabel($gj, 15 * $kp, 50 * $kp, $kq[2], $kq[3], -1, 0x00100000)
GUICtrlSetBkColor(-1, $al)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, $9v, 400, 0, "Arial", 5)
Local $kt =(($g0 / $kp) -($ko * 100) -(($ko - 1) * 20)) / 2
Local $ku =($g0 -($ko *(100 * $kp)) -(($ko - 1) *(20 * $kp))) / 2
Local $kv = $kt + 120
Local $kw = $kv + 120
GUICtrlCreateLabel("", 2 * $kp, $kr -(53 * $kp), $ku -(4 * $kp),(50 * $kp), -1, 0x00100000)
GUICtrlCreateLabel("", $g0 - $ku +(2 * $kp), $kr -(53 * $kp), $ku -(4 * $kp),(50 * $kp), -1, 0x00100000)
Local $kx = GUICtrlCreateDummy()
Local $ky[1][2] = [["{ENTER}", $kx]]
Local $ki = _1cw($kl, $kt,($kr / $kp) - 50, 100, 34, $ao, $ap)
Local $kj = _1cw($km, $kv,($kr / $kp) - 50, 100, 34, $ao, $ap)
If $ko < 2 Then GUICtrlSetState($kj, 32)
Local $kk = _1cw($kn, $kw,($kr / $kp) - 50, 100, 34, $ao, $ap)
If $ko < 3 Then GUICtrlSetState($kk, 32)
Switch $3f
Case 0, 1, 5
GUICtrlSetState($ki, 512)
Case 2, 4, 6
GUICtrlSetState($kj, 512)
Case 3
GUICtrlSetState($kk, 512)
Case Else
GUICtrlSetState($ki, 512)
EndSwitch
GUISetAccelerators($ky, $ks)
GUISetState(@SW_SHOW)
If $kh <> 0 Then
$e8 = $kh
AdlibRegister("_1dy", 1000)
EndIf
If $ef Then Opt("GUIOnEventMode", 0)
While 1
If $kh <> 0 Then
If $e8 <= 0 Then
AdlibUnRegister("_1dy")
_1cm($ks)
If $ef Then Opt("GUIOnEventMode", 1)
Return SetError(1)
EndIf
EndIf
Local $kz = GUIGetMsg()
Switch $kz
Case -3, $ki
_1cm($ks)
If $ef Then Opt("GUIOnEventMode", 1)
Return $kl
Case $kj
_1cm($ks)
If $ef Then Opt("GUIOnEventMode", 1)
Return $km
Case $kk
_1cm($ks)
If $ef Then Opt("GUIOnEventMode", 1)
Return $kn
Case $kx
_1cm($ks)
Local $l0
Switch $3f
Case 0, 1, 5
$l0 = $kl
Case 2, 4, 6
$l0 = $km
Case 3
$l0 = $kn
Case Else
$l0 = $kl
EndSwitch
If $ef Then Opt("GUIOnEventMode", 1)
Return $l0
EndSwitch
WEnd
EndFunc
Func _1dm($ej, $ek, $eh, $ei, $l1 = False, $l2 = $aq, $l3 = $ao)
Local $l4[8]
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$eh = Round($eh * $e5)
$ei = Round($ei * $e5)
EndIf
$l4[1] = $eh
$l4[2] = $ei
$l4[3] = "0xFF" & Hex($l2, 6)
$l4[4] = "0xFF" & Hex($l3, 6)
$l4[5] = StringReplace($as, "0x", "0xFF")
$l4[7] = $l1
Local $l5 = _19o($l4[5], 2)
Local $l6 = _1dr($eh, $ei, $l4[3], 1, 5)
If $l1 Then
_14y($l6[0], 0, 0, $eh, $ei, $l5)
EndIf
_19q($l5)
$l4[0] = GUICtrlCreatePic("", $ej, $ek, $eh, $ei)
$l4[6] = _1ds($l4[0], $l6)
GUICtrlSetResizing($l4[0], 768)
Return $l4
EndFunc
Func _1dn(ByRef $l7, $l8)
Local $l5 = _19o($l7[5], 2)
Local $l9 = _13b($l7[4])
Local $l6 = _1dr($l7[1], $l7[2], $l7[3], 1, 5)
If $l8 > 100 Then $l8 = 100
If $l7[7] Then
Local $la =(($l7[1] - 2) / 100) * $l8
_14y($l6[0], 0, 0, $l7[1], $l7[2], $l5)
_157($l6[0], 1, 1, $la, $l7[2] - 2, $l9)
Else
Local $la =(($l7[1]) / 100) * $l8
_157($l6[0], 0, 0, $la, $l7[2], $l9)
EndIf
_19q($l5)
_13c($l9)
Local $lb = _1ds($l7[0], $l6)
_4a($l7[6])
$l7[6] = $lb
EndFunc
Func _1do($ej, $ek, $eh, $lc, $ld = $an)
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$eh = Round($eh * $e5)
$lc = Round($lc * $e5)
EndIf
Local $le = GUICtrlCreateLabel("", $ej, $ek, $eh, $lc)
GUICtrlSetBkColor(-1, $ld)
GUICtrlSetState(-1, 128)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
Return $le
EndFunc
Func _1dp($ej, $ek, $ei, $lc, $ld = $an)
If $ed Then
$ej = Round($ej * $e5)
$ek = Round($ek * $e5)
$ei = Round($ei * $e5)
$lc = Round($lc * $e5)
EndIf
Local $le = GUICtrlCreateLabel("", $ej, $ek, $lc, $ei)
GUICtrlSetBkColor(-1, $ld)
GUICtrlSetState(-1, 128)
GUICtrlSetResizing(-1, 32 + 64 + 256 + 2)
Return $le
EndFunc
Func _1dq($lf)
Local $lg
For $1c = 0 To UBound($e6) - 1 Step +1
If $e6[$1c][0] = "" Then
$lg = $1c
ExitLoop
EndIf
Next
If $lg == "" Then
$lg = UBound($e6)
ReDim $e6[$lg + 1][16]
EndIf
For $1c = 0 To 15
$e6[$lg][$1c] = $lf[$1c]
Next
Return $lg
EndFunc
Func _1dr($lh, $li, $lj = 0, $lk = 4, $ll = 0)
Local $lm[2]
$lm[1] = _12z($lh, $li, $bi)
$lm[0] = _16d($lm[1])
_15v($lm[0], $lk)
_15w($lm[0], $ll)
If $lj <> 0 Then _14f($lm[0], $lj)
Return $lm
EndFunc
Func _1ds($ln, $lm, $lo = True)
Local $lp = _131($lm[1])
If $lo Then _4a(GUICtrlSendMsg($ln, 0x0172, 0, $lp))
_14i($lm[0])
_132($lm[1])
Return $lp
EndFunc
Func _1dt()
Local $lq = GUICtrlCreateLabel("", 0, 0, 0, 0)
Local $lr = _9a(GUICtrlGetHandle($lq))
GUICtrlDelete($lq)
Return $lr
EndFunc
Func _1du()
If $ed Then
Return $e5
Else
Return 1
EndIf
EndFunc
Func _1dv($ls, $lt, $lu, $lv)
Local $lw[2]
$lw[0] = $ls +($lv * Sin($lu / 180 * 3.14159265358979))
$lw[1] = $lt +($lv * Cos($lu / 180 * 3.14159265358979))
Return $lw
EndFunc
Func _1dw($lx, $av, $aw = 400, $ly = 0, $lz = "", $m0 = 5)
If $ed Then
GUICtrlSetFont($lx, $av, $aw, $ly, $lz, $m0)
Else
GUICtrlSetFont($lx, $av / $e4, $aw, $ly, $lz, $m0)
EndIf
EndFunc
Func _1dx()
Local $m1[3]
Local $m2, $m3, $m4 = 90, $k = 0
Local $74 = DllCall("user32.dll", "long", "GetDC", "long", $k)
Local $2i = DllCall("gdi32.dll", "long", "GetDeviceCaps", "long", $74[0], "long", $m4)
$74 = DllCall("user32.dll", "long", "ReleaseDC", "long", $k, "long", $74)
$m2 = $2i[0]
Select
Case $m2 = 0
$m2 = 96
$m3 = 94
Case $m2 < 84
$m3 = $m2 / 105
Case $m2 < 121
$m3 = $m2 / 96
Case $m2 < 145
$m3 = $m2 / 95
Case Else
$m3 = $m2 / 94
EndSelect
$m1[0] = 2
$m1[1] = $m2
$m1[2] = $m3
Return $m1
EndFunc
Func _1dy()
$e8 -= 1
EndFunc
Func _1e0($m5, $m6, $m7 = 7)
Local $m8 = $m6 *(BitAND(1, $m7) <> 0) + BitAND($m5, 0xff0000) / 0x10000
Local $m9 = $m6 *(BitAND(2, $m7) <> 0) + BitAND($m5, 0x00ff00) / 0x100
Local $ma = $m6 *(BitAND(4, $m7) <> 0) + BitAND($m5, 0x0000FF)
Return "0x" & Hex(String(_1e1($m8) * 0x10000 + _1e1($m9) * 0x100 + _1e1($ma)), 6)
EndFunc
Func _1e1($mb)
If $mb > 255 Then Return 255
If $mb < 0 Then Return 0
Return $mb
EndFunc
Func _1e2($er, $mc, $md, $me = 0xFFFFFF)
Local $mf, $mg, $mh, $mi
Local $eo = _1e9($er)
$mh = GUICtrlCreateLabel("", 0, 0, $mc, 1)
GUICtrlSetColor(-1, $me)
GUICtrlSetBkColor(-1, $me)
GUICtrlSetResizing(-1, 544)
GUICtrlSetState(-1, 128)
$mi = GUICtrlCreateLabel("", 0, $md - 1, $mc, 1)
GUICtrlSetColor(-1, $me)
GUICtrlSetBkColor(-1, $me)
GUICtrlSetResizing(-1, 576)
GUICtrlSetState(-1, 128)
$mf = GUICtrlCreateLabel("", 0, 1, 1, $md - 1)
GUICtrlSetColor(-1, $me)
GUICtrlSetBkColor(-1, $me)
GUICtrlSetResizing(-1, 256 + 2)
GUICtrlSetState(-1, 128)
$mg = GUICtrlCreateLabel("", $mc - 1, 1, 1, $md - 1)
GUICtrlSetColor(-1, $me)
GUICtrlSetBkColor(-1, $me)
GUICtrlSetResizing(-1, 256 + 4)
GUICtrlSetState(-1, 128)
If $eo <> "" Then
$e7[$eo][12] = $mh
$e7[$eo][13] = $mi
$e7[$eo][14] = $mf
$e7[$eo][15] = $mg
EndIf
EndFunc
Func _1e3($mj, $mk, $ml)
Local $mm[2]
$mm[0] = "-1"
$mm[1] = "-1"
Local $h7 = WinGetPos($mj)
If Not @error Then
$mm[0] =($h7[0] +(($h7[2] - $mk) / 2))
$mm[1] =($h7[1] +(($h7[3] - $ml) / 2))
EndIf
Return $mm
EndFunc
Func _1e4($mn = 96)
_1av()
Local $mo = _14h(0)
If @error Then Return SetError(1, @extended, 0)
Local $1w
#forcedef $bk, $mp
$1w = DllCall($bk, "int", "GdipGetDpiX", "handle", $mo, "float*", 0)
If @error Then Return SetError(2, @extended, 0)
Local $m2 = $1w[2]
_14i($mo)
_1au()
Return $m2 / $mn
EndFunc
Func _iHoverOn($d4, $mq)
Switch $e6[$mq][3]
Case 5, 7
If $e6[$mq][2] Then
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][8]))
Else
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][6]))
EndIf
Case "6"
If $e6[$mq][2] Then
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][14]))
Else
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][13]))
EndIf
Case Else
_4a(GUICtrlSendMsg($d4, 0x0172, 0, $e6[$mq][6]))
EndSwitch
EndFunc
Func _iHoverOff($d4, $mq)
Switch $e6[$mq][3]
Case 0, 3, 4, 8, 9, 10
If WinActive($e6[$mq][15]) Then
_4a(GUICtrlSendMsg($d4, 0x0172, 0, $e6[$mq][5]))
Else
_4a(GUICtrlSendMsg($d4, 0x0172, 0, $e6[$mq][7]))
EndIf
Case 5, 7
If $e6[$mq][2] Then
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][7]))
Else
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][5]))
EndIf
Case "6"
If $e6[$mq][2] Then
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][12]))
Else
_4a(GUICtrlSendMsg($e6[$mq][0], 0x0172, 0, $e6[$mq][5]))
EndIf
Case Else
_4a(GUICtrlSendMsg($d4, 0x0172, 0, $e6[$mq][5]))
EndSwitch
EndFunc
Func _1e5($mr, $k)
For $1c = 0 To UBound($e6) - 1
If($mr = $e6[$1c][3]) And($k = $e6[$1c][15]) Then Return $e6[$1c][0]
Next
Return False
EndFunc
Func _1e6($k, $1p, $1q, $1r, $9j, $eo)
Switch $1p
Case 0x00AF, 0x0085, 0x00AE, 0x0083, 0x0086
Return -1
Case 0x031A
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(2, 4))
_9t($k, 0, 0, 0, 0, 0, 0x0020 + 0x0002 + 0x0001 + 0x0008)
DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", BitOR(1, 2, 4))
Return 0
Case 0x0005
If Not $e7[$eo][11] Then
Switch $1q
Case 2
Local $ms = _1e8($k)
Local $mt = WinGetPos($k)
WinMove($k, "", $mt[0] - 1, $mt[1] - 1, $ms[2], $ms[3])
For $mu = 0 To UBound($e6) - 1
If $k = $e6[$mu][15] Then
Switch $e6[$mu][3]
Case 3
GUICtrlSetState($e6[$mu][0], 32)
$e6[$mu][8] = False
Case 4
GUICtrlSetState($e6[$mu][0], 16)
$e6[$mu][8] = True
EndSwitch
EndIf
Next
Case 0
For $mu = 0 To UBound($e6) - 1
If $k = $e6[$mu][15] Then
Switch $e6[$mu][3]
Case 3
If Not $e6[$mu][8] Then
GUICtrlSetState($e6[$mu][0], 16)
$e6[$mu][8] = True
EndIf
Case 4
If $e6[$mu][8] Then
GUICtrlSetState($e6[$mu][0], 32)
$e6[$mu][8] = False
EndIf
EndSwitch
EndIf
Next
EndSwitch
EndIf
Case 0x0024
Local $mv = DllStructCreate("int;int;int;int;int;int;int;int;int;dword", $1r)
Local $mw = _1e8($k)
DllStructSetData($mv, 3, $mw[2])
DllStructSetData($mv, 4, $mw[3])
DllStructSetData($mv, 5, $mw[0] + 1)
DllStructSetData($mv, 6, $mw[1] + 1)
DllStructSetData($mv, 7, $e7[$eo][3])
DllStructSetData($mv, 8, $e7[$eo][4])
Case 0x0084
If $e7[$eo][2] And Not $e7[$eo][11] Then
Local $mx = 0, $my = 0, $mz
Local $mt = WinGetPos($k)
Local $n0 = GUIGetCursorInfo($k)
If Not @error Then
If $n0[0] < $ec Then $mx = 1
If $n0[0] > $mt[2] - $ec Then $mx = 2
If $n0[1] < $ec Then $my = 3
If $n0[1] > $mt[3] - $ec Then $my = 6
$mz = $mx + $my
Else
$mz = 0
EndIf
If WinGetState($k) <> 47 Then
Local $n1 = 2, $n2 = 2
Switch $mz
Case 1
$n2 = 13
$n1 = 10
Case 2
$n2 = 13
$n1 = 11
Case 3
$n2 = 11
$n1 = 12
Case 4
$n2 = 12
$n1 = 13
Case 5
$n2 = 10
$n1 = 14
Case 6
$n2 = 11
$n1 = 15
Case 7
$n2 = 10
$n1 = 16
Case 8
$n2 = 12
$n1 = 17
EndSwitch
GUISetCursor($n2, 1)
If $n1 <> 2 Then Return $n1
EndIf
If Abs(BitAND(BitShift($1r, 16), 0xFFFF) - $mt[1]) <(28 * $e5) Then Return 2
EndIf
Case 0x0201
If $e7[$eo][1] And Not $e7[$eo][11] And Not(WinGetState($k) = 47) Then
Local $n3 = GUIGetCursorInfo($k)
If($n3[4] = 0) Then
DllCall("user32.dll", "int", "ReleaseCapture")
DllCall("user32.dll", "long", "SendMessageA", "hwnd", $k, "int", 0x00A1, "int", 2, "int", 0)
Return 0
EndIf
EndIf
Case 0x001C
For $mu = 0 To UBound($e6) - 1
Switch $e6[$mu][3]
Case 0, 3, 4, 8, 9, 10
If $1q Then
_4a(GUICtrlSendMsg($e6[$mu][0], 0x0172, 0, $e6[$mu][5]))
Else
_4a(GUICtrlSendMsg($e6[$mu][0], 0x0172, 0, $e6[$mu][7]))
EndIf
EndSwitch
Next
Case 0x0020
If MouseGetCursor() <> 2 Then
Local $n0 = GUIGetCursorInfo($k)
If Not @error And $n0[4] <> 0 Then
Local $mx = 0, $my = 0, $mz = 0
Local $mt = WinGetPos($k)
If $n0[0] < $ec Then $mx = 1
If $n0[0] > $mt[2] - $ec Then $mx = 2
If $n0[1] < $ec Then $my = 3
If $n0[1] > $mt[3] - $ec Then $my = 6
$mz = $mx + $my
If $mz = 0 Then
If $n0[4] <> $e7[$eo][12] And $n0[4] <> $e7[$eo][13] And $n0[4] <> $e7[$eo][14] And $n0[4] <> $e7[$eo][15] Then
GUISetCursor(2, 0, $k)
EndIf
EndIf
EndIf
EndIf
EndSwitch
Return DllCall("comctl32.dll", "lresult", "DefSubclassProc", "hwnd", $k, "uint", $1p, "wparam", $1q, "lparam", $1r)[0]
EndFunc
Func _1e7()
For $ez = 0 To UBound($e7) - 1 Step +1
_1cm($e7[$ez][0])
Next
DllCallbackFree($ea)
_1au()
EndFunc
Func _1e8($k, $n4 = False)
Local $n5[4], $n6 = 1
$n5[0] = 0
$n5[1] = 0
$n5[2] = @DesktopWidth
$n5[3] = @DesktopHeight
Local $n7, $n8 = _ug()
If @error Then Return $n5
ReDim $n8[$n8[0][0] + 1][5]
For $1c = 1 To $n8[0][0]
$n7 = _vp($n8[$1c][1])
For $1j = 0 To 3
$n8[$1c][$1j + 1] = $n7[$1j]
Next
Next
Local $n9 = _wo($k)
Local $na = _wo(WinGetHandle("[CLASS:Shell_TrayWnd]"))
For $nb = 1 To $n8[0][0] Step +1
If $n8[$nb][0] = $n9 Then
If $n4 Then
$n5[0] = $n8[$nb][1]
$n5[1] = $n8[$nb][2]
Else
$n5[0] = 0
$n5[1] = 0
EndIf
$n5[2] = $n8[$nb][3]
$n5[3] = $n8[$nb][4]
$n6 = $nb
EndIf
Next
Local $nc = DllCall("shell32.dll", "int", "SHAppBarMessage", "int", 0x00000004, "ptr*", 0)
If Not @error Then
$nc = $nc[0]
Else
$nc = 0
EndIf
If $na = $n9 Then
Local $nd = WinGetPos("[CLASS:Shell_TrayWnd]")
If @error Then Return $n5
If $n4 Then Return $n5
If($nd[0] = $n8[$n6][1] - 2) Or($nd[1] = $n8[$n6][2] - 2) Then
$nd[0] += 2
$nd[1] += 2
$nd[2] -= 4
$nd[3] -= 4
EndIf
If $nd[2] = $n5[2] Then
If $nc = 1 Then
If($nd[1] > 0) Then
$n5[3] -= 1
Else
$n5[1] += 1
$n5[3] -= 1
EndIf
Return $n5
EndIf
$n5[3] = $n5[3] - $nd[3]
If($nd[0] = $n8[$n6][1]) And($nd[1] = $n8[$n6][2]) Then $n5[1] = $nd[3]
Else
If $nc = 1 Then
If($nd[0] > 0) Then
$n5[2] -= 1
Else
$n5[0] += 1
$n5[2] -= 1
EndIf
Return $n5
EndIf
$n5[2] = $n5[2] - $nd[2]
If($nd[0] = $n8[$n6][1]) And($nd[1] = $n8[$n6][2]) Then $n5[0] = $nd[2]
EndIf
EndIf
Return $n5
EndFunc
Func _1e9($er)
For $ne = 0 To UBound($e7) - 1
If $e7[$ne][0] = $er Then
Return $ne
EndIf
Next
Return SetError(1, 0, "")
EndFunc
Func _iFullscreenToggleBtn($d4, $k)
If $ee Then _1cq($k)
EndFunc
Global Enum $nf, $ng, $nh
Global $ni[$nh]
Func _1ea($k, $nj = Default, $nk = Default, $nl = 0x000000)
If $nj = Default Then
$nj = 1
EndIf
If $nk = Default Then
$nk = 5
EndIf
If $k = -1 And $ni[$nf] = 0 Then
Local $nm = GUICtrlCreateLabel('', -99, -99, 1, 1)
$k = _9a(GUICtrlGetHandle($nm))
If @error Then
Return SetError(1, 0 * GUICtrlDelete($nm), 0)
EndIf
GUICtrlDelete($nm)
EndIf
If IsHWnd($ni[$nf]) Then
GUIDelete($ni[$nf])
GUISwitch($ni[$ng])
$ni[$nf] = 0
$ni[$ng] = 0
Else
$ni[$ng] = $k
Local $4y = 0, $4z = 0
Local $2t = GUIGetStyle($ni[$ng])
Local $nn = RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes', 'CurrentTheme')
Local $no = Number(StringInStr($nn, 'Basic.theme', 2) = 0 And StringInStr($nn, 'Ease of Access Themes', 2) > 0)
Local $np = WinGetClientSize($ni[$ng])
$ni[$nf] = GUICreate('', $np[0], $np[1], $4y + 3, $4z + 3, 0x80000000, 0x00000040, $ni[$ng])
GUISetBkColor($nl, $ni[$nf])
WinSetTrans($ni[$nf], '', Round($nk *(255 / 100)))
If not $nj Then
GUISetState(@SW_SHOW, $ni[$nf])
EndIf
GUISetState(@SW_DISABLE, $ni[$nf])
GUISwitch($ni[$ng])
EndIf
Return $ni[$nf]
EndFunc
_1co()
SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\splash.jpg", "443", "294", "-1", "-1", 1)
Sleep(2000)
SplashOff()
_1en()
_1ec()
Func _1ec()
_12e($b)
Global $nq = _1ck("AutoCharts 3.0.0", 540, 700, -1, -1, True)
GUISetIcon(@ScriptDir & "\assets\GUI_Menus\programicon_hxv_icon.ico")
$gz = _1cn(True, True, True, True, True)
$nr = $gz[0]
$ns = $gz[1]
$nt = $gz[2]
$nu = $gz[3]
$nv = $gz[4]
$nw = $gz[5]
$nx = $gz[6]
$ny = GUICtrlCreatePic(@ScriptDir & "\assets\GUI_Menus\main-img.bmp", 0, 35, 540, 158, BitOR(0x0100, 0x0200))
_1do(50, 240, 440, 1)
Local $nz = GUICtrlCreateLabel("Please Select a Fund Family", 50, 275, 440, 50)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 20, 400, 0, "Segoe UI")
$o0 = _1cw("Catalyst Funds", 50, 350, 140, 40)
$o1 = _1cw("Rational Funds", 200, 350, 140, 40)
$o2 = _1cw("Strategy Shares", 350, 350, 140, 40)
_1do(50, 570, 440, 1)
Local $o3 = _1cw("Settings", 50, 600, 100, 40, 0xE9E9E9, $ao, "Segoe UI", 10, 1, $ao)
Local $o4 = _1cw("About", 170, 600, 100, 40, 0xE9E9E9, $ao, "Segoe UI", 10, 1, $ao)
Local $o5 = GUICtrlCreateLabel("v3.0.0", 450, 620, 50, 50, 0x2)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 15, 400, 0, "Segoe UI")
GUICtrlSetResizing($o0, 768 + 8)
GUICtrlSetResizing($o1, 768 + 8)
GUICtrlSetResizing($o2, 768 + 8)
GUISetState(@SW_SHOW)
While 1
$kz = GUIGetMsg()
Switch $kz
Case -3, $nr
_1cm($nq)
Exit
Case $ns
GUISetState(@SW_MAXIMIZE, $nq)
Case $nu
GUISetState(@SW_MINIMIZE, $nq)
Case $nt
GUISetState(@SW_RESTORE, $nq)
Case $nv, $nw
ConsoleWrite("Fullscreen toggled" & @CRLF)
Case $nx
Local $o6[5] = ["Archive Factsheets", "Settings", "Sync Options", "Help", "Exit"]
Local $o7 = _1cs($nq, 150, $o6)
Switch $o7
Case "0"
_1ey()
Case "1"
_1ea($nq, 0, 50)
_1eg()
_1ea($nq)
Case "2"
_1ea($nq, 0, 50)
_1ei()
_1ea($nq)
Case "3"
_1ea($nq, 0, 50)
_1eh()
_1ea($nq)
Case "4"
_1cm($nq)
Exit
EndSwitch
Case $o0
_1ea($nq, 0, 50)
_1ed()
_1ea($nq)
Case $o1
_1ea($nq, 0, 50)
_1ee()
_1ea($nq)
Case $o2
_1ea($nq, 0, 50)
_1ef()
_1ea($nq)
Case $o3
_1ea($nq, 0, 50)
_1eg()
_1ea($nq)
Case $o4
ShellExecute("https://onevion.github.io/AutoCharts/")
EndSwitch
WEnd
EndFunc
Func _1ed()
Local $o8 = _1ck("Catalyst Funds GUI", 540, 620, -1, -1, False, $nq)
Local $o9 = _1cn(True, False, False, False)
Local $nr = $o9[0]
Local $oa = _1d1("ACX", 50, 70, 130, 30)
Local $ob = _1d1("ATR", 50, 120, 130, 30)
Local $oc = _1d1("BUY", 50, 170, 130, 30)
Local $od = _1d1("CAX", 50, 220, 130, 30)
Local $oe = _1d1("CFR", 50, 270, 130, 30)
Local $of = _1d1("CLP", 50, 320, 130, 30)
Local $og = _1d1("CLT", 50, 370, 130, 30)
Local $oh = _1dp(180, 85, 300, 1)
Local $oi = _1d1("CPE", 220, 70, 130, 30)
Local $oj = _1d1("CWX", 220, 120, 130, 30)
Local $ok = _1d1("DCX", 220, 170, 130, 30)
Local $ol = _1d1("EIX", 220, 220, 130, 30)
Local $om = _1d1("HII", 220, 270, 130, 30)
Local $on = _1d1("IIX", 220, 320, 130, 30)
Local $oo = _1d1("INS", 220, 370, 130, 30)
Local $op = _1dp(350, 85, 300, 1)
Local $oq = _1d1("IOX", 390, 70, 130, 30)
Local $or = _1d1("MBX", 390, 120, 130, 30)
Local $os = _1d1("MLX", 390, 170, 130, 30)
Local $ot = _1d1("SHI", 390, 220, 130, 30)
Local $ou = _1d1("TEZ", 390, 270, 130, 30)
Local $ov = _1d1("TRI", 390, 320, 130, 30)
Local $ow = _1d1("TRX", 390, 370, 130, 30)
Global $ox = GUICtrlCreateLabel("", 50, 420, 440, 20)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Local $oy = _1dd("Factsheet", 60, 450, 105, 30)
Local $oz = _1dd("Brochure", 210, 450, 105, 30)
Local $p0 = _1dd("Presentation", 350, 450, 115, 30)
_1di($oy, True)
Global $p1 = _1cw("Process Updates", 50, 550, 210, 40)
Global $p2 = _1cx("Update Expense Ratios", 280, 550, 210, 40, 0xE9E9E9, $ao, "Segoe UI", 10, 1, $ao)
Local $p3 = _1cr()
Global $p4 = _1dm(50, 500, 440, 26)
GUICtrlSetResizing($p1, 768 + 8)
GUICtrlSetResizing($oa, 768 + 8)
GUISetState(@SW_SHOW)
While 1
$kz = GUIGetMsg()
Switch $kz
Case -3, $p3, $nr
_1cm($o8)
Return 0
Case $oa
If _1d5($oa) Then
_1d7($oa)
$0[0] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($oa)
$0[0] = "ACX"
ConsoleWrite($0[0] & " Toggle checked!" & @CRLF)
EndIf
Case $ob
If _1d5($ob) Then
_1d7($ob)
$0[1] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($ob)
$0[1] = "ATR"
ConsoleWrite($0[1] & " Toggle checked!" & @CRLF)
EndIf
Case $oc
If _1d5($oc) Then
_1d7($oc)
$0[2] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($oc)
$0[2] = "BUY"
ConsoleWrite($0[2] & " Toggle checked!" & @CRLF)
EndIf
Case $od
If _1d5($od) Then
_1d7($od)
$0[3] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($od)
$0[3] = "CAX"
ConsoleWrite($0[3] & " Toggle checked!" & @CRLF)
EndIf
Case $oe
If _1d5($oe) Then
_1d7($oe)
$0[4] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($oe)
$0[4] = "CFR"
ConsoleWrite($0[4] & " Toggle checked!" & @CRLF)
EndIf
Case $of
If _1d5($of) Then
_1d7($of)
$0[5] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($of)
$0[5] = "CLP"
ConsoleWrite($0[5] & " Toggle checked!" & @CRLF)
EndIf
Case $og
If _1d5($og) Then
_1d7($og)
$0[6] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($og)
$0[6] = "CLT"
ConsoleWrite($0[6] & " Toggle checked!" & @CRLF)
EndIf
Case $oi
If _1d5($oi) Then
_1d7($oi)
$0[7] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($oi)
$0[7] = "CPE"
ConsoleWrite($0[7] & " Toggle checked!" & @CRLF)
EndIf
Case $oj
If _1d5($oj) Then
_1d7($oj)
$0[8] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($oj)
$0[8] = "CWX"
ConsoleWrite($0[8] & " Toggle checked!" & @CRLF)
EndIf
Case $ok
If _1d5($ok) Then
_1d7($ok)
$0[9] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($ok)
$0[9] = "DCX"
ConsoleWrite($0[9] & " Toggle checked!" & @CRLF)
EndIf
Case $ol
If _1d5($ol) Then
_1d7($ol)
$0[10] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($ol)
$0[10] = "EIX"
ConsoleWrite($0[10] & " Toggle checked!" & @CRLF)
EndIf
Case $om
If _1d5($om) Then
_1d7($om)
$0[11] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($om)
$0[11] = "HII"
ConsoleWrite($0[11] & " Toggle checked!" & @CRLF)
EndIf
Case $on
If _1d5($on) Then
_1d7($on)
$0[12] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($on)
$0[12] = "IIX"
ConsoleWrite($0[12] & " Toggle checked!" & @CRLF)
EndIf
Case $oo
If _1d5($oo) Then
_1d7($oo)
$0[13] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($oo)
$0[13] = "INS"
ConsoleWrite($0[13] & " Toggle checked!" & @CRLF)
EndIf
Case $oq
If _1d5($oq) Then
_1d7($oq)
$0[14] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($oq)
$0[14] = "IOX"
ConsoleWrite($0[14] & " Toggle checked!" & @CRLF)
EndIf
Case $or
If _1d5($or) Then
_1d7($or)
$0[15] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($or)
$0[15] = "MBX"
ConsoleWrite($0[15] & " Toggle checked!" & @CRLF)
EndIf
Case $os
If _1d5($os) Then
_1d7($os)
$0[16] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($os)
$0[16] = "MLX"
ConsoleWrite($0[16] & " Toggle checked!" & @CRLF)
EndIf
Case $ot
If _1d5($ot) Then
_1d7($ot)
$0[17] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($ot)
$0[17] = "SHI"
ConsoleWrite($0[17] & " Toggle checked!" & @CRLF)
EndIf
Case $ou
If _1d5($ou) Then
_1d7($ou)
$0[18] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($ou)
$0[18] = "TEZ"
ConsoleWrite($0[18] & " Toggle checked!" & @CRLF)
EndIf
Case $ov
If _1d5($ov) Then
_1d7($ov)
$0[19] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($ov)
$0[19] = "TRI"
ConsoleWrite($0[19] & " Toggle checked!" & @CRLF)
EndIf
Case $ow
If _1d5($ow) Then
_1d7($ow)
$0[20] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($ow)
$0[20] = "TRX"
ConsoleWrite($0[20] & " Toggle checked!" & @CRLF)
EndIf
Case $oy
If _1dg($oy) Then
_1dh($oy)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($oy)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $oz
If _1dg($oz) Then
_1dh($oz)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($oz)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $p0
If _1dg($p0) Then
_1dh($p0)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($p0)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $p1
_126()
If $a = True Then
$9 = "Catalyst"
$3 = $0
_1em()
_1er()
_1ew()
_119("############################### END OF RUN - CATALYST ###############################")
_1ea($o8, 0, 30)
_1dk(0, "Finished", "The process has finished.", 500, 11, $o8)
_1ea($o8)
_1cm($o8)
Return 0
Else
If @error = 50 Then
_1ea($o8, 0, 30)
_1dk(0, "Error", "Error Code: " & @error & " | Dropbox path not verified. Process has been aborted.", 500, 11, $o8)
_1ea($o8)
EndIf
EndIf
Case $p2
$9 = "Catalyst"
$3 = $0
GUICtrlSetData($p4, 10)
_1em()
_128()
_1ex()
_119("############################### END OF RUN - CATALYST ###############################")
GUICtrlSetData($p4, 0)
_1ea($o8, 0, 30)
_1dk(0, "Finished", "The process has finished.", 500, 11, $o8)
_1ea($o8)
If @error = 50 Then
_1ea($o8, 0, 30)
_1dk(0, "Error", "Error Code: " & @error & " | Dropbox path not verified. Process has been aborted.", 500, 11, $o8)
_1ea($o8)
EndIf
EndSwitch
WEnd
EndFunc
Func _1ee()
Local $p5 = _1ck("Rational Funds GUI", 540, 620, -1, -1, False, $nq)
Local $o9 = _1cn(True, False, False, False)
Local $nr = $o9[0]
Local $p6 = _1d1("HBA", 50, 70, 130, 30)
Local $74 = _1d1("HDC", 50, 120, 130, 30)
Local $lg = _1d1("HRS", 50, 170, 130, 30)
Local $p7 = _1d1("HSU", 50, 220, 130, 30)
Local $p8 = _1d1("PBX", 50, 270, 130, 30)
Local $p9 = _1d1("RDM", 50, 320, 130, 30)
Local $pa = _1d1("RFX", 50, 370, 130, 30)
Local $oh = _1dp(180, 85, 300, 1)
Global $ox = GUICtrlCreateLabel("", 50, 420, 440, 20)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Local $oy = _1dd("Factsheet", 60, 450, 105, 30)
Local $oz = _1dd("Brochure", 210, 450, 105, 30)
Local $p0 = _1dd("Presentation", 350, 450, 115, 30)
_1di($oy, True)
Local $pb = _1cw("Process Updates", 50, 550, 210, 40)
Local $pc = _1cw("Update Expense Ratios", 280, 550, 210, 40, 0xE9E9E9, $ao, "Segoe UI", 10, 1, $ao)
Local $p3 = _1cr()
Global $p4 = _1dm(50, 500, 440, 26)
GUICtrlSetResizing($pb, 768 + 8)
GUICtrlSetResizing($p6, 768 + 8)
GUISetState(@SW_SHOW)
While 1
$kz = GUIGetMsg()
Switch $kz
Case -3, $p3, $nr
_1cm($p5)
Return 0
Case $p6
If _1d5($p6) Then
_1d7($p6)
$1[0] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($p6)
$1[0] = "HBA"
ConsoleWrite($1[0] & " Toggle checked!" & @CRLF)
EndIf
Case $74
If _1d5($74) Then
_1d7($74)
$1[1] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($74)
$1[1] = "HDC"
ConsoleWrite($1[1] & " Toggle checked!" & @CRLF)
EndIf
Case $lg
If _1d5($lg) Then
_1d7($lg)
$1[2] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($lg)
$1[2] = "HRS"
ConsoleWrite($1[2] & " Toggle checked!" & @CRLF)
EndIf
Case $p7
If _1d5($p7) Then
_1d7($p7)
$1[3] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($p7)
$1[3] = "HSU"
ConsoleWrite($1[3] & " Toggle checked!" & @CRLF)
EndIf
Case $p8
If _1d5($p8) Then
_1d7($p8)
$1[4] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($p8)
$1[4] = "PBX"
ConsoleWrite($1[4] & " Toggle checked!" & @CRLF)
EndIf
Case $p9
If _1d5($p9) Then
_1d7($p9)
$1[5] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($p9)
$1[5] = "RDM"
ConsoleWrite($1[5] & " Toggle checked!" & @CRLF)
EndIf
Case $pa
If _1d5($pa) Then
_1d7($pa)
$1[6] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($pa)
$1[6] = "RFX"
ConsoleWrite($1[6] & " Toggle checked!" & @CRLF)
EndIf
Case $oy
If _1dg($oy) Then
_1dh($oy)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($oy)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $oz
If _1dg($oz) Then
_1dh($oz)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($oz)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $p0
If _1dg($p0) Then
_1dh($p0)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($p0)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $pb
$9 = "Rational"
$3 = $1
GUICtrlSetData($p4, 10)
_1em()
_1er()
_1ew()
_119("############################### END OF RUN - RATIONAL ###############################")
GUICtrlSetData($p4, 0)
_1ea($p5, 0, 30)
_1dk(0, "Finished", "The process has finished.", 500, 11, $p5)
_1ea($p5)
_1cm($p5)
Return 0
Case $pc
$9 = "Rational"
$3 = $1
GUICtrlSetData($p4, 10)
_1em()
_12a()
_1ex()
_119("############################### END OF RUN - RATIONAL ###############################")
GUICtrlSetData($p4, 0)
_1ea($p5, 0, 30)
_1dk(0, "Finished", "The process has finished.", 500, 11, $p5)
_1ea($p5)
If @error = 50 Then
_1ea($p5, 0, 30)
_1dk(0, "Error", "Error Code: " & @error & " | Dropbox path not verified. Process has been aborted.", 500, 11, $p5)
_1ea($p5)
EndIf
EndSwitch
WEnd
EndFunc
Func _1ef()
Local $pd = _1ck("Strategy Shares Funds GUI", 540, 620, -1, -1, False, $nq)
Local $o9 = _1cn(True, False, False, False)
Local $nr = $o9[0]
Local $pe = _1d1("GLDB", 50, 70, 130, 30)
Local $pf = _1d1("HNDL", 50, 120, 130, 30)
Local $pg = _1d1("ROMO", 50, 170, 130, 30)
Local $oh = _1dp(180, 85, 300, 1)
Global $ox = GUICtrlCreateLabel("", 50, 420, 440, 20)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Local $oy = _1dd("Factsheet", 60, 450, 105, 30)
Local $oz = _1dd("Brochure", 210, 450, 105, 30)
Local $p0 = _1dd("Presentation", 350, 450, 115, 30)
_1di($oy, True)
Local $ph = _1cw("Process Updates", 50, 550, 210, 40)
Local $p3 = _1cr()
Global $p4 = _1dm(50, 500, 440, 26)
GUICtrlSetResizing($ph, 768 + 8)
GUICtrlSetResizing($pe, 768 + 8)
GUISetState(@SW_SHOW)
While 1
$kz = GUIGetMsg()
Switch $kz
Case -3, $p3, $nr
_1cm($pd)
Return 0
Case $pe
If _1d5($pe) Then
_1d7($pe)
$2[0] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($pe)
$2[0] = "GLDB"
ConsoleWrite($2[0] & " Toggle checked!" & @CRLF)
EndIf
Case $pf
If _1d5($pf) Then
_1d7($pf)
$2[1] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($pf)
$2[1] = "HNDL"
ConsoleWrite($2[1] & " Toggle checked!" & @CRLF)
EndIf
Case $pg
If _1d5($pg) Then
_1d7($pg)
$2[2] = 0
ConsoleWrite("Toggle unchecked!" & @CRLF)
Else
_1d8($pg)
$2[2] = "ROMO"
ConsoleWrite($2[2] & " Toggle checked!" & @CRLF)
EndIf
Case $oy
If _1dg($oy) Then
_1dh($oy)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($oy)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $oz
If _1dg($oz) Then
_1dh($oz)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($oz)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $p0
If _1dg($p0) Then
_1dh($p0)
ConsoleWrite("Checkbox unchecked!" & @CRLF)
Else
_1di($p0)
ConsoleWrite("Checkbox checked!" & @CRLF)
EndIf
Case $ph
$9 = "StrategyShares"
$3 = $2
GUICtrlSetData($p4, 10)
_1em()
_1er()
_1ew()
_119("############################### END OF RUN - STRATEGY SHARES ###############################")
GUICtrlSetData($p4, 0)
_1ea($pd, 0, 30)
_1dk(0, "Finished", "The process has finished.", 500, 11, $pd)
_1ea($pd)
_1cm($pd)
Return 0
EndSwitch
WEnd
EndFunc
Func _1eg()
$e = IniRead($5, 'Settings', 'DropboxDir', '')
$6 = IniRead($5, 'Settings', 'UserName', '')
$7 = IniRead($5, 'Settings', 'CurrentQuarter', '')
$8 = IniRead($5, 'Settings', 'CurrentYear', '')
Global $pi = _1ck("AutoCharts Settings", 540, 620, -1, -1, False, $nq)
Local $o9 = _1cn(True, False, False, False)
Local $nr = $o9[0]
Local $pj = GUICtrlCreateLabel("Path to Dropbox Folder:", 50, 50, 440, 20)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Global $c = GUICtrlCreateInput($e, 50, 75, 440, 30)
GUICtrlSetFont(-1, 11, 500, 0, "Segoe UI")
Local $pk = _1cw("Browse", 280, 110, 210, 40)
Local $pl = GUICtrlCreateLabel("Your Name:", 50, 175, 440, 40)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Local $pm = GUICtrlCreateInput($6, 50, 200, 440, 30)
GUICtrlSetFont(-1, 11, 500, 0, "Segoe UI")
Local $pn = GUICtrlCreateLabel("Current Quarter:", 50, 275, 440, 40)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Local $po = _1da("1", "Q1", 50, 300, 100, 30)
If $7 = "Q1" Then
_1db("1", $po)
EndIf
Local $pp = _1da("1", "Q2", 160, 300, 100, 30)
If $7 = "Q2" Then
_1db("1", $pp)
EndIf
Local $pq = _1da("1", "Q3", 270, 300, 100, 30)
If $7 = "Q3" Then
_1db("1", $pq)
EndIf
Local $pr = _1da("1", "Q4", 380, 300, 100, 30)
If $7 = "Q4" Then
_1db("1", $pr)
EndIf
Local $ps = GUICtrlCreateLabel("Current Year:", 50, 375, 440, 40)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 11, 400, 0, "Segoe UI")
Local $pt = GUICtrlCreateInput($8, 50, 400, 440, 30)
GUICtrlSetFont(-1, 11, 500, 0, "Segoe UI")
Local $pu = _1da("2", "Blue", 50, 480, 100, 30)
If $b = "DarkBlue" Then
_1db("2", $pu)
EndIf
Local $pv = _1da("2", "Blue 2", 160, 480, 100, 30)
If $b = "LightBlue" Then
_1db("2", $pv)
EndIf
Local $pw = _1da("2", "Purple", 270, 480, 100, 30)
If $b = "DarkPurple" Then
_1db("2", $pw)
EndIf
Local $px = _1da("2", "Purple 2", 380, 480, 100, 30)
If $b = "LightPurple" Then
_1db("2", $px)
EndIf
Local $py = _1cw("Save Settings", 50, 550, 210, 40)
Local $pz = _1cw("Cancel", 280, 550, 210, 40, 0xE9E9E9, $ao, "Segoe UI", 10, 1, $ao)
Local $p3 = _1cr()
GUISetState(@SW_SHOW)
While 1
$kz = GUIGetMsg()
Switch $kz
Case -3, $p3, $nr, $pz
_1cm($pi)
Return 0
Case $pk
_1ej()
Case $po
_1db(1, $po)
ConsoleWrite("Radio 1 selected!" & @CRLF)
Case $pp
_1db(1, $pp)
ConsoleWrite("Radio 4 selected!" & @CRLF)
Case $pq
_1db(1, $pq)
ConsoleWrite("Radio 3 selected!" & @CRLF)
Case $pr
_1db(1, $pr)
ConsoleWrite("Radio 4 selected!" & @CRLF)
Case $pu
_1db(2, $pu)
ConsoleWrite("Dark Blue Theme selected!" & @CRLF)
Case $pv
_1db(2, $pv)
ConsoleWrite("Light Blue Theme selected!" & @CRLF)
Case $pw
_1db(2, $pw)
ConsoleWrite("Dark Purple Theme selected!" & @CRLF)
Case $px
_1db(2, $px)
ConsoleWrite("Light Purple Theme selected!" & @CRLF)
Case $py
$q0 = GUICtrlRead($c)
If $q0 = "" Then
_1ea($pi, 0, 30)
_1dk(0, "Error!", "You must select a dropbox directory!", 500, 11, $pi)
_1ea($pi)
Else
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'DropboxDir', $q0)
$q0 = GUICtrlRead($pm)
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UserName', $q0)
If _1dc(1, $po) Then
$7 = "Q1"
$q0 = "Q1"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $q0)
EndIf
If _1dc(1, $pp) Then
$7 = "Q2"
$q0 = "Q2"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $q0)
EndIf
If _1dc(1, $pq) Then
$7 = "Q3"
$q0 = "Q3"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $q0)
EndIf
If _1dc(1, $pr) Then
$7 = "Q4"
$q0 = "Q4"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentQuarter', $q0)
EndIf
If _1dc(2, $pu) Then
$b = "DarkBlue"
_12e("DarkBlue")
$q0 = "DarkBlue"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $q0)
EndIf
If _1dc(2, $pv) Then
$b = "LightBlue"
_12e("LightBlue")
$q0 = "LightBlue"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $q0)
EndIf
If _1dc(2, $pw) Then
$b = "DarkPurple"
_12e("DarkPurple")
$q0 = "DarkPurple"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $q0)
EndIf
If _1dc(2, $px) Then
$b = "LightPurple"
_12e("LightPurple")
$q0 = "LightPurple"
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'UITheme', $q0)
EndIf
$q0 = GUICtrlRead($pt)
$q1 = IniWrite(@ScriptDir & '\settings.ini', 'Settings', 'CurrentYear', $q0)
If $q1 = 1 Then
$e = IniRead($5, 'Settings', 'DropboxDir', '')
$6 = IniRead($5, 'Settings', 'UserName', '')
$7 = IniRead($5, 'Settings', 'CurrentQuarter', '')
$8 = IniRead($5, 'Settings', 'CurrentYear', '')
$a = IniRead($5, 'Settings', 'DBVerified', '')
$b = IniRead($5, 'Settings', 'UITheme', '')
_1ep()
_1ea($pi, 0, 30)
_1dk(0, "Success!", "Your settings were saved.", 500, 11, $pi)
_1ea($pi)
Else
_1ea($pi, 0, 30)
_1dk(0, "Error!", "An error occured", 500, 11, $pi)
_1ea($pi)
EndIf
_126()
If @error = 50 Then
_1ea($pi, 0, 30)
_1dk(0, "Error!", "Error Code: " & @error & " | Dropbox path not verified. Please try resetting it.", 500, 11, $pi)
_1ea($pi)
EndIf
_1cm($pi)
_1cm($nq)
_1ec()
EndIf
EndSwitch
WEnd
EndFunc
Func _1eh()
Global $q2 = _1ck("AutoCharts Help", 540, 500, -1, -1, False, $nq)
Local $o9 = _1cn(True, False, False, False)
Local $nr = $o9[0]
Local $o4 = _1cw("About AutoCharts", 50, 100, 440, 40)
Local $q3 = _1cw("Open Log File", 50, 160, 440, 40)
Local $q4 = _1cw("Clear Log File", 50, 220, 440, 40)
Local $q5 = _1cw("Check for Update", 50, 280, 440, 40)
Local $p3 = _1cr()
GUISetState(@SW_SHOW)
While 1
$kz = GUIGetMsg()
Switch $kz
Case -3, $p3, $nr
_1cm($q2)
Return 0
Case $o4
ShellExecute("https://onevion.github.io/AutoCharts/")
Case $q3
$q6 = @ScriptDir & "\AutoCharts.log"
$q7 = "notepad.exe " & $q6
ConsoleWrite("$_Run : " & $q7 & @CRLF)
Run($q7, @WindowsDir, @SW_SHOWDEFAULT)
Case $q4
_1eq()
Case $q5
_1eo()
EndSwitch
WEnd
EndFunc
Func _1ei()
Global $q8 = _1ck("AutoCharts Sync Options", 540, 500, -1, -1, False, $nq)
Local $o9 = _1cn(True, False, False, False)
Local $nr = $o9[0]
Local $q9 = _1cw("Pull Data from Dropbox", 50, 100, 440, 40)
Local $qa = _1cw("Import Datalinker from Database", 50, 160, 440, 40)
_1do(50, 240, 440, 1)
Local $qb = GUICtrlCreateLabel("Admin Settings", 200, 230, 150, 40, 0x1)
GUICtrlSetColor(-1, $am)
GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI")
Local $qc = _1cw("Upload amCharts to Database", 50, 280, 440, 40, 0xE9E9E9, $ao, "Segoe UI", 10, 1, $ao)
Local $qd = _1cw("Upload DataLinker to Database", 50, 340, 440, 40, 0xE9E9E9, $ao, "Segoe UI", 10, 1, $ao)
Local $p3 = _1cr()
GUISetState(@SW_SHOW)
While 1
$kz = GUIGetMsg()
Switch $kz
Case -3, $p3, $nr
_1cm($q8)
Return 0
Case $q9
ConsoleWrite($f & @CRLF)
_127()
_1ea($q8, 0, 50)
_1dk(0, "Alert", "Sync Completed. Done in " & TimerDiff($ak) / 1000 & " seconds!")
_1ea($q8)
Case $qa
_1em()
If @error Then
_1ea($q8, 0, 50)
_1dk(4096, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
_1ea($q8)
Else
_1ea($q8, 0, 50)
_1dk(4096, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
_1ea($q8)
EndIf
Case $qc
_12d()
Case $qd
_1el()
EndSwitch
WEnd
EndFunc
Func _1ej()
Local Const $qe = "Select a folder"
Local $qf = FileSelectFolder($qe, "")
If @error Then
_1ea($pi, 0, 50)
_1dk(4096, "Error", "No folder was selected.")
_1ea($pi)
GUICtrlSetData($c, "")
Else
GUICtrlSetData($c, $qf)
EndIf
EndFunc
Func _1el()
If $6 = "Jakob" Then
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $f, 1)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "There was an error uploading your Datalinker file to the database.", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to Upload Datalinker File to " & $f)
Else
_1ea($q8, 0, 30)
_1dk(0, "Success!", "Datalinker File has been uploaded to the database.", 500, 11, $q8)
_1ea($q8)
_119("Datalinker File Uploaded to " & $f)
EndIf
Else
FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $f & "\" & $6 & "_Datalinker.xml", 1)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "There was an error uploading your Datalinker file to the database.", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to Upload Datalinker File to " & $f)
Else
_1ea($q8, 0, 30)
_1dk(0, "Success!", "Datalinker File has been uploaded to the database.", 500, 11, $q8)
_1ea($q8)
_119("Datalinker File Uploaded to " & $f)
EndIf
EndIf
EndFunc
Func _1em()
FileCopy($f & "\DataLinker.xml", @ScriptDir & "\Datalinker_TEMP1.xml", 1)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "Unable to copy datalinker.xml file to script directory", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to copy datalinker.xml file to script directory")
Else
_119("Datalinker File Imported to AutoCharts Directory")
EndIf
Local $qg = @ScriptDir & "\Datalinker_TEMP1.xml"
Local $gj = FileRead($qg)
If $6 <> "Jakob" Then
$qh = StringReplace($gj, 'X:\Marketing Team Files\', $e & '\Marketing Team Files\')
FileWrite(@ScriptDir & "\DataLinker_Updated1.xml", $qh)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
_119("Datalinker File Imported to InDesign successfully")
EndIf
Else
FileCopy(@ScriptDir & "\Datalinker_TEMP1.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
_119("Datalinker File Imported to InDesign successfully")
EndIf
EndIf
FileCopy(@ScriptDir & "\Datalinker_Updated1.xml", @ScriptDir & "\Datalinker_TEMP2.xml", 1)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "There was an error importing your Datalinker file to InDesign", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to Import Datalinker File to InDesign")
Else
_119("Datalinker File Imported to AutoCharts Directory")
EndIf
Local $qi = @ScriptDir & "\Datalinker_TEMP2.xml"
Local $qj = FileRead($qi)
If $6 <> "Jakob" Then
$qk = StringReplace($qj, 'file:///X:', 'file:///' & $e)
FileWrite(@ScriptDir & "\DataLinker_Updated2.xml", $qk)
FileCopy(@ScriptDir & "\Datalinker_Updated2.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
FileDelete(@ScriptDir & "\Datalinker_Updated2.xml")
FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
_119("Datalinker File Imported to InDesign successfully")
EndIf
Else
FileCopy(@ScriptDir & "\Datalinker_TEMP.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
If @error Then
_1ea($q8, 0, 30)
_1dk(0, "Error!", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file", 500, 11, $q8)
_1ea($q8)
_11b("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")
Else
FileDelete(@ScriptDir & "\Datalinker_Updated.xml")
FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
_119("Datalinker File Imported to InDesign successfully")
EndIf
EndIf
EndFunc
Func _1en()
If FileExists(@ScriptDir & "/settings-MIGRATE.ini") Then
FileDelete(@ScriptDir & "/settings-MIGRATE.ini")
_119("Updated install detected.")
_1dk(0, "Thanks for upgrading!", "Thanks for upgrading AutoCharts!" & @CRLF & @CRLF & "Before you begin, please double check your settings have imported correctly.")
EndIf
EndFunc
Func _1eo()
Run(@ScriptDir & "/AutoCharts_Updater.exe")
EndFunc
_1en()
Func _1ep()
$7 = IniRead($5, 'Settings', 'CurrentQuarter', '')
$8 = IniRead($5, 'Settings', 'CurrentYear', '')
Local $ql
Local $qm
Local $qn
If $7 = 'Q1' Then
$ql = "March"
$qn = "03"
$qm = "31"
ElseIf $7 = 'Q2' Then
$ql = "June"
$qn = "06"
$qm = "30"
ElseIf $7 = 'Q3' Then
$ql = "September"
$qn = "09"
$qm = "30"
ElseIf $7 = 'Q4' Then
$ql = "December"
$qn = "12"
$qm = "31"
Else
_1dk(0, "Error!", "A quarter has not been selected in the settings tab.")
EndIf
_119("Determined quarter to be ~" & $7 & "~ and current year to be ~" & $8 & "~")
If FileExists($f & "\csv\Update_FactSheetDates.csv") Then
FileDelete($f & "\csv\Update_FactSheetDates.csv")
EndIf
Local $qg = $f & "\csv\Update_FactSheetDatesTEMP.csv"
Local $gj = FileReadLine($qg, 1)
$qh = StringReplace($gj, 'Label,ID', 'Label,ID' & @CRLF)
FileWrite($f & "\csv\Update_FactSheetDates.csv", $qh)
$gj = FileReadLine($qg, 2)
$qh = StringReplace($gj, '03/31/2021,1', $qn & '/' & $qm & '/' & $8 & ',1' & @CRLF)
FileWrite($f & "\csv\Update_FactSheetDates.csv", $qh)
$gj = FileReadLine($qg, 3)
$qh = StringReplace($gj, '"March 31, 2021",2', '"' & $ql & ' ' & $qm & ', ' & $8 & '",2' & @CRLF)
FileWrite($f & "\csv\Update_FactSheetDates.csv", $qh)
$gj = FileReadLine($qg, 4)
$qh = StringReplace($gj, 'Q1 2021,3', $7 & ' ' & $8 & ',3' & @CRLF)
FileWrite($f & "\csv\Update_FactSheetDates.csv", $qh)
$gj = FileReadLine($qg, 5)
$qh = StringReplace($gj, 'March 2021,4', $ql & ' ' & $8 & ',4' & @CRLF)
FileWrite($f & "\csv\Update_FactSheetDates.csv", $qh)
$gj = FileReadLine($qg, 6)
$qh = StringReplace($gj, '03/2021,5', $qn & '/' & $8 & ',5')
FileWrite($f & "\csv\Update_FactSheetDates.csv", $qh)
FileClose($f & "\csv\Update_FactSheetDates.csv")
_119("Updated FactSheetDates CSV File with selected dates")
EndFunc
Func _1eq()
FileDelete(@ScriptDir & "\AutoCharts.log")
_1j(@ScriptDir & "\AutoCharts.log")
If @error = 0 Then
_1ea($q2, 0, 50)
_1dk(4096, "Success", "Log file cleared.")
_1ea($q2)
EndIf
If @error = 1 Then
_1ea($q2, 0, 50)
_1dk(0, "Error", "There was an error with clearing the log.")
_1ea($q2)
EndIf
EndFunc
Func _1er()
For $qo = 0 To(UBound($3) - 1)
If $3[$qo] <> "" Then
$4 = $3[$qo]
GUICtrlSetData($ox, "Updating the following Fund Factsheet: " & $4)
_1dn($p4, 15)
_119("~~~~~~~~~~~~ " & $4 & " CSV CONVERSION START ~~~~~~~~~~~~")
If $9 = "Catalyst" Then
_129()
EndIf
If $9 = "Rational" Then
_12b()
EndIf
If $9 = "StrategyShares" Then
_12c()
EndIf
If Not FileCopy($f & "\fin_backup_files\" & $9 & "\" & $4 & "\" & $4 & "*.xlsx", @ScriptDir & "/VBS_Scripts/") Then
_1ea($nq, 0, 50)
_1dk(0, "Error", "Could not copy backup file from " & $f & "\fin_backup_files\" & $9 & "\" & $4 & "\" & $4 & "*.xlsx")
_1ea($nq)
_11b("Could not copy backup file from " & $f & "\fin_backup_files\" & $9 & "\" & $4 & "\" & $4 & "*.xlsx")
EndIf
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $4 & ".xlsx", @TempDir, @SW_HIDE)
GUICtrlSetData($ox, $4 & " | ~~~~~~~~~~~~ " & $4 & " CSV CONVERSION START ~~~~~~~~~~~~")
_119("Converted " & $4 & ".xlsx file to csv")
GUICtrlSetData($ox, $4 & " | Converted " & $4 & ".xlsx file to csv")
If FileExists($f & "\fin_backup_files\" & $9 & "\" & $4 & "\" & $4 & "-institutional.xlsx") Then
_1es()
EndIf
If FileExists($f & "\fin_backup_files\" & $9 & "\" & $4 & "\" & $4 & "-brochure.xlsx") Then
_1et()
EndIf
If FileExists($f & "\fin_backup_files\" & $9 & "\" & $4 & "\" & $4 & "-presentation.xlsx") Then
_1eu()
EndIf
_1dn($p4, 25)
FileCopy(@ScriptDir & "/VBS_Scripts/*.csv", @ScriptDir & $d & "\" & $9 & "\" & $4 & "\" & "*.csv", 1)
FileMove(@ScriptDir & "/VBS_Scripts/*.csv", $f & "\csv\" & $9 & "\" & $4 & "\*.csv", 1)
_119("Moved the " & $4 & ".csv files to the fund's InDesign Links folder in Dropbox")
GUICtrlSetData($ox, $4 & " | Moved the " & $4 & ".csv files to the fund's InDesign Links folder in Dropbox")
_1dn($p4, 30)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
_119("Deleted remaining " & $4 & ".xlsx files from CSV Conversion directory")
GUICtrlSetData($ox, $4 & " | Deleted remaining " & $4 & ".xlsx files from CSV Conversion directory")
_1dn($p4, 55)
Else
ContinueLoop
EndIf
Next
EndFunc
Func _1es()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $4 & "-institutional.xlsx", @TempDir, @SW_HIDE)
_119("Converted " & $4 & "-institutional.xlsx file to csv")
GUICtrlSetData($ox, $4 & " | Converted " & $4 & "-institutional.xlsx file to csv")
EndFunc
Func _1et()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $4 & "-brochure.xlsx", @TempDir, @SW_HIDE)
_119("Converted " & $4 & "-brochure.xlsx file to csv")
GUICtrlSetData($ox, $4 & " | Converted " & $4 & "-brochure.xlsx file to csv")
EndFunc
Func _1eu()
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs " & $4 & "-presentation.xlsx", @TempDir, @SW_HIDE)
_119("Converted " & $4 & "-presentation.xlsx file to csv")
GUICtrlSetData($ox, $4 & " | Converted " & $4 & "-presentation.xlsx file to csv")
EndFunc
Func _1ev()
Local $qg = @ScriptDir & "\assets\ChartBuilder\public\index_TEMPLATE.html"
Local $gj = FileRead($qg)
$qh = StringReplace($gj, '<script src="/scripts/CHANGEME.js"></script>', '<script src="/scripts/' & $4 & '.js"></script>')
FileWrite(@ScriptDir & "\assets\ChartBuilder\public\index.html", $qh)
_119("~~~~~~~~~~~~ " & $4 & " CHART GENERATION START ~~~~~~~~~~~~")
GUICtrlSetData($ox, $4 & " | ~~~~~~~~~~~~ " & $4 & " CHART GENERATION START ~~~~~~~~~~~~")
_119("Created HTML file for " & $4 & " chart generation")
GUICtrlSetData($ox, $4 & " | Created HTML file for " & $4 & " chart generation")
_119("Initializing Local Server for amCharts")
GUICtrlSetData($ox, $4 & " | Initializing Local Server for amCharts")
EndFunc
Func _1ew()
For $qo = 0 To(UBound($3) - 1)
If $3[$qo] <> "" Then
$4 = $3[$qo]
Call("_1ev")
RunWait(@ComSpec & " /c node --unhandled-rejections=strict server.js", @ScriptDir & "/assets/ChartBuilder/", @SW_HIDE)
_1dn($p4, 70)
_119($4 & " charts generated in SVG format using amCharts")
GUICtrlSetData($ox, $4 & " | Charts generated in SVG format using amCharts")
FileDelete(@ScriptDir & "\assets\ChartBuilder\public\index.html")
FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $f & "\images\charts\" & $9 & "\" & $4 & "\*.svg", 1)
_1dn($p4, 92)
_119($4 & " charts moved to the funds InDesign Links folder")
GUICtrlSetData($ox, $4 & " | Charts moved to the funds InDesign Links folder")
Else
ContinueLoop
EndIf
_1dn($p4, 100)
Next
EndFunc
Func _1ex()
If $9 = "Catalyst" Then
GUICtrlSetData($ox, "Updating Catalyst Expense Ratios")
_1dn($p4, 60)
FileCopy($f & "\fin_backup_files\" & $9 & "\Catalyst_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Catalyst_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
_119("~~~~~~~~~~~~ Updating Catalyst Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($ox, "Updating Catalyst Expense Ratios")
_119("Updated Catalyst Expense Ratios")
GUICtrlSetData($ox, "Updated Catalyst Expense Ratios")
FileMove(@ScriptDir & "/VBS_Scripts/Catalyst_ExpenseRatios.csv", $f & "\csv\" & $9 & "\Catalyst_ExpenseRatios.csv", 1)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
EndIf
If $9 = "Rational" Then
GUICtrlSetData($ox, "Updating Rational Expense Ratios")
_1dn($p4, 60)
FileCopy($f & "\fin_backup_files\" & $9 & "\Rational_ExpenseRatios.xlsx", @ScriptDir & "/VBS_Scripts/")
RunWait(@ComSpec & " /c " & @ScriptDir & "/VBS_Scripts/Excel_To_CSV_All_Worksheets.vbs Rational_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)
_119("~~~~~~~~~~~~ Updating Rational Expense Ratios ~~~~~~~~~~~~")
GUICtrlSetData($ox, "Updating Rational Expense Ratios")
_119("Updated Rational Expense Ratios")
GUICtrlSetData($ox, "Updated Rational Expense Ratios")
FileMove(@ScriptDir & "/VBS_Scripts/Rational_ExpenseRatios.csv", $f & "\csv\" & $9 & "\Rational_ExpenseRatios.csv", 1)
FileDelete(@ScriptDir & "/VBS_Scripts/*.xlsx")
EndIf
_1dn($p4, 100)
EndFunc
Func _1ey()
Local $qp, $qq
Local Const $qe = "Select Save Location"
Local $qf = FileSelectFolder($qe, "")
If @error Then
_1ea($nq, 0, 50)
_1dk(0, "Error", "No folder was selected.")
_1ea($nq)
Else
$qp = _g5($qf & "\FactSheets_" & $7 & "-" & $8 & ".zip")
_g7($qp, $f & "\fin_backup_files\", 4)
_g7($qp, $e & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\FactSheets\", 4)
_1ea($nq, 0, 50)
_1dk(0, "Items in Zip", "Succesfully added " & _gc($qp) & " items in " & $qp)
_1ea($nq)
_119("Created Factsheet Archive at " & $qp)
EndIf
EndFunc
