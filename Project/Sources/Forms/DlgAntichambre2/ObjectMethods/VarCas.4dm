
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		[DiaData:45]XValeur:4:=Num:C11(VarCas)
		SAVE RECORD:C53([DiaData:45])
End case 
