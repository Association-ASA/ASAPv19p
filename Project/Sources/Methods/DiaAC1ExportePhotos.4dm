//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 09/09/20, 19:35:29
// ----------------------------------------------------
// Méthode : DiaAC1ExportePhotos
// Description
// Méthode qui exporte les photos de la séléction 
//  vers un dossier choisi par l'utilisateur
// ----------------------------------------------------
$CDDoc:=Select folder:C670("Où voulez-vous recopier les photos ?")
If (OK=1)
	SELECTION TO ARRAY:C260([DiaData:45]XTexte:7; $TbCDOrigine)
	$FT:=Size of array:C274($TbCDOrigine)
	For ($Salé; 1; $FT)
		$Source:=$TbCDOrigine{$Salé}
		ARRAY TEXT:C222($TbFichierCourant; 0)
		ZTexteVersTableau($Source; ->$TbFichierCourant; Séparateur dossier:K24:12)
		$Cible:=$CDDoc+$TbFichierCourant{Size of array:C274($TbFichierCourant)}
		COPY DOCUMENT:C541($Source; $Cible)
	End for 
End if 