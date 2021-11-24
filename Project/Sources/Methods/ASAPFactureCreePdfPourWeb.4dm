//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 26/01/21, 14:50:58
  // ----------------------------------------------------
  // Méthode : ASAPFactureCreePdfPourWeb
  // Description
  // Méthode qui fait les pDF et les place dans le dossier
  // Facture sur le serveur
  // 
  // Paramètres : $1=NumAdh $2=NumFacture
  // ----------------------------------------------------
C_TEXT:C284($3;$NumFacture)
$NumAdhA:=$1
$NomFacture:=$2
$NumFacture:=$3
QUERY:C277([Factures:15];[Factures:15]NumFacture:3=$NumFacture)
RELATE MANY:C262([Factures:15]NumFacture:3)

$ChemCible:=<>PermCheDosFac+$NumAdhA+Séparateur dossier:K24:12
$DocFac:=$ChemCible+$NomFacture

If (Test path name:C476($ChemCible)#Est un dossier:K24:2)
	CREATE FOLDER:C475($ChemCible)
End if 
If (Test path name:C476($DocFac)=Est un document:K24:1)
	DELETE DOCUMENT:C159($DocFac)
End if 
ZPDFImprimer ($NomFacture;$ChemCible;"ASAPImprimeFacture")
