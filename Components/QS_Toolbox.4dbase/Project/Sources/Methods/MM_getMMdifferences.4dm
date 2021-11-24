//%attributes = {"invisible":true,"preemptive":"indifferent","executedOnServer":false,"publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
ARRAY TEXT:C222($tbPath; 0x0000)
ARRAY DATE:C224($tabDates; 0x0000)
ARRAY LONGINT:C221($tabHeures; 0x0000)

// ------------------------------------------------------------------
// Initialisation of the check

METHOD GET PATHS:C1163(Path all objects:K72:16; $tbPath; *)  // not PREEMPTIVE
METHOD GET MODIFICATION DATE:C1170($tbPath; $tabDates; $tabHeures; *)

C_OBJECT:C1216($obj)
$obj:=New object:C1471

For ($i; 1; Size of array:C274($tbPath))
	If ($obj[$tbPath{$i}]=Null:C1517)
		$obj[$tbPath{$i}]:=New object:C1471(\
			"path"; $tbPath{$i}; \
			"epoch"; UTIL_epoch($tabDates{$i}; $tabHeures{$i}); \
			"lastUpdate"; $tabDates{$i}; \
			"lastTime"; $tabHeures{$i})
	End if 
End for 


C_TEXT:C284($path)
C_COLLECTION:C1488($toUpdate; $toDelete; $data)  // $toUpdate = New or Update
C_OBJECT:C1216($objColl; $method)

$toUpdate:=New collection:C1472
$toDelete:=New collection:C1472

// ------------------------------------------------------------------
// Identification of New methods or Method to Update

