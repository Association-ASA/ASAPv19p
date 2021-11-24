//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 30/07/20, 19:58:07
// ----------------------------------------------------
// Méthode : DiaAC1ScruteDossierPhotos
// Description
// Méthode générique qui scrute un dossier passé en paramètre
//   en enrichissant les tableaux des chemins de chaque document
//   du dossier initial et des sous dossiers
// Paramètre chemin du dossier à scruter
// ----------------------------------------------------

$CD:=$1

ARRAY TEXT:C222($TbNomFichier; 0)
DOCUMENT LIST:C474($CD; $TbNomFichier; Ignorer invisibles:K24:16)
$FT:=Size of array:C274($TbNomFichier)
ARRAY TEXT:C222($TbCheminFichier; $FT)
For ($Salé; 1; $FT)
	APPEND TO ARRAY:C911(TbCheminFichier; $CD+$TbNomFichier{$Salé})
End for 
ARRAY TEXT:C222($TbNomDossier; 0)
FOLDER LIST:C473($CD; $TbNomDossier)
$FT:=Size of array:C274($TbNomDossier)
For ($Salé; 1; $FT)
	VarNumSérie:=VarNumSérie+1
	$CD2:=$CD+$TbNomDossier{$Salé}+Séparateur dossier:K24:12
	DiaAC1ScruteDossierPhotos($CD2)
End for 
