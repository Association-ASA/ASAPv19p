//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 25/11/20, 16:40:55
// ----------------------------------------------------
// Méthode : FactureMiseAJourTotaux
// Description
// Met à jour les totaux dans le formulaire Facture entrée
// ----------------------------------------------------


// Remise à 0 des tarifs
[Factures:15]TotalHT:8:=0
[Factures:15]TotalTTC:10:=0
[Factures:15]TotalTVA:9:=0

$TT:=Size of array:C274(TbPrestation)
For ($Salé; 1; $TT)
	[Factures:15]TotalHT:8:=[Factures:15]TotalHT:8+TbPrixHT{$Salé}
	[Factures:15]TotalTTC:10:=[Factures:15]TotalTTC:10+TbPrixTTC{$Salé}
	[Factures:15]TotalTVA:9:=[Factures:15]TotalTVA:9+(TbPrixHT{$Salé}*TbTauxTVA{$Salé}/100)
End for 
