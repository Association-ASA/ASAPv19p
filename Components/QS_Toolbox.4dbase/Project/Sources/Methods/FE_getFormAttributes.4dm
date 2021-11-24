//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 20/03/19, 07:44:27
// Paramètres
// ----------------------------------------------------
// $1 :  Form name (object)
// ----------------------------------------------------
// Méthode : FE_getFormAttributes
// Description
C_OBJECT:C1216($MyObject; $1)
C_TEXT:C284($formName)
C_LONGINT:C283($tableNum)

$MyObject:=$1
$formName:=$MyObject.formName
$tableNum:=$MyObject.tableNum
$MyObject.hauteur:=0
$MyObject.largeur:=0
$MyObject.nbpages:=1
$MyObject.largeurfixe:=False:C215
$MyObject.hauteurfixe:=False:C215
$MyObject.titre:=""

$methodCode:=New collection:C1472
$methodCode.push("C_Object:C1216($MyObject)C_TEXT:C284($formName;$QS_TBX_titre)")
$methodCode.push("C_LONGINT:C283($QS_TBX_largeur;$QS_TBX_hauteur;$QS_TBX_nbPages)")
$methodCode.push("C_BOOLEAN:C305($QS_TBX_largeurFixe;$QS_TBX_hauteurFixe)")
$methodCode.push("$formName:=\""+$formName+"\"")
$methodCode.push("C_POINTER:C301($1)")

If ($tableNum>0)
	$methodCode.push("C_POINTER:C301($ZTable)")
	$methodCode.push("$ZTable:=table:C252("+String:C10($tableNum)+")")
	$methodCode.push("FORM GET PROPERTIES:C674($Ztable->;$formName;$QS_TBX_largeur;$QS_TBX_hauteur;$QS_TBX_nbPages;$QS_TBX_largeurFixe;$QS_TBX_hauteurFixe;$QS_TBX_titre)")
Else 
	$methodCode.push("FORM GET PROPERTIES:C674($formName;$QS_TBX_largeur;$QS_TBX_hauteur;$QS_TBX_nbPages;$QS_TBX_largeurFixe;$QS_TBX_hauteurFixe;$QS_TBX_titre)")
End if 
$methodCode.push("OB SET:C1220($MyObject;\"hauteur\";$QS_TBX_hauteur;\"largeur\";$QS_TBX_largeur;\"nbpages\";$QS_TBX_nbPages;\"largeurfixe\";$QS_TBX_largeurFixe;\"hauteurfixe\";$QS_TBX_hauteurFixe;\"titre\";$QS_TBX_titre)")
$methodCode.push("$1->:=$MyObject")

$pathMethod:=METHOD Get path:C1164(Path project method:K72:1; "__QST_HOST_temporary_method"; *)
UPDT_WriteMethod($pathMethod; $methodCode.join("\r"))
METHOD SET ATTRIBUTE:C1192($pathMethod; Attribute shared:K72:10; True:C214; *)

If (OK=1)
	C_POINTER:C301($pointer)
	$pointer:=->$MyObject
	EXECUTE METHOD:C1007($pathMethod; $pointer; $pointer)
End if 

// Cleaning of the code set in __QST_HOST_temporary_method created method in the host base
$Method:=""
UPDT_WriteMethod($pathMethod; $Method)
METHOD SET ATTRIBUTE:C1192($pathMethod; Attribute shared:K72:10; False:C215; *)