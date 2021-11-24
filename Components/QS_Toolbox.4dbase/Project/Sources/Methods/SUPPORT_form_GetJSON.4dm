//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 15/12/16, 08:08:46
// Vu et modifié par : PE (17/04/2020)
// ----------------------------------------------------
// méthode : SUPPORT_form_GetJSON
// description
//
//
// paramètres
// ----------------------------------------------------

#DECLARE($FormDetail : Object)

var $dynamicForm; $compilePath_s : Object
var $tableNumber : Integer
var $formulareName; $tableName : Text
var $projectMode : Boolean

$formulareName:=Form:C1466.formulare
$tableNumber:=Form:C1466.tableNum
$dynamicForm:=New object:C1471

If ($formulareName#"")
	$tableName:=""
	
	If ($tableNumber>0)
		var $ZptTable : Pointer
		$ZptTable:=Table:C252($tableNumber)
		$tableName:=Table name:C256($tableNumber)
	End if 
	
	$projectMode:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_hostInProjectMode)
	
	If ($projectMode)
		$fullpath:=Replace string:C233(Storage:C1525.QS_TBX_SHARED_DATA.appPath; Folder separator:K24:12; "/")+"Project/Sources/"
		If ($tableNumber>0)
			$compilePath_s:=File:C1566($fullpath+"TableForms/"+String:C10($tableNumber)+"/"+$formulareName+"/form.4DForm"; *)
		Else 
			$compilePath_s:=File:C1566($fullpath+"Forms/"+$formulareName+"/form.4DForm"; *)
		End if 
		
		$dynamicFormTxt:=$compilePath_s.getText()
		$dynamicForm:=JSON Parse:C1218($dynamicFormTxt)
		
	Else 
		If ($tableNumber>0)
			$dynamicForm:=FORM Convert to dynamic:C1570($ZptTable->; $formulareName)
		Else 
			$methodCode:=New collection:C1472
			$methodCode.push("C_OBJET:C1216($dynamicForm)")
			$methodCode.push("$dynamicForm:=new object:C1471")
			$methodCode.push("$formulareName:=\""+$formulareName+"\"")
			$methodCode.push("$dynamicForm:=FORM Convert to dynamic:C1570($formulareName)")
			$methodCode.push("$1->:=$dynamicForm")
			
			$pathMethod:=METHOD Get path:C1164(Path project method:K72:1; "__QST_HOST_temporary_method"; *)
			UPDT_WriteMethod($pathMethod; $methodCode.join("\r"))
			METHOD SET ATTRIBUTE:C1192($pathMethod; Attribute shared:K72:10; True:C214; *)
			
			If (OK=1)
				var $pointer : Pointer
				$pointer:=->$dynamicForm
				EXECUTE METHOD:C1007($pathMethod; $pointer; $pointer)
			End if 
			
		End if 
		
	End if 
	
	$FormDetail.tableNum:=$tableNumber
	$FormDetail.formName:=$formulareName
	$FormDetail.tableName:=$tableName
	OB SET:C1220($FormDetail; "setup"; $dynamicForm)
	
	FORM UNLOAD:C1299
	
End if 