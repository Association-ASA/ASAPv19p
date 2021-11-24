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

ARRAY TEXT:C222($fields;0)

  //1-field
Begin SQL
	
	SELECT DISTINCT(CONCAT(CONCAT(CONCAT('[:',_USER_COLUMNS.TABLE_ID),']:'),_USER_COLUMNS.COLUMN_ID))
	FROM _USER_CONS_COLUMNS,_USER_COLUMNS,_USER_CONSTRAINTS,_USER_INDEXES,_USER_IND_COLUMNS
	WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
	AND _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
	AND _USER_COLUMNS.TABLE_ID = _USER_CONSTRAINTS.RELATED_TABLE_ID
	AND _USER_COLUMNS.COLUMN_ID = _USER_CONS_COLUMNS.RELATED_COLUMN_ID
	AND _USER_COLUMNS.TABLE_ID = _USER_IND_COLUMNS.TABLE_ID
	AND _USER_COLUMNS.COLUMN_ID = _USER_IND_COLUMNS.COLUMN_ID
	AND _USER_INDEXES.INDEX_ID = _USER_IND_COLUMNS.INDEX_ID
	AND (_USER_INDEXES.INDEX_TYPE = 3 AND _USER_INDEXES.KEYWORD = FALSE)
	INTO :$fields;
	
End SQL

ARRAY LONGINT:C221($pos;0)
ARRAY LONGINT:C221($len;0)

$results:=New collection:C1472

C_LONGINT:C283($type)

If (Size of array:C274($fields)#0)
	For ($i;1;Size of array:C274($fields))
		If (Match regex:C1019("(\\d+)\\D+(\\d+)";$fields{$i};1;$pos;$len))
			$tn:=Num:C11(Substring:C12($fields{$i};$pos{1};$len{1}))
			$fn:=Num:C11(Substring:C12($fields{$i};$pos{2};$len{2}))
			Begin SQL
				SELECT DATA_TYPE
				FROM _USER_COLUMNS 
				WHERE TABLE_ID = :$tn
				AND COLUMN_ID = :$fn
				INTO :$type;
			End SQL
			$results.push(New collection:C1472($dataTypeMap[$type];Parse formula:C1576($fields{$i};Formula out with tokens:K88:3)).join("\t"))
		End if 
	End for 
End if 

SET TEXT TO PASTEBOARD:C523($results.join("\r"))
