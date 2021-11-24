If (Records in set:C195("$ListboxSetQn")=1)
	USE SET:C118("$ListboxSetQn")
	CONFIRM:C162("Détruire la question "+[QuizzQuestions:34]LibelQuestion:3+" ???")
	If (OK=1)
		$EL:=Read only state:C362([QuizzQuestions:34])
		If ($EL)
			ZVerrouAttendre (->[QuizzQuestions:34])
		End if 
		DELETE RECORD:C58([QuizzQuestions:34])
		If ($EL)
			ZAmnistiePartielle (->[QuizzQuestions:34])
		End if 
	End if 
	QuizzAfficheLeQuestionnaire (PUMQuestionnaire)
	  // EFFACER SÉLECTION("selq")
End if 
