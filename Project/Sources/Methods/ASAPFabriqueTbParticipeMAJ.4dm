//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 16/08/19, 15:36:37
// ----------------------------------------------------
// Méthode : ASAPFabriqueTbParticipeMAJ
// Description
// Méthode qui met à jour les tableaux généraux 
//  des participations
// ----------------------------------------------------
ON ERR CALL:C155("aaaErreurVide")
C_LONGINT:C283($TT)
ON ERR CALL:C155("")
ASAPInitTbGenerauxParticipation
$TT:=Size of array:C274(<>TbPtTbParticipation)
For ($Salé; 1; $TT)
	GET PROCESS VARIABLE:C371(-1951; <>TbPtTbParticipation{$Salé}->; <>TbPtTbParticipation{$Salé}->)
End for 