//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 
// ----------------------------------------------------
// Méthode : SC_TIPSFromDoc
// Description
//  
//
// Paramètres
// ----------------------------------------------------

C_REAL:C285($pas)
C_COLLECTION:C1488($tips; $result; $data)
C_OBJECT:C1216($token; $Method)
C_LONGINT:C283($window)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)
$data:=Storage:C1525.allMethods

$tips:=New collection:C1472
$result:=New collection:C1472

// Initialisation
C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "Parsing "+String:C10($data.length)+" methods for Code optimisation."; "icon"; "icns_structure.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$tips:=TOOLS_get_TIPS_under_collection

$Progression:=0
$Pas:=1/($data.length+1)
$count:=0

For each ($Method; $data)  // Boucle sur les méthodes projets
	
	$Progression:=$Progression+$pas
	$count:=$count+1
	If ($count%10=0)  // Accelerate the execution
		$param.value:=$Progression
		$param.content:=$Method.name
		CALL FORM:C1391($window; "progressBar_update"; $param)
	End if 
	
	For each ($token; $tips)
		$PatternToSearch:=":C"+String:C10($token.token)
		If ($Method.commandToken.indexOf($PatternToSearch)#-1)  // $PatternToSearch thing has been found
			$result.push(New object:C1471("method"; $Method.name; "type"; $token.type; "command"; $token.request; "tips"; $token.tips))
		End if 
	End for each 
End for each 

QST_progress_compileData($param)

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy()
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 40)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				
			: ($i=3) | ($i=4)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 200)
		End case 
		
	End for 
	
	LB_setHeights($Listbox_Name; 1; 2)
	LISTBOX SET PROPERTY:C1440(*; $Listbox_Name; lk truncate:K53:37; lk without ellipsis:K53:64)
	ARRAY LONGINT:C221($MyEventsOnLB; 2)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	$MyEventsOnLB{2}:=On Double Clicked:K2:5
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
End if 

KILL WORKER:C1390("QST_Progress")

$FenetreInformation:=String:C10($result.length)+" tips proposed for "+String:C10($data.length)+" methods."
$FenetreInformation:=$FenetreInformation+"\rDouble click to edit method."
displayInfo($FenetreInformation; "red")