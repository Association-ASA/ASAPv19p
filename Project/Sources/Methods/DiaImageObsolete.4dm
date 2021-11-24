//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 09/05/20, 19:16:45
// ----------------------------------------------------
// Méthode : Ad3ImageObsolete
// Description
// Méthode qui permet de vérifier que l'image est bien
//   compatible avec AsaDia ( = jpg)
// Paramètre : $1 = image
// ----------------------------------------------------
C_PICTURE:C286($1; $Image)
$Image:=$1
ARRAY TEXT:C222($tabCodecsI; 0)
GET PICTURE FORMATS:C1406($Image; $tabCodecsI)
$0:=(Find in array:C230($tabCodecsI; ".jpg")<0)