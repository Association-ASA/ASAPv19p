//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
If (Form:C1466.ds=Null:C1517)
	Form:C1466.ds:=ds:C1482
End if 

C_TEXT:C284($class;$kind)
C_OBJECT:C1216($field)

If (Form:C1466.table=Null:C1517)
	For each ($class;Form:C1466.ds) While (Form:C1466.table=Null:C1517)
		Form:C1466.table:=Form:C1466.ds[$class]
	End for each 
End if 

If (Form:C1466.entity=Null:C1517)
	Form:C1466.entity:=Form:C1466.table.all().first()
End if 

Form:C1466.detail:=New collection:C1472
C_TEXT:C284($fieldname)
For each ($fieldname;Form:C1466.entity)
	$field:=New object:C1471
	$field.content:=Form:C1466.entity[$fieldname]
	$field.name:=$fieldname
	$kind:=Form:C1466.table[$fieldname].kind
	
	Case of 
		: ($kind="storage")
			$type:=Value type:C1509($field.content)
			If (($type#Is picture:K8:10) & ($type#Is BLOB:K8:12) & ($type#Is object:K8:27))
				Form:C1466.detail.push($field)
			End if 
			
		: ($kind="relatedEntity")
			$field.content:=Form:C1466.table[$fieldname].relatedDataClass
			$field.kind:=$kind
			Form:C1466.detail.push($field)
			
		: ($kind="relatedEntities")
			$field.content:=Form:C1466.table[$fieldname].relatedDataClass
			$field.kind:=$kind
			Form:C1466.detail.push($field)
		Else 
			  //???
	End case 
End for each 