#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=assets\GUI_Menus\programicon_hxv_icon.ico
#AutoIt3Wrapper_Outfile_x64=AutoCharts.exe
#AutoIt3Wrapper_Res_Description=AutoCharts 3.4.1
#AutoIt3Wrapper_Res_Fileversion=3.4.1.1
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=p
#AutoIt3Wrapper_Res_ProductName=AutoCharts
#AutoIt3Wrapper_Res_ProductVersion=3.4.1
#AutoIt3Wrapper_Res_CompanyName=Jakob Bradshaw Productions
#AutoIt3Wrapper_Res_LegalCopyright=© 2021 Jakob Bradshaw Productions
#AutoIt3Wrapper_Res_SaveSource=y
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_requestedExecutionLevel=requireAdministrator
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_AU3Check_Parameters=-w 1 -v 1
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#Au3Stripper_Ignore_Funcs=_iHoverOn,_iHoverOff,_iFullscreenToggleBtn,_cHvr_CSCP_X64,_cHvr_CSCP_X86,_iControlDelete


#Region ### GLOBAL Arrays and Variables

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



;Predeclare the variables with dummy values to prevent firing the Case statements, only for GUI this time
Global $GUI_UserSettings = 9999
Global $INPT_DropboxFolder = 9999
Global $BTN_Save = 9999
Global $BTN_Cancel = 9999
Global $BTN_SelectDBPath = 9999

Global $Radio_Q1 = 4
Global $Radio_Q2 = 4
Global $Radio_Q3 = 4
Global $Radio_Q4 = 4

#EndRegion ### GLOBAL Arrays and Variables

#Region ### Database Variables

Global $CSVDataDir = "\assets\ChartBuilder\public\Data\Backups\"
Global $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
Global $AutoChartsDriveDir = "Z:\"
Global $DatabaseDir = $AutoChartsDriveDir & "\database"


#EndRegion ### Database Variables
#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GUIListBox.au3>
#include <WinAPIFiles.au3>
#include <AutoItConstants.au3>
#include <FileConstants.au3>

;-------------------------------------------------------------------------------
; Main program that manages Logging
;
; This is the entry point to the DataLinker code.
;-------------------------------------------------------------------------------
#include "src/Logger.au3"

;-------------------------------------------------------------------------------
; Main program that manages database sync functions
;
; This is the entry point to the database sync code.
;-------------------------------------------------------------------------------
#include "src/Database_Sync.au3"

;-------------------------------------------------------------------------------
; Main program that houses all GUI events and controls
;
; This is the entry point to the GUI Wrapper code.
;-------------------------------------------------------------------------------
#include "src/GUI_Wrapper.au3"

;-------------------------------------------------------------------------------
; Main program that manages DataLinker Functions
;
; This is the entry point to the DataLinker code.
;-------------------------------------------------------------------------------
#include "src/DataLinker_Func.au3"

;-------------------------------------------------------------------------------
; Main program that manages files for the documents folder
;
; This is the entry point to the directory and file check and creation code.
;-------------------------------------------------------------------------------
#include "src/MyDocuments_Include.au3"

;-------------------------------------------------------------------------------
; Main program that manages PDF uploads to Fund Websites
;
; This is the entry point to the PDF uploading functions
;-------------------------------------------------------------------------------
#include "src/Upload_PDF_Func.au3"

Func CheckForFreshInstall()
	If Not FileExists(@MyDocumentsDir & "\AutoCharts\settings.ini") Then
		;FileCopy(@ScriptDir & "/settings.ini", @MyDocumentsDir & "\AutoCharts\settings.ini")
		_LogaInfo("Brand new install detected.")
		_Metro_MsgBox(0, "Thanks for installing AutoCharts!", "Thanks for installing AutoCharts!" & @CRLF & @CRLF & "Before you begin, please open the settings and set your AutoCharts drive.")
	Else
		$CopySettings = FileCopy(@MyDocumentsDir & "\AutoCharts\settings.ini", @ScriptDir & "\settings.ini", 1)
		If $CopySettings = 0 Then
			_ThrowError("Could not save file to documents folder", 0, 0, 0, 3) ; No exit, no error, auto-close in 3 seconds
			_LogaError("Could not save file to documents folder")
		EndIf

	EndIf
