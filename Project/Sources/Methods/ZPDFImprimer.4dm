//%attributes = {}
  //ZPDFImprimer V12 du 12/01/2013
  // Imprime tout un document dans une tâche unique d'impression
  // $1 : Nom du fichier
  //$2 : Chemin du dossier d'impression
  // $3 = méthode à exécuter pour créer le Pdf et 
  // $4 = Paramètres de la méthode à exécuter
$NomFichier:=$1
$CheminDossier:=$2
$NomMethode:=$3
ZPDFInitPrinter ($NomFichier;$CheminDossier)
OPEN PRINTING JOB:C995
If (Count parameters:C259=3)
	EXECUTE METHOD:C1007($NomMethode)
Else 
	EXECUTE METHOD:C1007($NomMethode;*;$4)
End if 
CLOSE PRINTING JOB:C996
  // ZPDFRestoreRegistre 


