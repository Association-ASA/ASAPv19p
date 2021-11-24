//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 19/06/19, 11:53:19
  // Paramètres
  // ----------------------------------------------------
  // $0 : text
  // $1 : object
  // $2 : property
  // $3 : boolean -> expression of the boolean (False = "short (F/T)" / True = "complete (False/True)")
  // ----------------------------------------------------
  // Méthode : EXPORT_addBoolFromObject
  // Description
  // 


C_OBJECT:C1216($1)
C_TEXT:C284($0;$2;$wrong;$correct)
C_BOOLEAN:C305($3)

$tmp:=""
If (OB Is defined:C1231($1;$2))
	$Tmp:=$1[$2]
End if 
If ($3)
	$wrong:=String:C10(False:C215)
	$correct:=String:C10(True:C214)
Else 
	$wrong:=""
	$correct:="X"
End if 

$0:=Choose:C955((($Tmp="") | ($Tmp="False"));$wrong;$correct)