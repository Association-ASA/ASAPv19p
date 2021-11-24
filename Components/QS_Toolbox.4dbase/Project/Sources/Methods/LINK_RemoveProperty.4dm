//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 26/11/17, 13:05:06
// ----------------------------------------------------
// Méthode : LINK_RemoveProperty
// Description
//  
//
// Paramètres
// ----------------------------------------------------
// $1 : property

ASSERT:C1129(Count parameters:C259=1; "Need 1 parameter")
ASSERT:C1129(Value type:C1509($1)=Is text:K8:3; "Need 1 parameter as TEXT")

C_TEXT:C284($1; $Param)
C_COLLECTION:C1488($coll; $pos)

$Param:=$1

If (Form:C1466.linkProperties#Null:C1517)
	$pos:=Form:C1466.linkProperties.indices("propName = :1"; $Param)
	If ($pos.length>0)
		$coll:=Form:C1466.linkProperties
		$coll.remove($pos[0])
		Form:C1466.linkProperties:=$coll
	End if 
End if 