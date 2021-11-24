CONFIRM:C162("Do you want to continue?\nThere is NO CHECK of your code and this one must be one line and tokenised.\nIn any doubt, click on Cancel button.")

If (ok=1)
	  //$pbj:=(OBJECT Get pointer(Object named;"SQLCommands"))->
	  //SET DATABASE PARAMETER(Number of formulas in cache;3)
	  //EXECUTE FORMULA($pbj)
	C_TEXT:C284($tOutput;$tScript)
	
	$pScript:=OBJECT Get pointer:C1124(Object named:K67:5;"SQLCommands")
	$tScript:="<!--#4DCODE\r"+$pScript->+"\r-->"
	PROCESS 4D TAGS:C816($tScript;$tOutput)
	
	If (OK=1)
		ALERT:C41("No error detected during execution")
	Else 
		ALERT:C41("An error occured during execution of your 4D code.")
	End if 
End if 