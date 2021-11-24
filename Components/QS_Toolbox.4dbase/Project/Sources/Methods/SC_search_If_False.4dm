//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 27/04/18, 18:56:45
// ----------------------------------------------------
// Méthode : SC_search_If_False
// Description
//  Identify all methods in all objects containing this kind of code:
//
// if (False) ... end if
// if (1=2) ... end if
// if (True)  ... end if                      // What???
// Begin SQL /* .... */ end SQL
//
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($tableau2D; 0x0000; 0x0000)
C_TEXT:C284($langage; $MethText; $MethPath)
C_OBJECT:C1216($Method)
C_REAL:C285($pas; $Progression)
C_COLLECTION:C1488($result)
C_LONGINT:C283($window)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
$langage:=Config_getLanguage

// Pattern to detect code set as comment
$Pattern1:="(?si-m)((if \\("+Choose:C955($langage="en"; "False:C215"; "Faux:C215")+"\\))(.+?)(end if))"
$Pattern2:="(?si-m)((if \\(1=2\\))(.+?)(end if))"
$Pattern3:="(?si-m)((if \\(2=1\\))(.+?)(end if))"
$Pattern4:="(?si-m)((if \\("+Choose:C955($langage="en"; "True:C214"; "Vrai:C214")+"\\))(.+?)(end if))"
$Pattern10:="(?si-m)(Begin SQL[\\r\\n\\t]*/\\*.+?\\*/[\\r\\n\\t]*End SQL)"

// Initialisation
C_OBJECT:C1216($param)
C_COLLECTION:C1488($data)
$data:=Storage:C1525.allMethods
$param:=New object:C1471("title"; "Parsing "+String:C10($data.length)+" methods (it takes a while)"; "icon"; "icns_structure.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$Pas:=1/($data.length+1)

For each ($Method; $data)  // Boucle sur les méthodes projets
	
	$Progression:=$Progression+$pas
	
	$MethPath:=$Method.name
	$MethText:=$Method.code
	
	$param.value:=$Progression
	$param.content:=$MethPath
	CALL FORM:C1391($window; "progressBar_update"; $param)
	
	If (REGEX_ExtractText($Pattern1; $MethText; "1 2 3 4"; ->$tableau2D; 0)=0)
		$result.push(New object:C1471("method"; $MethPath; "description"; "If (False) ... End if"; "empty"; ""))
	End if 
	
	If (REGEX_ExtractText($Pattern2; $MethText; "1 2 3 4"; ->$tableau2D; 0)=0)
		$result.push(New object:C1471("method"; $MethPath; "description"; "If (1=2) ... End if"; "empty"; ""))
	End if 
	
	If (REGEX_ExtractText($Pattern3; $MethText; "1 2 3 4"; ->$tableau2D; 0)=0)
		$result.push(New object:C1471("method"; $MethPath; "description"; "If (2=1) ... End if"; "empty"; ""))
	End if 
	
	If (REGEX_ExtractText($Pattern4; $MethText; "1 2 3 4"; ->$tableau2D; 0)=0)
		$result.push(New object:C1471("method"; $MethPath; "description"; "If (True) ... End if"; "empty"; ""))
	End if 
	
	If (REGEX_ExtractText($Pattern10; $MethText; "1"; ->$tableau2D; 0)=0)
		$result.push(New object:C1471("method"; $MethPath; "description"; "Begin SQL /* ... */ End SQL"; "empty"; ""))
	End if 
	
End for each 

// Listbox construction
// -----------------------

QST_progress_compileData($param)

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy()
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Method Path Name")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
				
			: ($i=2)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Case of 'comments'")
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 500)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
		End case 
		
	End for 
	
	ARRAY LONGINT:C221($MyEventsOnLB; 2)
	$MyEventsOnLB{1}:=On Double Clicked:K2:5
	$MyEventsOnLB{2}:=On Clicked:K2:4
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	
	$UpdateInfo:="Found: "+String:C10($result.length)+" cases of comments. Check if it is still necessary to keep them."
	displayInfo($UpdateInfo)
	$color:="red"
	
Else 
	
	$FenetreInformation:="No death part of code 'if (false)...' has been found."
	$color:="green"
End if 
displayInfo($FenetreInformation; $color)

KILL WORKER:C1390("QST_Progress")
