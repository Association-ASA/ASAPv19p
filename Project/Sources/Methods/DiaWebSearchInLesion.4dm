//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 23/07/16, 22:48:32
// ----------------------------------------------------
// Méthode : WebSearchInLesion
// Description
// Méthode qui cherche les [Lesions]
// dans [Lesions]NomLesion, [Lesions]DescriptionTypeMacro
// et [Lesions]FicheReflexe
// Paramètres $1=Pt sur tableau adéquate de la langue concernée 
//                     $2 = critère de recherche
// ----------------------------------------------------

$L:=0
$PtTb:=$1
$Critère:=$2

$L:=Find in array:C230($PtTb->; $Critère; ($L+1))
While ($L>0)
	$NumLésionF:=<>TbNumLesN{$L}
	$L2:=Find in array:C230(<>TbLesionsNumLesion; $NumLésionF)
	$NumEnrLesion:=<>TbNumEnrLes{$L2}
	If (Find in array:C230(TbNumLesN; $NumEnrLesion)<0)
		APPEND TO ARRAY:C911(TbNumLesN; $NumEnrLesion)
	End if 
	$L:=Find in array:C230($PtTb->; $Critère; ($L+1))
End while 