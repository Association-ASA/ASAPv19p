C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
		
	: ($evt=On Load:K2:1)
		C_TEXT:C284(Content_t)
		Form:C1466.formulare:=""
		Form:C1466.tableNum:=0
		
		$seeIt:=True:C214
		OBJECT SET VISIBLE:C603(*; "properties"; Not:C34($seeIt))
		OBJECT SET VISIBLE:C603(*; "webZone"; $seeIt)
		
		UTIL_noPicturePath
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		If (Form:C1466.LH#Null:C1517)
			LH_clearList(Form:C1466.LH)
		End if 
		Content_FE:=""
		CANCEL:C270
		
End case 