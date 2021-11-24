C_OBJECT:C1216($formEvent)
C_TEXT:C284($object)
C_LONGINT:C283($evt)
$evt:=Form event code:C388
$formEvent:=FORM Event:C1606
If (OB Is defined:C1231($formEvent;"objectName"))
	$object:=$formEvent.objectName
End if 

Case of 
	: ($evt=On Load:K2:1)
		WA SET PREFERENCE:C1041(*;"webZone";WA enable Web inspector:K62:7;True:C214)
		SET TIMER:C645(1)
		
		  // ****************************************************************************
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)
		
		  // ****************************************************************************
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		CANCEL:C270
		
End case 
