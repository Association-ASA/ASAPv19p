//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// WP SET ATTRIBUTEs($range; wk page break inside; wk avoid)
C_POINTER:C301($Zpt)
ARRAY TEXT:C222($TbForms; 0x0000)
C_LONGINT:C283($tableNumber)
C_LONGINT:C283($window)
C_OBJECT:C1216($FormDetail; $1; $param)

$param:=New object:C1471("title"; "Export"; "icon"; "btn_phpword.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window
$hostInProjectMode:=(Storage:C1525.QS_TBX_SHARED_DATA.QS_hostInProjectMode=1)

For ($tableNumber; 0; Get last table number:C254)
	CLEAR VARIABLE:C89($TbForms)
	
	Case of 
		: ($tableNumber=0)
			FORM GET NAMES:C1167($TbForms; *)
			$tableName:=""
			
		: ($tableNumber>0)
			If (Is table number valid:C999($tableNumber))
				$Zpt:=Table:C252($tableNumber)
				$tableName:=Table name:C256($Zpt)
				FORM GET NAMES:C1167($Zpt->; $TbForms; *)
			End if 
	End case 
	
	If (Size of array:C274($TbForms)>0)  // In case of there is no Project Forms
		$FormDetail:=New object:C1471
		$Progression:=0
		$pas:=1/(Size of array:C274($TbForms)+1)
		
		For ($b; 1; Size of array:C274($TbForms))
			Case of 
				: ($tableNumber>0)
					$form:=New object:C1471("formName"; $TbForms{$b}; "table"; $tableNumber; "project"; $hostInProjectMode)
					$FormDetail:=TOOL_getFormDynamicExport($form)
					
				Else 
					$form:=New object:C1471("formName"; $TbForms{$b}; "table"; 0; "project"; $hostInProjectMode)
					$FormDetail:=TOOL_getFormDynamicExport($form)
			End case 
			
			$FormDetail.formName:=$TbForms{$b}
			$FormDetail.tableName:=$tableName
			$FormDetail.tableNum:=$tableNumber
			$Progression:=$Progression+$pas
			
			$param.value:=-1
			$param.content:="Export of Form "+$FormDetail.tableName+": "+$FormDetail.formName
			CALL FORM:C1391($window; "progressBar_update"; $param)
			
			$param.value:=$Progression
			CALL FORM:C1391($window; "progressBar_update"; $param)
			
			CALL WORKER:C1389("QST_exportForm"+String:C10($tableNumber)+"_"+String:C10($b); "FE_exportForm"; $FormDetail)  // Should be faster than working Form by Form
		End for 
		
	End if 
	
End for 

$param.value:=1
$param.content:="Forms export ended"
CALL FORM:C1391($window; "progressBar_update"; $param)
signal_addResult($1; Current method name:C684)