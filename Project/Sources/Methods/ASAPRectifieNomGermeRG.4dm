//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 25/06/20, 14:34:30
// ----------------------------------------------------
// Méthode : ASAPRectifieNomGermeRG
// Description
// Méthode qui harmonise les noms des germes
//  du Raema Gel : tous les noms doivent être ceux du schéma
// ----------------------------------------------------
READ WRITE:C146([CampagneGelGermes:25])
ALL RECORDS:C47([CampagneGelGermes:25])
$FT:=Records in selection:C76([CampagneGelGermes:25])
For ($Salé; 1; $FT)
	$L:=Find in array:C230(<>TbNomGermeCampagneGEL; [CampagneGelGermes:25]NomDuGerme:3)
	If ($L>0)
		[CampagneGelGermes:25]NomDuGerme:3:=<>TbNomGermeSchémaGEL{$L}
		SAVE RECORD:C53([CampagneGelGermes:25])
	End if 
	NEXT RECORD:C51([CampagneGelGermes:25])
End for 

