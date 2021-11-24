//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($1;$pid)

If (Count parameters:C259>=1)
	$pid:=$1
Else 
	$pid:=Current process:C322
End if 

BRING TO FRONT:C326($pid)