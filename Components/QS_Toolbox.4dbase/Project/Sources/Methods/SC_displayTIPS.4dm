//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 19/04/18, 07:56:52
// ----------------------------------------------------
// Méthode : SC_displayTIPS
// Description
//  
//
// Paramètres
// ----------------------------------------------------

C_COLLECTION:C1488($tips; $result)
C_OBJECT:C1216($vals)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$tips:=New collection:C1472
$result:=New collection:C1472
$tips:=TOOLS_get_TIPS_under_collection

For each ($vals; $tips)
	$result.push(New object:C1471("method"; $vals.request; "type"; $vals.type; "tips"; $vals.tips))
End for each 

$Listbox_Name:="LB_Information"

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("request")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "PATTERN")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 40)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "TYPE")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "TIPS")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				
		End case 
	End for 
	LB_setHeights($Listbox_Name; 1; 2)
	LB_ResizeLine($Listbox_Name)
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$FenetreInformation:=String:C10($result.length)+" tips displayed."
	$color:="red"
	
Else 
	$FenetreInformation:="No TIP has been found."
	$color:="green"
End if 
displayInfo($FenetreInformation; $color)