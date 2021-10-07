;===============================================================================
;
; Name:    			Database Sync
; Description:      Dropbox Database Sync for AutoCharts
; Author(s):        oNevion
; Version:          v0.7
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
; Function Name:    VerifyDropbox()
; Description:      Verifies User Selected Dropbox Directory. If .checkfile does not exist, than user receives and error.
; Parameter(s):     None
;
;===============================================================================

Func VerifyDropbox()
	If FileExists($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\.checkfile") Then
		$bDBVerified = True
		IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
	Else
		$bDBVerified = False
		IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
		SetError(50)
	EndIf
	;Verifies Connection to new AutoCharts Drive
		If FileExists($DatabaseDir & "/.checkfile") Then
		$bACDriveVerified = True
		IniWrite($ini, 'Settings', 'ACDriveVerified', $bDBVerified)
	Else
		$bACDriveVerified = False
		IniWrite($ini, 'Settings', 'ACDriveVerified', $bDBVerified)
		SetError(50)
	EndIf
EndFunc   ;==>VerifyDropbox

;===============================================================================
;
; Function Name:    SyncronizeDataFiles()
; Description:      Downloads all files from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================
Func SyncronizeDataFiles()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files"
	$destination = $DatabaseDir & "\fin_backup_files"
	$timer = TimerInit()

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)


	$source = $DatabaseDir & "\fin_backup_files"
	$destination = @ScriptDir & $CSVDataDir

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)


	_LogaInfo("Synced Dropbox data with Autocharts Data") ; Write to the logfile

	$source = $DatabaseDir & "\amCharts"
	$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile


	SplashOff()


EndFunc   ;==>SyncronizeDataFiles

;===============================================================================
;
; Function Name:    PullCatalystData()
; Description:      Downloads all files for Catalyst Funds from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullCatalystData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst"
	$destination = $DatabaseDir & "\fin_backup_files\Catalyst"
	;Local $timer = TimerInit()

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	$source = $DatabaseDir & "\fin_backup_files\Catalyst"
	$destination = @ScriptDir & $CSVDataDir & "\Catalyst"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Pulled All Catalyst Data from Dropbox") ; Write to the logfile

	$source = $DatabaseDir & "\amCharts"
	$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
	;MsgBox(0,"","Done in " & TimerDiff($timer)/1000 & " seconds!")

EndFunc   ;==>PullCatalystData

;===============================================================================
;
; Function Name:    PullCatalystFundData()
; Description:      Downloads $CurrentFund's csv data from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullCatalystFundData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst\" & $CurrentFund & "\"
	$destination = $DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund & "\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	$source = $DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund & "\"
	$destination = @ScriptDir & $CSVDataDir & "\Catalyst\" & $CurrentFund & "\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox") ; Write to the logfile

	$source = $DatabaseDir & "\amCharts"
	$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullCatalystFundData

;===============================================================================
;
; Function Name:    PullRationalData()
; Description:      Downloads all files for Rational Funds from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullRationalData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational\"
	$destination = $DatabaseDir & "\fin_backup_files\Rational\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	$source = $DatabaseDir & "\fin_backup_files\Rational\"
	$destination = @ScriptDir & $CSVDataDir & "\Rational\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Pulled Rational Data from Dropbox") ; Write to the logfile

	$source = $DatabaseDir & "\amCharts"
	$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)


	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullRationalData

;===============================================================================
;
; Function Name:    PullRationalFundData()
; Description:      Downloads $CurrentFund's csv data from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullRationalFundData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational\" & $CurrentFund & "\"
	$destination = $DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund & "\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	$source = $DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund & "\"
	$destination = @ScriptDir & $CSVDataDir & "\Rational\" & $CurrentFund & "\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox") ; Write to the logfile

	$source = $DatabaseDir & "\amCharts"
	$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullRationalFundData


;===============================================================================
;
; Function Name:    PullStrategySharesFundData()
; Description:      Downloads $CurrentFund's csv data from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullStrategySharesFundData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	$source = $DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\StrategyShares\" & $CurrentFund & "\"
	$destination = $DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund & "\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	$source = $DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund & "\"
	$destination = @ScriptDir & $CSVDataDir & "\StrategyShares\" & $CurrentFund & "\"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox") ; Write to the logfile

	$source = $DatabaseDir & "\amCharts"
	$destination = @ScriptDir & "\assets\ChartBuilder\public\scripts"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullStrategySharesFundData

;===============================================================================
;
; Function Name:    UploadamCharts()
; Description:      Uploads amCharts JS files from AutoCharts directory to Dropbox Database
; Parameter(s):     None
;
;===============================================================================

Func UploadamCharts()
	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	$source = "C:\Users\mrjak\Documents\GitHub\AutoCharts\assets\ChartBuilder\public\scripts\"
	$destination = $DatabaseDir & "\amCharts"

	RunWait(@ComSpec & " /c " & "xcopy " & '"' & $source & '"' & ' "' & $destination & '"' & " /E /C /D /Y /H /J /I", "", @SW_HIDE)

	SplashOff()

	_LogaInfo("Uploaded amCharts Scripts to Database") ; Write to the logfile
EndFunc   ;==>UploadamCharts
