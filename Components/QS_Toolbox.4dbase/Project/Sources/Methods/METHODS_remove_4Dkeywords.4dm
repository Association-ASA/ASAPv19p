//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($1;$ent;$keyW)

ASSERT:C1129(Count parameters:C259=1;Current method name:C684+" expect 1 parameter (Object).")
ASSERT:C1129(Type:C295($1)#Is object:K8:27;"First parameter must be an object.")
$ent:=$1
$language:=Config_getLanguage 

For each ($keyW;Storage:C1525.keywords)
	$ent.clearCode:=Replace string:C233($ent.clearCode;$keyW[$language];"")
End for each 