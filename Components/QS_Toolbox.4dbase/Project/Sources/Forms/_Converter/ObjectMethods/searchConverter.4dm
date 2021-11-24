  //Searchpicker sample code

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		  // Init the var it(OBJECT Get pointer(Object current:K67:2))
		  // this can be done anywhere else in your code
		  // the let's customise the SearchPicker (if needed)
		
		C_BOOLEAN:C305($Customise)
		$Customise:=True:C214
		
		C_TEXT:C284($ObjectName)
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		
		  // The exemple below shows how to set a label (ex : "name") inside the search zone
		
		If ($Customise)
			
			SearchPicker SET HELP TEXT ($ObjectName;"Command or Constant")
			
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		CONVERTER_search 
		
End case 
