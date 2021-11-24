//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($fieldname;$detail)
C_OBJECT:C1216($entity;$field)
C_COLLECTION:C1488($coll)
$coll:=New collection:C1472

If (Form:C1466.selection=Null:C1517) | (Form:C1466.selection.length=0)
	If (Form:C1466.tablelist.length>0)
		Form:C1466.selection:=Form:C1466.table.all()
	End if 
End if 

$count:=0

For each ($entity;Form:C1466.selection) Until ($count=1)
	$count:=$count+1
	For each ($fieldname;$entity)
		$field:=New object:C1471("content";$entity[$fieldname])
		  //$field.content:=$entity[$fieldname]
		$type:=Value type:C1509($field.content)
		  //$kind:=Form.table[$fieldname].kind
		
		If (($type#Is picture:K8:10) & ($type#Is BLOB:K8:12) & ($type#Is object:K8:27))
			$detail:=$detail+$fieldname+"\t"
		End if 
	End for each 
	$coll.push($detail)
	
End for each 


For each ($entity;Form:C1466.selection)
	
	$detail:=""
	For each ($fieldname;$entity)
		$field:=New object:C1471("content";$entity[$fieldname])
		  //$field.content:=$entity[$fieldname]
		$type:=Value type:C1509($field.content)
		  //$kind:=Form.table[$fieldname].kind
		
		If (($type#Is picture:K8:10) & ($type#Is BLOB:K8:12) & ($type#Is object:K8:27))
			$detail:=$detail+String:C10($entity[$fieldname])+"\t"
		End if 
		
	End for each 
	
	$coll.push($detail)
End for each 

$detail:=$coll.join("\r")
SET TEXT TO PASTEBOARD:C523($detail)
$info:=String:C10(Form:C1466.selection.length)+" entity(ies) copied and set into the pasteboard."
displayInfo ($info)
