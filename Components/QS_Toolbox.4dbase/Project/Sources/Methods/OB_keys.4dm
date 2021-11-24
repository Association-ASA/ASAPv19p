//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($1;$data)
C_COLLECTION:C1488($0;$result)
ARRAY TEXT:C222($tabProperties;0)

$data:=$1
$result:=New collection:C1472

OB GET PROPERTY NAMES:C1232($data;$tabProperties)
ARRAY TO COLLECTION:C1563($result;$tabProperties)
$0:=$result.copy()