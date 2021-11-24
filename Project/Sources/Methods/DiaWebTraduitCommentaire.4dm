//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 31/03/16, 16:53:27
// ----------------------------------------------------
// Méthode : WebTraduitCommentaire
// Description
//   Permet de récupérer le commentaire 
//   dans la langue courante
// Paramètres : $1=N° de la photo  
//                       $2 = initiale de la langue 
// ----------------------------------------------------
C_TEXT:C284($0; $2; $Langue)
C_LONGINT:C283($1; $NumDiaN; $L)
C_POINTER:C301($PtTb)

$NumDiaN:=$1
$Langue:=$2
$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos; $NumDiaN)
$PtTb:=Get pointer:C304("<>TbDiaposCom"+$Langue)
$0:=$PtTb->{$L}