//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 26/04/19, 08:03:39
  // ----------------------------------------------------
  // Méthode : WebQuizzEcritHTMLPhotos
  // Description
  //   Méthode qui écrit le HTML des photos affichées
  //   pour une question donnée
  // Paramètre : $1 = ID de la question (numérique)
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$L;$L2)

$IDQuestionN:=$1
$IDQuestionA:=String:C10($IDQuestionN)
QUERY:C277([QuizzPhotos:36];[QuizzPhotos:36]IDQuestion:2=$IDQuestionN)  // recherche d'éventuelles photos
SELECTION TO ARRAY:C260([QuizzPhotos:36]CodePhoto:5;$TbCodePhoto\
;[QuizzPhotos:36]CommentairePhoto:4;$TbComPhoto\
;[QuizzPhotos:36]ID:1;$TbIdPhoto\
;[QuizzPhotos:36]NumPhotoA:3;$TbNumPhotoA)
SORT ARRAY:C229($TbCodePhoto;$TbComPhoto;$TbNumPhotoA;$TbIdPhoto;>)
$THTML:=""

  //  champ liste des photos : pour tout le monde
$THTML:=$THTML+"       <p class="+<>ZGuil+"champlistephoto"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <b>Entrer les n° des photos associées</b> <span class="+<>ZGuil+"textenews"+<>ZGuil+"> (séparés par un espace)</span>"+<>ZCR
$THTML:=$THTML+"        <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"QP"+$IDQuestionA+<>ZGuil+" size="+<>ZGuil+"40px"+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"champlistephotossup"+<>ZGuil+" value="+<>ZGuil+ZTableauVersTexte (->$TbNumPhotoA;" ")+<>ZGuil+" /> "+<>ZCR
$THTML:=$THTML+"       </p>"+<>ZCR
  // les photos si elles existent

$FT:=Size of array:C274($TbNumPhotoA)
For ($Salé;1;$FT)
	$THTML:=$THTML+"       <div class="+<>ZGuil+"blocphoto"+<>ZGuil+" id="+<>ZGuil+"QP"+String:C10($TbIdPhoto{$Salé})+<>ZGuil+">"+<>ZCR
	  // la photo et sa triplette
	$THTML:=$THTML+"         <div class="+<>ZGuil+"photoquizz"+<>ZGuil+">"+<>ZCR
	$Title:="Photo n°"+$TbNumPhotoA{$Salé}
	$L:=Find in array:C230(<>TbNumDia;Num:C11($TbNumPhotoA{$Salé}))
	If ($L>0)  // Photo de la collection
		$THTML:=$THTML+"          <img src="+<>ZGuil+"PhotosAsaDia/"+$TbNumPhotoA{$Salé}+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"          <p class="+<>ZGuil+"petittexte"+<>ZGuil+">"+<>ZCR
		  // la triplette
		$Triplette:=DiaWebAfficheTriplette ($L;"F")
	Else   // Photo pour le quizz
		$L:=Find in array:C230(<>TbQuizzNumPhotoA;$TbNumPhotoA{$Salé})
		$THTML:=$THTML+"          <img src="+<>ZGuil+"PhotosAsaDia/"+<>TbQuizzNumPhotoWA{$L}+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"          <p class="+<>ZGuil+"petittexte"+<>ZGuil+">"+<>ZCR
		$Triplette:="Photo Quizz ajoutée"
	End if 
	$THTML:=$THTML+"           Photo n° "+$TbNumPhotoA{$Salé}+" :<br />"+$Triplette+"<br /><br /><br /><br /><br /><br />"+<>ZCR
	$THTML:=$THTML+"          </p>"+<>ZCR
	$THTML:=$THTML+"         </div>"+<>ZCR
	$THTML:=$THTML+"        <!-- le commentaire souhaité    -->"+<>ZCR
	$THTML:=$THTML+"        <div class="+<>ZGuil+"photoquizz"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          Commentaire à faire figurer sous la photo "+$TbNumPhotoA{$Salé}+" lors du questionnaire :"+<>ZCR
	$THTML:=$THTML+"          <br />"+<>ZCR
	$THTML:=$THTML+"          <textarea  id="+<>ZGuil+"PC"+String:C10($TbIdPhoto{$Salé})+<>ZGuil+" class="+<>ZGuil+"textareaphoto"+<>ZGuil+">"+$TbComPhoto{$Salé}+"</textarea>"+<>ZCR
	$THTML:=$THTML+"         </div>"+<>ZCR
	$THTML:=$THTML+"       </div>"+<>ZCR2
End for 
$0:=$THTML