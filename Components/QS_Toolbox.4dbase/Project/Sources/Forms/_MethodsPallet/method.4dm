C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		OBJECT SET VISIBLE:C603(*; "varCodePreview_t"; False:C215)
		Form:C1466.searchInMethod:=0
		Form:C1466.onlyProjectMethod:=0
		Form:C1466.collapseExpand:=False:C215
		Form:C1466.analyseDone:=False:C215
		Form:C1466.toggleSort:=False:C215
		Form:C1466.txtQuery:=""
		Form:C1466.emoji:=emoji("1F4C4")
		MM_initDecorate
		
		content_MP:=""
		SET TIMER:C645(1)
		
	: ($evt=On Timer:K2:25)
		
		SET TIMER:C645(0)
		If (Form:C1466.onlyProjectMethod=1)
			Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType"; "Path project method").orderBy("name")
		Else 
			Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayAll").orderBy("name")
		End if 
		Form:C1466.listboxDisplayed:=Form:C1466.listboxDisplayed
		
		$FenetreInformation:="Last update "+String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+". Found "+String:C10(Form:C1466.listboxDisplayed.length)+" methods."
		displayInfo($FenetreInformation)
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		CANCEL:C270
		
End case 