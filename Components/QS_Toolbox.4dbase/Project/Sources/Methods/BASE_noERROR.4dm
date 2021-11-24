//%attributes = {"invisible":true}
// BASE_noERROR

BASE_GetError

Case of 
	: (gerror=77)
		//ALERT("Bad variable name used in this form: '"+<>QST_OnError+"'.\nName has been replaced by 'BadObjectName_"+<>QST_OnError+"' to allow reporting.")
		ALERT:C41("Bad variable name used in this form: '"+Storage:C1525.text.onError+"'.\nName has been replaced by 'BadObjectName_"+Storage:C1525.text.onError+"' to allow reporting.")
		
	: (gerror=81)
		ALERT:C41("This form doesn't exist anymore.")
		
	: (gerror=1024) | (gerror=1011)  // Structure | data file
		C_TEXT:C284($QS_VCS_COMP_DB_PATH)
		$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
		ALERT:C41("Cannot open "+$QS_VCS_COMP_DB_PATH+"\rIf you are in client server, check that the path of the Documents/QS_Toolbox is available from your server.")
		
	: (gerror=-43)
		PROCESS_sleep(10)
		
	: (gerror=-9768)
		
	: (gerror=-9766)
		ALERT:C41("It seems that "+Storage:C1525.text.onError+" is currently in edit mode.\nPlease, close it before retry.")
		
	: (gError=-9801)
		ALERT:C41("The selected method no longer exists.\nFirst check the \"trash\" folder and run a \"New database analysis\" to get a more accurate analysis..")
		
	: (gError=-9802)
		ALERT:C41("Duplicated method name have been detected.\nCheck with MSC the database structure.")
		
	: (gerror=-9926)
		
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
		$file:=Folder:C1567(fk logs folder:K87:17; *).file("error/error_"+$timestamp_t+".json")
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