//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 07/03/19, 10:54:15
// ----------------------------------------------------
// Méthode : LH_updateTB
// Paramètres
// ----------------------------------------------------
// $0 = sublist number
// $1 = pointer on $list
// $2 = pointer to LH icon 
// $3 = Text to add to the List $1->
// ----------------------------------------------------
// Description
// 

C_POINTER:C301($1)  // hierarchic list
C_POINTER:C301($2)  // icon
C_TEXT:C284($3)  // Text to add to the List $1->

$sep:=":"
$subList:=New list:C375
QS_TBX_LH_counter:=QS_TBX_LH_counter+1
If (QS_TBX_LH_counter=0)  // To avoid a value of 0
	QS_TBX_LH_counter:=QS_TBX_LH_counter+1
End if 
APPEND TO LIST:C376($1->; $3; QS_TBX_LH_counter; $subList; False:C215)
// TODO
//SET LIST ITEM PROPERTIES($1->; QS_TBX_LH_counter; False; Plain; "path:/RESOURCES/"+$2)  // Idea to develop
//SET LIST ITEM PARAMETER($1->; 0; Associated standard action; "fontSize?value=10pt")

SET LIST ITEM ICON:C950($1->; 0; $2->)
$0:=$subList