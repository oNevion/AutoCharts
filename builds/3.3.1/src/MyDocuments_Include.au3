;===============================================================================
;
; Name:    			MyDocuments Includes for Program
; Description:      Moves some important filesa to the user's Documents folder
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

;===============================================================================
;
; Function Name:    CreateAutoChartsDocFolder()
; Description:      Verifies and creates folder for current user's documents folder
; Parameter(s):     None
;
;===============================================================================

Func CreateAutoChartsDocFolder()

	If FileExists(@MyDocumentsDir & "\AutoCharts\vbs\Excel_to_CSV_All_Worksheets.vbs") Then
			_LogaInfo("Checking for " & @MyDocumentsDir & "\AutoCharts\vbs\Excel_to_CSV_All_Worksheets.vbs") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, $CurrentFund & " | Checking for " & @MyDocumentsDir & "\AutoCharts\vbs\Excel_to_CSV_All_Worksheets.vbs")
			_LogaInfo("File Exists. Moving on") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, $CurrentFund & " | VBS script has already moved to " & $INPT_Name & "'s documents folder. Moving on")
    Else
		DirCopy(@ScriptDir & "\VBS_Scripts", @MyDocumentsDir & "\AutoCharts\vbs", 0)
		_LogaInfo("File did not exist. Creating directory " & @MyDocumentsDir & "\AutoCharts\vbs\") ; Write to the logfile
		GUICtrlSetData($UpdateLabel, $CurrentFund & " | File did not exist. Creating directory " & @MyDocumentsDir & "\AutoCharts\vbs\")
    EndIf

EndFunc   ;==>CreateAutoChartsDocFolder


