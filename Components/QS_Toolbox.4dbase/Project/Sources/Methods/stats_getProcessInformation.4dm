//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // TO DO

C_COLLECTION:C1488($processes)
C_LONGINT:C283($howMany)
$processes:=New collection:C1472

For ($vlProcess;1;Count tasks:C335)
	If (Process state:C330($vlProcess)>=Executing:K13:4)
		PROCESS PROPERTIES:C336($vlProcess;$procName;$procState;$procTime;$procMode;$procUniqueID;$procOrigin)
		If ($procOrigin=5)
			If ($procName#"QST_Menu")
				If ($procName="QST_@")
					KILL WORKER:C1390($procName)
				End if 
			End if 
		End if 
		
	End if 
End for 

$n:=Count user processes:C343
For ($vlProcess;1;Count tasks:C335)
	If (Process state:C330($vlProcess)>=Executing:K13:4)
		PROCESS PROPERTIES:C336($vlProcess;$procName;$procState;$procTime;$procMode;$procUniqueID;$procOrigin)
		$processes.push(New object:C1471("name";$procName;"state";$procState;"since";$procTime;"mode";$procMode;"id";$procUniqueID;"origin";$procOrigin))
	End if 
End for 

$howMany:=$processes.length