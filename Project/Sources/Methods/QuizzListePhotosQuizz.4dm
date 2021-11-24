//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 16/06/20, 05:37:50
  // ----------------------------------------------------
  // Méthode : QuizzListePhotosQuizz
  // Description
  // Méthode qui affiche la liste des photos
  //  ajoutées par la structure
  //  Paramètres : $1 = sigle de la structure concernée
  //               {$2} = valeur choisie dans le LiPUM
  //               {$3} = type de valeur choisie dans le LiPUM
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$TT;$FT)
$Structure:=$1
If (Count parameters:C259=3)
	$Recalcul:=True:C214
	ValeurPUMLi:=$2
	TypeValeurA:=$3
Else 
	$Recalcul:=False:C215
	ValeurPUMLi:=""
	TypeValeurA:=""
End if 
  // Contenu de la liste
SELECTION TO ARRAY:C260([DiaData:45]XNom:1;$TbNomFichierPhoto\
;[DiaData:45]ID:12;TbUUIDPhoto\
;[DiaData:45]XEntier:2;$TbNumPhoto\
;[DiaData:45]XTexte:7;TbEspecePhoto\
;[DiaData:45]XTexteSup:8;TbLesionPhoto\
;[DiaData:45]XValeur:4;TbOrientationPhoto\
;[DiaData:45]XDate:3;$TbDatePhoto)
LONGINT ARRAY FROM SELECTION:C647([DiaData:45];$TbNumEnrPaniers)

$FT:=Size of array:C274($TbNomFichierPhoto)
$BlancInsécable:=" "
If (Sum:C1(TbOrientationPhoto)=0) & (Not:C34($Recalcul))
	QuizzMAJPhotosOriginales 
End if 
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1<80000)
DISTINCT VALUES:C339([Diapositives:40]Espece:3;$TbEspèce)
DISTINCT VALUES:C339([Diapositives:40]NomLesion:4;$TbNomLésion)

  // Ecrivons le HTML
$THTML:=""
$THTML:=$THTML+"    <div id="+<>ZGuil+"zonephoto"+<>ZGuil+" class="+<>ZGuil+"tablehistoire"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"<i>Pour ajouter une photographie, merci glisser son fichier dans le dossier DropBox "
$THTML:=$THTML+<>ZGuil+"Photos quizz"+$Structure+<>ZGuil+" qui vous a été communiqué.</i>"
$THTML:=$THTML+"    <p id="+<>ZGuil+"champlistephoto"+<>ZGuil+" class="+<>ZGuil+"champlistephoto"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+QuizzEcritHTMAvantTableau ($Structure)  // Les PUM espèce et lésion
$THTML:=$THTML+"    </p>"+<>ZCR

$THTML:=$THTML+"     <table class="+<>ZGuil+"tablehistoire"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <tr class="+<>ZGuil+"tbhistoireet"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"10%"+<>ZGuil+">OK</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15%"+<>ZGuil+">Date</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15%"+<>ZGuil+">N°</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15%"+<>ZGuil+">Fichier importé</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15%"+<>ZGuil+">Espèce</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15%"+<>ZGuil+">Lésion</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"20%"+<>ZGuil+">Photo</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"10%"+<>ZGuil+">Supprimer</td>"+<>ZCR
$THTML:=$THTML+"      </tr>"+<>ZCR

For ($Salé;1;$FT)
	$NomPhoto:=$Structure+String:C10($TbNumPhoto{$Salé})
	$UUIDDiaData:=TbUUIDPhoto{$Salé}
	  //$DisplayNone:=Num($Recalcul)*(" style="+<>ZGuil+"display: none;"+<>ZGuil)
	$THTML:=$THTML+"      <tr class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+" id="+<>ZGuil+"tr"+$UUIDDiaData+<>ZGuil+">"+<>ZCR
	$BaC:="<input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$BaC:=$BaC+" id="+<>ZGuil+"bacok"+String:C10($Salé)+<>ZGuil+" name="+<>ZGuil+"OK"+<>ZGuil+" value="+<>ZGuil+$UUIDDiaData+<>ZGuil+" />"
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+$BaC+"</td>"+<>ZCR  // OK
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+String:C10($TbDatePhoto{$Salé})+"</td>"+<>ZCR  // Date
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+$NomPhoto+"</td>"+<>ZCR  //N°
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+$TbNomFichierPhoto{$Salé}+"</td>"+<>ZCR  // Fichier importé
	$PUM:=QuizzEcritHTMLPUMPhotoSup (->$TbEspèce;"espèce";$Salé)
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+$PUM+"</td>"+<>ZCR  // Espèce
	$PUM:=QuizzEcritHTMLPUMPhotoSup (->$TbNomLésion;"lésion";$Salé)
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+$PUM+"</td>"+<>ZCR  // Lésion
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"
	$Title:="Image de la photo "+$NomPhoto
	$Source:="PhotosAsaDia/Q"+$Structure+String:C10($TbNumPhoto{$Salé};"00000")+"i.jpg"
	$THTML:=$THTML+"          <img src="+<>ZGuil+$Source+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+" class="+<>ZGuil+"imagequizz"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"150px"+<>ZGuil+" />"+<>ZCR  // Photo
	$THTML:=$THTML+"       </td>"+<>ZCR  // Photo
	$BaC:="<input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"caseko"+<>ZGuil
	$BaC:=$BaC+" id="+<>ZGuil+$UUIDDiaData+<>ZGuil+" name="+<>ZGuil+"KO"+<>ZGuil+" />"
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+$BaC+"</td>"+<>ZCR  // KO
	$THTML:=$THTML+"      </tr>"+<>ZCR
End for 

$THTML:=$THTML+"      </table>"+<>ZCR
$THTML:=$THTML+"      <br /><br /><br />"+<>ZCR
$THTML:=$THTML+"   </div>"+<>ZCR

$0:=$THTML
  //  FIXER TEXTE DANS CONTENEUR($THTML)
