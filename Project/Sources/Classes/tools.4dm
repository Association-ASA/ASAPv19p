Class constructor($coll : Collection)
	
	This:C1470.coll:=$coll
	
Function toStorage($racine : Text; $destination : Text)
	
	Use (Storage:C1525)
		If (Storage:C1525[$racine]=Null:C1517)
			Storage:C1525[$racine]:=New shared object:C1526
		End if 
		
		Use (Storage:C1525[$racine])
			Storage:C1525[$racine][$destination]:=This:C1470.coll.copy(ck shared:K85:29)
		End use 
		
	End use 
	