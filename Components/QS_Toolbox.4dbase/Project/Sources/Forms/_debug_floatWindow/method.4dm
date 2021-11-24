$evt:=Form event code:C388
Case of 
	: ($evt=On Load:K2:1)
		C_COLLECTION:C1488(messages)
		messages:=New collection:C1472
		Form:C1466.toSave:=False:C215
		SET TIMER:C645(2*60)  // 2 seconds
		
	: ($evt=On Timer:K2:25)
		messages:=messages
		OBJECT SET SCROLL POSITION:C906(*;"message_lb";messages.length)
		
End case 
