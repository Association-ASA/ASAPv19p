//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 23/07/16, 16:14:54
// ----------------------------------------------------
// Méthode : WebAffecteChampLangue
// Description
//   héritée de Ad3AffecteChampLangue
//
// Paramètres
// $1 = n° de la lésion
// $2 = radical du nom des tableaux de traduction de CM
// $3 valeur actuelle du champ en fraçais
// ----------------------------------------------------

$NumLésion:=$1
$PtE:=Get pointer:C304($2+LangueEnCours)
$L:=Find in array:C230(<>TbNumLesN; $NumLésion)
$Val:=Replace string:C233($PtE->{$L}; " ££"; "£")
$Val:=Replace string:C233($Val; "£"; " <br /> ")
$0:=$Val
