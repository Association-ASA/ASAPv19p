//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_LONGINT:C283($ref)
C_OBJECT:C1216($selection)
$selection:=New object:C1471
$selection.methodSelected:=Form:C1466.methodSelected

C_OBJECT:C1216($param)
$param:=New object:C1471
$param.att1:=0
$param.att2:=0
$param.att3:=0
$param.att4:=0
$param.att5:=0
$param.att6:=0
$param.att7:=0
$param.howMany:=Form:C1466.methodSelected.length

$ref:=Open form window:C675("_MethodMassiveAttrUpdate"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("_MethodMassiveAttrUpdate"; $param)
CLOSE WINDOW:C154

If ($param.confirm)
	
	If (Form:C1466.methodSelected.length=0)
		Form:C1466.methodSelected:=Form:C1466.listboxDisplayed
	End if 
	
	If (Form:C1466.methodSelected.length>0)
		MM_updateAttributes(Form:C1466.methodSelected; $param)
	End if 
	
	Form:C1466.toSave:=False:C215
	OBJECT SET VISIBLE:C603(*; "btnSave"; False:C215)
End if 