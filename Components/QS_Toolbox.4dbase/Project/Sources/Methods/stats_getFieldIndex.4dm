//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
  // ----------------------------------------------------
  // $0 : Collection(Object("index";"BTree";"cluster";"auto";"composite";"keyword"))
  // ----------------------------------------------------
  // Méthode : stats_getFieldIndex
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 26/10/19, 09:49:54
  // Paramètres
C_COLLECTION:C1488($0;$dataTypeMap;$results;$indexTypes)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

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

ARRAY LONGINT:C221($fieldTypes;0)

Begin SQL
	SELECT DISTINCT(DATA_TYPE) 
	FROM _USER_COLUMNS,_USER_IND_COLUMNS
	WHERE _USER_IND_COLUMNS.TABLE_ID = _USER_COLUMNS.TABLE_ID
	AND _USER_IND_COLUMNS.COLUMN_ID = _USER_COLUMNS.COLUMN_ID
	INTO :$fieldTypes
End SQL

$results:=New collection:C1472

$indexTypes:=New collection:C1472
$indexTypes[0]:="B-Tree"
$indexTypes[1]:="Cluster B-Tree"
$indexTypes[2]:="Composite"
$indexTypes[3]:="Keyword"
$indexTypes[4]:="Auto"
$indexTypes[5]:="Object"

ARRAY LONGINT:C221($types;0x0000)
ARRAY TEXT:C222($id;0x0000)

For ($i;1;Size of array:C274($fieldTypes))
	
	CLEAR VARIABLE:C89($types)
	CLEAR VARIABLE:C89($id)
	$type:=$fieldTypes{$i}
	$composite:=0
	$keyword:=0
	
	Begin SQL
		SELECT _USER_INDEXES.INDEX_TYPE,_USER_INDEXES.INDEX_ID 
		FROM _USER_COLUMNS,_USER_IND_COLUMNS,_USER_INDEXES
		WHERE DATA_TYPE = :$type
		AND _USER_IND_COLUMNS.TABLE_ID = _USER_COLUMNS.TABLE_ID
		AND _USER_IND_COLUMNS.COLUMN_ID = _USER_COLUMNS.COLUMN_ID
		AND _USER_INDEXES.INDEX_ID = _USER_IND_COLUMNS.INDEX_ID
		INTO :$types,:$id;
	End SQL
	
	For ($j;1;Size of array:C274($id))
		$INDEX_ID:=$id{$j}
		$count:=0
		$count2:=0
		
		Begin SQL
			SELECT COUNT(*)
			FROM _USER_IND_COLUMNS
			WHERE INDEX_ID = :$INDEX_ID
			INTO :$count;
			
			SELECT COUNT(*)
			FROM _USER_INDEXES
			WHERE INDEX_ID = :$INDEX_ID
			AND KEYWORD = TRUE
			INTO :$count2;
		End SQL
		
		If ($count>1)
			$composite:=$composite+1
		End if 
		
		If ($count2#0)
			$keyword:=$keyword+1
		End if 
		
	End for 
	
	$results.push(New object:C1471("index";$dataTypeMap[$type];\
		"BTree";Count in array:C907($types;1)-$composite;\
		"cluster";Count in array:C907($types;3)-$keyword;\
		"auto";Count in array:C907($types;7)+Count in array:C907($types;8);\
		"composite";$composite;\
		"keyword";$keyword))
	
End for 

$0:=$results
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")

