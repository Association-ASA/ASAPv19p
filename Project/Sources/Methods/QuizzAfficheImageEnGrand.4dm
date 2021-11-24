//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 03/01/16, 08:55:51
  // ----------------------------------------------------
  // Méthode : QuizzAfficheImageEnGrand
  // Description
  // Crée une image occupant tout l'écran avec les boutons
  // permettant un complément d'information
  // et les flèches d'explication
  // Paramètre : $1 = chaine AJAX de type suivant
  // si à partir de l'espace création :
  // "quizzaffichepleinecranPhotosAsaDia/"+n° de l'image+"_"+Largeur Ecran+"_"+Hauteur Ecran+"_"+idsuivi
  // si à partir de l'utilisation
  // quizzaffichepleinecranPhotosAsaDia/ImagesQuizz/imagequizz355i.jpg_1449_793_ASAA80DC070FD674F15BB1016312C610432
  // ----------------------------------------------------

C_LONGINT:C283($Pos;$NumEnrImage;$NumImageN)


$Mess:=$1
$Langue:="F"
$Prefixe:="quizzaffichepleinecranPhotoAsadia/"
$Mess2:=Substring:C12($Mess;Length:C16($Prefixe)+2)  // quizzaffichepleinecranPhotoAsadia/
$ModeUtilisation:=($Mess2="@quizz@")

ARRAY TEXT:C222($TbMess;0)
If ($ModeUtilisation)
	$Mess2:=Substring:C12($Mess;48)  //
	ZTexteVersTableau ($Mess;->$TbMess;"_")
	If (Size of array:C274($TbMess)=3)
		APPEND TO ARRAY:C911($TbMess;"")
	End if 
Else 
	$Pos:=Position:C15("/";$Mess)
	$Mess:=Substring:C12($Mess;($Pos+1))  // élimination de quizzaffichepleinecranPhotoAsadia/
	ZTexteVersTableau ($Mess;->$TbMess;"_")
	  // $TbMess = 1:Nom de l'image; 2:largeur écran; 3:Hauteur écran; 4:Id de suivi
End if 

$NumImageN:=Num:C11($TbMess{1})
$PhotoQuizzB:=(Find in array:C230(<>TbDiaposNumOrdreDiapos;$NumImageN)<0)  // booléen de photo ajoutée
If ($PhotoQuizzB) | ($ModeUtilisation)
	$Pos:=Position:C15(".";$TbMess{1})
	$NumImageN:=0
	$NumImageA:=Substring:C12($TbMess{1};1;($Pos-2))
Else 
	$NumImageA:=String:C10($NumImageN)
End if 
If ($ModeUtilisation)  // demande depuis le questionnaire
	  // $Pos:=Position("_";$Mess)
	  //$NumEnrImage:=Num(Sous chaîne($Mess;1;($Pos-1)))
	$NumEnrImage:=Num:C11($TbMess{1})
	GOTO RECORD:C242([Diapositives:40];$NumEnrImage)
	$NumImageA:=String:C10([Diapositives:40]NumOrdreDiapos:1)
Else   // demande depuis l'espace création
	If (Not:C34($PhotoQuizzB))
		QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1=$NumImageN)
		QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
		If ([Diapositives:40]DiapoFicheReflexe:31="")
			$FR:=[DiaLesions:44]FicheReflexe:12
		Else 
			$FR:=[Diapositives:40]DiapoFicheReflexe:31
		End if 
		If ([Diapositives:40]NPC:14="")
			$NPC:=[DiaLesions:44]NPC:9
		Else 
			$NPC:=[Diapositives:40]NPC:14
		End if 
		$RG:=[Diapositives:40]ReferenceReglementaireUE:27
		$BF:=[Diapositives:40]BlobFleches:21
		$NomEspece:=[Diapositives:40]Espece:3
		$NomOrgane:=[Diapositives:40]Organe:2
		$NomLésion:=[Diapositives:40]NomLesion:4
	End if 
End if 
$Largeur:=$TbMess{2}+"px"
$Hauteur:=$TbMess{3}+"px"
$IdSuivi:=$TbMess{4}

