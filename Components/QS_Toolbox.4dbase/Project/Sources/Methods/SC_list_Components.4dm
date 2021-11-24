//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
ARRAY TEXT:C222($tabComponantName; 0x0000)
C_COLLECTION:C1488($result)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
COMPONENT LIST:C1001($tabComponantName)
ARRAY TEXT:C222($tabEmpty; Size of array:C274($tabComponantName))
ARRAY TO COLLECTION:C1563($result; $tabComponantName; "method"; $tabEmpty; "empty")

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 170)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Component list")
				
			: ($i=2)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
		
	End for 
	
	LB_setHeights($Listbox_Name; 1; 2)
	LB_ResizeLine($Listbox_Name)
	
End if 
$txt:=String:C10($result.length)+" componant(s) found."
displayInfo($txt)