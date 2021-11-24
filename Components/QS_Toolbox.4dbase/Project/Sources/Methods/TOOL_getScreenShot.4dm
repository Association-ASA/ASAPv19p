//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $isProjectForm : Boolean
var $ptTable : Pointer
var $formName : Text
var $Screen; $ScreenShot : Picture
var $pagenum : Integer
var $1; $param : Object

$param:=$1
$pagenum:=Num:C11($param.pageNum)
$formName:=$param.formName
$isProjectForm:=Bool:C1537($param.project)

If (Not:C34($isProjectForm))
	$ptTable:=Table:C252(Num:C11($param.table))
	FORM SCREENSHOT:C940($ptTable->; $formName; $ScreenShot; $pagenum)
	
Else 
	
	Case of 
			
		: (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode)  // This is  a component
			FORM SCREENSHOT:C940($formName; $ScreenShot; $pagenum)
			
		Else   // Prokect form of the Host DB
			
			//FORM SCREENSHOT($formName;$ScreenShot;$pagenum)
			// Workaround for ACI0089071
			// **************************************
			
			var $methodCode : Text
			$methodCode:="C_PICTURE:C286($ScreenShot;$0)\nC_TEXT:C284($Formulaire;$1)\nC_LONGINT:C283($pagenum;$2)\n"
			$methodCode:=$methodCode+"$Formulaire:=$1\n$pagenum:=$2\n"
			$methodCode:=$methodCode+"FORM SCREENSHOT:C940($Formulaire;$ScreenShot;$pagenum)\n"
			$methodCode:=$methodCode+"$0:=$ScreenShot"
			
			$code:=METHOD Get path:C1164(Path project method:K72:1; "__QST_HOST_temporary_method"; *)
			UPDT_WriteMethod($code; $methodCode)
			METHOD SET ATTRIBUTE:C1192($code; Attribute shared:K72:10; True:C214; *)
			
			If (OK=1)
				EXECUTE METHOD:C1007("__QST_HOST_temporary_method"; $Screen; $formName; $pagenum)
				If (OK=1)
					$ScreenShot:=$Screen
				End if 
			End if 
			$methodCode:=""
			UPDT_WriteMethod($code; $methodCode)
			METHOD SET ATTRIBUTE:C1192($code; Attribute shared:K72:10; False:C215; *)
			
	End case 
End if 

$0:=$ScreenShot