//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 20/06/20, 19:11:25
// ----------------------------------------------------
// Méthode : QuizzGerePhotosSup
// Description
// Méthode qui recueille le message AJAX de la page Web
//  contenant la liste des photos supplémentaires 
// et renvoie le HTML à placer au bon endroit
// Paramètre : $1=message AJAX de type 
//  "photossup" + "RCP"+ ID de la réponse+ "£" +"liste des photo séparées par un espace"
// exemple photossupRCP2562£50661 asa2
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $LDiaColl; $LDiaQuizz; $LComDia)

$Mess:=$1
$Pos:=Position:C15("£"; $Mess)
$IDRéponseN:=Num:C11(Substring:C12($Mess; 1; ($Pos-1)))
$IDRéponseA:=String:C10($IDRéponseN)
$ListePhotos:=Substring:C12($Mess; ($Pos+1))
ARRAY TEXT:C222($TbNumProposePhotosA; 0)
ZTexteVersTableau($ListePhotos; ->$TbNumProposePhotosA; " ")
READ WRITE:C146([QuizzReponses:33])
QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]ID:1=$IDRéponseN)
ARRAY TEXT:C222($TbNumAncPhotosA; 0)
OB GET ARRAY:C1229([QuizzReponses:33]Argument:7; "TbNumPhoto"; $TbNumAncPhotosA)
ARRAY TEXT:C222($TbComAncPhotosA; 0)
OB GET ARRAY:C1229([QuizzReponses:33]Argument:7; "TbComPhoto"; $TbComAncPhotosA)

// Fabrication des nouveaux tableaux "TbNumPhoto" et "TbComPhoto" de [QuizzReponses]Argument
ARRAY TEXT:C222($TbNumNouvPhotosA; 0)
ARRAY TEXT:C222($TbComNouvPhotosA; 0)
$FT:=Size of array:C274($TbNumProposePhotosA)
For ($Salé; 1; $FT)
	$NumPhotoCourantA:=$TbNumProposePhotosA{$Salé}
	// la photo existe t'elle soit dans la collection soit ajoutée ?
	$LDiaColl:=Find in array:C230(<>TbDiaposNumOrdreDiapos; Num:C11($NumPhotoCourantA))
	$LDiaQuizz:=Find in array:C230(<>TbQuizzNumPhotoA; $NumPhotoCourantA)
	If ($LDiaColl>0) | ($LDiaQuizz>0)  // photo de la collection ou ajoutée
		APPEND TO ARRAY:C911($TbNumNouvPhotosA; $NumPhotoCourantA)
		// existe t'il déjà un commentaire noté pour cette photo ?
		$LComDia:=Find in array:C230($TbNumAncPhotosA; $NumPhotoCourantA)
		If ($LComDia>0)
			APPEND TO ARRAY:C911($TbComNouvPhotosA; $TbComAncPhotosA{$LComDia})
		Else 
			APPEND TO ARRAY:C911($TbComNouvPhotosA; "")
		End if 
	End if 
End for 
// Stockage des tableaux
OB SET ARRAY:C1227([QuizzReponses:33]Argument:7; "TbNumPhoto"; $TbNumNouvPhotosA)
OB SET ARRAY:C1227([QuizzReponses:33]Argument:7; "TbComPhoto"; $TbComNouvPhotosA)
SAVE RECORD:C53([QuizzReponses:33])


// fabrication du HTML du bloc
$THTML:=QuizzEcritHTMLBlocPhotosSup(->$TbNumNouvPhotosA; ->$TbComNouvPhotosA; $IDRéponseA)
// restitution de la liste proposée en liste validée
$Liste:=ZTableauVersTexte(->$TbNumNouvPhotosA; " ")
$Envoi:=$Liste+"£"+$THTML
WEB SEND TEXT:C677($Envoi)