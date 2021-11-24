$Dem:=Request:C163("Quelle diapo ajouter ?"; "18432")
If (OK=1)
	$L1:=Find in array:C230(<>TbNumDia; Num:C11($Dem))
	$L2:=Find in array:C230(TbNumDiaNPC; $Dem)
	Case of 
		: ($L1<0)
			ALERT:C41("Désolé, la photo n°"+$Dem+" n'existe pas dans la collection...")
			
		: ($L2>0)
			ALERT:C41("La photo n°"+$Dem+" existe déjà dans les NPC...")
			
		Else 
			APPEND TO ARRAY:C911(TbNumDiaNPC; $Dem)
			READ WRITE:C146([DiaData:45])
			QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=String:C10([Diapositives:40]NumOrdreDiapos:1); *)
			QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="NPC")
			If (Records in selection:C76([DiaData:45])=0)
				CREATE RECORD:C68([DiaData:45])
				[DiaData:45]XNom:1:=String:C10([Diapositives:40]NumOrdreDiapos:1)
				[DiaData:45]XType:5:="NPC"
			End if 
			[DiaData:45]XTexteSup:8:=ZTableauVersTexte(->TbNumDiaNPC)
			SAVE RECORD:C53([DiaData:45])
			ZAmnistiePartielle(->[DiaData:45]; True:C214)
	End case 
	
End if 