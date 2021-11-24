//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
var $1; $2; $ent; $result : Object

$ent:=$1
If ($ent#Null:C1517)
	$result:=$2.syntax[$ent.name]
	$ent.isThread:=$result.threadSafe
	$ent.syntax:=$result.syntax
End if 
