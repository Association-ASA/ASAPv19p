If (Form event code:C388=On Data Change:K2:15)
	
	$Search:=(OBJECT Get pointer:C1124(Object named:K67:5;OBJECT Get name:C1087(Object current:K67:2)))->
	
	Case of 
		: (Length:C16($Search)=0)
			Form:C1466.allVersion:=Form:C1466.allVersionTemp.copy()
			
		: (Length:C16($Search)>=2)
			Form:C1466.allVersion:=Form:C1466.allVersionTemp.filter("CM_displayByType";"@"+$Search+"@")
			
	End case 
	Form:C1466.oldVersion:=""
	Form:C1466.currentVersion:=""
	(OBJECT Get pointer:C1124(Object named:K67:5;"Compteur"))->:=Form:C1466.allVersion.length
	
End if 