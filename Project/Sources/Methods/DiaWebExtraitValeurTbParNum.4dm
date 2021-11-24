//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 11/06/16, 07:02:53
  // ----------------------------------------------------
  // Méthode : WebExtraitValeurTbParNum
  // Description
  // Fonction qui permet de renvoyer la valeur d'une page Web par le nom du cham``
  // $1= n° (entier long) généralement n° de diapo
  // {$2} = Pt sur tableau des n° et TbNoms si non mentionné
  // {$3} = Pt sur tableau des valeurs et TbValeurs si non mentionné
  // ---------------------------------------------------- 
C_TEXT:C284($Texte)
C_POINTER:C301($2;$3)
C_LONGINT:C283($1;$L)

If (Count parameters:C259=3)
	$PtNom:=$2
	$PtValeur:=$3
Else 
	$PtNom:=->TbNoms
	$PtValeur:=->TbValeurs
End if 
$L:=Find in array:C230($PtNom->;$1)
If ($L<0)
	$0:=""
Else 
	$0:=$PtValeur->{$L}
End if 
