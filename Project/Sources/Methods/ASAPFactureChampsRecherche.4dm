//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 29/01/21, 15:22:11
// ----------------------------------------------------
// Méthode : ASAPFactureChampsRecherche
// Description
// Calcul le champs recherche de la table des factures
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$Champ:=[Factures:15]AdresseFacturation:5+" "+[Factures:15]CP:6+" "+String:C10([Factures:15]DateFacture:4)+" "+[Factures:15]NumBonCommande:14+" "+[Factures:15]NumFacture:3
$Champ:=$Champ+" "+[Factures:15]PaysFacturation:7+" "+String:C10([Factures:15]TotalHT:8)+" "+String:C10([Factures:15]TotalTTC:10)+" "+[Factures:15]UUIDPersonne:2+" "
RELATE MANY:C262([Factures:15]NumFacture:3)
SELECTION TO ARRAY:C260([Ventes:16]Intitule:3; $TbIntitulé)
$0:=$Champ+ZTableauVersTexte(->$TbIntitulé; " ")

