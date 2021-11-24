var $formEvent : Object
var $object : Text
var $evt : Integer

$evt:=Form event code:C388
$formEvent:=FORM Event:C1606
If (OB Is defined:C1231($formEvent; "objectName"))
	$object:=$formEvent.objectName
Else 
	$object:=""
End if 

Case of 
	: ($evt=On Load:K2:1)
		
		(OBJECT Get pointer:C1124(Object named:K67:5; "searchCommands"))->:=""
		
		var Content_MA : Text
		LH_messageProcessingData
		
		Form:C1466.found:=New collection:C1472
		Form:C1466.tb_home:=New collection:C1472
		Form:C1466.collapse:=False:C215
		Form:C1466.indice:=0
		Form:C1466.path:=""
		Form:C1466.declarationToAdd:=""
		
		METHOD_codeMirror_display
		SET TIMER:C645(-1)
		
		// ****************************************************************************
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)
		MA_analyzer
		OBJECT SET LIST BY REFERENCE:C1266(*; "myLH"; Choice list:K42:19; Form:C1466.LH)
		OBJECT SET ENTERABLE:C238(*; "myLH"; False:C215)
		OBJECT SET VISIBLE:C603(*; "updateDeclaration"; Form:C1466.declarationToAdd#"")
		
		// ****************************************************************************
		
	: ($evt=On Double Clicked:K2:5)
		If ($object="myLH")
			ARRAY TEXT:C222($atKeys; 0)
			ARRAY TEXT:C222($atValues; 0)
			var $key : Integer
			var $path : Text
			
			GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item
			$key:=Find in array:C230($atKeys; "path")
			$path:=""
			If ($key>0)
				$path:=$atValues{$key}
				METHOD OPEN PATH:C1213($path; *)
			End if 
		End if 
		
	: ($evt=On Clicked:K2:4)
		
		If ($object#"")
			Case of 
				: ($object="myLH")
					MA_LH_clicked
					OBJECT SET VISIBLE:C603(*; "updateDeclaration"; Form:C1466.declarationToAdd#"")
					
				: ($object="btn_n_redo")
					$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5; "webZone")
					WA SET PAGE CONTENT:C1037($wa_p->; ""; "about:blank")
					(OBJECT Get pointer:C1124(Object named:K67:5; "searchCommands"))->:=""
					LH_openCollapse(Form:C1466.LH; False:C215)
					
				Else 
					
					Case of 
						: ($object="btn_n_first")
							Form:C1466.indice:=1
							
						: ($object="btn_n_previous")
							Form:C1466.indice:=(Form:C1466.indice-1)
							
						: ($object="btn_n_next")
							Form:C1466.indice:=(Form:C1466.indice+1)
							
						: ($object="btn_n_last")
							Form:C1466.indice:=Form:C1466.found.length
							
					End case 
					
					SELECT LIST ITEMS BY REFERENCE:C630(Form:C1466.LH; Form:C1466.found[(Form:C1466.indice-1)])
					LH_btn_updateStatus
					
			End case 
		End if 
		
		// ****************************************************************************
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		LH_clearList(Form:C1466.LH)
		CANCEL:C270
		
End case 