//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
ARRAY LONGINT:C221($tabElements; 0x0000)
$Search:=(OBJECT Get pointer:C1124(Object named:K67:5; OBJECT Get name:C1087(Object current:K67:2)))->

If ($Search="")
	SELECT LIST ITEMS BY POSITION:C381(*; "myLH"; -1)
	Form:C1466.indice:=0
	
Else 
	If (Length:C16($Search)>2)  // At least 3 characters
		$ItemRef:=Find in list:C952(*; "myLH"; "@"+$search+"@"; 1; $tabElements; *)
		SELECT LIST ITEMS BY REFERENCE:C630(Form:C1466.LH; $ItemRef; $tabElements)
		ARRAY TO COLLECTION:C1563(Form:C1466.found; $tabElements)
		If ($ItemRef#0)
			Form:C1466.indice:=1
		End if 
	End if 
End if 
LH_btn_updateStatus
$CurrentCommand:=String:C10(Form:C1466.found.length; "### ##0")+" reference(s) found."
displayInfo($CurrentCommand)