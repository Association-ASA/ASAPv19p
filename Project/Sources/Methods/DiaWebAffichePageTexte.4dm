//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 02/12/17, 11:29:14
// ----------------------------------------------------
// Méthode : WebAffichePageTexte
// Description
// Permet d'afficher le texte demandé par AJAX
//  $1 = message type ajaxtextetexteajax1
// ----------------------------------------------------
$Mess:=$1

$IDTexteN:=Num:C11($Mess)
$Pos:=Position:C15("£"; $Mess)
VarLogin:=Substring:C12($Mess; ($Pos+1))
QUERY:C277([DiaTextesWeb:38]; [DiaTextesWeb:38]IDTexteWeb:1=$IDTexteN)
//VarNomGeneral:=[TextesWeb]TitreTexte
//VarNomFichier:=[TextesWeb]NomDuFichier
//VarAuteurRevue:=[TextesWeb]AuteurRevue
//VarTexteRevue:=[TextesWeb]RefRevueJaune
//VarNomEspece:=[TextesWeb]NomEspece
//VarNomOrgane:=[TextesWeb]NomOrgane

//VarNomPageWeb:=[TextesWeb]NomPageWeb
//VarIDTexte:=[TextesWeb]IDTexteWeb

//CHERCHER([TextesWebParagraphes];[TextesWebParagraphes]IDTexte=$IDTexteN)
//TRIER([TextesWebParagraphes];[TextesWebParagraphes]OrdreAffichage;>)
//SÉLECTION VERS TABLEAU([TextesWebParagraphes]TitreParagraphe;Colonne1;[TextesWebParagraphes]NiveauTitre;Colonne2N;[TextesWebParagraphes]OrdreAffichage;Colonne3N)

//TABLEAU ENTIER LONG SUR SÉLECTION([TextesWebParagraphes];Colonne4N)

DiaWebEcritLaPageTextes