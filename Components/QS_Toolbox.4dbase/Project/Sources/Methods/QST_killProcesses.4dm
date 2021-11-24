//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"indifferent","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}

// Clean space to prevent wrong analyse
$keepQSTWorkerList:="QST_Menu;QST_VCS;QST_Converter;QST_DataExplorer"
For ($vlProcess; 1; Count tasks:C335)
	If (Process state:C330($vlProcess)>=Executing:K13:4)
		PROCESS PROPERTIES:C336($vlProcess; $procName; $procState; $procTime; $procMode; $procUniqueID; $procOrigin)
		If ($procOrigin=Worker process:K36:32)  // 5
			If (Position:C15($procName; $keepQSTWorkerList)=0)  // Not found in $keepQSTWorkerList
				If ($procName="QST_@")  // Check now if the process is a QST_ process
					KILL WORKER:C1390($procName)  // So, we can close it
				End if 
			End if 
		End if 
		
	End if 
End for 
