//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 16/08/19, 15:36:37
// ----------------------------------------------------
// Méthode : ASAPFabriqueTbCampagneToutesMAJ
// Description
// Méthode qui met à jour les tableaux généraux 
//  de toutes les Campagnes RAEMA
// ----------------------------------------------------
// trace

ON ERR CALL:C155("aaaErreurVide")
C_LONGINT:C283($TT)
ON ERR CALL:C155("")

ASAPInitTbGenerauxCampagnes
$TT:=Size of array:C274(<>TbPtTbCampagnes)
For ($Salé; 1; $TT)
	GET PROCESS VARIABLE:C371(-1951; <>TbPtTbCampagnes{$Salé}->; <>TbPtTbCampagnes{$Salé}->)
End for 