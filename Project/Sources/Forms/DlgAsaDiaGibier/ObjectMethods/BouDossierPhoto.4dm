
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		$VarCDDossierPhotos:=Select folder:C670("Où se trouve le dossier des photos ?")
		If (OK=1)
			VarCDDossierPhotos:=$VarCDDossierPhotos
		Else 
			VarCDDossierPhotos:=""
		End if 
End case 
