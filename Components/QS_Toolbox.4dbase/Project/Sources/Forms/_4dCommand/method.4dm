var $formEvent : Object
var $object : Text
var $evt : Integer

$evt:=Form event code:C388
$formEvent:=FORM Event:C1606
If (OB Is defined:C1231($formEvent; "objectName"))
	$object:=$formEvent.objectName
End if 

Case of 
	: ($evt=On Load:K2:1)
		Form:C1466.found:=New collection:C1472
		Form:C1466.collapse:=False:C215
		Form:C1466.indice:=0
		Form:C1466.tb_home:=New collection:C1472
		Form:C1466.name:=""
		(OBJECT Get pointer:C1124(Object named:K67:5; "searchCommands"))->:=""
		Content_4DC:=""
		METHOD_codeMirror_display
		SET TIMER:C645(1)
		
		// ****************************************************************************
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)
		Form:C1466.LH:=Copy list:C626(Storage:C1525.QS_TBX_SHARED_DATA.QS_LH_commands)
		OBJECT SET LIST BY REFERENCE:C1266(*; "myLH"; Choice list:K42:19; Form:C1466.LH)
		OBJECT SET ENTERABLE:C238(*; "myLH"; False:C215)
		
		// ****************************************************************************
	: ($evt=On Clicked:K2:4)
		
		If ($object#"")
			
			Case of 
				: ($object="btn_n_first")
					btn_first
					
				: ($object="btn_n_previous")
					btn_previous
					
				: ($object="btn_n_next")
					btn_next
					
				: ($object="btn_n_last")
					btn_last
					
				: ($object="btn_n_redo")
					(OBJECT Get pointer:C1124(Object named:K67:5; "searchCommands"))->:=""
					LH_openCollapse(Form:C1466.LH; False:C215)
					
				: ($object="btn_property")
					COMMANDS_btn_propertySelect
					
			End case 
			
		End if 
		
		// ****************************************************************************
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		LH_clearList(Form:C1466.LH)
		CANCEL:C270
		
End case 