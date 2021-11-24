//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// ----------------------------------------------------
// Méthode : SC_4DServer_Optimizer
// Description
//  
//
// Paramètres
// ----------------------------------------------------

C_OBJECT:C1216($method; $command)
C_COLLECTION:C1488($QS_TBX_TIPS; $result)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$QS_TBX_TIPS:=New collection:C1472
$result:=New collection:C1472

// DELETE SELECTION
$QS_TBX_TIPS.push(New object:C1471("token"; 66; \
"request"; Command name:C538(66); \
"tips"; "After "+Command name:C538(66)+" has executed, you can test the LockedSet to see if any records were locked."))

// APPLY TO SELECTION 
$QS_TBX_TIPS.push(New object:C1471("token"; 70; \
"request"; Command name:C538(70); \
"tips"; Command name:C538(70)+": the server does not execute any of the commands that may be passed in statement. Every record in the selection will be sent back to the local workstation to be modified."))

// APPLY TO SELECTION 
$QS_TBX_TIPS.push(New object:C1471("token"; 70; \
"request"; Command name:C538(70); \
"tips"; "After "+Command name:C538(70)+" has executed, you can test the LockedSet to see if any records were locked."))

// SELECTION TO ARRAY
$QS_TBX_TIPS.push(New object:C1471("token"; 260; \
"request"; Command name:C538(260); \
"tips"; "With the * parameter, 4D does not execute the corresponding statement line immediately but only with the last call of "+Command name:C538(260)))

// ARRAY TO SELECTION
$QS_TBX_TIPS.push(New object:C1471("token"; 261; \
"request"; Command name:C538(261); \
"tips"; "With the * parameter, 4D does not execute the corresponding statement line immediately but only with the last call of "+Command name:C538(261)))

// ARRAY TO SELECTION
$QS_TBX_TIPS.push(New object:C1471("token"; 261; \
"request"; Command name:C538(261); \
"tips"; "After "+Command name:C538(261)+" has executed, you can test the set LockedSet to see if any records were locked."))

// JSON TO SELECTION 
$QS_TBX_TIPS.push(New object:C1471("token"; 1235; \
"request"; Command name:C538(1235); \
"tips"; "After "+Command name:C538(1235)+" has executed, you can test the set LockedSet to see if any records were locked."))

// -----------------------------------------------------

For each ($method; Storage:C1525.allMethods)  // For each method
	
	If ($method.commandToken.length>0)
		For each ($command; $QS_TBX_TIPS)
			$token:=":C"+String:C10($command.token)
			If ($method.commandToken.indexOf($token)#-1)
				If ($result.query("method = :1 and command = :2"; $method.name; $command.request).length=0)
					$result.push(New object:C1471("method"; $method.name; "pattern search"; $command.request; "tips for 4D server"; $command.tips))
				End if 
			End if 
		End for each 
	End if 
End for each 

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy().orderBy("method")
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 350)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Method Path Name")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 250)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Tips")
				
		End case 
	End for 
	
	LB_setHeights($Listbox_Name; 2; 2)
	ARRAY LONGINT:C221($MyEventsOnLB; $nbEvents)
	$MyEventsOnLB{1}:=On Double Clicked:K2:5
	$MyEventsOnLB{2}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$txt:="At least "+String:C10($result.length)+" improvement(s) to perform found in "+String:C10(Storage:C1525.allMethods.length)+" methods."
	$txt:=$txt+"\rDouble click to edit method."
	displayInfo($txt; "red")
Else 
	displayInfo("Search returns no result")
End if 