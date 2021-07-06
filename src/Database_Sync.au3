;===============================================================================
;
; Name:    			Database Sync
; Description:      Dropbox Database Sync for AutoCharts
; Author(s):        oNevion
; Version:          v0.2
;
;===============================================================================

#Region ### Database Variables

Global $CSVDataDir = "\assets\ChartBuilder\public\Data\Backups"
Global $DropboxDir = IniRead($ini, 'Settings', 'DropboxDir', '')
Global $DatabaseDir = $DropboxDir & "\Marketing Team Files\AutoCharts_Database"


#EndRegion ### Database Variables

;===============================================================================
;
; Function Name:    VerifyDropbox()
; Description:      Verifies User Selected Dropbox Directory. If .checkfile does not exist, than user receives and error.
; Parameter(s):     None
;
;===============================================================================

Func VerifyDropbox()
	If FileExists($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\.checkfile") Then  ; dynamically checks if Current Fund has institutional backupfile. If so, runs csv convert on both
		$bDBVerified = True
		IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
	Else
		$bDBVerified = False
		IniWrite($ini, 'Settings', 'DBVerified', $bDBVerified)
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

	DirRemove($DatabaseDir & "\fin_backup_files", 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files", $DatabaseDir & "\fin_backup_files", 1)

	DirRemove(@ScriptDir & $CSVDataDir, 1)
	DirCopy($DatabaseDir & "\fin_backup_files", @ScriptDir & $CSVDataDir, 1)

	_LogaInfo("Synced Dropbox data with Autocharts Data") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

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

	DirRemove($DatabaseDir & "\fin_backup_files\Catalyst", 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst", $DatabaseDir & "\fin_backup_files\Catalyst", 1)
	DirCopy($DatabaseDir & "\fin_backup_files\Catalyst", @ScriptDir & $CSVDataDir & "\Catalyst", 1)

	_LogaInfo("Pulled Catalyst Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullCatalystData

;===============================================================================
;
; Function Name:    PullRationalData()
; Description:      Downloads all files for Rational Funds from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullRationalData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove($DatabaseDir & "\fin_backup_files\Rational", 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational", $DatabaseDir & "\fin_backup_files\Rational", 1)
	DirCopy($DatabaseDir & "\fin_backup_files\Rational", @ScriptDir & $CSVDataDir & "\Rational", 1)

	_LogaInfo("Pulled Rational Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullRationalData

;===============================================================================
;
; Function Name:    PullStrategySharesData()
; Description:      Downloads all files for Strategy Shares from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullStrategySharesData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove($DatabaseDir & "\fin_backup_files\StrategyShares", 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\StrategyShares", $DatabaseDir & "\fin_backup_files\StrategyShares", 1)
	DirCopy($DatabaseDir & "\fin_backup_files\StrategyShares", @ScriptDir & $CSVDataDir & "\StrategyShares", 1)

	_LogaInfo("Pulled Strategy Shares Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()

EndFunc   ;==>PullStrategySharesData

;===============================================================================
;
; Function Name:    UploadamCharts()
; Description:      Uploads amCharts JS files from AutoCharts directory to Dropbox Database
; Parameter(s):     None
;
;===============================================================================

Func UploadamCharts()
	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove($DatabaseDir & "\amCharts", 1)
	DirCopy(@ScriptDir & "\assets\ChartBuilder\public\scripts", $DatabaseDir & "\amCharts", 1)

	SplashOff()

	_LogaInfo("Uploaded amCharts Scripts to Database") ; Write to the logfile
EndFunc   ;==>UploadamCharts