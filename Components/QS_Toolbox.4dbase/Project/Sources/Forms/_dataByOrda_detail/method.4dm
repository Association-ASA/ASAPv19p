C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		
		If (Form:C1466.ds=Null:C1517)
			Form:C1466.ds:=ds:C1482
		End if 
		C_TEXT:C284($class)
		If (Form:C1466.table=Null:C1517)
			For each ($class;Form:C1466.ds) While (Form:C1466.table=Null:C1517)
				Form:C1466.table:=Form:C1466.ds[$class]
			End for each 
		End if 
		If (Form:C1466.entity=Null:C1517)
			Form:C1466.entity:=Form:C1466.table.all().first()
		End if 
		
		DATA_displayDetail 
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		
		CANCEL:C270
		
End case 
