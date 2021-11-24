//%attributes = {"lang":"fr"}
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 07/10/18, 08:08:21
// ----------------------------------------------------
// Paramètre : $1 = type de tarif
// ----------------------------------------------------
// Méthode : PrestationAfficheTarif
// Description
// Méthode qui affiche les tarifs pour le RAEMA Poudre
//  dans le formulaire projet DlgPrestations
// ----------------------------------------------------
//$Type:=$1[[1]]+"@"
$Année:=(VarNomAnnee-1)
//CHERCHER([Prestations];[Prestations]CodePrestation=$Type;*)
QUERY:C277([Prestations:26]; [Prestations:26]AnneePrestation:6=$Année)
SELECTION TO ARRAY:C260([Prestations:26]NomPrestation:3; Colonne1\
; [Prestations:26]PrixPrestation:4; Colonne2R\
; [Prestations:26]TauxTVAPrestation:5; Colonne3R\
; [Prestations:26]CodePrestation:2; CodePrestation)
$TT:=Size of array:C274(Colonne1)
ARRAY LONGINT:C221(AnnéePrestation; $TT)
For ($salé; 1; $TT)
	AnnéePrestation{$salé}:=VarNomAnnee
End for 

