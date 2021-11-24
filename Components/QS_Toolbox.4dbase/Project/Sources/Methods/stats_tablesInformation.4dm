//%attributes = {"invisible":true}
  // ----------------------------------------------------
  // $0 : object
  // ----------------------------------------------------
  // Méthode : stats_tablesInformation
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 24/10/19, 20:17:17
  // Paramètres

C_OBJECT:C1216($0;$info)
ARRAY TEXT:C222($formNames;0x0000)
C_POINTER:C301($zptTable)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

$allFields:=0
$total:=0
$tableName:="{No table}"
$countFields:=0
$maxField:=0

FORM GET NAMES:C1167($formNames;*)
$info:=New object:C1471("maxField";0;"maxFieldsInTable";$tableName;"countTables";0;"countFields";0;"tablesForm";0;"projectForm";Size of array:C274($formNames))

If (Get last table number:C254>0)  // If there is at least 1
	$total:=Get last table number:C254
	
	For ($Table;Get last table number:C254;1;-1)
		
		$total:=Choose:C955(Is table number valid:C999($Table);$total;$total-1)
		
		If (Is table number valid:C999($Table))
			CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;"Analyse table: "+Table name:C256($Table))
			
			$ZptTable:=Table:C252($Table)
			FORM GET NAMES:C1167($ZptTable->;$formNames;*)
			$info.tablesForm:=$info.tablesForm+Size of array:C274($formNames)
			
			$countFields:=Get last field number:C255($Table)
			
			For ($FieldScan;1;$countFields)
				$countFields:=Choose:C955(Is table number valid:C999($Table);$countFields;$countFields-1)
			End for 
			
			If ($countFields>$maxField)
				$maxField:=$countFields
				$tableName:=Table name:C256($Table)
			End if 
			
			$allFields:=$allFields+$countFields
		End if 
		
	End for 
End if 

$info.maxField:=$maxField
$info.maxFieldsInTable:=$tableName
$info.countTables:=$total
$info.countFields:=$allFields

$0:=$info
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
