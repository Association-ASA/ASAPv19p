
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY TEXT:C222(PUMTypeAsaDia;2)
		PUMTypeAsaDia{1}:="Asadia Animaux domestiques"
		PUMTypeAsaDia{2}:="Asadia Gibier"
		
	: ($evt=Sur données modifiées:K2:15)
		If (PUMTypeAsaDia=1)
			DiaSuiviConnexions 
		Else 
			DiaSuiviConnexions (True:C214)
		End if 
End case 

