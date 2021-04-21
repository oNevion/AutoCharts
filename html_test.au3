$file = @ScriptDir & "\helping.html"

$text = FileRead ($file)

$tout1 = StringReplace ($text, '<script src="/scripts/GLDB_I_EXPORT_10kChart.js"></script></body></html>', '<script src="/scripts/TEST_REPLACE.js"></script></body></html>')
FileWrite (@ScriptDir & "\helpingOut1.html", $tout1)