$THTML:="<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+"  <head>"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude HeaderAsaDia.shtml-->"+<>ZCR
$THTML:=$THTML+"    <title>Photo n°"+$NumImageA+"</title>"+<>ZCR
$THTML:=$THTML+"  </head>"+<>ZCR2

$THTML:=$THTML+"  <body>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"boutonsphotoengrand"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"languecourante"+<>ZGuil+" value="+<>ZGuil+$Langue+<>ZGuil+" />"+<>ZCR

If ($ModeUtilisation=False:C215) & ($PhotoQuizzB=False:C215)
	  // Description de la photographie
	$Title:=DiaWebTraduitTexte ("Description macroscopique";$Langue)
	$THTML:=$THTML+"     <img id="+<>ZGuil+"cphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+"  src="+<>ZGuil+"images/IconeComRepos.png"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	
	  // Fiche réflexe
	$Title:=DiaWebTraduitTexte ("Fiche reflexe";$Langue)
	If (Length:C16($FR)>0)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"fphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+"src="+<>ZGuil+"images/IconeFreRepos.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
	
	  // Description-type de la lésion
	$Title:=DiaWebTraduitTexte ("Description de la lésion";$Langue)
	$THTML:=$THTML+"     <img id="+<>ZGuil+"lphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeLesRepos.png"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	
	  //Si ($Langue="F")
	  // Ne pas confondre
	If (Length:C16($NPC)>0)
		$Title:=DiaWebTraduitTexte ("Ne pas confondre";$Langue)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"nphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeNpcRepos.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
	  //Fin de si
	
	  // Réglementation
	$Title:=DiaWebTraduitTexte ("Références réglementaires";$Langue)
	If (Length:C16($RG)>0)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"rphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeRegRepos.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
	
	If ($Langue="F")
		  // texte d'anapath
		QUERY:C277([DiaTextesWebParagraphes:37];[DiaTextesWebParagraphes:37]NomEspece:2=$NomEspece;*)
		QUERY:C277([DiaTextesWebParagraphes:37]; & [DiaTextesWebParagraphes:37]NomOrgane:3=$NomOrgane;*)
		QUERY:C277([DiaTextesWebParagraphes:37]; & [DiaTextesWebParagraphes:37]NomLesion:10=$NomLésion)
		If (Records in selection:C76([DiaTextesWebParagraphes:37])>0)
			$THTML:=$THTML+"     <img id="+<>ZGuil+"sphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+"src="+<>ZGuil+"images/IconeComReposr.png"+<>ZGuil
			$THTML:=$THTML+" alt="+<>ZGuil+"Voir le cours d'anapath spécial"+<>ZGuil+" title="+<>ZGuil+"Voir le cours d'anapath spécial"+<>ZGuil+">"+<>ZCR
		End if 
	End if 
	
	$Title:="Placer les explications"
	If (BLOB size:C605([Diapositives:40]BlobFleches:21)>0)  // les éventuelles flèches
		$THTML:=$THTML+"     <img id="+<>ZGuil+"flechephotoengrand"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeFleRepos.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
	
Else   // Gestion par l'internaute : notons le n° de la photo affiché en grand
	If ($PhotoQuizzB=False:C215)
		READ WRITE:C146([QuizzSuivi:32])
		QUERY:C277([QuizzSuivi:32];[QuizzSuivi:32]IdSessionVisiteur:9=$IDSuivi)
		ORDER BY:C49([QuizzSuivi:32];[QuizzSuivi:32]Ordre:8;<)
		ARRAY TEXT:C222($TbNumPhotosVisuEnGrandA;0)
		OB GET ARRAY:C1229([QuizzSuivi:32]Argument:6;"TbPhotosEngrand";$TbNumPhotosVisuEnGrandA)
		If (Find in array:C230($TbNumPhotosVisuEnGrandA;$NumImageA)<0)
			APPEND TO ARRAY:C911($TbNumPhotosVisuEnGrandA;$NumImageA)
			OB SET ARRAY:C1227([QuizzSuivi:32]Argument:6;"TbPhotosEngrand";$TbNumPhotosVisuEnGrandA)
			SAVE RECORD:C53([QuizzSuivi:32])
		End if 
		ZAmnistiePartielle (->[QuizzSuivi:32];True:C214)
	End if 
