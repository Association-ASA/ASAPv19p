//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 14/04/21, 12:21:12
// ----------------------------------------------------
// Méthode : ASAPTestDispoFactureClient
// Description
// Methode qui teste la disponibilité des factures sur
// le serveur avant de procéder à un envoi de facture
// ----------------------------------------------------
//SÉLECTION VERS TABLEAU([Factures]NumFacture;$TbNumFacture;[Factures]UUIDPersonne;$TbUUIDPersonne)
$TT:=Size of array:C274(TbNumLabo)
ARRAY TEXT:C222($TbUUIDPersonne; $TT)
For ($Salé; 1; $TT)
	$UUIDLabo:=ASAPTrouveUUIDLaboParNumero(TbNumLabo{$Salé})
	$TbUUIDPersonne{$Salé}:=$UUIDLabo
End for 
$VarTbNumFacture:=ZTableauVersTexte(->TbNumFactureASA)
$VarTbUUIDPersonne:=ZTableauVersTexte(->$TbUUIDPersonne)
$p:=Execute on server:C373("ASAPTestDispoFactureServeur"; 0; "DispoFacture"; $VarTbNumFacture; $VarTbUUIDPersonne)
