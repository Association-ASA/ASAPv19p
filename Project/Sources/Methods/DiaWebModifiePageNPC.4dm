//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 06/01/17, 19:21:41
  // ----------------------------------------------------
  // Méthode : WebModifiePageNPC
  // Description
  // Permute les images des lésions resemblantes
  //
  // Paramètre $1 = message AJAX
  // type npcclic+ rang petite photo + n° petite photo + n° de la photo en place + n° photo référence
  // ----------------------------------------------------
$M:=$1
$Rang:=Substring:C12($M;8;1)
$NumPetitePhoto:=Substring:C12($M;9;5)
$NumNpcPhoto:=Substring:C12($M;14;5)
$NumRefPhoto:=Substring:C12($M;19)
$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos;Num:C11($NumRefPhoto))
$Lesion1:=<>TbDiaposNomLesion{$L}
$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos;Num:C11($NumPetitePhoto))
$Lesion2:=<>TbDiaposNomLesion{$L}
$FicheReflexe:=<>TbDiaposDiapoFicheReflexe{$L}
If ($FicheReflexe="")
	$L:=Find in array:C230(<>TbLesionsNomLesion;$Lesion2)
	$FicheReflexe:=<>TbLesionsFicheReflexe{$L}
End if 
  // CHERCHER([Diapositives];[Diapositives]NumOrdreDiapos=Num($NumRefPhoto))
$THTML:=""

  // HTML de la photo grande devenue petite
$THTML:=$THTML+"          <img src="+<>ZGuil+"PhotosAsaDia/"+$NumNpcPhoto+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+"photo"+$NumNpcPhoto+<>ZGuil+" title="+<>ZGuil+"photo"+$NumNpcPhoto+<>ZGuil
$L:=Find in array:C230(<>TbNumDia;Num:C11($NumNpcPhoto))
$THTML:=$THTML+" class="+<>ZGuil+"petitephoto"+<>ZGuil+" id="+<>ZGuil+"photonpc"+$Rang+<>ZGuil+" /><br />"
$THTML:=$THTML+"Photo n°"+$NumNpcPhoto+" : <i>"+DiaWebAfficheTriplette ($L;"F")+"</i>"+<>ZCR
$THTML:=$THTML+"£"  // premier séparateur des trois HTML

  // HTML de la photo petite devenue grande -> div id npcphoto
$THTML:=$THTML+"          <p class="+<>ZGuil+"adsoustitrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            Lésion à ne pas confondre"+<>ZCR
$THTML:=$THTML+"          </p>"+<>ZCR
$THTML:=$THTML+"          <div id="+<>ZGuil+"imagephotonpc"+<>ZGuil+" class="+<>ZGuil+"npcgrandephoto"+<>ZGuil+">"+<>ZCR
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1=Num:C11($NumPetitePhoto))
$ClassPhoto:="imageenliste "+(Num:C11([Diapositives:40]OrientationPhotoH:30)*"grandephotoH")+(Num:C11(Not:C34([Diapositives:40]OrientationPhotoH:30))*"grandephotoV")
$THTML:=$THTML+"            <img src="+<>ZGuil+"PhotosAsaDia/"+$NumPetitePhoto+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+$NumPetitePhoto+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+$ClassPhoto+<>ZGuil+" id="+<>ZGuil+"grandephotonpc"+<>ZGuil+" />"
$L:=Find in array:C230(<>TbNumDia;Num:C11($NumPetitePhoto))
$THTML:=$THTML+"<br />Photo n°"+$NumPetitePhoto+" : <i>"+DiaWebAfficheTriplette ($L;"F")+"</i>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR
$THTML:=$THTML+"          <div id="+<>ZGuil+"comphotonpc"+<>ZGuil+" class="+<>ZGuil+"npccomphoto"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"            <b>Description de la photographie</b><br />"+<>ZCR
$THTML:=$THTML+"            "+Replace string:C233([Diapositives:40]Commentaires:7;<>ZCR;"<br />")+<>ZCR
$THTML:=$THTML+"            <br />"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"adtitrenpc adtitre2e"+<>ZGuil+" id="+<>ZGuil+"npcfr2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              Fiche réflexe <img id="+<>ZGuil+"imagenpcfr2"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil+" width="+<>ZGuil+"10px"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"description descriptione"+<>ZGuil+" id="+<>ZGuil+"npcfr2t"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+$FicheReflexe+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"adtitrenpc adtitre2e"+<>ZGuil+" id="+<>ZGuil+"npcdl2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              Description type de la lésion <img id="+<>ZGuil+"imagenpcdl2"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil+" width="+<>ZGuil+"10px"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"description descriptione"+<>ZGuil+" id="+<>ZGuil+"npcdl2t"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+Replace string:C233([Diapositives:40]DescriptionTypeLesion:8;<>ZCR;"<br />")+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR+"£"
  // Le cadre récapitulatif
QUERY:C277([DiaData:45];[DiaData:45]XType:5="NPCdd";*)
QUERY:C277([DiaData:45];[DiaData:45]XNom:1=$NumRefPhoto;*)
QUERY:C277([DiaData:45];[DiaData:45]XAlpha:14=$NumPetitePhoto)
If (Records in selection:C76([DiaData:45])=1)
	$Diagno:=[DiaData:45]XTexte:7
Else 
	$test1:=$Lesion1+"/"+[Diapositives:40]NomLesion:4
	$test2:=[Diapositives:40]NomLesion:4+"/"+$Lesion1
	QUERY:C277([DiaData:45];[DiaData:45]XNom:1=$test1;*)
	QUERY:C277([DiaData:45]; | [DiaData:45]XNom:1=$test2)
	$Diagno:=[DiaData:45]XTexte:7
End if 
$THTML:=$THTML+"          Eléments de diagnostic différentiel : <br>"+<>ZCR
$THTML:=$THTML+"          "+Replace string:C233($Diagno;<>ZCR;"<br />")+<>ZCR
  // FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)
