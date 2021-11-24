// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 02/04/18, 07:06:15
// ----------------------------------------------------
// Méthode : DlgAntichambre.BouOuvre
// Description
// Permet d'ouvrir un dossier 
// et d'en lister le contenu dans la LB ListBoxCDFichiers
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$CD:=Select folder:C670("Quel dossier ??")
If (OK=1)
	DiaAC1ScruteDossierPhotos($CD)
	$TT:=Size of array:C274(TbCheminFichier)
	$Type:="AjoutDia"+(Num:C11(VarPOD=1)*"POD")
	QUERY:C277([DiaData:45]; [DiaData:45]XType:5=$Type)
	SELECTION TO ARRAY:C260([DiaData:45]XTexte:7; $TbCheminsDiaFaites)
	ARRAY LONGINT:C221(TbCouleurAC; $TT)
	ARRAY TEXT:C222(TbNomFichier; $TT)
	For ($Salé; 1; $TT)
		TbNomFichier{$Salé}:=ZDocNomFichier(TbCheminFichier{$Salé}; 0)
		If (Find in array:C230($TbCheminsDiaFaites; TbCheminFichier{$Salé})<0)
			TbCouleurAC{$Salé}:=0x00FFFFFF
		Else 
			TbCouleurAC{$Salé}:=0x00FFAAAA
		End if 
	End for 
	LISTBOX SELECT ROW:C912(*; "ListBoxCDFichiers"; 0; lk supprimer de sélection:K53:3)
End if 