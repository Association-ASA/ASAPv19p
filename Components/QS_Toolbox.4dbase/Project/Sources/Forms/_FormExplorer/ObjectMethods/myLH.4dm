// Depending of the version, analyse is not made by the same way

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Right click:C712)
			FE_Edit_form
		Else 
			FE_LH_ElementClicked
		End if 
		
	: (Form event code:C388=On Double Clicked:K2:5)
		
		ARRAY TEXT:C222($atKeys; 0x0000)
		ARRAY TEXT:C222($atValues; 0x0000)
		GET LIST ITEM:C378(*; "myLH"; Selected list items:C379(*; "myLH"); $vlItemRef; $eleTxt; $eleSSL; $elebDep)
		GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item
		
		If (Size of array:C274($atKeys)>0)
			$key:=Find in array:C230($atKeys; "type")
			$key2:=Find in array:C230($atKeys; "formName")
			
			$type:=$atValues{$key}
			$formulareName:=$atValues{$key2}
			
			Case of 
				: ($type="method")
					METHOD OPEN PATH:C1213($formulareName; *)
					
				: ($type="form")
					FE_Edit_form
					
			End case 
			
		End if 
		
End case 
