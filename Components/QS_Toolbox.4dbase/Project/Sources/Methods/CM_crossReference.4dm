//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 22/02/19, 10:32:59
// Paramètres
// ----------------------------------------------------
// Méthode : CM_crossReference
// Description

C_OBJECT:C1216($ent; $SharedData; $signal)
C_COLLECTION:C1488($data; $projectMethod)
C_TEXT:C284($projectMethods)

$isPop:=False:C215
If (Count parameters:C259=1)
	C_BOOLEAN:C305($1)
	$isPop:=$1
End if 

If (Storage:C1525.QS_TBX_SHARED_DATA.startDBAnalysis#Null:C1517)
	If (Storage:C1525.QS_TBX_SHARED_DATA.startDBAnalysis=1)
		
		$data:=Storage:C1525.allMethods
		CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+"(E) -> Start")
		
		If ($data.length>0)
			$i:=0
			$methodType:="Path project method"
			$projectMethod:=$data.query("path =:1"; $methodType).extract("name")
			$projectMethods:="(?mi-s)(?<!(\\$)|(<>))\\b("+$projectMethod.join("|")+")\\b[\\s;\\\"\\(\\)]"
			//$projectMethod:="(?mi-s)(?<!(\\$)|(<>))\\b("+$projectMethod+")\\b(?>\"| [\\s(;)])"
			STO_textToStorage("PMlist"; $projectMethods)
			CLEAR VARIABLE:C89($projectMethods)
			
			$signal:=New signal:C1641
			signal_setNew($signal; $projectMethod.length)
			
			For each ($ent; $data)
				If ($ent.path="Path project method")
					CALL WORKER:C1389("QST_calleesCallers_"+String:C10($i); "MM_calleesCallers"; $ent; $signal)
					$i:=$i+1
					
					If ($i=Storage:C1525.QS_TBX_SHARED_DATA.maxWorkers)
						$i:=0
					End if 
				End if 
			End for each 
			
			CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "X: Stack creation finished ("+String:C10($projectMethod.length)+" PMs)")
			$signal.wait()
		End if 
		
		$signal:=New signal:C1641
		signal_setNew($signal; 1)
		CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(6) - X: record data")
		CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; $data; 2; $signal)  //4
		$signal.wait()
		
		$signal:=New signal:C1641
		signal_setNew($signal; 1)
		CALL WORKER:C1389("QST_rebuildLH"; "COMMANDS_LH_create"; $isPop; $signal)  // not PREEMPTIVE with LIST commands -> DOESN'T WORK in a worker or a process
		CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> End")
		CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "update allMethods")
		
		$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
		Use ($SharedData)
			$SharedData.calleesCallersDone:=True:C214
		End use 
		$signal.wait()
		
		$index:=New object:C1471
		For each ($method; $data)
			$index[$method.name]:=$method
		End for each 
		
		Use (Storage:C1525)
			Storage:C1525.index:=New shared object:C1526
			Use (Storage:C1525.index)
				OB_CopyToSharedObject($index; Storage:C1525.index)
			End use 
		End use 
		
		savingData
		floatWindow_save
		CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+" -> End")
		CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "copy logs to memory")
		CALL WORKER:C1389("QST_debug"; "floatWindow_close")
		CALL WORKER:C1389("QST_analysisEnd"; "TOOLS_cleanWorkers")
	End if 
	
End if 

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
End if 
KILL WORKER:C1390