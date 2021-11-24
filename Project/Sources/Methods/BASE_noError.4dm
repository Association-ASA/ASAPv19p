//%attributes = {"lang":"fr"}
// BASE_noERROR

BASE_getError

Case of 
		
	: (gerror=81)
		ALERT:C41("This form doesn't exist anymore.")
		
	: (gerror=-43)
		PROCESS_sleep(10)
		
	Else 
		
		C_OBJECT:C1216($error; $file)
		C_COLLECTION:C1488($_callChain)
		C_TEXT:C284($timestamp_t)
		
		// get last error stack into a collection 
		$errorStack:=New collection:C1472
		ARRAY TEXT:C222($errors_at; 0x0000)
		ARRAY LONGINT:C221($codes_al; 0x0000)
		ARRAY TEXT:C222($comps_at; 0x0000)
		GET LAST ERROR STACK:C1015($codes_al; $comps_at; $errors_at)
		ARRAY TO COLLECTION:C1563($errorStack; $codes_al; "code"; $comps_at; "component"; $errors_at; "error")
		
		// get call chain into a collection 
		$_callChain:=Get call chain:C1662
		
		// get current timestamp 
		$timestamp_t:=Timestamp:C1445
		
		// put it all together 
		$error:=New object:C1471
		$error.timestamp:=$timestamp_t
		$error.user_4d:=Current user:C182
		$error.user_system:=Current system user:C484
		$error.machine:=Current machine:C483
		$error.method:=Error method
		$error.error:=Error
		$error.line:=Error line
		$error.formula:=Error formula
		$error.deep:=$_callChain.length
		$error.callChain:=$_callChain
		$error.errorStack:=$errorStack
		
		// Store the error in a file located in the database logs folder
		$timestamp_t:=Replace string:C233($timestamp_t; ":"; "-")
		$file:=Folder:C1567(fk dossier fichiers d'historique; *).file("error/error_"+$timestamp_t+".json")
		$file.setText(JSON Stringify:C1217($error))
		
		// ----> keep in QST instance
		C_COLLECTION:C1488($callChain; $currentError)
		C_OBJECT:C1216($obj)
		
		$currentError:=New collection:C1472
		$callChain:=New collection:C1472
		$callChain:=Get call chain:C1662
		
		For each ($obj; $callChain)
			$obj.when:=Current date:C33
			$obj.timestamp:=Current time:C178
			$currentError.push($obj)
		End for each 
		
		Use (Storage:C1525)
			Use (Storage:C1525.getCallChain)
				OB_CopyToSharedCollection($currentError; Storage:C1525.getCallChain)
			End use 
		End use 
		
End case 

// Reset the error number
gerror:=0