//%attributes = {"invisible":true}
// FE_Edit_form
// Parameters:
// 
// ----------------------------------------------------
// Description:
// 
// ----------------------------------------------------
// Creation: Patrick EMANUEL, 27/11/20, 14:55:50
//

// before v18R5, do nothing

ARRAY TEXT:C222($atKeys; 0x0000)
ARRAY TEXT:C222($atValues; 0x0000)
GET LIST ITEM:C378(*; "myLH"; Selected list items:C379(*; "myLH"); $vlItemRef; $eleTxt; $eleSSL; $elebDep)
GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item
$key2:=Find in array:C230($atKeys; "formName")

If ($key2>0)  // Bug from Lutz Veith
	
	$formName:=$atValues{$key2}
	
	If ($formName#"")  // Don't waste any time
		
		$key4:=Find in array:C230($atKeys; "tableNumber")
		$tableNum:=Num:C11($atValues{$key4})
		
		If ($tableNum>0)
			$path:="["+Table name:C256($tableNum)+"];"+$formName
		Else 
			$path:=$formName
		End if 
		
		$oldError:=Method called on error:C704
		ON ERR CALL:C155("BASE_noERROR")
		FORM EDIT:C1749($path)
		ON ERR CALL:C155($oldError)
		
	End if 
	
End if 