EndFunc   ;==>CheckForFreshInstall

Func CheckForUpdate()
	RunWait(@ScriptDir & "/AutoCharts_Updater.exe")
EndFunc   ;==>CheckForUpdate

CheckForFreshInstall()


#Region ### Start Main Functions Region

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

	_LogaInfo("Determined quarter to be ~" & $Select_Quarter & "~ and current year to be ~" & $INPT_CurYear & "~") ; Write to the logfile

	If FileExists($DatabaseDir & "\csv\Update_FactSheetDates.csv") Then
		FileDelete($DatabaseDir & "\csv\Update_FactSheetDates.csv")
	EndIf

	;Create CSV Line by Line for Datalinker to read current year and quarter.

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
	FileClose($DatabaseDir & "\csv\Update_FactSheetDates.csv") ; Close the filehandle to release the file.
	;FileMove(@ScriptDir & "\assets\ChartBuilder\public\Data\Backups\Update_FactSheetDates.csv", $DatabaseDir & "\csv\", 1)

	_LogaInfo("Updated FactSheetDates CSV File with selected dates") ; Write to the logfile


EndFunc   ;==>DetermineDates

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

EndFunc   ;==>ClearLog



Func RunCSVConvert() ; Dynamically checks for funds with "-institutional.xlsx" files and converts those automatically as well.

	For $a = 0 To (UBound($FamilySwitch) - 1) ; Loops through FundFamily Array
		If $FamilySwitch[$a] <> "" Then
			$CurrentFund = $FamilySwitch[$a]
			GUICtrlSetData($UpdateLabel, "Updating the following Fund Factsheet: " & $CurrentFund)
			_Metro_SetProgress($ProgressBar, 15)

			_LogaInfo("~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")     ; Write to the logfile


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

			If Not FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & "*.xlsx", @MyDocumentsDir & "/AutoCharts/vbs/") Then      ; grab .xlsx from current fund directory and move to /VBS_Scripts
				_GUIDisable($Form1, 0, 50)
				_Metro_MsgBox(0, "Error", "Could not copy backup file " & $DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & ".xlsx")
				_GUIDisable($Form1)
				_LogaError("Could not copy backup file " & $DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & ".xlsx")     ; Write to the logfile
				ExitLoop
			EndIf

			RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & ".xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv

			GUICtrlSetData($UpdateLabel, $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CSV CONVERSION START ~~~~~~~~~~~~")

			_LogaInfo("Converted " & $CurrentFund & ".xlsx file to csv")     ; Write to the logfile

			GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & ".xlsx file to csv")

			;Checks to see if Catalyst checkboxes are checked for different marketing material types | Factsheet, Brochure, Presentation
			If $FundFamily = "Catalyst" Then
				If _Metro_CheckboxIsChecked($CB_Brochure_Catalyst) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
						RunCSVConvert4Brochure()
					EndIf
					;_Metro_CheckboxUnCheck($CB_Brochure_Catalyst)
				EndIf

				If _Metro_CheckboxIsChecked($CB_FactSheet_Catalyst) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
						RunCSVConvert4Institution()
					EndIf
					;_Metro_CheckboxUnCheck($CB_FactSheet_Catalyst)

				EndIf

				If _Metro_CheckboxIsChecked($CB_Presentation_Catalyst) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
						RunCSVConvert4Presentation()
					EndIf
					;_Metro_CheckboxUnCheck($CB_Presentation_Catalyst)

				EndIf
			EndIf

			;Checks to see if Rational checkboxes are checked for different marketing material types | Factsheet, Brochure, Presentation
			If $FundFamily = "Rational" Then

				If _Metro_CheckboxIsChecked($CB_Brochure_Rational) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
						RunCSVConvert4Brochure()
					EndIf
					;_Metro_CheckboxUnCheck($CB_Brochure_Rational)

				EndIf

				If _Metro_CheckboxIsChecked($CB_FactSheet_Rational) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
						RunCSVConvert4Institution()
					EndIf
					;_Metro_CheckboxUnCheck($CB_FactSheet_Rational)

				EndIf

				If _Metro_CheckboxIsChecked($CB_Presentation_Rational) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
						RunCSVConvert4Presentation()
					EndIf
					;_Metro_CheckboxUnCheck($CB_Presentation_Rational)

				EndIf
			EndIf

			;Checks to see if Strategy Shares checkboxes are checked for different marketing material types | Factsheet, Brochure, Presentation
			If $FundFamily = "StrategyShares" Then

				If _Metro_CheckboxIsChecked($CB_Brochure_SS) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-brochure.xlsx") Then
						RunCSVConvert4Brochure()
					EndIf
					;_Metro_CheckboxUnCheck($CB_Brochure_SS)

				EndIf

				If _Metro_CheckboxIsChecked($CB_FactSheet_SS) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-institutional.xlsx") Then
						RunCSVConvert4Institution()
					EndIf
					;_Metro_CheckboxUnCheck($CB_FactSheet_SS)

				EndIf

				If _Metro_CheckboxIsChecked($CB_Presentation_SS) Then
					If FileExists($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\" & $CurrentFund & "\" & $CurrentFund & "-presentation.xlsx") Then
						RunCSVConvert4Presentation()
					EndIf
					;_Metro_CheckboxUnCheck($CB_Presentation_SS)

				EndIf
			EndIf

			_Metro_SetProgress($ProgressBar, 25)


			$CSVCopy = FileCopy(@MyDocumentsDir & "/AutoCharts/vbs/*.csv", @ScriptDir & $CSVDataDir & "\" & $FundFamily & "\" & $CurrentFund & "\" & "*.csv", 1)       ; Move all .CSV back to Data folder and overwrite.
			If $CSVCopy = 0 Then
				_ThrowError("Could not save CSV files to program directory.", 1, 0, 0, 3) ; No exit, no error, auto-close in 3 seconds
				_LogaError("Could not save CSV files to program directory.")
			EndIf

			$CSVMove = FileMove(@MyDocumentsDir & "/AutoCharts/vbs/*.csv", $DatabaseDir & "\csv\" & $FundFamily & "\" & $CurrentFund & "\*.csv", 1)       ; Move all .CSV back to Data folder and overwrite.
			If $CSVMove = 0 Then
				_ThrowError("Could not save CSV files to AutoCharts Database.", 0, 0, 0, 3) ; No exit, no error, auto-close in 3 seconds
				_LogaError("Could not save CSV files to AutoCharts Database.")
			EndIf

			_LogaInfo("Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in AutoCharts Drive") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, $CurrentFund & " | Moved the " & $CurrentFund & ".csv files to the fund's InDesign Links folder in AutoCharts Drive")
			_Metro_SetProgress($ProgressBar, 30)


			$XLSXDelete = FileDelete(@MyDocumentsDir & "/AutoCharts/vbs/*.xlsx")     ; deletes remaining .xlsx from conversion
			If $XLSXDelete = 0 Then
				_ThrowError("Cound not clear excel files from VBS directory.", 0, 0, 0, 3) ; No exit, no error, auto-close in 3 seconds
				_LogaError("Cound not clear excel files from VBS directory.")
			EndIf
			_LogaInfo("Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, $CurrentFund & " | Deleted remaining " & $CurrentFund & ".xlsx files from CSV Conversion directory")
			_Metro_SetProgress($ProgressBar, 55)

		Else
			ContinueLoop
		EndIf

	Next

EndFunc   ;==>RunCSVConvert


Func RunCSVConvert4Institution() ; Dynamically checks for funds with "-institutional.xlsx" files and converts those automatically as well.

	RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-institutional.xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

	_LogaInfo("Converted " & $CurrentFund & "-institutional.xlsx file to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & "-institutional.xlsx file to csv")


EndFunc   ;==>RunCSVConvert4Institution



Func RunCSVConvert4Brochure() ; Dynamically checks for funds with "-brochure.xlsx" files and converts those automatically as well.

	RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-brochure.xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

	_LogaInfo("Converted " & $CurrentFund & "-brochure.xlsx file to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & "-brochure.xlsx file to csv")


EndFunc   ;==>RunCSVConvert4Brochure


Func RunCSVConvert4Presentation() ; Dynamically checks for funds with "-brochure.xlsx" files and converts those automatically as well.

	RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs " & $CurrentFund & "-presentation.xlsx", @TempDir, @SW_HIDE)     ;~ Runs command hidden, Converts Current Fund's INSTITUTIONAL.xlsx to .csv

	_LogaInfo("Converted " & $CurrentFund & "-presentation.xlsx file to csv")     ; Write to the logfile
	GUICtrlSetData($UpdateLabel, $CurrentFund & " | Converted " & $CurrentFund & "-presentation.xlsx file to csv")


EndFunc   ;==>RunCSVConvert4Presentation




Func HTMLChartEditor() ; Edits index_TEMPLATE.html file to include current fund's chart .js file
	Local $file = @ScriptDir & "\assets\ChartBuilder\public\index_TEMPLATE.html"
	Local $text = FileRead($file)

	$tout1 = StringReplace($text, '<script src="/scripts/CHANGEME.js"></script>', '<script src="/scripts/' & $CurrentFund & '.js"></script>')
	FileWrite(@ScriptDir & "\assets\ChartBuilder\public\index.html", $tout1)

	_LogaInfo("~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~") ; Write to the logfile
	GUICtrlSetData($UpdateLabel, $CurrentFund & " | ~~~~~~~~~~~~ " & $CurrentFund & " CHART GENERATION START ~~~~~~~~~~~~")

	_LogaInfo("Created HTML file for " & $CurrentFund & " chart generation") ; Write to the logfile
	GUICtrlSetData($UpdateLabel, $CurrentFund & " | Created HTML file for " & $CurrentFund & " chart generation")

	_LogaInfo("Initializing Local Server for amCharts") ; Write to the logfile
	GUICtrlSetData($UpdateLabel, $CurrentFund & " | Initializing Local Server for amCharts")


EndFunc   ;==>HTMLChartEditor




Func CreateCharts()
	For $a = 0 To (UBound($FamilySwitch) - 1)    ; Loops through FundFamily Array
		If $FamilySwitch[$a] <> "" Then
			$CurrentFund = $FamilySwitch[$a]
			Call("HTMLChartEditor")
			RunWait(@ComSpec & " /c node --unhandled-rejections=strict server.js", @ScriptDir & "/assets/ChartBuilder/", @SW_HIDE) ;~ Runs local server to create current fund's amcharts svgs.
			;RunWait(@ComSpec & " /c node server.js", @ScriptDir & "/assets/ChartBuilder/") ;~ Runs local server to create current fund's amcharts svgs.
			_Metro_SetProgress($ProgressBar, 70)

			_LogaInfo($CurrentFund & " charts generated in SVG format using amCharts") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, $CurrentFund & " | Charts generated in SVG format using amCharts")


			FileDelete(@ScriptDir & "\assets\ChartBuilder\public\index.html")  ; ~ Deletes index.html file that was created in Func HTMLChartEditor to keep from editing the same file.
			FileMove(@ScriptDir & "/assets/ChartBuilder/*.svg", $DatabaseDir & "\images\charts\" & $FundFamily & "\" & $CurrentFund & "\*.svg", 1)   ; Move all .SVG to Database
			_Metro_SetProgress($ProgressBar, 92)

			_LogaInfo($CurrentFund & " charts moved to the funds InDesign Links folder") ; Write to the logfile
			GUICtrlSetData($UpdateLabel, $CurrentFund & " | Charts moved to the funds InDesign Links folder")


		Else
			ContinueLoop
		EndIf
		_Metro_SetProgress($ProgressBar, 100)

	Next
EndFunc   ;==>CreateCharts

Func RunExpenseRatios()
	If $FundFamily = "Catalyst" Then
		GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")
		_Metro_SetProgress($ProgressBar, 60)

		FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\Catalyst_ExpenseRatios.xlsx", @MyDocumentsDir & "/AutoCharts/vbs/")       ; grab Expense Ratio .xlsx from Catalyst Data Directory
		RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs Catalyst_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)         ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv

		_LogaInfo("~~~~~~~~~~~~ Updating Catalyst Expense Ratios ~~~~~~~~~~~~")     ; Write to the logfile
		GUICtrlSetData($UpdateLabel, "Updating Catalyst Expense Ratios")

		_LogaInfo("Updated Catalyst Expense Ratios")         ; Write to the logfile

		GUICtrlSetData($UpdateLabel, "Updated Catalyst Expense Ratios")
		FileMove(@MyDocumentsDir & "/AutoCharts/vbs/Catalyst_ExpenseRatios.csv", $DatabaseDir & "\csv\" & $FundFamily & "\Catalyst_ExpenseRatios.csv", 1)           ; Move all .CSV back to Data folder and overwrite.
		FileDelete(@MyDocumentsDir & "/AutoCharts/vbs/*.xlsx")           ; deletes remaining .xlsx from conversion


	EndIf
	If $FundFamily = "Rational" Then
		GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")
		_Metro_SetProgress($ProgressBar, 60)

		FileCopy($DatabaseDir & "\fin_backup_files\" & $FundFamily & "\Rational_ExpenseRatios.xlsx", @MyDocumentsDir & "/AutoCharts/vbs/")       ; grab Expense Ratio .xlsx from Rational Data Directory
		RunWait(@ComSpec & " /c " & @MyDocumentsDir & "/AutoCharts/vbs/Excel_To_CSV_All_Worksheets.vbs Rational_ExpenseRatios.xlsx", @TempDir, @SW_HIDE)         ;~ Runs command hidden, Converts Current Fund's .xlsx to .csv

		_LogaInfo("~~~~~~~~~~~~ Updating Rational Expense Ratios ~~~~~~~~~~~~")         ; Write to the logfile
		GUICtrlSetData($UpdateLabel, "Updating Rational Expense Ratios")

		_LogaInfo("Updated Rational Expense Ratios")         ; Write to the logfile

		GUICtrlSetData($UpdateLabel, "Updated Rational Expense Ratios")
		FileMove(@MyDocumentsDir & "/AutoCharts/vbs/Rational_ExpenseRatios.csv", $DatabaseDir & "\csv\" & $FundFamily & "\Rational_ExpenseRatios.csv", 1)           ; Move all .CSV back to Data folder and overwrite.
		FileDelete(@MyDocumentsDir & "/AutoCharts/vbs/*.xlsx")           ; deletes remaining .xlsx from conversion


	EndIf

	_Metro_SetProgress($ProgressBar, 100)

EndFunc   ;==>RunExpenseRatios

Func CreateFactSheetArchive()
	Local $Archive

	; Create a constant variable in Local scope of the message to display in FileSelectFolder.
	Local Const $sMessage = "Select Save Location"

	; Display an open dialog to select a file.
	Local $sFileSelectFolder = FileSelectFolder($sMessage, "")
	If @error Then
		; Display the error message.

		_GUIDisable($Form1, 0, 50)
		_Metro_MsgBox(0, "Error", "No folder was selected.")
		_GUIDisable($Form1)


	Else
		_GUIDisable($Form1, 0, 50)
		SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

		$Archive = $sFileSelectFolder & "\FactSheets_" & $Select_Quarter & "-" & $INPT_CurYear & "\"
		DirCreate($Archive) ;Create The archive folder.
		DirCopy($DatabaseDir & "\fin_backup_files", $Archive, 1) ;Add a folder to the archive (files/subfolders will be added)
		DirCopy($DropboxDir & "\FactSheets", $Archive, 1) ;Add a folder to the archive (files/subfolders will be added)
		SplashOff()

		_Metro_MsgBox(0, "Success", "Created Factsheet Archive at " & $Archive)
		_GUIDisable($Form1)

		_LogaInfo("Created Factsheet Archive at " & $Archive) ; Write to the logfile

	EndIf


EndFunc   ;==>CreateFactSheetArchive


#EndRegion ### Start Main Functions Region
