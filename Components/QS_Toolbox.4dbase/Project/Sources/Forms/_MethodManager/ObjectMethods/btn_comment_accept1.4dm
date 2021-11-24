$evt:=Form event code:C388
$formEvent:=FORM Event:C1606
If (OB Is defined:C1231($formEvent;"objectName"))
	$object:=$formEvent.objectName
End if 

Case of 
	: (Form event code:C388=On Mouse Enter:K2:33)
		OBJECT SET HELP TIP:C1181(*;$object;"Markdown guide")
		
	: (Form event code:C388=On Clicked:K2:4)
		
		CALL WORKER:C1389("QST_userGuide";"_userGuide";"markdown")
		
		  //OPEN URL("https://simplemde.com/markdown-guide")
		
End case 