//%attributes = {}
C_LONGINT:C283($Salé;$FT)
$CD:=Select folder:C670("Quel dossier ??")
If (OK=1)
	ARRAY TEXT:C222(TbCheminFichier;0)
	DiaAC1ScruteDossierPhotos ($CD)
	$TT:=Size of array:C274(TbCheminFichier)
	ARRAY TEXT:C222(TbNomFichier;$TT)
	For ($Salé;1;$TT)
		TbNomFichier{$Salé}:=Replace string:C233(TbCheminFichier{$Salé};$CD;"")
	End for 
	
	QUERY:C277([DiaData:45];[DiaData:45]XType:5="AjoutDia")
	VarNumSérie:=Max:C3([DiaData:45]XValeur:4)+1
	LISTBOX SELECT ROW:C912(*;"ListBoxCDFichiers";0;lk supprimer de sélection:K53:3)
End if 
  // YAjusteNumAutomatique (->[QuizzReponses]ID)