For each ($path; $obj)
	$data:=Storage:C1525.allMethods.query("name =:1"; $path)
	
	If ($data#Null:C1517)
		If ($data.epoch#$obj[$path].epoch)
			$toUpdate.push($path)
		End if 
	Else 
		$toUpdate.push($path)
	End if 
	
End for each 

// Update Storage.allMethods
C_TEXT:C284($Code; $Message)

If ($toUpdate.length>0)
	For each ($path; $toUpdate)
		$data:=Storage:C1525.allMethods.query("name =:1"; $path)
		METHOD GET CODE:C1190($path; $Code; Code with tokens:K72:18; *)
		
		If ($data.length>0)  // This is an update
			$method:=$data[0]
			Use (Storage:C1525.allMethods)
				$method.epoch:=$obj[$path].epoch
				$method.lastUpdate:=$obj[$path].lastUpdate
				$method.timeUpdate:=$obj[$path].lastTime
				$method.code:=$Code
			End use 
			$Message:=$method.path
			
			// ------------------------------------------------------------------
		Else   // This is a new one
			C_LONGINT:C283($methodType)
			C_POINTER:C301($tablePtr)
			C_TEXT:C284($objectName)
			C_TEXT:C284($objectFormName)
			C_OBJECT:C1216($attributes)
			$attr:=New collection:C1472
			
			METHOD RESOLVE PATH:C1165($path; $methodType; $tablePtr; $objectName; $objectFormName)  // not PREEMPTIVE
			
			Case of 
					
				: ($methodType=Path project method:K72:1)  //1
					$Message:="Path project method"
					$chemin:=METHOD Get path:C1164($methodType; $path)
					METHOD GET ATTRIBUTES:C1334($chemin; $attributes; *)
					
				: ($methodType=Path database method:K72:2)  // 2
					$Message:="Path database method"
					
				: ($methodType=Path project form:K72:3)  // 4
					$Message:="Path project form"
					
				: ($methodType=Path trigger:K72:4)  // 8
					$Message:="Path trigger"
					
				: ($methodType=Path table form:K72:5)  // 16
					$Message:="Path table form"
					
					// TODO: replace by constant v19
				: ($methodType=32)  // Path class
					$Message:="Path Class"
					
			End case 
			
			$newMethod:=New object:C1471(\
				"name"; $path; \
				"code"; $Code; \
				"clearCode"; ""; \
				"attributes"; $attributes; \
				"lastUpdate"; $obj[$path].lastUpdate; \
				"timeUpdate"; $obj[$path].lastTime; \
				"epoch"; $obj[$path].epoch; \
				"nbLines"; 0; \
				"nbEmpty"; 0; \
				"nbComment"; 0; \
				"nbNested"; 0; \
				"Complexity"; 0; \
				"path"; $Message; \
				"syntax"; ""; \
				"pluginUsed"; New collection:C1472; \
				"pluginToken"; New collection:C1472; \
				"constantUsed"; New collection:C1472; \
				"constantToken"; New collection:C1472; \
				"commandUsed"; New collection:C1472; \
				"commandToken"; New collection:C1472; \
				"callees"; New collection:C1472; \
				"callers"; New collection:C1472; \
				"isThread"; False:C215; \
				"checkOnStart"; False:C215\
				)
			
			C_COLLECTION:C1488($toPush)
			$toPush:=New collection:C1472($newMethod)
			OB_InsertToSharedCollection($toPush; Storage:C1525.allMethods)  // Update a shared Collection by insert new Element at its end
			$data:=Storage:C1525.allMethods.query("name =:1"; $path)
			$method:=$data[0]
			
		End if 
		
		Use (Storage:C1525.allMethods)
			
			METHODS_clearCode($Method)
			If ($Message="Path project method")
				METHODS_getSyntax($Method; $declaration)
			End if 
			
			If ($Message#"Path Class")
				METHODS_analyseOne($Method)  // Determination of the complexity...
				METHODS_get4dInformation($Method)
				
				For each ($toAnalyse; $Method.constantUsed)
					$txt:=Parse formula:C1576($toAnalyse; Formula out with tokens:K88:3)
					$Method.constantToken.push(Substring:C12($txt; Position:C15(":"; $txt)))
				End for each 
				C_COLLECTION:C1488($c)
				$c:=$Method.constantToken.distinct()
				Use ($method)
					$Method.constantToken:=New shared collection:C1527
					OB_CopyToSharedCollection($c; $Method.constantToken)
				End use 
				
				For each ($toAnalyse; $Method.commandUsed)
					$txt:=Parse formula:C1576($toAnalyse; Formula out with tokens:K88:3)
					$Method.commandToken.push(Substring:C12($txt; Position:C15(":"; $txt)))
				End for each 
				$c:=$Method.commandToken.distinct()
				Use ($method)
					$Method.commandToken:=New shared collection:C1527
					OB_CopyToSharedCollection($c; $Method.commandToken)
				End use 
				
			End if 
		End use 
		
	End for each 
	
End if 

// ------------------------------------------------------------------
// Deletion of Methods from Storage

For each ($objColl; Storage:C1525.allMethods)
	$path:=$objColl.name
	If ($obj[$path]=Null:C1517)
		$toDelete.push($path)
	End if 
End for each 

If ($toDelete.length>0)
	For each ($path; $toDelete)
		$data:=Storage:C1525.allMethods.indices("name =:1"; $path)
		If ($data.length>0)
			Use (Storage:C1525.allMethods)
				Storage:C1525.allMethods.remove($data[0])
			End use 
		End if 
	End for each 
	
	// First check that all Methods deleted have been removed from Callees / Callers paths
	For each ($method; Storage:C1525.allMethods)
		$pos:=$method.callees.indexOf($path)
		If ($pos>=0)
			Use ($methods)
				$method.callees.remove($pos)
			End use 
		End if 
		
		$pos:=$method.callers.indexOf($path)
		If ($pos>=0)
			Use ($methods)
				$method.callers.remove($pos)
			End use 
		End if 
		
	End for each 
	
End if 

// ------------------------------------------------------------------
// Now, we can update callees / callers


If ($toUpdate.length>0)
	
	CALL WORKER:C1389("QST_debug"; "floatWindow_launch")
	PROCESS_sleep(5)
	$projectMethod:=Storage:C1525.allMethods.query("path =:1"; "Path project method").extract("name").join("|")
	$projectMethod:="(?mi-s)(?<!(\\$)|(<>))\\b("+$projectMethod+")\\b"
	STO_textToStorage("PMlist"; $projectMethods)
	CLEAR VARIABLE:C89($projectMethods)
	
	$i:=0
	$newSignal:=New signal:C1641
	signal_setNew($newSignal; $toUpdate.length)
	
	For each ($path; $toUpdate)
		$method:=Storage:C1525.allMethods.query("name =:1"; $path)[0]
		$i:=$i+1
		
		CALL WORKER:C1389("QST_calleesCallers_"+String:C10($i); "MM_calleesCallers"; $method; $newSignal)
		
		If ($i=Storage:C1525.QS_TBX_SHARED_DATA.maxWorkers)
			$i:=0
		End if 
		
	End for each 
	CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "Cross: waiting for end stacks execution")
	$newSignal.wait()
	
	CALL WORKER:C1389("QST_debug"; "floatWindow_close")
	
End if 
