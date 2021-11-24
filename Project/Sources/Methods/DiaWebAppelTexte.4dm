//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 04/12/17, 16:16:18
// ----------------------------------------------------
// Méthode : WebAppelTexte
// Description
// Permet d'appeler le texte désigné
//
// Paramètres
// ----------------------------------------------------


ARRAY TEXT:C222($TbNoms; 0)
ARRAY TEXT:C222($TbValeurs; 0)
WEB GET VARIABLES:C683($TbNoms; $TbValeurs)
VarLogin:=DiaWebExtraitValeurTbParNom("loginasadia"; ->$TbNoms; ->$TbValeurs)
$L:=Find in array:C230($TbNoms; "Texte@")
$IDTexteN:=Num:C11($TbNoms{$L})
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
Gibier:=False:C215
DiaWebEcritLaPageTextes