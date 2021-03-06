//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 19/10/19, 10:32:53
// ----------------------------------------------------
// Paramètres
// ----------------------------------------------------
// Méthode : ZPipeletteServeurScrute
// Description
//  Gestion périodique

C_LONGINT:C283($Salé; $FT)


If (<>AJAR)
	$FT:=Size of array:C274(<>TbSigleInstitution)
	For ($Salé; 1; $FT)
		QuizzScruteNouvellesPhotos(<>TbSigleInstitution{$Salé})
	End for 
	
	// Suppression de fichiers dans le dossier des téléchargements
	DOCUMENT LIST:C474(<>PermCheDosTel; $TbNomsDoc; Ignorer invisibles:K24:16)
	$FT:=Size of array:C274($TbNomsDoc)
	For ($Salé; 1; $FT)
		$CDFichier:=<>PermCheDosTel+$TbNomsDoc{$Salé}
		GET DOCUMENT PROPERTIES:C477($CDFichier; $verrouillé; $invisible; $crééle; $crééà; $modifiéle; $modifiéà)
		$JourDif:=($crééle#Current date:C33)
		$Delta:=Current time:C178-$crééà
		If ($Delta>?00:02:00?) | ($JourDif)
			DELETE DOCUMENT:C159($CDFichier)
		End if 
		// ENDORMIR PROCESS(Numéro du process courant;2*60*60)  // Toutes les 2 mn
	End for 
	
	// Déplacement des fichiers de la DB <>PermCheDosPJCourrielSource vers le dossier Web
	ARRAY TEXT:C222($TbNomsDoc; 0)
	// Incorporation des PJ
	DOCUMENT LIST:C474(<>PermCheDosPJCourrielSource; $TbNomsDoc; Ignorer invisibles:K24:16)
	$FT:=Size of array:C274($TbNomsDoc)
	// Incorporation des fichiers des nouveaux rapports
	For ($Salé; 1; $FT)
		$Source:=<>PermCheDosPJCourrielSource+$TbNomsDoc{$Salé}
		$Cible:=<>PermCheDosPJCourrielWeb+$TbNomsDoc{$Salé}
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		MOVE DOCUMENT:C540($Source; $Cible)
	End for 
	
	DiaWebScruteListeLicences
	DiaPipeletteTraitement
	AsaContactScrute
End if 

