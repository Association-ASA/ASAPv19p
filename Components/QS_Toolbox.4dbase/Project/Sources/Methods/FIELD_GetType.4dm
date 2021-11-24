//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 14/04/16, 07:43:58
  // ----------------------------------------------------
  // méthode : FIELD_GetType
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_LONGINT:C283($type_l;$1;$long;$2)
C_TEXT:C284($type_t;$0)

$type_l:=$1
$long:=$2
$type_t:=""

Case of 
		
	: ($type_l=Is alpha field:K8:1)
		
		If ($long>0)
			$type_t:="Alpha "+String:C10($long)
		Else 
			$type_t:="UUID"
		End if 
		
	: ($type_l=Is text:K8:3)
		$type_t:="Text"
		
	: ($type_l=Is real:K8:4)
		$type_t:="Real"
		
	: ($type_l=Is longint:K8:6)
		$type_t:="Longint"
		
	: ($type_l=Is integer:K8:5)
		$type_t:="Integer"
		
	: ($type_l=Is date:K8:7)
		$type_t:="Date"
		
	: ($type_l=Is time:K8:8)
		$type_t:="Time"
		
	: ($type_l=Is boolean:K8:9)
		$type_t:="Boolean"
		
	: ($type_l=Is BLOB:K8:12)
		$type_t:="BLOB"
		
	: ($type_l=Is picture:K8:10)
		$type_t:="Picture"
		
	: ($type_l=Is object:K8:27)
		$type_t:="Object"
		
		  // :($type_l=Est un je ne sais quoi)
		
	Else 
		
		$type_t:="type ??"+String:C10($type_l)
		
End case 

$0:=$type_t
