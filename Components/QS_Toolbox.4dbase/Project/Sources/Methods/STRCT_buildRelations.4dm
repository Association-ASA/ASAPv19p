//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// https://blog.4d.com/detailed-analysis-database-structure/

C_OBJECT:C1216($oTable; $2)
C_LONGINT:C283($i)
C_COLLECTION:C1488($1; $result)
C_TEXT:C284($3; $tableName; $destinationField; $destinationUUID; $destinationTable; $destinationUUID; $sourceField; $sourceUUID; $sourceUUID; $sourceTable)
C_TEXT:C284($name_Nto1; $name_1toN; $relationUUID)
//ARRAY OBJECT($arrField; 0)
// OB GET ARRAY($oTable; "related_field"; $arrField)  // Retrieve the 
$result:=$1
$oTable:=$2
$tableName:=$3

$arrField:=$oTable.related_field
For each ($field; $arrField)
	
	Case of 
		: ($field.kind="source")
			$sourceField:=$field.name
			$sourceUUID:=$field.uuid
			$sourceTable:=$field.table_name
			$sourceUUID:=$field.table_uuid
			
		: ($field.kind="destination")
			$destinationField:=$field.name
			$destinationUUID:=$field.uuid
			$destinationTable:=$field.table_name
			$destinationUUID:=$field.table_uuid
			
	End case 
	
End for each 

If ($tableName=$sourceTable) | ($tableName=$destinationTable)
	C_LONGINT:C283($auto_load_Nto1; $auto_load_1toN; $entry_wildchar; $entry_create; $pentry_autofill; $choice_field)
	
	STRCT_getColorTable($oTable)
	
	$name_Nto1:=$oTable.name_Nto1
	$name_1toN:=$oTable.name_1toN
	$relationUUID:=$oTable.uuid
	
	$integrity:="None"
	If (OB Is defined:C1231($oTable; "integrity")=True:C214)
		$integrity:=$oTable.integrity
	End if 
	
	$choice_field:=Num:C11($oTable.choice_field)  // Correct the retypage error
	
	$Tmp:=$oTable.auto_load_Nto1
	$auto_load_Nto1:=Choose:C955((($Tmp="") | ($Tmp="False")); 0; 1)
	
	$Tmp:=$oTable.auto_load_1toN
	$auto_load_1toN:=Choose:C955((($Tmp="") | ($Tmp="False")); 0; 1)
	
	$Tmp:=$oTable.entry_wildchar
	$entry_wildchar:=Choose:C955((($Tmp="") | ($Tmp="False")); 0; 1)
	
	$Tmp:=$oTable.entry_create
	$entry_create:=Choose:C955((($Tmp="") | ($Tmp="False")); 0; 1)
	
	$Tmp:=$oTable.entry_autofill
	$pentry_autofill:=Choose:C955((($Tmp="") | ($Tmp="False")); 0; 1)
	
	$result.push(New object:C1471("From"; "["+$sourceTable+"]"+$sourceField; "To"; "["+$destinationTable+"]"+$destinationField; "name_Nto1"; $name_Nto1; "name_1toN"; \
		$name_1toN; "b_AutoLoad_Nto1"; $auto_load_Nto1; "b_autoLoad_1toN"; $auto_load_1toN; "Integrity"; $integrity; "choiceField"; $choice_field; \
		"b_wildchar"; $entry_wildchar; "b_create"; $entry_create; "b_autoFill"; $pentry_autofill; "color"; $oTable.color))
End if 
