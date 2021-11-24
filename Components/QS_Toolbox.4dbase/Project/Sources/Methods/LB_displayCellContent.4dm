//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
If (Form:C1466.result.length>0)
	C_LONGINT:C283($line; $column)
	
	$NomObj:=OBJECT Get name:C1087(Object current:K67:2)
	LISTBOX GET CELL POSITION:C971(*; $NomObj; $column; $line)
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232(Form:C1466.result[$line-1]; $tabPropertyNames)
	
	If ($column>0)
		Form:C1466.column:=$tabPropertyNames{$column}
		SearchPicker SET HELP TEXT("Search"; Form:C1466.column)
	End if 
	
	$type:=Value type:C1509(Form:C1466.currentElement[Form:C1466.column])
	Case of 
		: ($type=Is collection:K8:32)
			displayInfo(Form:C1466.currentElement[Form:C1466.column].join("; "))
			
		: ($type=Is longint:K8:6) | ($type=Is real:K8:4)
			displayInfo(String:C10(Form:C1466.currentElement[Form:C1466.column]))
			
		Else 
			displayInfo(Form:C1466.currentElement[Form:C1466.column])
	End case 
End if 