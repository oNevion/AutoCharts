;===============================================================================
;
; Name:    			InDesign Functions
; Description:      Automation of opening InDesign files, syncing datalinker and saving as PDF
; Author(s):        oNevion
; Version:          v0.1
;
;===============================================================================

#include-once
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>

Local $source
Local $destination
Global $timer

;===============================================================================
;
; Function Name:    OpenInDesignFile()
; Description:     	Opens the current fund's InDesign file located in the AutoCharts drive.
; Parameter(s):     None
;
;===============================================================================

Func OpenInDesignFile()
	$sInDesignFile = $DropboxDir & "\FactSheets\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "_FactSheet.indd"
	$_Run = "C:\Program Files\Adobe InDesign 2021\InDesign.exe " & $sInDesignFile
	ConsoleWrite("$_Run : " & $_Run & @CRLF)
	Run($_Run, @WindowsDir, @SW_SHOWDEFAULT)
EndFunc   ;==>OpenInDesignFile

;===============================================================================
;
; Function Name:    ClickInDesignDialog()
; Description:     	After opening InDesign file, clicks to update modified links
; Parameter(s):     None
;
;===============================================================================

Func ClickInDesignDialog()
	ControlClick ( "Issues with Links", "OS_ViewContainer")
EndFunc   ;==>ClickInDesignDialog

