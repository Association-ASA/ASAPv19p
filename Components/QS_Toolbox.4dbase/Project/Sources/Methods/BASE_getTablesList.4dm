//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 18/12/10, 13:41:57
// ----------------------------------------------------
// méthode : BASE_getTablesList
// description
//
//
// paramètres
// ----------------------------------------------------

C_LONGINT:C283($a; $type; $vlNumTable)
C_COLLECTION:C1488($QS_TBX_structureTable)
$type:=-1

If (Count parameters:C259=1)
	C_VARIANT:C1683($1)
	$type:=Value type:C1509($1)
End if 

$QS_TBX_structureTable:=New collection:C1472
$vlNumTable:=Get last table number:C254  // Get the bigger number of the table

For ($a; 1; $vlNumTable)
	If (Is table number valid:C999($a))  // still exist?
		$QS_TBX_structureTable.push(New object:C1471("name"; Table name:C256(Table:C252($a)); "id"; $a))
	End if 
End for 

If ($type=Is boolean:K8:9)
	$QS_TBX_structureTable.push(New object:C1471("name"; "BASE"; "id"; 0))
End if 

Use (Storage:C1525)
	Use (Storage:C1525.structureTable)
		OB_CopyToSharedCollection($QS_TBX_structureTable; Storage:C1525.structureTable)
	End use 
End use 

If ($type=Is object:K8:27)
	signal_addResult($1; Current method name:C684)
End if 