//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 04/05/19, 06:32:44
  // ----------------------------------------------------
  // Méthode : QuizzOutilTableauVersChapitre
  // Description
  //   Méthode qui transforme un tableau en chapitre  
  // Paramètre : $1:= Pt vers tableau
  // ----------------------------------------------------

$PtTb:=$1
ARRAY TEXT:C222($PtTb->;0)
$Pos:=Position:C15(".";$Chapitre)
While ($Pos>0)
	APPEND TO ARRAY:C911($PtTb->;Substring:C12($Chapitre;1;($Pos-1)))
	$Pos:=Position:C15(".";$Chapitre)
	$Chapitre:=Substring:C12($Chapitre;($Pos+1))
End while 