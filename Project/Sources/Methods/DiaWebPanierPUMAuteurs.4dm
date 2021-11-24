//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 12/12/17, 06:39:11
// ----------------------------------------------------
// Méthode : WebPanierPUMAuteurs
// Description
// Réaction au changement du PUM des auteurs de panier
//    afin de n'ajouter que les paniers de l'auteur choisi
// Paramètre $1 = message AJAX type "Fauteurspumpaniercegeheme@wanadoo.fr£CGM"
// ----------------------------------------------------
$Mess:=$1
$Langue:=$Mess[[1]]
$Mess:=Substring:C12($1; 18)  // Elimination de "Fauteurspumpanier" reste "cegeheme@wanadoo.fr£CGM"
$Pos:=Position:C15("£"; $Mess)
$Login:=Substring:C12($Mess; 1; ($Pos-1))
$Auteur:=Substring:C12($Mess; ($Pos+1))
QUERY:C277([DiaData:45]; [DiaData:45]XAlpha:14=$Login; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XEntier:2=1951; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XBool:9=False:C215)
$Tous:=DiaWebTraduitTexte("tous"; $Langue)
If ($Auteur#$Tous)
	QUERY SELECTION:C341([DiaData:45]; [DiaData:45]XType:5=$Auteur)  // les initiales sont placées dans [XDonnees]XType
End if 
$THTML:=DiaWebCreationHTMLListePaniers($Langue; True:C214)
WEB SEND TEXT:C677($THTML)