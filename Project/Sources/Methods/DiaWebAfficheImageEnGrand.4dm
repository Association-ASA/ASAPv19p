//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 03/01/16, 08:55:51
  // ----------------------------------------------------
  // Méthode : WebAfficheImageEnGrand
  // Description
  // Crée une image occupant tout l'écran avec les boutons
  // permettant un complément d'information
  // et les flèches d'explication
  // Paramètre : $1 = chaine AJAX de type suivant
  //  "Fafficheengrand"+NumImage+"_"+Largeur Ecran+"_"+Hauteur Ecran+"_"+emailvisiteur
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$L;$H;$LDia;$LLes;$TailleMaxN)


$Mess:=$1
$Langue:=$Mess[[1]]
$Mess:=Substring:C12($Mess;16)  // élimination de Fafficheengrand
$Pos:=Position:C15("_";$Mess)
$NumImage:=Substring:C12($Mess;1;($Pos-1))
$NumImageN:=Num:C11($NumImage)
$Mess:=Substring:C12($Mess;($Pos+1))
$Pos:=Position:C15("_";$Mess)
$Largeur:=Substring:C12($Mess;1;($Pos-1))+"px"
$Mess:=Substring:C12($Mess;($Pos+1))
$Pos:=Position:C15("_";$Mess)
$Hauteur:=Substring:C12($Mess;1;($Pos-1))+"px"
$Login:=Substring:C12($Mess;($Pos+1))
  // Ad3TraducFabriqueTb

CREATE RECORD:C68([DiaPistePhotos:41])
[DiaPistePhotos:41]DateAffichage:3:=Current date:C33
[DiaPistePhotos:41]HeureAffichage:4:=Current time:C178
[DiaPistePhotos:41]IDVisiteur:5:=$Login
Case of 
	: ($login="@gouv.fr")
		$visiteur:="Abattoirs"
		
	: ($login="@enva.fr")
		$visiteur:="ENVA"
		
	: ($login="@vetagro-sup.fr")
		$visiteur:="ENVL"
		
	: ($login="@oniris-nantes.fr")
		$visiteur:="ENVN"
		
	: ($login="@envt.fr")
		$visiteur:="ENVT"
		
	: ($login="@ulg.ac.be")
		$visiteur:="ULG"
		
	: ($login="cegeheme@wanadoo.fr")
		$visiteur:="CGM"
		
	: ($login="@.ru") | ($Langue="R")
		$visiteur:="Russe"
		
	Else 
		$visiteur:="Autres"
		
End case 
[DiaPistePhotos:41]TypeVisiteur:6:=$visiteur
[DiaPistePhotos:41]NumOrdreDiapo:2:=$NumImageN
[DiaPistePhotos:41]IDPistePhoto:7:=$NumImage+String:C10([DiaPistePhotos:41]DateAffichage:3)+String:C10([DiaPistePhotos:41]HeureAffichage:4)+$Login
SAVE RECORD:C53([DiaPistePhotos:41])


