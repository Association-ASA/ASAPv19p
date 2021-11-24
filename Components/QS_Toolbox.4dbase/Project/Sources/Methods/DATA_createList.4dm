//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
If (Form:C1466.ds=Null:C1517)
	Form:C1466.ds:=ds:C1482
End if 

If (Form:C1466.table=Null:C1517)
	If (Form:C1466.tablelist=Null:C1517)
		Form:C1466.tablelist:=New collection:C1472
		Form:C1466.selection:=New collection:C1472
		Form:C1466.tablename:=""
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
		Form:C1466.list:=Form:C1466.table.all()
	End if 
	
Else 
	OBJECT SET VISIBLE:C603(*;"tablelist";False:C215)
End if 

DATA_DisplayListbox 