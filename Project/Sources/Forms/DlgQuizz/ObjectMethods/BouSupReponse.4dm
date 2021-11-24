If (Records in set:C195("$ListboxSetR")=1)
	CUT NAMED SELECTION:C334([QuizzReponses:33];"selr")
	USE SET:C118("$ListboxSetR")
	CONFIRM:C162("Détruire la réponse "+[QuizzReponses:33]LibelReponse:3+" ???")
	If (OK=1)
		DELETE RECORD:C58([QuizzReponses:33])
	End if 
	USE NAMED SELECTION:C332("selr")
	  // EFFACER SÉLECTION("selr")
End if 
