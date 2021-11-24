//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 25/12/15, 09:11:04
// ----------------------------------------------------
// Méthode : WebTextesAfficheGestion
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
ARRAY LONGINT:C221(Colonne2N; 0)
QUERY:C277([DiaTextesWeb:38]; [DiaTextesWeb:38]IDTexteWeb:1=TbIDTexte{PUMTextes})

VarNomGeneral:=[DiaTextesWeb:38]TitreTexte:2
VarNomFichier:=[DiaTextesWeb:38]NomDuFichier:5
VarAuteurRevue:=[DiaTextesWeb:38]AuteurRevue:4
VarTexteRevue:=[DiaTextesWeb:38]RefRevueJaune:3
VarNomEspece:=[DiaTextesWeb:38]NomEspece:7
VarNomOrgane:=[DiaTextesWeb:38]NomOrgane:8

VarNomPageWeb:=[DiaTextesWeb:38]NomPageWeb:6
VarIDTexte:=[DiaTextesWeb:38]IDTexteWeb:1

QUERY:C277([DiaTextesWebParagraphes:37]; [DiaTextesWebParagraphes:37]IDTexte:7=TbIDTexte{PUMTextes})
ORDER BY:C49([DiaTextesWebParagraphes:37]; [DiaTextesWebParagraphes:37]OrdreAffichage:12; >)
SELECTION TO ARRAY:C260([DiaTextesWebParagraphes:37]TitreParagraphe:6; Colonne1; \
[DiaTextesWebParagraphes:37]NiveauTitre:13; Colonne2N; \
[DiaTextesWebParagraphes:37]OrdreAffichage:12; Colonne3N)
LONGINT ARRAY FROM SELECTION:C647([DiaTextesWebParagraphes:37]; Colonne4N)


