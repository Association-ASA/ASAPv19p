  //Searchpicker sample code

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305($Customise)
		C_TEXT:C284($ObjectName)
		
		$Customise:=True:C214
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		If ($Customise)
			SearchPicker SET HELP TEXT ($ObjectName;"First column ...")
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		$Search:=(OBJECT Get pointer:C1124(Object named:K67:5;OBJECT Get name:C1087(Object current:K67:2)))->
		Form:C1466.result:=New collection:C1472
		
		If (Form:C1466.resultCopy#Null:C1517)
			Case of 
				: ($Search#"")
					ON ERR CALL:C155("BASE_noERROR")
					Form:C1466.result:=Form:C1466.resultCopy.filter("SC_search";Form:C1466.column;"@"+$search+"@")
					ON ERR CALL:C155("")
					
				: ($Search="")
					Form:C1466.result:=Form:C1466.resultCopy.copy()
			End case 
			
		End if 
		
End case 

