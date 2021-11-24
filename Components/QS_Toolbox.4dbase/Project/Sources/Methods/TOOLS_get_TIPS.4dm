//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 23/03/19, 15:45:15
  // Paramètres
  // ----------------------------------------------------
  // $1 : longint, command number
  // $0 : text
  // ----------------------------------------------------
  // Méthode : TOOLS_get_TIPS
  // Description
  // 

C_LONGINT:C283($1;$token;$oneTip)
C_TEXT:C284($0;$txt)

$0:=""
ASSERT:C1129(Count parameters:C259=1;Current method name:C684+" expect 1 parameter (longint = token number)")
ASSERT:C1129(Type:C295($1)=Is longint:K8:6;"first parameter must be a LONGINT")

$token:=$1
C_COLLECTION:C1488($tips;$coll)
$tips:=New collection:C1472
$coll:=New collection:C1472
$tips:=TOOLS_get_TIPS_under_collection 
$coll:=$tips.indices("token =:1";$token)
If ($coll.length>0)
	For each ($oneTip;$coll)
		$txt:=$txt+$tips[$oneTip].tips+"\n"
	End for each 
	$0:="TIPS:\n"+$txt
End if 