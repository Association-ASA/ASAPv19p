//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
#DECLARE($param : Object)->$result : Object

C_BOOLEAN:C305($isProjectForm)
C_POINTER:C301($ptTable)
C_TEXT:C284($formName)

$formName:=$param.formName
$isProjectForm:=Bool:C1537($param.table=0)
If (OB Is defined:C1231($param; "project"))
	$isProjectMode:=$param.project
Else 
	$isProjectMode:=False:C215
End if 
$result:=New object:C1471

If (Not:C34($isProjectForm))
	$ptTable:=Table:C252(Num:C11($param.tableNum))
	$result:=FORM Convert to dynamic:C1570($ptTable->; $formName)
	
Else 
	
	Case of 
			// This is  a binary base: ($isProjectMode=False) 
		: ($isProjectMode=False:C215) & ($isProjectForm=True:C214)  // Project form
			//Same like FORM SCREENSHOT($formName;$ScreenShot;$pagenum)
			// Workaround for ACI0089071
			// **************************************
			C_TEXT:C284($methodCode)
			$methodCode:="C_OBJECT:C1216($0)\nC_TEXT:C284($1;$formName)\n"
			$methodCode:=$methodCode+"$formName:=$1\n"
			$methodCode:=$methodCode+"$0:=FORM Convert to dynamic:C1570($formName)"
			
			$code:=METHOD Get path:C1164(Path project method:K72:1; "__QST_HOST_temporary_method"; *)
			UPDT_WriteMethod($code; $methodCode)
			METHOD SET ATTRIBUTE:C1192($code; Attribute shared:K72:10; True:C214; *)
			
			If (OK=1)
				EXECUTE METHOD:C1007("__QST_HOST_temporary_method"; $result; $formName)
			End if 
			$methodCode:=""
			UPDT_WriteMethod($code; $methodCode)
			METHOD SET ATTRIBUTE:C1192($code; Attribute shared:K72:10; False:C215; *)
			
		: ($isProjectMode=False:C215) & ($isProjectForm=False:C215)  // Table form
			$ptTable:=Table:C252(Num:C11($param.tableNum))
			$result:=FORM Convert to dynamic:C1570($ptTable->; $formName)
			
		Else 
			
			// This is  a project mode DB: ($isProjectMode=true) 
			$path:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.appPath; fk platform path:K87:2).folder("Project/Sources/"+Choose:C955($isProjectMode=False:C215; "Table"; "")+"Forms/"+$formName).file("form.4DForm")
			$result:=JSON Parse:C1218($path.getText())
			
	End case 
End if 