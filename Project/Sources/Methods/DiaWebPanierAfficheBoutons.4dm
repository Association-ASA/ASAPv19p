//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 04/01/18, 15:07:53
// ----------------------------------------------------
// Méthode : WebPanierAfficheBoutons
// Description
// Permet d'afficher les boutons d'explication
//  lors d'un diaporama
// Paramètre  $1 = message AJAX type boutonsdiaporama13946£1
// où le n° de diapo est 13946 et son rang 1
// ----------------------------------------------------
C_POINTER:C301($PtTb)

$Mess:=$1
// Ad3TraducFabriqueTb
$Langue:=$Mess[[1]]
$Pos:=Position:C15("£"; $Mess)
$Rang:=Num:C11(Substring:C12($Mess; ($Pos+1)))
$NumPhotoN:=Num:C11(Substring:C12($Mess; 1; ($Pos-1)))
QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=$NumPhotoN)
RELATE ONE:C42([Diapositives:40]NomLesion:4)  // Charge l'enregistrement de [Lesions]
$THTML:=""
// Description de la photographie
$Title:=DiaWebTraduitTexte("Description macroscopique"; $Langue)
$THTML:=$THTML+"     <img id="+<>ZGuil+"cphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+"  src="+<>ZGuil+"images/IconeComRepos.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR

// Fiche réflexe
$Title:=DiaWebTraduitTexte("Fiche reflexe"; $Langue)
If (Length:C16([DiaLesions:44]FicheReflexe:12)>0)
	$THTML:=$THTML+"     <img id="+<>ZGuil+"fphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+"src="+<>ZGuil+"images/IconeFreRepos.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
End if 

// Description-type de la lésion
$Title:=DiaWebTraduitTexte("description de la lésion"; $Langue)
If (Length:C16([DiaLesions:44]DescriptionTypeMacro:4)>0)
	$THTML:=$THTML+"     <img id="+<>ZGuil+"lphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeLesRepos.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
End if 

If ($Langue="F")
	// Ne pas confondre
	If (Length:C16([Diapositives:40]NPC:14)>0)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"nphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeNpcRepos.png"+<>ZGuil+" alt="+<>ZGuil+"Ne pas confondre"+<>ZGuil+" title="+<>ZGuil+"Ne pas confondre"+<>ZGuil+">"+<>ZCR
	End if 
End if 

If ($Langue#"R")
	// Réglementation
	$Title:=DiaWebTraduitTexte("Références réglementaires"; $Langue)
	If (Length:C16([Diapositives:40]ReferenceReglementaireUE:27)>0)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"rphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeRegRepos.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
End if 

If ($Langue="F")
	// texte d'anapath
	QUERY:C277([DiaTextesWebParagraphes:37]; [DiaTextesWebParagraphes:37]NomEspece:2=[Diapositives:40]Espece:3; *)
	QUERY:C277([DiaTextesWebParagraphes:37];  & [DiaTextesWebParagraphes:37]NomOrgane:3=[Diapositives:40]Organe:2; *)
	QUERY:C277([DiaTextesWebParagraphes:37];  & [DiaTextesWebParagraphes:37]NomLesion:10=[Diapositives:40]NomLesion:4)
	If (Records in selection:C76([DiaTextesWebParagraphes:37])>0)
		$THTML:=$THTML+"     <img id="+<>ZGuil+"sphotoeg"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+"src="+<>ZGuil+"images/IconeComReposr.png"+<>ZGuil+" alt="+<>ZGuil+"Voir le cours d'anapath spécial"+<>ZGuil+" title="+<>ZGuil+"Voir le cours d'anapath spécial"+<>ZGuil+">"+<>ZCR
	End if 
	$THTML:=$THTML+"     <img id="+<>ZGuil+"videphoto"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeVide.png"+<>ZGuil+">"+<>ZCR
End if 

// Les flèches d'explications
If ($Langue#"R")
	$Title:=DiaWebTraduitTexte("Placer les explications"; $Langue)
	If (BLOB size:C605([Diapositives:40]BlobFleches:21)>0)  // les éventuelles flèches
		$THTML:=$THTML+"     <img id="+<>ZGuil+"flechephotoengrand"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeFleRepos.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	End if 
End if 

//  // les photos associées
//TABLEAU TEXTE($Tb;0)
//LIRE MOTS CLÉS TEXTE([Diapositives]DiaposLiees;$Tb)
//$FT:=Taille tableau($Tb)
//Si ($FT#0)
//$Title:=WebTraduitTexte ("Autres photographies";$Langue)
//$THTML:=$THTML+"     <img id="+<>ZGuil+"videphoto"+<>ZGuil+" class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeVide.png"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"     <img  class="+<>ZGuil+"bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeImagesSup.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"     <div id="+<>ZGuil+"photossup"+<>ZGuil+">"+<>ZCR
//Boucle ($Salé;1;$FT)
//$ND:=$Tb{$Salé}
//CHERCHER([Atlas];[Atlas]NumOrdreDiapo=Num($ND))
//PROPRIÉTÉS IMAGE([Atlas]Photo;$L;$H)
//$hv:=(Num($L>$H)*"h")+(Num($H>$L)*"v")
//$alt:=" alt="+<>ZGuil+$ND+<>ZGuil
//$title:=" title="+<>ZGuil+$ND+<>ZGuil
//$THTML:=$THTML+" <img id="+<>ZGuil+"imagette"+$ND+<>ZGuil+" class="+<>ZGuil+"imagesup"+$hv+<>ZGuil+" src="+<>ZGuil+"PhotosAsaDia/"+$ND+"is.jpg"+<>ZGuil+$alt+$title+" />"+<>ZCR
//Fin de boucle
//$THTML:=$THTML+"     </div>"+<>ZCR
//Fin de si
$Title:=DiaWebTraduitTexte("Ajuster à la fenêtre"; $Langue)
$THTML:=$THTML+"     <img id="+<>ZGuil+"resize"+<>ZGuil+" class="+<>ZGuil+"resize bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeResizeRepos.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
//$Title:=WebTraduitTexte ("Quitter";$Langue)
//$THTML:=$THTML+"     <img id="+<>ZGuil+"quittephotoengrand"+<>ZGuil+" class="+<>ZGuil+"quitte bouton"+<>ZGuil+" src="+<>ZGuil+"images/IconeQuiRepos.png"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <p id="+<>ZGuil+"fermeture"+<>ZGuil+" class="+<>ZGuil+"commentaire"+<>ZGuil+">       <img id="+<>ZGuil+"casefermeture"+<>ZGuil+"  width="+<>ZGuil+"36px"+<>ZGuil+" src="+<>ZGuil+"images/Casefermeture.GIF"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"     </p>"+<>ZCR
$THTML:=$THTML+"     <p id="+<>ZGuil+"com"+<>ZGuil+" class="+<>ZGuil+"commentaire"+<>ZGuil+"></p>"+<>ZCR

WEB SEND TEXT:C677($THTML)