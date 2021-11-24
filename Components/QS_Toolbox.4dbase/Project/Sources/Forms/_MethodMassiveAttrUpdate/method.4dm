Case of 
	: (Form event code:C388=On Load:K2:1)
		C_BOOLEAN:C305($UseSelected_b)
		C_LONGINT:C283($howMany)
		
		  // Set unselected
		(OBJECT Get pointer:C1124(Object named:K67:5;"cbAtt1"))->:=2
		(OBJECT Get pointer:C1124(Object named:K67:5;"cbAtt2"))->:=2
		(OBJECT Get pointer:C1124(Object named:K67:5;"cbAtt3"))->:=2
		(OBJECT Get pointer:C1124(Object named:K67:5;"cbAtt4"))->:=2
		(OBJECT Get pointer:C1124(Object named:K67:5;"cbAtt5"))->:=2
		(OBJECT Get pointer:C1124(Object named:K67:5;"cbAtt6"))->:=2
		(OBJECT Get pointer:C1124(Object named:K67:5;"cbAtt7"))->:=2
		
		$howMany:=Storage:C1525.allMethods.length
		
		$UseSelected_b:=Choose:C955((Form:C1466.howMany>0);Not:C34(Form:C1466.howMany=$howMany);False:C215)
		If ($UseSelected_b)
			$GroupTitle_t:="Set attributes of the "+String:C10(Form:C1466.howMany)+" methods selected."
		Else 
			$GroupTitle_t:="Set attributes for all methods ("+String:C10($howMany)+")."
		End if 
		SET WINDOW TITLE:C213($GroupTitle_t)
		
End case 