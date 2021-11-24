//%attributes = {"invisible":true,"preemptive":"capable","publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($1; $method)
C_COLLECTION:C1488($Keyword; $2)
C_LONGINT:C283($x)

$method:=$1
$Keyword:=$2

$x:=$Keyword.countValues($method.name)

Use (Storage:C1525.allMethods)
	$method.nbNested:=$x
End use 

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; $method.name)