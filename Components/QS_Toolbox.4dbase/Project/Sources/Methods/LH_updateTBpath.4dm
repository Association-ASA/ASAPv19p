//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 18/11/2021
// ----------------------------------------------------
// Méthode : LH_updateTBpath
// Paramètres
// ----------------------------------------------------
// $0 = sublist
// $1 = pointer on $list
// $2 = path to icon to LH icon 
// $3 = Text to add to the List $1->
// ----------------------------------------------------
// Description
// 

C_POINTER:C301($1)
C_TEXT:C284($2; $3)

$sep:=":"
$subList:=New list:C375
QS_TBX_LH_counter:=QS_TBX_LH_counter+1
If (QS_TBX_LH_counter=0)  // To avoid a value of 0
	QS_TBX_LH_counter:=QS_TBX_LH_counter+1
End if 
APPEND TO LIST:C376($1->; $3; QS_TBX_LH_counter; $subList; False:C215)
SET LIST ITEM PROPERTIES:C386($1->; QS_TBX_LH_counter; False:C215; Plain:K14:1; "path:/RESOURCES/"+$2)
$0:=$subList


