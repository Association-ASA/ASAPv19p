C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
		
	: ($evt=On Load:K2:1)
		
		Form:C1466.command:=Storage:C1525.commands4d
		Form:C1466.convertLanguages:=New list:C375  // just to remember the ref and lean it
		
		APPEND TO LIST:C376(Form:C1466.convertLanguages;"En";1)
		APPEND TO LIST:C376(Form:C1466.convertLanguages;"Fr";2)
		
		OBJECT SET LIST BY REFERENCE:C1266(*;"mySelectFrom";Choice list:K42:19;Form:C1466.convertLanguages)
		OBJECT SET LIST BY REFERENCE:C1266(*;"mySelectTo";Choice list:K42:19;Form:C1466.convertLanguages)
		OBJECT SET TITLE:C194(*;"GotoPage";"Go to\\Converter")
		
		Form:C1466.mySelectFrom:="EN"
		Form:C1466.mySelectTo:="FR"
		Form:C1466.konstant:=False:C215
		Form:C1466.toggleViewTokens:=0
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"searchConverter"))->:=""
		
		SET TIMER:C645(1)
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)
		Form:C1466.konstante:=New collection:C1472
		Form:C1466.keyword:=New collection:C1472
		Form:C1466.konstante:=Storage:C1525.constants
		Form:C1466.keyword:=Storage:C1525.keywords
		Form:C1466.display:=Form:C1466.command
		Form:C1466.display:=Form:C1466.display
		
		$txt:="Found "+String:C10(Form:C1466.display.length)+" references."
		displayInfo ($txt;"blue")
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		LH_clearList (Form:C1466.convertLanguages)
		CANCEL:C270
		
End case 
