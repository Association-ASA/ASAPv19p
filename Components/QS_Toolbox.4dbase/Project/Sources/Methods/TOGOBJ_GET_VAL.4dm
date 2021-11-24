//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // method: TOGOBJ_GET_VAL
  // retrieve value given object and property name
  // $1 (Object) - Toggle object
  // $2 (Text) - Proprety
  // $3 (Pointer) - Pointer to variable to contain result

C_OBJECT:C1216($togObj;$1)
C_TEXT:C284($prop;$2)
C_POINTER:C301($3)  // pointer to return value
C_LONGINT:C283($type)

$togObj:=$1
$prop:=$2

If (OB Is defined:C1231($togObj;$prop))
	$type:=OB Get type:C1230($togObj;$prop)
	$3->:=OB Get:C1224($togObj;$prop;$type)
End if 
