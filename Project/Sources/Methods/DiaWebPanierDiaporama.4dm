//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 13/12/17, 07:36:39
  // ----------------------------------------------------
  // Méthode : WebPanierDiaporama
  // Description
  //   permet de lancer le diaporama et d'en gérer la progression
  //
  // Paramètres : 
  //    $1=message AJAX type "lancerpanier7343_1397_349"
  //      où 7343 est le numéro d'enregistrement de la [XDonnées] du panier
  //      1397 la largeur et 349 la hauteur de la fenêtre du navigateur
  //      dans le cas du lancement du diaporama (Pas de $2)
  //
  //    {$2} si existe = diaporama en cours sinon lancement du diaporama
  //      alors $1=message AJAX type "diaporamapanier7464_1507_709£photoapres£Diaporama (1 sur 9)"
  //      où 7464 est le numéro d'enregistrement de la [XDonnées] du panier
  //      1507 la largeur et 709 la hauteur de la fenêtre du navigateur
  //      photoapres est l'ID du bouton cliqué (ici photo suivante)
  //      Diaporama (1 sur 9) est le titre de la fenêtre qui donne le rang actuel à incrémenter
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$L;$H;$NumXDoneesN)
$Mess:=$1
$DiapoDemarre:=(Count parameters:C259=1)
$Langue:=$Mess[[1]]

  // repérage de la [XDonnées] du panier
$Pos:=Position:C15("_";$Mess)
$NumXDoneesN:=Num:C11(Substring:C12($Mess;1;($Pos-1)))
$NumXDoneesA:=String:C10($NumXDoneesN)

GOTO RECORD:C242([DiaData:45];$NumXDoneesN)
$Mess:=Substring:C12($Mess;($Pos+1))

  // détection de la hauteur et largeur de l'écran de l'internaute
$Pos:=Position:C15("_";$Mess)
If ($DiapoDemarre)
	$Largeur:=Substring:C12($Mess;1;($Pos-1))+"px"
	$Hauteur:=Substring:C12($Mess;($Pos+1))+"px"
Else 
	$Largeur:=Substring:C12($Mess;1;($Pos-1))+"px"
	$Reste:=Substring:C12($Mess;($Pos+1))
	$Pos:=Position:C15("_";$Reste)
	$Hauteur:=Substring:C12($Reste;1;($Pos-1))+"px"
End if 

  // détection de la photo à afficher
ARRAY TEXT:C222($TbNumPhotosA;0)
ZTexteVersTableau ([DiaData:45]XTexte:7;->$TbNumPhotosA)
$TTA:=String:C10(Size of array:C274($TbNumPhotosA))
If ($DiapoDemarre)
	$NumPhotoA:=$TbNumPhotosA{1}
	$RangActuelPhotoA:="1"
Else 
	$Pos:=Position:C15("£";$Mess)
	$Reste:=Substring:C12($Mess;($Pos+1))  // "photoapres£Diaporama (1 sur 9)"
	$Pos:=Position:C15("£";$Reste)
	$IDFleche:=Substring:C12($Reste;1;($Pos-1))  // "photoapres"
	Case of 
		: ($IDFleche="@avant")
			$Progression:=-1
			
		: ($IDFleche="@apres")
			$Progression:=1
			
	End case 
	$Titre:=Substring:C12($Reste;($Pos+1))  // "Diaporama (1 sur 9)"
	$pos:=Position:C15("sur";$Titre)
	$Reste:=Substring:C12($Titre;1;($Pos-1))  // "Diaporama (1 "
	$RangActuelPhotoN:=Num:C11(Substring:C12($Reste;12))+$Progression
	$NumPhotoA:=$TbNumPhotosA{$RangActuelPhotoN}
	$RangActuelPhotoA:=String:C10($RangActuelPhotoN)
End if 
$NumPhotoN:=Num:C11($NumPhotoA)
$Title:="Diaporama ("+$RangActuelPhotoA+" sur "+$TTA+")"
If ($DiapoDemarre)
	$THTML:=""
Else 
	$THTML:=$Title+"£"
