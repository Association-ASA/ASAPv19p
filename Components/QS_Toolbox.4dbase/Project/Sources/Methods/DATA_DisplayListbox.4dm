//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}

C_TEXT:C284($class;$field)
If (Form:C1466.table=Null:C1517)
	For each ($class;Form:C1466.ds) While (Form:C1466.table=Null:C1517)
		Form:C1466.table:=Form:C1466.ds[$class]
	End for each 
End if 

If (Form:C1466.list#Null:C1517) & (Form:C1466.table#Null:C1517)
	Form:C1466.list:=Form:C1466.table.all()
	
	C_COLLECTION:C1488($fieldcol)
	C_LONGINT:C283($i)
	C_TEXT:C284($formula)
	C_OBJECT:C1216($entity)
	$fieldcol:=New collection:C1472
	
	  // needed to test field type
	$entity:=Form:C1466.table.all().first()
	LISTBOX DELETE COLUMN:C830(*;"listbox";1;999)
	If (Not:C34(OB Is empty:C1297($entity)))
		For each ($field;Form:C1466.table) While ($fieldcol.length<15)
			If (Form:C1466.table[$field].kind="storage")
				$type:=Value type:C1509($entity[$field])
				If (($type#Is picture:K8:10) & ($type#Is BLOB:K8:12) & ($type#Is object:K8:27))
					$fieldcol.push(New object:C1471("name";Form:C1466.table[$field].name))
				End if 
			End if 
		End for each 
		
		C_POINTER:C301($nil)
		For ($i;0;$fieldcol.length-1)
			$formula:="This[\""+$fieldcol[$i].name+"\"]"
			LISTBOX INSERT COLUMN FORMULA:C970(*;"Listbox";999;$fieldcol[$i].name;$formula;Is text:K8:3;"QS_header"+String:C10($i);$nil)
			OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);$fieldcol[$i].name)
		End for 
	End if 
End if 
