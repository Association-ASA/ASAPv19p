
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		C_LONGINT:C283($C;$L)
		C_PICTURE:C286(VarPhotoSup)
		
		LISTBOX GET CELL POSITION:C971(*;"ListBoxPhotosSup";$C;$L)
		GOTO SELECTED RECORD:C245([DiaData:45];$L)
		$NomFichierImage:="Q"+[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2;"00000")+"i.jpg"
		$cd:=<>CDPhotosSauveAsaDia+$NomFichierImage
		READ PICTURE FILE:C678($CD;VarPhotoSup)
End case 
