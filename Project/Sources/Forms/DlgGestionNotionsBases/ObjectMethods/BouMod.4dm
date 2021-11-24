READ WRITE:C146([DiaTextesWeb:38])
QUERY:C277([DiaTextesWeb:38];[DiaTextesWeb:38]IDTexteWeb:1=TbIDTexte{PUMTextes})
ZFenetreModaleAuCentre (450;350)
VarNomGeneral:=[DiaTextesWeb:38]TitreTexte:2
VarNomFichier:=[DiaTextesWeb:38]NomDuFichier:5
VarAuteurRevue:=[DiaTextesWeb:38]AuteurRevue:4
VarTexteRevue:=[DiaTextesWeb:38]RefRevueJaune:3
VarNomEspece:=[DiaTextesWeb:38]NomEspece:7
VarNomOrgane:=[DiaTextesWeb:38]NomOrgane:8
DIALOG:C40("DlgTextesChoixNouveau")
CLOSE WINDOW:C154
If (BouOK=1)
	[DiaTextesWeb:38]TitreTexte:2:=VarNomGeneral
	[DiaTextesWeb:38]NomDuFichier:5:=VarNomFichier
	[DiaTextesWeb:38]AuteurRevue:4:=VarAuteurRevue
	[DiaTextesWeb:38]RefRevueJaune:3:=VarTexteRevue
	[DiaTextesWeb:38]NomEspece:7:=VarNomEspece
	[DiaTextesWeb:38]NomOrgane:8:=VarNomOrgane
	SAVE RECORD:C53([DiaTextesWeb:38])
End if 