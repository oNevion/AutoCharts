;===============================================================================
;
; Name:    			Database Sync
; Description:      Dropbox Database Sync for AutoCharts
; Author(s):        oNevion
; Version:          v0.4
;
;===============================================================================

#include-once
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <FileConstants.au3>


;sync.exe "X:\Marketing Team Files\AutoCharts_Database" "C:\Users\mrjak\Documents\GitHub\AutoIt UDF\BackUp" /VerifyByDate /PreserveDates

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

	_LogaInfo("Pulled All Catalyst Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
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

	DirRemove($DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund, 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Catalyst\" & $CurrentFund, $DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund, 1)
	DirCopy($DatabaseDir & "\fin_backup_files\Catalyst\" & $CurrentFund, @ScriptDir & $CSVDataDir & "\Catalyst\" & $CurrentFund, 1)

	_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

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
; Function Name:    PullRationalFundData()
; Description:      Downloads $CurrentFund's csv data from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullRationalFundData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove($DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund, 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\Rational\" & $CurrentFund, $DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund, 1)
	DirCopy($DatabaseDir & "\fin_backup_files\Rational\" & $CurrentFund, @ScriptDir & $CSVDataDir & "\Rational\" & $CurrentFund, 1)

	_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullRationalFundData

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
; Function Name:    PullStrategySharesFundData()
; Description:      Downloads $CurrentFund's csv data from Dropbox Database into AutoCharts Directory
; Parameter(s):     None
;
;===============================================================================

Func PullStrategySharesFundData()

	SplashImageOn("", @ScriptDir & "\assets\GUI_Menus\loading.jpg", "160", "160", "-1", "-1", 1)

	DirRemove($DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund, 1)
	DirCopy($DropboxDir & "\Marketing Team Files\Marketing Materials\AutoCharts&Tables\Backup Files\StrategyShares\" & $CurrentFund, $DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund, 1)
	DirCopy($DatabaseDir & "\fin_backup_files\StrategyShares\" & $CurrentFund, @ScriptDir & $CSVDataDir & "\StrategyShares\" & $CurrentFund, 1)

	_LogaInfo("Pulled " & $CurrentFund & " Data from Dropbox") ; Write to the logfile

	DirRemove(@ScriptDir & "\assets\ChartBuilder\public\scripts", 1)
	DirCopy($DatabaseDir & "\amCharts", @ScriptDir & "\assets\ChartBuilder\public\scripts", 1)

	_LogaInfo("Downloaded amChart Scripts from Database") ; Write to the logfile

	SplashOff()
EndFunc   ;==>PullRationalFundData

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