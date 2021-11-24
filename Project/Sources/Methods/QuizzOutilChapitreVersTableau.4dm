//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 04/05/19, 06:32:44
// ----------------------------------------------------
// Méthode : QuizzOutilChapitreVersTableau
// Description
//   Méthode qui transforme un chapitre en tableau texte
// Paramètres : $1:= chapitre,    $2= Pt vers tableau
// ----------------------------------------------------

$Chapitre:=$1
$PtTb:=$2
ARRAY TEXT:C222($PtTb->; 0)
$Pos:=Position:C15("."; $Chapitre)
While ($Pos>0)
	APPEND TO ARRAY:C911($PtTb->; Substring:C12($Chapitre; 1; ($Pos-1)))
	$Chapitre:=Substring:C12($Chapitre; ($Pos+1))
	$Pos:=Position:C15("."; $Chapitre)
End while 
If ($Chapitre#"")
	APPEND TO ARRAY:C911($PtTb->; $Chapitre)
End if 