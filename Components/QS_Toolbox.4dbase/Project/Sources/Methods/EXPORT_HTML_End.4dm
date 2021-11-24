//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
#DECLARE->$html : Text
var $col : Collection

$col:=New collection:C1472
$col.push("\r")
$col.push("</div>")
$col.push("</div>")
$col.push("<div class=\"content\">")
$col.push("<iframe scrolling=yes src=\"\" name=\"methodFrame\" width=\"100%\" height=\"100%\"></iframe>")
$col.push("</div>")
$col.push("</body>")
$col.push("</html>")
$html:=$col.join("\r")
