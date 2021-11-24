//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 22/12/20, 13:32:11
// ----------------------------------------------------
// Méthode : ASAPFactureNonPaye
// Description
// Permet de sélectionner les factures non payées
// hors avoir/factures donnant lieu à un avoir et devis
// ----------------------------------------------------
$Année:=Request:C163("De quelle année voulez-vous les factures Non payées ?")
$Millesime:=Substring:C12($Année; 3; 2)
QUERY:C277([Factures:15]; [Factures:15]NumFacture:3=$Millesime+"@"; *)
QUERY:C277([Factures:15];  & [Factures:15]Regle:12=False:C215)
LONGINT ARRAY FROM SELECTION:C647([Factures:15]; $TbNumEnrFac)
ARRAY LONGINT:C221($TbNumEnrFacNonPaye; 0)
SELECTION TO ARRAY:C260([Factures:15]NumFacture:3; $TbFactureNonPaye)
$TT:=Size of array:C274($TbFactureNonPaye)
For ($salé; 1; $TT)
	$L:=Find in array:C230($TbFactureNonPaye; $TbFactureNonPaye{$Salé}+"A")
	If ($L<0) & ($TbFactureNonPaye{$Salé}#"@D") & ($TbFactureNonPaye{$Salé}#"@A")
		APPEND TO ARRAY:C911($TbNumEnrFacNonPaye; $TbNumEnrFac{$Salé})
	End if 
End for 
CREATE SELECTION FROM ARRAY:C640([Factures:15]; $TbNumEnrFacNonPaye)
ASAPFabriqueTbFactures