//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 07/10/21, 09:54:28
  // ----------------------------------------------------
  // Méthode : DiaWebAfficheEnGrandOrganeSain
  // Description
  // Méthode qui renvoie l'image en grand d'un organe sain
  //
  // Paramètre : $1=message ajax type 
  // "imageengrandanat£"+nom du fichier de l'image+"£"+Largeur Ecran+"£"+Hauteur Ecran
  // ----------------------------------------------------
C_LONGINT:C283($Pos;$NumEnrImage;$NumImageN)


$Mess:=$1
$Langue:="F"
$Prefixe:="imageengrandanat£"
$Mess:=Substring:C12($Mess;Length:C16($Prefixe)+1)  // quizzaffichepleinecranPhotoAsadia/

ARRAY TEXT:C222($TbMess;0)
ZTexteVersTableau ($Mess;->$TbMess;"£")
  // $TbMess = 1:Nom de l'image; 2:largeur écran; 3:Hauteur écran

$CDImage:=Replace string:C233($TbMess{1};"i.jpg";".jpg")
$NomImage:=Substring:C12($CDImage;14)  // élimination de PhotosAsaDia
$NomImage:=Substring:C12($NomImage;1;Length:C16($NomImage)-4)  // élimination de .jpg
$Largeur:=$TbMess{2}+"px"
$Hauteur:=$TbMess{3}+"px"

$THTML:="<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+"  <head>"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude HeaderAsaDia.shtml-->"+<>ZCR
$THTML:=$THTML+"    <title>"+$NomImage+"</title>"+<>ZCR
$THTML:=$THTML+"  </head>"+<>ZCR2

$THTML:=$THTML+"  <body>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"boutonsphotoengrand"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"languecourante"+<>ZGuil+" value="+<>ZGuil+$Langue+<>ZGuil+" />"+<>ZCR
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
$THTML:=$THTML+"      <img id="+<>ZGuil+"photodia"+<>ZGuil+"  width="+<>ZGuil+"100%"+<>ZGuil+" src="+<>ZGuil+$CDImage+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"    <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
$THTML:=$THTML+"  </body>"+<>ZCR2
$THTML:=$THTML+"</html>"+<>ZCR

  //FIXER TEXTE DANS CONTENEUR($THTML)
$NomFichier:=$NomImage+".shtml"
$CD:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$NomFichier
If (Test path name:C476($CD)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CD)
End if 
$Doc:=Create document:C266($CD)
SEND PACKET:C103($Doc;$THTML)
CLOSE DOCUMENT:C267($Doc)
WEB SEND TEXT:C677($NomFichier)