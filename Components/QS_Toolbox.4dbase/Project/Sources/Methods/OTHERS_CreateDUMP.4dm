//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$chemin:=Select folder:C670("Select path for DUMP : ";System folder:C487(Documents folder:K41:18))

If (ok=1)
	$chemin:=$chemin+"dump-"+String:C10(Current date:C33;Internal date abbreviated:K1:6)+Folder separator:K24:12
	
	CREATE FOLDER:C475($chemin;*)
	If (OK=1)
		
		SQL EXPORT DATABASE:C1065($chemin)
		
		If (OK=1)
			ALERT:C41("Dump created.")
			
		Else 
			ALERT:C41("An error occured during the DUMP or process has been stopped by the user.")
		End if 
	Else 
		ALERT:C41("An error occured during folder creation.")
	End if 
End if 