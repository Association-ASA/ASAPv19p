//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/03/16, 17:48:30
  // ----------------------------------------------------
  // Méthode : WebTraduitLesion
  // Description
  // Fonction qui renvoie le nom de la lésion
  //  dans la langue désirée
  // Paramètres $1= nom de la lésion en Fr $2 = langue désirée
  // {$3} = chaine "<>Tb" de description   
  // ----------------------------------------------------

C_LONGINT:C283($L)
C_TEXT:C284($Texte;$1;$Langue;$2;$0)
C_POINTER:C301($PtTb)
$Texte:=$1
$Langue:=$2

$PtTb:=Get pointer:C304("<>TbNL"+$Langue)
$L:=Find in array:C230(<>TbNLF;$Texte)
If ($L<0)
	  // TRACE
	$0:=""
Else 
	$0:=$PtTb->{$L}
End if 


  //$Lesion:=$1
  //$Langue:=$2
  //Si ($Langue="F")
  //$0:=$Lesion
  //Sinon 
  //$L:=Chercher dans tableau(<>TbNLF;$Lesion)
  //$0:=<>TbNLE{$L}
  //Fin de si 