End if 
  //$Title:="Placer les explications"
  //Si (Taille BLOB([Diapositives]BlobFleches)>0)  // les éventuelles flèches
  //$THTML:=$THTML+"     <img id="+<>ZGuil+"flechephotoengrand"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeFleRepos.png"+<>ZGuil
  //$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
  //Fin de si

$Title:="Ajuster à la fenêtre"
$THTML:=$THTML+"     <img id="+<>ZGuil+"resize"+<>ZGuil+" class="+<>ZGuil+"resize bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeResizeRepos.png"+<>ZGuil
$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <p id="+<>ZGuil+"com"+<>ZGuil+" class="+<>ZGuil+"commentaire"+<>ZGuil+"></p>"+<>ZCR
$Title:="Quitter"
$THTML:=$THTML+"     <img id="+<>ZGuil+"quittephotoengrand"+<>ZGuil+" class="+<>ZGuil+"quitte bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeQuiRepos.png"+<>ZGuil
$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <p id="+<>ZGuil+"fermeture"+<>ZGuil+" class="+<>ZGuil+"commentaire"+<>ZGuil+">       <img id="+<>ZGuil+"casefermeture"+<>ZGuil
$THTML:=$THTML+"  width="+<>ZGuil+"36px"+<>ZGuil+" src="+<>ZGuil+"images/Casefermeture.GIF"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"     </p>"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR

$THTML:=$THTML+"    <div id="+<>ZGuil+"photo"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <img"+<>ZCR
$THTML:=$THTML+"             id="+<>ZGuil+"fleche1"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             src="+<>ZGuil+"images/flecheadroite.PNG"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             alt="+<>ZGuil+"flèche à droite"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             width="+<>ZGuil+"35px"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             title="+<>ZGuil+""+<>ZGuil+<>ZCR
$THTML:=$THTML+"         />"+<>ZCR
$THTML:=$THTML+"        <img"+<>ZCR
$THTML:=$THTML+"             id="+<>ZGuil+"fleche2"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             src="+<>ZGuil+"images/flecheenbas.PNG"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             alt="+<>ZGuil+"flèche en bas"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             width="+<>ZGuil+"35px"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             title="+<>ZGuil+""+<>ZGuil+<>ZCR
$THTML:=$THTML+"         />"+<>ZCR
$THTML:=$THTML+"        <img"+<>ZCR
$THTML:=$THTML+"             id="+<>ZGuil+"fleche3"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             src="+<>ZGuil+"images/flecheagauche.PNG"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             alt="+<>ZGuil+"flèche à gauche"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             width="+<>ZGuil+"35px"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             title="+<>ZGuil+""+<>ZGuil+<>ZCR
$THTML:=$THTML+"         />"+<>ZCR
$THTML:=$THTML+"        <img"+<>ZCR
$THTML:=$THTML+"             id="+<>ZGuil+"fleche4"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             src="+<>ZGuil+"images/flecheenhaut.PNG"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             alt="+<>ZGuil+"flèche en haut"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             width="+<>ZGuil+"35px"+<>ZGuil+<>ZCR
$THTML:=$THTML+"             title="+<>ZGuil+""+<>ZGuil+<>ZCR
$THTML:=$THTML+"         />"+<>ZCR
$THTML:=$THTML+"      <img id="+<>ZGuil+"photodia"+<>ZGuil+"  width="+<>ZGuil+"100%"+<>ZGuil+" src="+<>ZGuil+"PhotosAsaDia/"+$NumImageA+".jpg"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"    <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
$THTML:=$THTML+"  </body>"+<>ZCR2
$THTML:=$THTML+"</html>"+<>ZCR

  //FIXER TEXTE DANS CONTENEUR($THTML)
$NomFichier:="photo n°"+$NumImageA+".shtml"
$CD:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$NomFichier
If (Test path name:C476($CD)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CD)
End if 
$Doc:=Create document:C266($CD)
SEND PACKET:C103($Doc;$THTML)
CLOSE DOCUMENT:C267($Doc)
WEB SEND TEXT:C677($NomFichier)
ZAmnistieInternationale 