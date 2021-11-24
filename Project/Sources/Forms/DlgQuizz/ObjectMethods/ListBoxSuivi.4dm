
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxSuivi";$C;$L)
		GOTO SELECTED RECORD:C245([QuizzSuivi:32];$L)
		QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]ID:1=[QuizzSuivi:32]IDQuestion:7)
End case 
