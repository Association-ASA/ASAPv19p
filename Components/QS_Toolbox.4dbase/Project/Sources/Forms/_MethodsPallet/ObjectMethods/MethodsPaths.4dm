Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		C_TEXT:C284($codePreview)
		C_LONGINT:C283($firstNL)
		If (Form:C1466.currentElement#Null:C1517)
			content_MP:=""
			METHOD GET CODE:C1190(Form:C1466.currentElement.name; $codePreview; *)
			$firstNL:=Position:C15("\r"; $codePreview)
			
			If ($firstNL>0)
				content_MP:=Substring:C12($codePreview; $firstNL+1)
			End if 
			METHOD_codeMirror_display
			
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Right click:C712)
			If (Form:C1466.currentElement#Null:C1517)
				MM_LB_rightClick
			End if 
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Form:C1466.currentElement#Null:C1517)
			If (Form:C1466.currentElement.name#"")
				METHOD OPEN PATH:C1213(Form:C1466.currentElement.name; *)
			End if 
		End if 
		
	: (Form event code:C388=On Header Click:K2:40)
		MM_sortByLastUpdate("MethodsPaths"; 2)
		
End case 