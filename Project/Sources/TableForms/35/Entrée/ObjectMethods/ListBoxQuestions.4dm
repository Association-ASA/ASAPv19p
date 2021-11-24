
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		RELATE MANY:C262([QuizzQuestions:34]ID:1)
		ORDER BY:C49([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5; >)
		
End case 