$LDia:=Find in array:C230(<>TbDiaposNumOrdreDiapos;$NumImageN)
$LLes:=Find in array:C230(<>TbLesionsNomLesion;<>TbDiaposNomLesion{$LDia})
$NomLésion:=<>TbDiaposNomLesion{$LDia}
$NomMotif:=<>TbDiaposMotifSaisieDGAL{$LDia}
$DiapoLiée:=<>TbDiaposRefPhotoLiéesGibier{$LDia}
$NomOrgane:=<>TbDiaposOrgane{$LDia}
$NomEspece:=<>TbDiaposEspece{$LDia}
$Commentaire:=<>TbDiaposComF{$LDia}
$NPC:=<>TbDiaposNPC{$LDia}
$FR:=(Num:C11(<>TbDiaposDiapoFicheReflexe{$LDia}#"")*<>TbDiaposDiapoFicheReflexe{$LDia})+(Num:C11(<>TbDiaposDiapoFicheReflexe{$LDia}="")*<>TbLesionsFicheReflexe{$LLes})
$DL:=<>TbDiaposDescriptionTypeLesion{$LDia}
$MS:=<>TbDiaposMotifSaisieDGAL{$LDia}
$RG:=<>TbDiaposReferenceReglementaireU{$LDia}
$BF:=<>TbDiaposBlobFleches{$LDia}
$DL:=<>TbDiaposDiaposLiees{$LDia}
$TailleMaxN:=OB Get:C1224(<>TbDiaposObjetDiapo{$LDia};"MaxDim";Est un entier long:K8:6)

If ($NumImageN>80000) & ($TailleMaxN<1600) & (Num:C11($Largeur)>1600)  // Eventuel problème de taille
	QUERY BY ATTRIBUTE:C1331([Diapositives:40];[Diapositives:40]ObjetDiapo:32;"RefPhotoPrincipaleGibier";=;$DiapoLiée)
	$OnAffiche2:=(Records in selection:C76([Diapositives:40])>0)
	If ($OnAffiche2)
		$THTML:=DiaGibierHTMLPhotoTimbrePoste ($NumImageN;$Largeur)
	Else 
		$THTML:=DiaGibierHTMLPhotoTimbrePoste ($NumImageN;$Largeur;True:C214)
	End if 
	
Else   // photo sans problème de taille
	$THTML:="<!DOCTYPE html>"+<>ZCR
	$THTML:=$THTML+"<html>"+<>ZCR
	$THTML:=$THTML+"  <head>"+<>ZCR
	$THTML:=$THTML+"    <!--4dinclude HeaderAsaDia.shtml-->"+<>ZCR
	$THTML:=$THTML+"    <title>Photo n°"+$NumImage+"</title>"+<>ZCR
	$THTML:=$THTML+"  </head>"+<>ZCR2
	
	$THTML:=$THTML+"  <body>"+<>ZCR
	$THTML:=$THTML+"    <div id="+<>ZGuil+"boutonsphotoengrand"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"languecourante"+<>ZGuil+" value="+<>ZGuil+$Langue+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"mailvisiteur"+<>ZGuil+" value="+<>ZGuil+$Login+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"numphoto"+<>ZGuil+" value="+<>ZGuil+$NumImage+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        <input id="+<>ZGuil+"pageasadia"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+"P2"+<>ZGuil+" />"+<>ZCR
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
	If (Length:C16($Commentaire)>0)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"lphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeLesRepos.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
	
	  //Si ($Langue="F")
	  // Ne pas confondre
	If (Length:C16($NPC)>0)
		$Title:=DiaWebTraduitTexte ("Ne pas confondre";$Langue)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"nphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeNpcRepos.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
	  //Fin de si
	
	  // Réglementation
	If ($Langue#"R")
		$Title:=DiaWebTraduitTexte ("Références réglementaires";$Langue)
		If (Length:C16($RG)>0)
			$THTML:=$THTML+"     <img id="+<>ZGuil+"rphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeRegRepos.png"+<>ZGuil
			$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
		End if 
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
	$Title:=DiaWebTraduitTexte ("Ajouter au panier";$Langue)
	$THTML:=$THTML+"     <img id="+<>ZGuil+"pphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+"src="+<>ZGuil+"images/IconePanRepos.png"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"     <img id="+<>ZGuil+"videphoto"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeVide.png"+<>ZGuil+">"+<>ZCR
	
	  // Les flèches d'explications
	If ($Langue#"R")
		$Title:=DiaWebTraduitTexte ("Placer les explications";$Langue)
		If (BLOB size:C605($BF)>0)  // les éventuelles flèches
			$THTML:=$THTML+"     <img id="+<>ZGuil+"flechephotoengrand"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeFleRepos.png"+<>ZGuil
			$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
		End if 
		If ($Langue="F")
			$THTML:=$THTML+"     <img id="+<>ZGuil+"qphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeFaqRepos.png"+<>ZGuil
			$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+"Adresser un message à l'ASA"+<>ZGuil+">"+<>ZCR
		End if 
	End if 
	  // les photos associées
	ARRAY TEXT:C222($Tb;0)
	GET TEXT KEYWORDS:C1141($DL;$Tb)
	$FT:=Size of array:C274($Tb)
	If ($FT#0)
		$Title:=DiaWebTraduitTexte ("Autres photographies";$Langue)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"videphoto"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeVide.png"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"     <img  class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeImagesSup.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"     <div id="+<>ZGuil+"photossup"+<>ZGuil+">"+<>ZCR
		For ($Salé;1;$FT)
			$ND:=$Tb{$Salé}
			  // CHERCHER([Atlas];[Atlas]NumOrdreDiapo=Num($ND))
			$CDNomImage:=Get 4D folder:C485(Dossier base:K5:14)+"dossier Photos"+Séparateur dossier:K24:12+$ND+".jpg"
			READ PICTURE FILE:C678($CDNomImage;$VarImage)
			PICTURE PROPERTIES:C457($VarImage;$L;$H)
			$hv:=(Num:C11($L>$H)*"h")+(Num:C11($H>$L)*"v")
			$alt:=" alt="+<>ZGuil+$ND+<>ZGuil
			$title:=" title="+<>ZGuil+$ND+<>ZGuil
			$THTML:=$THTML+" <img id="+<>ZGuil+"imagette"+$ND+<>ZGuil+" class="+<>ZGuil+"imagesup"+$hv+<>ZGuil+" src="+<>ZGuil+"PhotosAsaDia/"+$ND+"is.jpg"+<>ZGuil+$alt+$title+" />"+<>ZCR
		End for 
		$THTML:=$THTML+"     </div>"+<>ZCR
	End if 
	$Title:=DiaWebTraduitTexte ("Ajuster à la fenêtre";$Langue)
	$THTML:=$THTML+"     <img id="+<>ZGuil+"resize"+<>ZGuil+" class="+<>ZGuil+"resize bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeResizeRepos.png"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	$Title:=DiaWebTraduitTexte ("Quitter";$Langue)
	$THTML:=$THTML+"     <img id="+<>ZGuil+"quittephotoengrand"+<>ZGuil+" class="+<>ZGuil+"quitte bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeQuiRepos.png"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"     <p id="+<>ZGuil+"fermeture"+<>ZGuil+" class="+<>ZGuil+"commentaire"+<>ZGuil+">       <img id="+<>ZGuil+"casefermeture"+<>ZGuil
	$THTML:=$THTML+"  width="+<>ZGuil+"36px"+<>ZGuil+" src="+<>ZGuil+"images/Casefermeture.GIF"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"     </p>"+<>ZCR
	$THTML:=$THTML+"     <p id="+<>ZGuil+"com"+<>ZGuil+" class="+<>ZGuil+"commentaire"+<>ZGuil+"></p>"+<>ZCR
	
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
	$THTML:=$THTML+"      <img id="+<>ZGuil+"photodia"+<>ZGuil+"  width="+<>ZGuil+"100%"+<>ZGuil+" src="+<>ZGuil+"PhotosAsaDia/"+$NumImage+".jpg"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"    </div>"+<>ZCR
End if 
If (False:C215)
	$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script><!-- jQuery     -->"+<>ZCR
	$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/jquery-ui.min.js"+<>ZGuil+"></script> <!-- jQuery UI    -->"+<>ZCR
End if 
$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadiaP1.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
$THTML:=$THTML+"  </body>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"</html>"+<>ZCR
  //FIXER TEXTE DANS CONTENEUR($THTML)
$NomFichier:="photo"+$NumImage+".shtml"
$CD:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$NomFichier
If (Test path name:C476($CD)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CD)
End if 
$Doc:=Create document:C266($CD)
SEND PACKET:C103($Doc;$THTML)
CLOSE DOCUMENT:C267($Doc)
WEB SEND TEXT:C677($NomFichier)
ZAmnistieInternationale 