rem  XLS_To_CSV.vbs
rem =============================================================
rem  convert all NON-empty worksheets in an Excel file to csv
rem  CSV file names will default to Sheet names
rem  output folder defaults to the folder where the script resides or
rem  if path is specified with the input file, that path is used
rem  
rem  input parameter 1:  Excel path\file in argument 1 
rem                     (if path is not specified, the current path is defaulted)
rem  
rem ============================================================

Dim strExcelFileName
Dim strCSVFileName

strExcelFileName = WScript.Arguments.Item(0) 'file name to parses

rem get path where script is running
Set fso = CreateObject ("Scripting.FileSystemObject") 
strScript = Wscript.ScriptFullName
strScriptPath = fso.GetAbsolutePathName(strScript & "\..")

rem If the Input file is NOT qualified with a path, default the current path
LPosition = InStrRev(strExcelFileName, "\")
if LPosition = 0 Then 'no folder path
strExcelFileName = strScriptPath & "\" & strExcelFileName
	strScriptPath = strScriptPath & "\"
else 'there is a folder path, use it for the output folder path also
	strScriptPath = Mid(strExcelFileName, 1, LPosition)
End If
rem msgbox LPosition & " - " & strExcelFileName & " - " & strScriptPath  ' use this for debugging

Set objXL = CreateObject("Excel.Application")
Set objWorkBook = objXL.Workbooks.Open(strExcelFileName)
objXL.DisplayAlerts = False

rem loop over worksheets
For Each sheet In objWorkBook.Sheets
'only saveAS sheets that are NOT empty
	if objXL.Application.WorksheetFunction.CountA(sheet.Cells) <> 0 And sheet.Tab.ColorIndex = 3 Then
rem             sheet.Rows(1).delete  ' this will remove Row 1 or the header Row
		sheet.SaveAs strScriptPath & sheet.Name & ".csv", 6 'CSV
End If
 Next

rem clean up
objWorkBook.Close
objXL.quit
Set objXL = Nothing
Set objWorkBook = Nothing
Set fso = Nothing

rem end script