//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($currentVersion;$OldVersion;$path)
C_LONGINT:C283($methodType;gerror)
C_POINTER:C301($tablePtr)
C_TEXT:C284($objectName)
C_TEXT:C284($objectFormName)
C_BOOLEAN:C305($result)

If (Form:C1466.allVersionCurrent#Null:C1517)
	gerror:=0
	ON ERR CALL:C155("BASE_noERROR")
	$path:=Form:C1466.allVersionCurrent.path
	
	METHOD RESOLVE PATH:C1165($path;$methodType;$tablePtr;$objectName;$objectFormName;*)
	
	If (gerror=0)  // The object still exist
		
		$code:=METHOD Get path:C1164($methodType;$path)
		METHOD GET CODE:C1190($code;$currentVersion;*)
		MM_removeFirstLine (->$currentVersion)
		Form:C1466.currentVersion:=$currentVersion
		Form:C1466.oldVersion:=VCS_UpdateOldVersion (Num:C11(Form:C1466.allVersionCurrent.timeStamp);$path)
		$OldVersion:=Form:C1466.oldVersion
		
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"Compare_All";"insertInEditor";$result;"mergeleft";$currentVersion)
		PROCESS_sleep 
		WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"Compare_All";"insertInEditor";$result;"mergeright";$OldVersion)
		
		Case of 
			: ($currentVersion="")
				$info:="No current version found. It seems that this method has been deleted."
				
			: ($OldVersion="")
				$info:="No old version found. It seems that this method is New."
				
			Else 
				$info:="Comparison done."
				
		End case 
		
		displayInfo ($info)
		
	Else   // The method has been surely deleted
		gerror:=0
		$txt:=$path+"' hasn't been found. Check first if it still exists."
		displayInfo ($txt;"red")
		
	End if 
	
	ON ERR CALL:C155("")
End if 