//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 21/06/20, 08:39:41
// ----------------------------------------------------
// Méthode : QuizzChangeComPhotosSup
// Description
// Méthode qui répercute les changements 
//  résultant d'une saisie dans un commentaire de photo sup
// Paramètre : $1=message AJAX 
//   type 'comsup'+'RCom'+id réponse+'_'+rang du commentaire+'§'+contenu du champ
//   exemple : comsupRCom2562_1§tu vois bien que c'est pas ça!
// ----------------------------------------------------
$Mess:=$1
$Pos:=Position:C15("_"; $Mess)
$IdRéponseN:=Num:C11(Substring:C12($Mess; 1; ($Pos-1)))
$Reste:=Substring:C12($Mess; ($Pos+1))
$Pos:=Position:C15("§"; $Reste)
$TexteCom:=Replace string:C233(Substring:C12($Reste; ($Pos+1)); "£"; <>ZCR)
$Rang:=Num:C11(Substring:C12($Reste; 1; ($Pos-1)))
READ WRITE:C146([QuizzReponses:33])
QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]ID:1=$IdRéponseN)
ARRAY TEXT:C222($TbComPhotosSup; 0)
OB GET ARRAY:C1229([QuizzReponses:33]Argument:7; "TbComPhoto"; $TbComPhotosSup)
$TbComPhotosSup{$Rang}:=$TexteCom
OB SET ARRAY:C1227([QuizzReponses:33]Argument:7; "TbComPhoto"; $TbComPhotosSup)
SAVE RECORD:C53([QuizzReponses:33])
