
C_TEXT:C284($path)
$path:=Form:C1466.currentMethod
If ($path#"")
	$action:=False:C215
	If (x_io_confirm_yesNo ("Beautify method "+$path+"?";->$action))
		
		C_TEXT:C284($codeMethod)
		METHOD GET CODE:C1190($path;$codeMethod;*)
		$codeMethod:=METHOD_MIMOSA_Enjoliver ($codeMethod;True:C214)
		UPDT_WriteMethod ($path;$codeMethod)
		METHOD_GetCodeToDisplay ($path)
		
		  // Update the current code, just in case of use later
		C_COLLECTION:C1488($selectedMethod)
		$selectedMethod:=Storage:C1525.allMethods.query("name =:1";$path)
		If ($selectedMethod.length>0)
			$selectedMethod[0].code:=$codeMethod
		End if 
		
		If (OK=1)
			$FenetreInformation:=$path+" has been treated successfully."
		Else 
			$FenetreInformation:=""
		End if 
		displayInfo ($FenetreInformation)
	End if 
Else 
	BEEP:C151
End if 


