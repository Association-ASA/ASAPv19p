
CONFIRM:C162("Créer un nouveau texte pour le Web ?")
If (OK=1)
	ZFenetreModaleAuCentre (450;350)
	DIALOG:C40("DlgTextesChoixNouveau")
	CLOSE WINDOW:C154
	If (BouOK=1)
		CREATE RECORD:C68([DiaTextesWeb:38])
		[DiaTextesWeb:38]TitreTexte:2:=VarNomGeneral
		[DiaTextesWeb:38]NomDuFichier:5:=VarNomFichier
		[DiaTextesWeb:38]AuteurRevue:4:=VarAuteurRevue
		[DiaTextesWeb:38]RefRevueJaune:3:=VarTexteRevue
		[DiaTextesWebParagraphes:37]NomEspece:2:=VarNomEspece
		[DiaTextesWebParagraphes:37]NomOrgane:3:=VarNomOrgane
		SAVE RECORD:C53([DiaTextesWeb:38])
		CREATE RECORD:C68([DiaTextesWebParagraphes:37])
		[DiaTextesWebParagraphes:37]IDTexte:7:=[DiaTextesWeb:38]IDTexteWeb:1
		[DiaTextesWebParagraphes:37]OrdreAffichage:12:=100000
		[DiaTextesWebParagraphes:37]NiveauTitre:13:=1
		SAVE RECORD:C53([DiaTextesWebParagraphes:37])
		APPEND TO ARRAY:C911(PUMTextes;VarNomGeneral)
		APPEND TO ARRAY:C911(TbIDTexte;[DiaTextesWeb:38]IDTexteWeb:1)
		DiaWebTextesAfficheGestion 
		PUMTextes:=Size of array:C274(PUMTextes)
	End if 
End if 
