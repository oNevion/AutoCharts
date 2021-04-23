#include <Array.au3>
#include <SQLite.au3>

_SQLite_Startup() ; Load the DLL
If @error Then Exit MsgBox(0, "Error", "Unable to start SQLite, Please verify your DLL")

Local $sDatabase = @ScriptDir & 'databases\acx.db'
Local $hDatabase = _SQLite_Open($sDatabase) ; Create the database file and get the handle for the database

_SQLite_Exec($hDatabase, 'CREATE TABLE ACX_Charts (name, filedir);') ; CREATE a TABLE with the name "People"
_SQLite_Exec($hDatabase, 'INSERT INTO ACX_Charts VALUES ("ACX 10k Chart", "Files/ACX/ACX_10k.js");') ; INSERT "Timothy Lee" into the "People" TABLE
_SQLite_Exec($hDatabase, 'INSERT INTO ACX_Charts VALUES ("ACX Annual Return Graph", "Files/ACX/ACX_AnnualReturn.js");') ; INSERT "John Doe" into the "People" TABLE

Local $aResult, $iRows, $iColumns ; $iRows and $iColuums are useless but they cannot be omitted from the function call so we declare them

_SQLite_GetTable2d($hDatabase, 'SELECT * FROM ACX_Charts;', $aResult, $iRows, $iColumns) ; SELECT everything FROM "ACX_Charts" TABLE and get the $aResult
_ArrayDisplay($aResult, "Results from the query")

_SQLite_Close($hDatabase)
_SQLite_Shutdown()