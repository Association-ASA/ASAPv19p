//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 16/03/18, 09:42:49
// ----------------------------------------------------
// Méthode : SC_checkDeclrVariables
// Description
// ----------------------------------------------------

C_REAL:C285($pas)
C_COLLECTION:C1488($result; $Coll; $varDeclare; $allVariables; $i; $uniqueVariables; $data; $symbols)
C_OBJECT:C1216($method; $variable)
C_LONGINT:C283($NbMethod; $Pos; $counter)
C_LONGINT:C283($window)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$Coll:=New collection:C1472
$result:=New collection:C1472
$varDeclare:=New collection:C1472
$allVariables:=New collection:C1472
$i:=New collection:C1472
$uniqueVariables:=New collection:C1472
$data:=Storage:C1525.allMethods
$symbols:=Storage:C1525.symbols_variable

C_OBJECT:C1216($declaration)
$declaration:=New shared object:C1526
TOOLS_readSymbolFile(True:C214; $declaration; False:C215)

$NbMethod:=$data.length
$Progression:=0.001
$Pas:=1/($NbMethod+1)
$counter:=0

// Initialisation
C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "Parsing "+String:C10($NbMethod)+" methods."; "icon"; "icns_structure.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$startTime:=Current time:C178
$stop:=False:C215

For each ($method; $data) Until ($stop=True:C214)
	
	$counter:=$counter+1
	$path:=$method.name
	$Progression:=$Progression+$pas
	
	If (Position:C15("Compiler_"; $path; 1)=0)  // don't work on Compilers
		
		If ($counter%5=0) | ($counter=1)
			$currentT:=Current time:C178
			$delta:=$currentT-$startTime
			$timeNeededEvaluated:=String:C10(Time:C179(($NbMethod-$counter)*($delta/$counter)); HH MM SS:K7:1)
			$info:=$timeNeededEvaluated+" - "+$path
			$Progression:=$Progression+$pas
			
			$param.value:=$Progression
			$param.content:=$info
			CALL FORM:C1391($window; "progressBar_update"; $param)
			
		End if 
		
		$path2:=Replace string:C233($path; "/"; ".")
		$uniqueVariables:=$symbols.query("sourceName = :1"; $path2).extract("name"; "varType"; "varDimension")
		$varDeclare.clear()
		
		// Don't need TOKEN information anymore.
		METHOD GET CODE:C1190($path; $MethText; *)
		METHOD_getCleanCode(->$MethText)  // Remove commanet and blanck lines
		METHOD_getDeclarationType($varDeclare; $MethText)
		
		If ($uniqueVariables.length>0)
			For each ($variable; $uniqueVariables)
				
				$i:=$varDeclare.indices("label = :1"; $variable.varType)
				$pos:=1
				
				Case of 
					: ($i.length>0)
						$pos:=Position:C15($variable.varType; $MethText; $Pos)  // Found for the declaration
						If (Position:C15($variable.varType; $MethText; $Pos+1)>0)  // Is it found a second time => I assume that it is because it is used
							$result.push(New object:C1471("method"; $path; "variable"; $variable.varType; "declaration"; $varDeclare[$i[0]].declare; "empty"; ""))
						Else 
							$result.push(New object:C1471("method"; $path; "variable"; $variable.varType; "declaration"; "declared -> Not used"; "empty"; ""))
						End if 
						
					Else 
						$result.push(New object:C1471("method"; $path; "variable"; $variable.varType; "declaration"; "not declared"; "empty"; ""))
						
				End case 
				
			End for each 
		End if 
		
	End if 
	//End if 
	
End for each 


If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	Form:C1466.result:=$result.copy()
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($a; 1; Size of array:C274($tabPropertyNames))
		Case of 
			: ($a=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$a}; 250)
				
			: ($a=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$a}; 300)
				
			: ($a=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$a}; 150)
				
			: ($a=4)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($a); "")
				
		End case 
	End for 
	
	$txt:="Found: "+String:C10($result.countValues("not declared"; "declaration"))+" variables NOT declared."
	$txt:=$txt+"\n"+String:C10($result.countValues("declared -> Not used"; "declaration"))+" variables declared and NOT used."
	
Else 
	
	$txt:="Analysis returns no result."
End if 

If ($result.length>0)
	ARRAY LONGINT:C221($MyEventsOnLB; 2)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	$MyEventsOnLB{2}:=On Double Clicked:K2:5
	OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
Else 
	LB_BlockEvents($Listbox_Name)
	
End if 

QST_progress_compileData($param)
displayInfo($txt)
KILL WORKER:C1390("QST_Progress")