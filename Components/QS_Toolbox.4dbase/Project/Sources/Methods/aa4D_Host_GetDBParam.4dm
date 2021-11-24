//%attributes = {"shared":true,"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent","published4DMobile":{"scope":"none"}}
#DECLARE($selecteur : Integer)->$result : Variant

$result:=-1  // Erreur, pas de paramètre
If (Count parameters:C259>0)
	$result:=Get database parameter:C643($selecteur)  // NOt preemptive
End if 