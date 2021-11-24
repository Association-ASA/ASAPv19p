//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
  // ----------------------------------------------------
  // $0 : Collection(Object("tableName";"fragmentation";"countField";"countDeleted";"size";"sizePercent"))
  // ----------------------------------------------------
  // Méthode : stats_getTableStats
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : sieste68
  // Date et heure : 25/10/19, 12:55:33
  // Paramètres

C_COLLECTION:C1488($0;$results)
ARRAY LONGINT:C221($recordsInTable;0)
ARRAY LONGINT:C221($fieldsInTable;0)
ARRAY LONGINT:C221($deletedFieldsInTable;0)
ARRAY LONGINT:C221($fragmentation;0)
ARRAY TEXT:C222($tableName;0)
ARRAY LONGINT:C221($tableId;0)
C_OBJECT:C1216($temp)
ARRAY TEXT:C222($tab;0x0000)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

$results:=New collection:C1472

For ($table;1;Get last table number:C254)
	
	If (Is table number valid:C999($table))
		CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;"tableStat: "+Table name:C256($table))
		
		CLEAR VARIABLE:C89($tab)
		$temp:=ds:C1482[Table name:C256($table)]
		OB GET PROPERTY NAMES:C1232($temp;$tab)
		$size:=Size of array:C274($tab)
		
		APPEND TO ARRAY:C911($fieldsInTable;$size)
		APPEND TO ARRAY:C911($deletedFieldsInTable;Get last field number:C255($table)-$size)
		APPEND TO ARRAY:C911($recordsInTable;Records in table:C83(Table:C252($table)->))
		APPEND TO ARRAY:C911($fragmentation;Get table fragmentation:C1127(Table:C252($table)->))
		APPEND TO ARRAY:C911($tableName;Table name:C256($table))
		APPEND TO ARRAY:C911($tableId;$table)
	End if 
End for 

  //MULTI SORT ARRAY(\
$fieldsInTable;<;\
$recordsInTable;<;\
$tableName;<;\
$tableId;<;\
$deletedFieldsInTable;<;\
$fragmentation;<)

$recordsInDatabase:=Sum:C1($recordsInTable)

For ($i;1;Size of array:C274($tableName))
	  // Get the size of an empty record
	CREATE RECORD:C68(Table:C252($tableId{$i})->)
	$path:=Temporary folder:C486+Generate UUID:C1066
	SET CHANNEL:C77(10;$path)
	SEND RECORD:C78(Table:C252($tableId{$i})->)
	SET CHANNEL:C77(11)
	$size:=Get document size:C479($path)
	
	$results.push(New object:C1471(\
		"tableName";$tableName{$i};\
		"fragmentation";String:C10($fragmentation{$i};"##0.00");\
		"countField";String:C10($fieldsInTable{$i});\
		"countDeleted";String:C10($deletedFieldsInTable{$i});\
		"size";String:C10($size);\
		"sizePercent";String:C10($recordsInTable{$i}/$recordsInDatabase;"##0.00");\
		"records";$recordsInTable{$i}))
End for 

$0:=$results
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
