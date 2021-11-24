//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 31/03/18, 20:18:54
// Modifié par : PE (08/11/2019)
// ----------------------------------------------------
// Méthode : SC_list_styleSheets
// Description
//  
//
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($tbStyle; 0x0000)
C_LONGINT:C283($l; $Size; $styles)
C_TEXT:C284($police)
C_COLLECTION:C1488($result)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
LIST OF STYLE SHEETS:C1255($tbStyle)
APPEND TO ARRAY:C911($tbStyle; "__automatic_additional_text__")
APPEND TO ARRAY:C911($tbStyle; "__automatic_main_text__")

For ($l; 1; Size of array:C274($tbStyle))
	GET STYLE SHEET INFO:C1256($tbStyle{$l}; $police; $Size; $styles)
	$result.push(New object:C1471("method"; $tbStyle{$l}; "police"; $police; "size"; $Size; "style"; Choose:C955($styles; "Plain"; "Bold"; "Italic"; "Bold & Italic"; "Underline"; "Bold and Underline"; "Italic and Underline"); "empty"; ""))
End for 

// -----------------------

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($a; 1; Size of array:C274($tabPropertyNames))
		Case of 
			: ($a=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($a); Uppercase:C13("style"))
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$a}; 220)
				
			: ($a=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$a}; 150)
				
			: ($a=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$a}; 80)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$a}; Align center:K42:3)
				
			: ($a=4)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$a}; 220)
				
			: ($a=5)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($a); "")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 1; 2)
	LB_ResizeLine($Listbox_Name)
	
	ARRAY LONGINT:C221($MyEventsOnLB; 1)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$txt:="Found: "+String:C10($result.length)+" Style Sheets."
	displayInfo($txt)
	
End if 