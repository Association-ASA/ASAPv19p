//%attributes = {"invisible":true}
// SC_conversionLogs
// Parameters:
// 
// ----------------------------------------------------
// Description:
// 
// ----------------------------------------------------
// Creation: Patrick EMANUEL, 22/11/20, 10:07:34
//


C_COLLECTION:C1488($paths; $result)
C_OBJECT:C1216($obj)
ARRAY TEXT:C222($tbObjProp; 0x0000)
ARRAY TEXT:C222($tbPropToHave; 6)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
$paths:=getConvertToProjectLogs

If ($paths.length>0)
	$path:=Folder:C1567(Folder:C1567(fk logs folder:K87:17).platformPath; fk platform path:K87:2)
	$obj:=JSON Parse:C1218(Document to text:C1236($paths[0].platformPath))
	$paths:=$obj.messages
	
	$tbPropToHave{1}:="form"
	$tbPropToHave{2}:="message"
	$tbPropToHave{3}:="object"
	$tbPropToHave{4}:="severity"
	$tbPropToHave{5}:="table"
	$tbPropToHave{6}:="tableName"
	
	
	For each ($obj; $paths)
		OB GET PROPERTY NAMES:C1232($obj; $tbObjProp)
		
		For ($a; 1; Size of array:C274($tbPropToHave))
			
			$p:=Find in array:C230($tbObjProp; $tbPropToHave{$a})
			If ($p<0)
				If ($a#5)
					$obj[$tbPropToHave{$a}]:="-"
				Else 
					$obj[$tbPropToHave{$a}]:=0
				End if 
				
			End if 
		End for 
		
		
	End for each 
	
	$result:=$paths.copy()
End if 


If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $tabPropertyNames{$i}; Align center:K42:3)
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Message")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 400)
				LISTBOX SET PROPERTY:C1440(*; "QS_Col_"+$tabPropertyNames{$i}; lk allow wordwrap:K53:39; True:C214)
				
			: ($i=2)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Severity")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 80)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Form")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				
			: ($i=4)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Widget")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 150)
				
			: ($i=5)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table Num")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 100)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				
			: ($i=6)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table Name")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 3; 2)
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
End if 
$txt:="Found "+String:C10($result.length)+" index defined."
displayInfo($txt; "blue")

