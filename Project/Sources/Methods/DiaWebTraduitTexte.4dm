//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/03/16, 11:08:59
  // ----------------------------------------------------
  // Méthode : WebTraduitTexte
  // Description
  // Fonction qui renvoi un texte dans la langue choisie
  // sur la base du texte français
  // Paramètres $1 = texte en français  $2=langue choisie ("A", "R" ou "F")
  // ----------------------------------------------------

C_LONGINT:C283($L)
C_TEXT:C284($Texte;$1;$Langue;$2;$0)
C_POINTER:C301($PtTb)
$Texte:=$1
$Langue:=$2
  // $Langue:=(Num($2="A")*"E")+(Num($2#"A")*$2)

$PtTb:=Get pointer:C304("<>TbTexte"+$Langue)
$L:=Find in array:C230(<>TbRefTexte;$Texte)
If ($L<0)
	  // TRACE
	$0:=""
Else 
	$0:=$PtTb->{$L}
End if 
