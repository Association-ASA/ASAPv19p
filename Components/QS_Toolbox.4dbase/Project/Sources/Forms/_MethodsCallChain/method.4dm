C_OBJECT:C1216($formEvent)
C_TEXT:C284($object)
C_LONGINT:C283($evt)
$evt:=Form event code:C388
$formEvent:=FORM Event:C1606
If (OB Is defined:C1231($formEvent; "objectName"))
	$object:=$formEvent.objectName
End if 

Case of 
	: ($evt=On Load:K2:1)
		Form:C1466.indice:=0
		Form:C1466.name:=""
		OBJECT SET ENABLED:C1123(*; "rd@"; True:C214)
		OBJECT SET ENABLED:C1123(*; "rd0"; True:C214)  // Display 4D Code
		(OBJECT Get pointer:C1124(Object named:K67:5; "rd0"))->:=1  // Select rd0
		(OBJECT Get pointer:C1124(Object named:K67:5; "btCallees"))->:=1  // Select Callees
		Form:C1466.callees:=1
		content_CC:=""
		WA SET PREFERENCE:C1041(*; "webZone"; WA enable Web inspector:K62:7; True:C214)
		METHOD_codeMirror_display
		LH_messageProcessingData
		SET TIMER:C645(1)
		
		// ****************************************************************************
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)
		MA_analyzer(True:C214)
		OBJECT SET LIST BY REFERENCE:C1266(*; "myLH"; Choice list:K42:19; Form:C1466.LH)
		OBJECT SET ENTERABLE:C238(*; "myLH"; False:C215)
		
		// ****************************************************************************
		
	: ($evt=On Clicked:K2:4)
		
		If ($object="maximize")
			C_OBJECT:C1216($data)
			$data:=New object:C1471("data"; content_CC)
			$window:="_maximize"
			$Win:=Open form window:C675($window; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
			DIALOG:C40($window; $data; *)
			MAXIMIZE WINDOW:C453($Win)
			
		Else 
			
			Form:C1466.callees:=(OBJECT Get pointer:C1124(Object named:K67:5; "btCallees"))->
			MCC_callees
		End if 
		
		// ****************************************************************************
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		LH_clearList(Form:C1466.LH)
		CANCEL:C270
		
End case 