
Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		C_BOOLEAN:C305($Customise)
		$Customise:=True:C214
		C_TEXT:C284($ObjectName)
		$ObjectName:=OBJECT Get name:C1087(Object current:K67:2)
		If ($Customise)
			SearchPicker SET HELP TEXT ($ObjectName;"Method name")
		End if 
		(OBJECT Get pointer:C1124(Object named:K67:5;"Compteur1"))->:=Form:C1466.exported.length
		
	: (Form event code:C388=On Data Change:K2:15)
		$Search:=(OBJECT Get pointer:C1124(Object named:K67:5;OBJECT Get name:C1087(Object current:K67:2)))->
		
		Case of 
			: (Length:C16($Search)=0)
				Form:C1466.exported:=Form:C1466.allVersionTemp.copy()
				
			: (Length:C16($Search)>=2)
				Form:C1466.exported:=Form:C1466.allVersionTemp.filter("CM_displayByType";"@"+$Search+"@")
				
		End case 
		Form:C1466.oldVersion:=""
		Form:C1466.currentVersion:=""
		Form:C1466.exported:=Form:C1466.exported
		(OBJECT Get pointer:C1124(Object named:K67:5;"Compteur1"))->:=Form:C1466.exported.length
		
End case 

