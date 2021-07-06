;===============================================================================
;
; Name:    			Basic Logger
; Description:      Basic Logger while running scripts.
; Author(s):        oNevion
; Version:          v0.1
;
;===============================================================================


#include "Loga.au3"



;LogFileAutoFlush Eeable vs  LogFileAutoFlush Disable
Global $sInstancesComparison = ""

Global $sLogFilePath = 'FilePath="AutoCharts.log"'
Global $hLoga1 = _LogaNew($sLogFilePath) ;create instance with custom settings
