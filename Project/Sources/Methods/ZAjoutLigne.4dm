//%attributes = {"publishedWeb":true,"lang":"fr"}
// ZAjoutLigne 6.0 du 25/8/98
//  permet d'ajouter une valeur en fin de tableau
// $1= pointeur tableau alphanumérique   $2=valeur
C_POINTER:C301($1)
C_TEXT:C284($2)
$Pt:=$1
INSERT IN ARRAY:C227($Pt->; Size of array:C274($Pt->)+1)
$Pt->{Size of array:C274($Pt->)}:=$2