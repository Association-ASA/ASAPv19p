//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 08/02/19, 09:59:58
// ----------------------------------------------------
// Paramètres
// ----------------------------------------------------
// Méthode : ASAPImprimeFacture
// Description
// Imprime la facture courante
C_TEXT:C284($1)

If (Count parameters:C259=0)
	FORM SET OUTPUT:C54([Factures:15]; "Facture")
	PRINT RECORD:C71([Factures:15])
Else 
	FORM SET OUTPUT:C54([Personnes:12]; $1)
	PRINT RECORD:C71([Personnes:12])
End if 

