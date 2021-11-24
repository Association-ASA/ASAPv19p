//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 27/06/20, 11:32:00
// ----------------------------------------------------
// Méthode : 0

// Description
// Méthode qui recopie les imagettes (xxxxxi.jpg) 
//   et les images (xxxxx.jpg) dans le dossier Quizz
//   qui stocke les photos sans données AsaDia
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
C_PICTURE:C286($VarImage)

DOCUMENT LIST:C474(<>PermCheDossierAsaDiaQuizz; $TbNomDocQuizz; Ignorer invisibles:K24:16)
DOCUMENT LIST:C474(<>PermCheDossierAsaDiaWeb; $TbNomDocWeb; Ignorer invisibles:K24:16)
$ft:=Size of array:C274($TbNomDocWeb)
For ($Salé; 1; $FT)
	$NomFichierCourant:=$TbNomDocWeb{$Salé}
	// le fichier fait-il partie de la collection ?
	$NumDiapoN:=Num:C11($NomFichierCourant)
	$LiDiaColl:=Find in array:C230(<>TbDiaposNumOrdreDiapos; $NumDiapoN)
	$DiapoCollection:=($LiDiaColl>0)
	// existe t'il déjà dans <>PermCheDossierAsaDiaQuizz
	
	$L:=Find in array:C230($TbNomDocQuizz; $NomFichierCourant)
	If ($NomFichierCourant#"@is.jpg") & ($L<0) & ($DiapoCollection)
		$Source:=<>PermCheDossierAsaDiaWeb+$NomFichierCourant
		$NumDiapoA:=String:C10($NumDiapoN)
		$NumEnrDiaA:=String:C10(<>TbNumEnrDiapos{$LiDiaColl})
		$Cible:=<>PermCheDossierAsaDiaQuizz+"imagequizz"+Replace string:C233($NomFichierCourant; $NumDiapoA; $NumEnrDiaA)
		COPY DOCUMENT:C541($Source; $Cible)
	End if 
End for 
