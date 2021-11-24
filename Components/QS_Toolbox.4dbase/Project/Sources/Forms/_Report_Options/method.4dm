Case of 
		
	: (Form event code:C388=On Load:K2:1)
		(OBJECT Get pointer:C1124(Object named:K67:5; "FileFormat"))->:=1
		(OBJECT Get pointer:C1124(Object named:K67:5; "Formulaire"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5; "Methodes"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5; "dbStructure"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5; "WithGraphviz"))->:=0
		OBJECT SET ENABLED:C1123(*; "WithGraphviz"; False:C215)
		OBJECT SET TITLE:C194(*; "txtinfo"; "")
		
	: (Form event code:C388=On Clicked:K2:4)
		$Methodes:=(OBJECT Get pointer:C1124(Object named:K67:5; "Methodes"))->
		OBJECT SET ENABLED:C1123(*; "WithGraphviz"; $Methodes=1)
		
		If ($Methodes=0)
			(OBJECT Get pointer:C1124(Object named:K67:5; "WithGraphviz"))->:=0
			OBJECT SET TITLE:C194(*; "txtinfo"; "")
		Else 
			OBJECT SET TITLE:C194(*; "txtinfo"; "Add method analysis execution time to the report creation.")
		End if 
		
	: (Form event code:C388=On Unload:K2:2)
		Form:C1466.Formulaire:=(OBJECT Get pointer:C1124(Object named:K67:5; "Formulaire"))->
		Form:C1466.Methodes:=(OBJECT Get pointer:C1124(Object named:K67:5; "Methodes"))->
		Form:C1466.Structure:=(OBJECT Get pointer:C1124(Object named:K67:5; "dbStructure"))->
		Form:C1466.WithGraphviz:=(OBJECT Get pointer:C1124(Object named:K67:5; "WithGraphviz"))->
		Form:C1466.FileFormat:=(OBJECT Get pointer:C1124(Object named:K67:5; "FileFormat"))->
		
End case 
