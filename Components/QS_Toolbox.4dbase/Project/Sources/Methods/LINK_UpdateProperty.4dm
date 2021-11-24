//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 26/11/17, 13:08:16
  // ----------------------------------------------------
  // Méthode : LINK_UpdateProperty
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

ASSERT:C1129(Count parameters:C259=2;"Need 2 parameter")
ASSERT:C1129(Value type:C1509($1)=Is text:K8:3;"Need $1 parameter as TEXT")
ASSERT:C1129(Value type:C1509($2)=Is text:K8:3;"Need $2 parameter as TEXT")

C_TEXT:C284($1;$Param)
C_TEXT:C284($2;$Value)
C_COLLECTION:C1488($pos)
C_BOOLEAN:C305($ToAdd)

$Param:=$1
$Value:=$2

$ToAdd:=False:C215
If (Form:C1466.linkProperties#Null:C1517)
	$pos:=Form:C1466.linkProperties.indices("propName = :1";$Param)
	If ($pos.length>0)
		Form:C1466.linkProperties[$pos[0]].propValue:=$Value
	Else 
		$ToAdd:=True:C214
	End if 
Else 
	$ToAdd:=True:C214
End if 

If ($ToAdd)
	$pos:=Form:C1466.linkProperties
	$pos.push(New object:C1471("propName";$Param;"propValue";$Value))
	Form:C1466.linkProperties:=$pos
End if 
