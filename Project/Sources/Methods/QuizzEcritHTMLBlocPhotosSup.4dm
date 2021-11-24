//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 21/06/20, 07:18:25
// ----------------------------------------------------
// Méthode : QuizzEcritHTMLBlocPhotosSup
// Description
// Méthode qui écrit le HTML
//   du bloc des photos illustrant la réponse
// Paramètres :
//       $1=Pt sur le tableau des numéros de photos
//       $2=Pt sur le tableau des commentaires de photos
//       $3=id de la réponse
// ----------------------------------------------------

$PtNumPhoto:=$1
$PtComPhoto:=$2
$IdRéponseA:=$3
$THTML:=""
$FT:=Size of array:C274($PtNumPhoto->)
For ($Salé; 1; $FT)  // Boucle sur les photos d'explication de la réponse
	$NumPhotoSupA:=$PtNumPhoto->{$Salé}
	$ComCourant:=$PtComPhoto->{$Salé}
	$L:=Find in array:C230(<>TbNumDia; Num:C11($NumPhotoSupA))
	$PhotoCollection:=($L>0)
	$THTML:=$THTML+"           <div class="+<>ZGuil+"comphotor"+<>ZGuil+"> "+<>ZCR
	$Title:="Photo n°"+$NumPhotoSupA
	If ($PhotoCollection)
		$NomPhotoSup:=$NumPhotoSupA
		$Triplette:=DiaWebAfficheTriplette($L; "F")  // la triplette
	Else   // Photo pour le quizz
		$LDiaQuizz:=Find in array:C230(<>TbQuizzNumPhotoA; $NumPhotoSupA)
		$NomPhotoSup:="Q"+<>TbQuizzStructurePhoto{$LDiaQuizz}+String:C10(<>TbQuizzNumPhotoN{$LDiaQuizz}; "00000")
		$Triplette:="Photo Quizz ajoutée"
	End if 
	$THTML:=$THTML+"            <img src="+<>ZGuil+"PhotosAsaDia/"+$NomPhotoSup+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil
	$THTML:=$THTML+" title="+<>ZGuil+$Title+<>ZGuil+" width="+<>ZGuil+"180px"+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil+" />"+<>ZCR
	
	$THTML:=$THTML+"             <p class="+<>ZGuil+"petittexter"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"              "+$Title+" :<br />"+$Triplette+<>ZCR
	$THTML:=$THTML+"             </p>"+<>ZCR
	$THTML:=$THTML+"           </div>"+<>ZCR
	$THTML:=$THTML+"           <div class="+<>ZGuil+"comphotor"+<>ZGuil+"> <!-- le commentaire souhaité de la photo 1    -->"+<>ZCR
	$THTML:=$THTML+"              <span class="+<>ZGuil+"petittexter"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"               Commentaire à faire figurer sous la photo "+$NumPhotoSupA+" lors du questionnaire :"+<>ZCR
	$THTML:=$THTML+"              </span>"+<>ZCR
	$THTML:=$THTML+"              <br />"+<>ZCR
	$THTML:=$THTML+"              <textarea  id="+<>ZGuil+"RCom"+$IdRéponseA+"_"+String:C10($Salé)+<>ZGuil+" class="+<>ZGuil+"textareaphotor"+<>ZGuil+">"
	$THTML:=$THTML+$ComCourant+"</textarea>"+<>ZCR
	$THTML:=$THTML+"           </div>"+<>ZCR
End for 
$0:=$THTML