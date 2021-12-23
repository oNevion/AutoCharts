;===============================================================================
;
; Name:    			DataLinker Integration
; Description:      Custom Integration of DataLinker plugin for InDesign
; Author(s):        oNevion
; Version:          v0.6
;
;===============================================================================

#include-once
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>

;===============================================================================
;
; Function Name:    ExportDatalinker()
; Description:      Copies and exports DataLinker XML file from AutoCharts Drive Database to user defined directory
; Parameter(s):     None
;
;===============================================================================
Func ExportDatalinker()
	$LogFile = FileOpen(@ScriptDir & "\AutoCharts.log", 1)


	Local Const $sMessage = "Select where you would like to save the Datalinker file."

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
	If @error Then
		; Display the error message.
		MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
	Else
		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 17.0\en_US\DataLinker\DataLinker.xml", $sFileSelectFolder & "\" & $INPT_Name & "_Datalinker.xml", 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error finding your DataLinker file.")
			_LogaError("Error! Unable to Export Datalinker File to " & $sFileSelectFolder) ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File Exported to " & $sFileSelectFolder)

			_LogaInfo("Datalinker File Exported to " & $sFileSelectFolder) ; Write to the logfile

		EndIf
	EndIf

EndFunc   ;==>ExportDatalinker


;===============================================================================
;
; Function Name:    UploadDatalinker()
; Description:      Copies DataLinker XML file from current user's local plugin directory and uploads it to AutoCharts Drive directory
; Parameter(s):     None
;
;===============================================================================
Func UploadDatalinker()

	If $INPT_Name = "Jakob" Then
		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 17.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir, 1)
		If @error Then
			_GUIDisable($Form7, 0, 30)
			_Metro_MsgBox(0, "Error!", "There was an error uploading your Datalinker file to the database.", 500, 11, $Form7)
			_GUIDisable($Form7)
			_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir) ; Write to the logfile
		Else
			_GUIDisable($Form7, 0, 30)
			_Metro_MsgBox(0, "Success!", "Datalinker File has been uploaded to the database.", 500, 11, $Form7)
			_GUIDisable($Form7)
			_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir) ; Write to the logfile

		EndIf
	Else

		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 17.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir & "\" & $INPT_Name & "_Datalinker.xml", 1)
		If @error Then
			_GUIDisable($Form7, 0, 30)
			_Metro_MsgBox(0, "Error!", "There was an error uploading your Datalinker file to the database.", 500, 11, $Form7)
			_GUIDisable($Form7)
			_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir) ; Write to the logfile
		Else
			_GUIDisable($Form7, 0, 30)
			_Metro_MsgBox(0, "Success!", "Datalinker File has been uploaded to the database.", 500, 11, $Form7)
			_GUIDisable($Form7)
			_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir) ; Write to the logfile

		EndIf
	EndIf

EndFunc   ;==>UploadDatalinker

;===============================================================================
;
; Function Name:    ImportDatalinker()
; Description:      Imports Datalinker file from AutoCharts Drive Database and changes file paths to current user's AutoCharts Drive directory.
; Parameter(s):     None
;
;===============================================================================
Func ImportDatalinker()

	FileCopy($DatabaseDir & "\DataLinker.xml", @ScriptDir & "\Datalinker_TEMP1.xml", 1)
	If @error Then

		_GUIDisable($Form7, 0, 30)
		_Metro_MsgBox(0, "Error!", "Unable to copy datalinker.xml file to script directory", 500, 11, $Form7)
		_GUIDisable($Form7)

		_LogaError("Error! Unable to copy datalinker.xml file to script directory")     ; Write to the logfile
	Else
		_LogaInfo("Datalinker File Imported to AutoCharts Directory")     ; Write to the logfile

	EndIf

	Local $file = @ScriptDir & "\Datalinker_TEMP1.xml"
	Local $text = FileRead($file)

	FileCopy(@ScriptDir & "\Datalinker_TEMP1.xml", @AppDataDir & "\Adobe\InDesign\Version 17.0\en_US\DataLinker\DataLinker.xml", 1)
	If @error Then
		_GUIDisable($Form7, 0, 30)
		_Metro_MsgBox(0, "Error!", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file", 500, 11, $Form7)
		_GUIDisable($Form7)

		_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file")     ; Write to the logfile
	Else

		_LogaInfo("Datalinker File Imported to InDesign successfully")     ; Write to the logfile

	EndIf

	FileDelete(@ScriptDir & "\Datalinker_Updated2.xml")
	FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
	FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
	FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
	_LogaInfo("Datalinker File Imported to InDesign successfully")         ; Write to the logfile


EndFunc   ;==>ImportDatalinker