End if 
If ($DiapoDemarre)
	
	$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
	$THTML:=$THTML+"<html>"+<>ZCR
	$THTML:=$THTML+"  <head>"+<>ZCR
	$THTML:=$THTML+"    <!--4dinclude HeaderAsaDia.shtml-->"+<>ZCR
	$THTML:=$THTML+"    <title>"+$Title+"</title>"+<>ZCR
	$THTML:=$THTML+"  </head>"+<>ZCR
	$THTML:=$THTML+""+<>ZCR
	$THTML:=$THTML+"  <body>"+<>ZCR
	$THTML:=$THTML+"    <div id="+<>ZGuil+"barrenavigation"+<>ZGuil+" width="+<>ZGuil+$Largeur+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"      <p>"+<>ZCR
	If (False:C215)
		$THTML:=$THTML+"        <img id="+<>ZGuil+"photoavant"+<>ZGuil+" class="+<>ZGuil+""+<>ZGuil+"  src="+<>ZGuil+"images/photoavant.PNG"+<>ZGuil+" alt="+<>ZGuil+"Photo précédente"+<>ZGuil+" title="+<>ZGuil+"Photo précédente"+<>ZGuil+" />"+<>ZCR
		$THTML:=$THTML+"        <img id="+<>ZGuil+"photoapres"+<>ZGuil+" class="+<>ZGuil+""+<>ZGuil+"  src="+<>ZGuil+"images/photoapres.PNG"+<>ZGuil+" alt="+<>ZGuil+"Photo suivante"+<>ZGuil+" title="+<>ZGuil+"Photo suivante"+<>ZGuil+" />"+<>ZCR
	End if 
	$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"valeurxdonnees"+<>ZGuil+" value="+<>ZGuil+$NumXDoneesA+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"languecourante"+<>ZGuil+" value="+<>ZGuil+$Langue+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"      </p>"+<>ZCR
	$THTML:=$THTML+"    </div>"+<>ZCR
	$THTML:=$THTML+"    <div id="+<>ZGuil+"boutonsphotoengrand"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"    </div>"+<>ZCR
	$THTML:=$THTML+"    <div id="+<>ZGuil+"photo"+<>ZGuil+">"+<>ZCR
End if   // fin du HTML de première photo du diaporama
  // le bouton quitter pour avoir la langue
$Title:="Quitter"
$THTML:=$THTML+"     <img id="+<>ZGuil+"quittephotoengrand"+<>ZGuil+" class="+<>ZGuil+"quitte bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeQuiRepos.png"+<>ZGuil
$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+" style="+<>ZGuil+"display: none;"+<>ZGuil+" />"+<>ZCR
  // les photos des flèches de commentaires
If ($Langue#"R")
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
	$THTML:=$THTML+"         />"+<>ZCR2
	  // fin des photos des flèches de commentaires
End if 
  // la photo de la lésion
$THTML:=$THTML+"        <img id="+<>ZGuil+"photodia"+<>ZGuil+"  width="+<>ZGuil+"100%"+<>ZGuil+" src="+<>ZGuil+"PhotosAsaDia/"+$NumPhotoA+".jpg"+<>ZGuil+" />"+<>ZCR
  // le champ avec son n°
$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"numphoto"+<>ZGuil+" value="+<>ZGuil+$NumPhotoA+<>ZGuil+" />"+<>ZCR

If ($DiapoDemarre)
	$THTML:=$THTML+"    </div>"+<>ZCR
	$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
	$THTML:=$THTML+"  </body>"+<>ZCR
	$THTML:=$THTML+""+<>ZCR
	$THTML:=$THTML+"</html>"+<>ZCR
	  //FIXER TEXTE DANS CONTENEUR($THTML)
	$NomFichier:="photo"+$NumPhotoA+".shtml"
	$CD:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$NomFichier
	If (Test path name:C476($CD)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CD)
	End if 
	$Doc:=Create document:C266($CD)
	SEND PACKET:C103($Doc;$THTML)
	CLOSE DOCUMENT:C267($Doc)
	WEB SEND TEXT:C677($NomFichier)
Else 
	WEB SEND TEXT:C677($THTML)
End if 