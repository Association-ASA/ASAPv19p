//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/12/17
  // ----------------------------------------------------
  // Méthode : SC_checkSetName
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
  // Following discussion on http://forums.4d.com/Post/FR/21949953/3/21998331#21998331

ARRAY TEXT:C222($tableau2D;0;0)
C_TEXT:C284($Motif;$path)
C_LONGINT:C283($countedMethods)
C_COLLECTION:C1488($result;$pattern)
C_OBJECT:C1216($methodToCheck)

$Listbox_Name:="LB_Information"
LB_Init_Start ($Listbox_Name)

$pattern:=New collection:C1472
$result:=New collection:C1472

$pattern.push("116";"140";"185")
$countedMethods:=Storage:C1525.allMethods.length

For each ($methodToCheck;Storage:C1525.allMethods)
	
	For each ($includedtoken;$pattern)  // For each item of the pattern
		$includedSetName:=":C"+$includedtoken
		
		If ($methodToCheck.commandToken.indexOf($includedSetName)#-1)  // One command setting a name has been found, so we have to check all method path
			
			$path:=$methodToCheck.name
			METHOD GET CODE:C1190($path;$MethText;*)  // this is the code of method to check (lastest version)
			
			$Motif:="(?mi-s)"+Command name:C538(116)+"(\\((.*);(.*?)\\))"  // CREATE SET
			If (REGEX_ExtractText ($Motif;$MethText;"1 2 3";->$tableau2D;0)=0)
				For ($i;1;Size of array:C274($tableau2D))
					$result.push(New object:C1471("command";Command name:C538(116);"method";$path;"result";$tableau2D{$i}{3};"tableName";$tableau2D{$i}{2}))
				End for 
			End if 
			
			$Motif:="(?mi-s)"+Command name:C538(140)+"(\\((.*);(.*?)\\))"  // CREATE EMPTY SET
			If (REGEX_ExtractText ($Motif;$MethText;"1 2 3";->$tableau2D;0)=0)
				For ($i;1;Size of array:C274($tableau2D))
					$result.push(New object:C1471("command";Command name:C538(140);"method";$path;"result";$tableau2D{$i}{3};"tableName";$tableau2D{$i}{2}))
				End for 
			End if 
			$Motif:="(?mi-s)"+Command name:C538(185)+"(\\((.*);(.*);(.*?)\\))"  // LOAD SET
			If (REGEX_ExtractText ($Motif;$MethText;"1 2 3 4";->$tableau2D;0)=0)
				For ($i;1;Size of array:C274($tableau2D))
					$result.push(New object:C1471("method";$path;"table";$tableau2D{$i}{2};"command";Command name:C538(185);"result";$tableau2D{$i}{3}))
				End for 
			End if 
		End if 
		
	End for each 
End for each 

If ($result.length>0)
	LB_buildByCollection ($result;$Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames;0x0000)
	OB GET PROPERTY NAMES:C1232($result[0];$tabPropertyNames)
	
	For ($i;1;Size of array:C274($tabPropertyNames))
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};300)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Command Name")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};300)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Method Path Name")
				
			: ($i=3)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};300)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Set Name")
				
			: ($i=4)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};300)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Table Name")
				
		End case 
	End for 
	
	ARRAY LONGINT:C221($MyEventsOnLB;2)
	$MyEventsOnLB{1}:=On Double Clicked:K2:5
	$MyEventsOnLB{2}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*;$Listbox_Name;$MyEventsOnLB;Enable events disable others:K42:37)
	
	$txt:=String:C10($result.length)+" set used.\nCheck for duplicate."
Else 
	$txt:="No set found."
End if 
displayInfo ($txt)
