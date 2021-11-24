C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		
		DATA_createList 
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		CANCEL:C270
		
End case 