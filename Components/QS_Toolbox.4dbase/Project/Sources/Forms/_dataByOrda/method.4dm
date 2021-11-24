C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		
		If (Form:C1466.ds=Null:C1517)
			Form:C1466.ds:=ds:C1482
		End if 
		
		If (Form:C1466.table=Null:C1517)
			If (Form:C1466.tablelist=Null:C1517)
				Form:C1466.tablelist:=New collection:C1472
				C_TEXT:C284($class;$name)
				For each ($class;Form:C1466.ds)
					Form:C1466.tablelist.push($class)
				End for each 
			End if 
			C_POINTER:C301($ptr)
			$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"tablelist")
			COLLECTION TO ARRAY:C1562(Form:C1466.tablelist;$ptr->)
			If (Size of array:C274($ptr->)>0)
				$ptr->:=1
				$name:=$ptr->{1}
				Form:C1466.table:=Form:C1466.ds[$name]
				Form:C1466.tablename:=$name
				
			Else 
				OBJECT SET VISIBLE:C603(*;"tablelist";False:C215)
			End if 
		End if 
		
		DATA_DisplayListbox 
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		
		CANCEL:C270
		
End case 
