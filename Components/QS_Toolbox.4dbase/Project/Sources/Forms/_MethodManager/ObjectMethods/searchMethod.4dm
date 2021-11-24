  //Searchpicker sample code

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305($Customise)
		C_TEXT:C284($ObjectName)
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"cb1"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"cb2"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"cb3"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"cb4"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"cb5"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"cb6"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"cb7"))->:=0
		
		$Customise:=True:C214
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		If ($Customise)
			SearchPicker SET HELP TEXT ($ObjectName;"Method name")
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		MM_startSearch 
		
End case 

