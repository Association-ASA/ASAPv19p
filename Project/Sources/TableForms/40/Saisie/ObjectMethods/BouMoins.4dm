C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxPhotosNPC";$C;$L)
If ($L=0)
	ALERT:C41("Merci de désigner une photo en cliquant sur son n°")
Else 
	CONFIRM:C162("Suprimer la photo n°"+TbNumDiaNPC{$L}+"???")
	If (OK=1)
		$NumPhtoNPCCourante:=TbNumDiaNPC{$L}
		DELETE FROM ARRAY:C228(TbNumDiaNPC;$L)
		READ WRITE:C146([DiaData:45])
		QUERY:C277([DiaData:45];[DiaData:45]XAlpha:14=$NumPhtoNPCCourante;*)
		QUERY:C277([DiaData:45]; & [DiaData:45]XNom:1=String:C10([Diapositives:40]NumOrdreDiapos:1);*)
		QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="NPCdd")
		DELETE SELECTION:C66([DiaData:45])
		QUERY:C277([DiaData:45];[DiaData:45]XNom:1=String:C10([Diapositives:40]NumOrdreDiapos:1);*)
		QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="NPC")
		If (Size of array:C274(TbNumDiaNPC)=0)
			DELETE RECORD:C58([DiaData:45])
			QUERY:C277([DiaData:45];[DiaData:45]XNom:1=String:C10([Diapositives:40]NumOrdreDiapos:1);*)
			QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="NPCdd")
			DELETE SELECTION:C66([DiaData:45])
		Else 
			[DiaData:45]XTexteSup:8:=ZTableauVersTexte (->TbNumDiaNPC)
			SAVE RECORD:C53([DiaData:45])
		End if 
		ZAmnistiePartielle (->[DiaData:45];True:C214)
	End if 
End if 