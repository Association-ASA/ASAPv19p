Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305($UseSelected_b)
		C_LONGINT:C283($howMany)
		$howMany:=Storage:C1525.allMethods.length
		
		$UseSelected_b:=Choose:C955((Form:C1466.methodSelected>0);Not:C34(Form:C1466.methodSelected=$howMany);False:C215)
		If ($UseSelected_b)
			$GroupTitle_t:="Set attributes of the "+String:C10(Form:C1466.methodSelected)+" methods selected."
		Else 
			$GroupTitle_t:="Set attributes for all methods ("+String:C10($howMany)+")."
		End if 
		OBJECT SET TITLE:C194(*;"GroupTitle";$GroupTitle_t)
		SET WINDOW TITLE:C213($GroupTitle_t)
		
End case 