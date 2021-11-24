$Evt:=Form event code:C388
Case of 
	: ($Evt=Sur clic:K2:4)
		
		QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=TbNomsAuteurs{TbNomsAuteurs}; *)
		QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="Aut")
		FORM SET INPUT:C55([DiaData:45]; "Tout")
		If (Records in selection:C76([DiaData:45])=0)
			//  FIXER TEXTE DANS CONTENEUR(TbNomsAuteurs{TbNomsAuteurs})
			ADD RECORD:C56([DiaData:45])
		End if 
		If (Macintosh command down:C546)
			READ WRITE:C146([DiaData:45])
			MODIFY RECORD:C57([DiaData:45]; *)
		End if 
		If (Windows Alt down:C563)
			ZVerrouAttendre(->[DiaData:45])
			CONVERT PICTURE:C1002([DiaData:45]XImage:6; ".jpg")
			SAVE RECORD:C53([DiaData:45])
		End if 
		VarImageAuteur:=[DiaData:45]XImage:6
		VarPedigree:=[DiaData:45]XTexte:7
		
		
		
End case 
