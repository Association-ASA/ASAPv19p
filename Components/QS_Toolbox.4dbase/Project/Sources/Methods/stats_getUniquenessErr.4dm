//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"indifferent","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
  // ----------------------------------------------------
  // $0 : collection(object("typeMap";"log"))
  // ----------------------------------------------------
  // Méthode : stats_getUniquenessErr
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 26/10/19, 17:08:59
  // Paramètres

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")
C_LONGINT:C283($type)
ARRAY TEXT:C222($fields;0x0000)

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

ARRAY LONGINT:C221($types;0x0000)

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
$results:=New collection:C1472

For each ($type;$types1)
	
	Begin SQL
		SELECT DISTINCT(CONCAT(CONCAT(CONCAT('[:',_USER_COLUMNS.TABLE_ID),']:'),_USER_COLUMNS.COLUMN_ID))
		FROM _USER_CONS_COLUMNS,_USER_COLUMNS,_USER_CONSTRAINTS
		WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
		AND _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
		AND _USER_COLUMNS.TABLE_ID = _USER_CONSTRAINTS.RELATED_TABLE_ID
		AND _USER_COLUMNS.COLUMN_ID = _USER_CONS_COLUMNS.RELATED_COLUMN_ID
		AND _USER_COLUMNS.UNIQUENESS = FALSE
		AND _USER_COLUMNS.DATA_TYPE = :$type
		INTO :$fields;
	End SQL
	
	If (Size of array:C274($fields)#0)
		For ($i;1;Size of array:C274($fields))
			$to:=Parse formula:C1576($fields{$i};Formula out with tokens:K88:3)
			$results.push(New object:C1471("typeMap";$dataTypeMap[$type];"log";$to))
		End for 
	End if 
End for each 
$0:=$results.orderBy("typeMap")

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
