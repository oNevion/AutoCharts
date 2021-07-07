;===============================================================================
;
; Name:    			DataLinker Integration
; Description:      Custom Integration of DataLinker plugin for InDesign
; Author(s):        oNevion
; Version:          v0.2
;
;===============================================================================


;===============================================================================
;
; Function Name:    ExportDatalinker()
; Description:      Copies and exports DataLinker XML file from Dropbox Database to user defined directory
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
		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $sFileSelectFolder & "\" & $INPT_Name & "_Datalinker.xml", 1)
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
; Description:      Copies DataLinker XML file from current user's local plugin directory and uploads it to Dropbox directory
; Parameter(s):     None
;
;===============================================================================
Func UploadDatalinker()

	If $INPT_Name = "Jakob" Then
		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir, 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
			_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir) ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")

			_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir) ; Write to the logfile

		EndIf
	Else

		FileCopy(@AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", $DatabaseDir & "\" & $INPT_Name & "_Datalinker.xml", 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error uploading your Datalinker file to the database.")
			_LogaError("Error! Unable to Upload Datalinker File to " & $DatabaseDir) ; Write to the logfile
		Else
			MsgBox($MB_SYSTEMMODAL, "Success", "Datalinker File has been uploaded to the database.")

			_LogaInfo("Datalinker File Uploaded to " & $DatabaseDir) ; Write to the logfile

		EndIf
	EndIf

EndFunc   ;==>UploadDatalinker

;===============================================================================
;
; Function Name:    ImportDatalinker()
; Description:      Imports Datalinker file from Dropbox Database and changes file paths to current user's dropbox directory.
; Parameter(s):     None
;
;===============================================================================
Func ImportDatalinker()

	FileCopy($DatabaseDir & "\DataLinker.xml", @ScriptDir & "\Datalinker_TEMP1.xml", 1)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Error", "Unable to copy datalinker.xml file to script directory")
		_LogaError("Error! Unable to copy datalinker.xml file to script directory")     ; Write to the logfile
	Else
		_LogaInfo("Datalinker File Imported to AutoCharts Directory")     ; Write to the logfile

	EndIf

	Local $file = @ScriptDir & "\Datalinker_TEMP1.xml"
	Local $text = FileRead($file)


	If $INPT_Name <> "Jakob" Then
		$tout1 = StringReplace($text, 'X:\Marketing Team Files\', $DropboxDir & '\Marketing Team Files\')
		FileWrite(@ScriptDir & "\DataLinker_Updated1.xml", $tout1)
		;FileCopy(@ScriptDir & "\Datalinker_Updated.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)


		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
			_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file") ; Write to the logfile
		Else
			;FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
			;FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
			_LogaInfo("Datalinker File Imported to InDesign successfully") ; Write to the logfile

		EndIf
	Else
		FileCopy(@ScriptDir & "\Datalinker_TEMP1.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
			_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file") ; Write to the logfile
		Else
			;MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
			;FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
			;FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
			_LogaInfo("Datalinker File Imported to InDesign successfully") ; Write to the logfile

		EndIf

	EndIf

	; Run again for image links

	FileCopy(@ScriptDir & "\Datalinker_Updated1.xml", @ScriptDir & "\Datalinker_TEMP2.xml", 1)
	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign")
		_LogaError("Error! Unable to Import Datalinker File to InDesign")     ; Write to the logfile
	Else
		_LogaInfo("Datalinker File Imported to AutoCharts Directory")     ; Write to the logfile

	EndIf

	Local $file2 = @ScriptDir & "\Datalinker_TEMP2.xml"
	Local $text2 = FileRead($file2)


	If $INPT_Name <> "Jakob" Then
		$tout2 = StringReplace($text2, 'file:///X:', 'file:///' & $DropboxDir)
		FileWrite(@ScriptDir & "\DataLinker_Updated2.xml", $tout2)
		FileCopy(@ScriptDir & "\Datalinker_Updated2.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)


		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
			_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file") ; Write to the logfile
		Else
			;MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
			FileDelete(@ScriptDir & "\Datalinker_Updated2.xml")
			FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
			FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
			FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
			_LogaInfo("Datalinker File Imported to InDesign successfully") ; Write to the logfile

		EndIf
	Else
		FileCopy(@ScriptDir & "\Datalinker_TEMP.xml", @AppDataDir & "\Adobe\InDesign\Version 16.0\en_US\DataLinker\DataLinker.xml", 1)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "Error", "There was an error importing your Datalinker file to InDesign | Could not replace directory in file")
			_LogaError("Error! Unable to Import Datalinker File to InDesign | Could not replace directory in file") ; Write to the logfile
		Else
			;MsgBox($MB_SYSTEMMODAL, "Success", "DataLinker file has successfully been imported. Please Restart InDesign if it is currently Open.")
			FileDelete(@ScriptDir & "\Datalinker_Updated.xml")
			FileDelete(@ScriptDir & "\Datalinker_Updated1.xml")
			FileDelete(@ScriptDir & "\Datalinker_TEMP1.xml")
			FileDelete(@ScriptDir & "\Datalinker_TEMP2.xml")
			_LogaInfo("Datalinker File Imported to InDesign successfully") ; Write to the logfile

		EndIf

	EndIf

EndFunc   ;==>ImportDatalinker