//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
ARRAY TEXT:C222($tabPlugName; 0x0000)
ARRAY LONGINT:C221($tabPlugID; 0x0000)
C_COLLECTION:C1488($result)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
PLUGIN LIST:C847($tabPlugID; $tabPlugName)
ARRAY TEXT:C222($tabEmpty; Size of array:C274($tabPlugID))
ARRAY TEXT:C222($tabPlugIDTxt; Size of array:C274($tabPlugID))
For ($a; 1; Size of array:C274($tabPlugIDTxt))
	$tabPlugIDTxt{$a}:=String:C10($tabPlugID{$a})
End for 
ARRAY TO COLLECTION:C1563($result; $tabPlugName; "method"; $tabPlugIDtxt; "id"; $tabEmpty; "empty")

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Plugin name")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 140)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Plugin ID")
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 1; 2)
	LB_ResizeLine($Listbox_Name)
End if 

$txt:=String:C10($result.length)+" Plugin found."
displayInfo($txt)