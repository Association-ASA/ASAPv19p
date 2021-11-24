Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Form:C1466.currentMethod#"")
			ON ERR CALL:C155("BASE_noERROR")
			$path:=Form:C1466.currentMethod
			METHOD OPEN PATH:C1213($path; *)
		End if 
		
	: (Form event code:C388=On Selection Change:K2:29)
		If (Form:C1466.currentElement#Null:C1517)
			
			Form:C1466.oldData:=Form:C1466.currentElement
			MM_option_manager(2; True:C214)
			If (Form:C1466.currentElement.hasDescription)
				MM_option_manager(3; True:C214)
			Else 
				MM_option_manager(3; False:C215)
			End if 
			
			Form:C1466.currentMethod:=Form:C1466.currentElement.name
			If (Form:C1466.currentMethod#"")
				Form:C1466.currentMethod_selected:=Form:C1466.positionElement
				MM_getCodeToDisplay(Form:C1466.currentElement)
				$syntax:=Form:C1466.currentElement.syntax
				$syntax:=Replace string:C233($syntax; ":"; " -> ")
				displayInfo($syntax)
			End if 
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Right click:C712)
			If (Form:C1466.currentElement#Null:C1517)
				MM_LB_rightClick
			End if 
		End if 
		
	: (Form event code:C388=On Header Click:K2:40)
		MM_sortByLastUpdate("MethodsPaths"; 10)
		
	: (Form event code:C388=On Data Change:K2:15)
		
		Case of 
				
				// Check id attributes are populated (=> Not a Project Method)
			: (Form:C1466.oldData.attributes=Null:C1517)
			: (Form:C1466.oldData.attributes.invisible=Null:C1517) | (Form:C1466.oldData.attributes.preemptive=Null:C1517) | (Form:C1466.oldData.attributes.shared=Null:C1517) | (Form:C1466.oldData.attributes.publishedWeb=Null:C1517) | (Form:C1466.oldData.attributes.publishedSoap=Null:C1517) | (Form:C1466.oldData.attributes.publishedWsdl=Null:C1517) | (Form:C1466.oldData.attributes.publishedSoap=Null:C1517) | (Form:C1466.oldData.attributes.publishedSql=Null:C1517)
				Form:C1466.currentElement.attributes:=Null:C1517
				// One property has been touched. Need to set all back to NULL
				
			Else   // This is a Project Method. May we can accept the update
				
				//If (Not(Form.toSave))  // Perfom just once the check to set visible the Save button
				//OBJECT SET VISIBLE(*;"btnSave";True)
				//Form.toSave:=True
				//End if 
		End case 
		
End case 