$file = @ScriptDir & "\index_TEMPLATE.html"

$text = FileRead ($file)

$tout1 = StringReplace ($text, '<script src="/scripts/chart2.js"></script></body></html>', '<script src="/scripts/TEST_REPLACE.js"></script></body></html>')
FileWrite (@ScriptDir & "\index.html", $tout1)
