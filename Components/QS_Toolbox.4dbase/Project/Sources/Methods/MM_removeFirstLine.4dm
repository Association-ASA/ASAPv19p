//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_POINTER:C301($1)
C_COLLECTION:C1488($lines)

$lines:=Split string:C1554($1->; "\r")
$lines.shift()
$1->:=$lines.join("\r")