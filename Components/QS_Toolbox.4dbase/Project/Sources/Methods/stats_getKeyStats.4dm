//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$dataTypeMap:=New collection:C1472
$dataTypeMap[1]:="boolean"
  //
$dataTypeMap[3]:="16-bit integer"
$dataTypeMap[4]:="32-bit integer"
$dataTypeMap[5]:="64-bit integer"
$dataTypeMap[6]:="real"
$dataTypeMap[7]:="float"
$dataTypeMap[8]:="date"
$dataTypeMap[9]:="time"
$dataTypeMap[10]:="text inside record"
  //11
$dataTypeMap[12]:="picture"
$dataTypeMap[13]:="UUID"
$dataTypeMap[14]:="text outside record"
  //15
  //16
  //17
$dataTypeMap[18]:="BLOB"
$dataTypeMap[19]:="text inside record"  //utf8
$dataTypeMap[20]:="text outside record"  //utf8
$dataTypeMap[21]:="object"

ARRAY LONGINT:C221($types;0)

  //1-field
Begin SQL
	SELECT DISTINCT(_USER_COLUMNS.DATA_TYPE)
	FROM _USER_CONS_COLUMNS,_USER_COLUMNS,_USER_CONSTRAINTS
	WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
	AND _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
	AND _USER_COLUMNS.TABLE_ID = _USER_CONSTRAINTS.RELATED_TABLE_ID
	AND _USER_COLUMNS.COLUMN_ID = _USER_CONS_COLUMNS.RELATED_COLUMN_ID
	INTO :$types;
End SQL

$types1:=New collection:C1472
ARRAY TO COLLECTION:C1563($types1;$types)

C_LONGINT:C283($type)

$results:=New collection:C1472

ARRAY TEXT:C222($fields;0)

For each ($type;$types1)
	
	Begin SQL
		SELECT DISTINCT(CONCAT(CONCAT(_USER_COLUMNS.TABLE_NAME,'.'),_USER_COLUMNS.COLUMN_NAME))
		FROM _USER_CONS_COLUMNS,_USER_COLUMNS,_USER_CONSTRAINTS
		WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
		AND _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
		AND _USER_COLUMNS.TABLE_ID = _USER_CONSTRAINTS.RELATED_TABLE_ID
		AND _USER_COLUMNS.COLUMN_ID = _USER_CONS_COLUMNS.RELATED_COLUMN_ID
		AND _USER_COLUMNS.DATA_TYPE = :$type
		INTO :$fields;
	End SQL
	
	$results.push(New collection:C1472(\
		$dataTypeMap[$type];String:C10(Size of array:C274($fields))).join("\t"))
	
End for each 

SET TEXT TO PASTEBOARD:C523($results.join("\r"))
