//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 30/09/21, 10:36:38
// ----------------------------------------------------
// Méthode : ASAPFactureBilanImpayés
// Description
// Ouvre le formulaire de bilan des impayés
//
// ----------------------------------------------------
CUT NAMED SELECTION:C334([Factures:15]; "$sel")
$F:=Open form window:C675("DlgBilanImpaye")
DIALOG:C40("DlgBilanImpaye")
CLOSE WINDOW:C154
USE NAMED SELECTION:C332("$sel")