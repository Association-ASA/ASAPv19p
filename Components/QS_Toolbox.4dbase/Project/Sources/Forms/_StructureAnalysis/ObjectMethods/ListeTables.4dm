$evt:=Form event code:C388

Case of 
	: ($evt=On Selection Change:K2:29)
		Case of 
			: (FORM Get current page:C276=1)
				STRCT_displayTableInformation 
				
			: (FORM Get current page:C276=2)
				STRCT_selectRelation 
				
		End case 
		
		
	: ($evt=On Double Clicked:K2:5)
		
		C_LONGINT:C283($position)
		OBJECT SET VISIBLE:C603(*;"Zone_Web";False:C215)
		$position:=Form:C1466.posCurrentTable-1
		If ($position>=0)
			
			If (Storage:C1525.structureTable[$position].id>0)
				$NumTable:=Storage:C1525.structureTable[$position].id
				If ($NumTable>0)
					  //%W-533.3
					$pbj:=(OBJECT Get pointer:C1124(Object named:K67:5;"SQLCommands"))->
					$pbj:=$pbj+" "+Uppercase:C13(Table name:C256($NumTable))+" "
					(OBJECT Get pointer:C1124(Object named:K67:5;"SQLCommands"))->:=$pbj
					  //%W+533.3
					
				End if 
			End if 
			
		End if 
		
End case 