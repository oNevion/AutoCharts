;===============================================================================
;
; Name:    			FTP Database Functions
; Description:      FTP Database Sync for AutoCharts
; Author(s):        oNevion
; Version:          v0.1
;
;===============================================================================

#include <FTPEx.au3>

_AutoCharts_FTP()

Func _AutoCharts_FTP()
    Local $sServer = 'onevio.synology.me' ; AutoCharts FTP
    Local $sUsername = 'AutoCharts_FTP'
    Local $sPass = '579!EaK%yJX6'
        Local $Err, $sFTP_Message

    Local $hOpen = _FTP_Open('MyFTP Control')
    Local $hConn = _FTP_Connect($hOpen, $sServer, $sUsername, $sPass)
    If @error Then
        MsgBox($MB_SYSTEMMODAL, '_FTP_Connect', 'ERROR=' & @error)
    Else
        _FTP_GetLastResponseInfo($Err, $sFTP_Message)
        ConsoleWrite('$Err=' & $Err & '   $sFTP_Message:' & @CRLF & $sFTP_Message & @CRLF)
        ; do something ...
    EndIf
    Local $iFtpc = _FTP_Close($hConn)
    Local $iFtpo = _FTP_Close($hOpen)
EndFunc   ;==>_AutoCharts_FTP

