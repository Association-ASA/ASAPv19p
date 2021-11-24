//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 03/02/21, 11:28:31
  // ----------------------------------------------------
  // Méthode : ASAPFactureNomDocPdfWeb
  // Description
  // Méthode qui calcul le nom du PDF
  // A exécuter avec ASAPFactureCreePdfPourWeb (sur le serveur)
  // ----------------------------------------------------
$NomFacture:=Replace string:C233([Factures:15]NumFacture:3;"/";"_")+".pdf"
$Identificateur:=[Personnes:12]Identificateur:4
$NumFacture:=[Factures:15]NumFacture:3
$NumAdhA:=String:C10(RAEMADemoduleMdPWeb ($Identificateur;True:C214))

$Prc:=Execute on server:C373("ASAPFactureCreePdfPourWeb";0;"FactureDansWeb";$NumAdhA;$NomFacture;$NumFacture)