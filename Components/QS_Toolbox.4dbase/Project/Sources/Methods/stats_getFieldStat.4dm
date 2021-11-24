//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
  // ----------------------------------------------------
  // $0 : Collection(objects("dataType";"count"))
  // ----------------------------------------------------
  // Méthode : stats_getFieldStat
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 25/10/19, 07:14:57
  // Paramètres

C_LONGINT:C283($type;$count)
C_COLLECTION:C1488($results;$dataTypeMap;$types)
C_PICTURE:C286($img)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

$types:=New collection:C1472
$results:=New collection:C1472
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
$dataTypeMap[15]:="Subtable Source"
$dataTypeMap[16]:="Subtable Destination"
  //17
$dataTypeMap[18]:="BLOB"
$dataTypeMap[19]:="text inside record"  //utf8
$dataTypeMap[20]:="text outside record"  //utf8
$dataTypeMap[21]:="object"

ARRAY LONGINT:C221($fieldTypes;0)

Begin SQL
	SELECT DISTINCT(DATA_TYPE) FROM _USER_COLUMNS 
	INTO :$fieldTypes
End SQL

ARRAY TO COLLECTION:C1563($types;$fieldTypes)

For each ($type;$types)
	Begin SQL
		SELECT COUNT(*) FROM _USER_COLUMNS
		WHERE DATA_TYPE = :$type
		INTO :$count
	End SQL
	
	$PictureFile:=File:C1566("/RESOURCES/images/fields/"+String:C10($type)+".png").platformPath
	READ PICTURE FILE:C678($PictureFile;$Img)
	
	$results.push(New object:C1471("dataType";$dataTypeMap[$type];"count";$count;"logo";$img))
End for each 

$results:=$results.orderBy("count desc")
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
$0:=$results
