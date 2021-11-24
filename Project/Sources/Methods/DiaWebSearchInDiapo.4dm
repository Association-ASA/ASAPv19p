//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 30/07/16, 13:23:12
  // ----------------------------------------------------
  // Méthode : WebSearchInDiapo
  // Description
  // Méthode qui chercher dans les tableaux
  //
  // Paramètres
  // ----------------------------------------------------

$L:=0
$PtTb:=$1
$Critère:=$2

$L:=Find in array:C230($PtTb->;$Critère;($L+1))
While ($L>0)
	$NumLésionF:=<>TbNumLesN{$L}
	$L2:=Find in array:C230(<>TbLesionsNumLesion;$NumLésionF)
	$NumEnrLesion:=<>TbNumEnrLes{$L2}
	If (Find in array:C230(TbNumLesN;$NumEnrLesion)<0)
		APPEND TO ARRAY:C911(TbNumLesN;$NumEnrLesion)
	End if 
	$L:=Find in array:C230($PtTb->;$Critère;($L+1))
End while 

$L:=0
$PtTb:=$1
$Critère:=$2
Repeat 
	$L:=Find in array:C230($PtTb->;$Critère;($L+1))
	If ($L>0)
		If (Find in array:C230(TbNumDiaN;<>TbNumEnrDia{$L})<0)
			APPEND TO ARRAY:C911(TbNumDiaN;<>TbNumEnrDia{$L})
		End if 
	End if 
Until ($L<0)