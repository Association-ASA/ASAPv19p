//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"indifferent","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
ARRAY TEXT:C222($id;0x0000)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

Begin SQL
	SELECT DISTINCT(INDEX_ID)
	FROM _USER_IND_COLUMNS
	INTO :$id;
End SQL

$count:=0
$results:=New collection:C1472

For ($i;1;Size of array:C274($id))
	$INDEX_ID:=$id{$i}
	Begin SQL
		SELECT COUNT(*)
		FROM _USER_IND_COLUMNS
		WHERE INDEX_ID = :$INDEX_ID
		INTO :$count;
	End SQL
	
	If ($count>1)
		ARRAY TEXT:C222($fields;0)
		Begin SQL
			SELECT DISTINCT(CONCAT(CONCAT(CONCAT('[:',TABLE_ID),']:'),COLUMN_ID))
			FROM _USER_IND_COLUMNS
			WHERE INDEX_ID = :$INDEX_ID
			INTO :$fields;
		End SQL
		
		$f:=New collection:C1472
		
		For ($j;1;Size of array:C274($fields))
			$f.push(Parse formula:C1576($fields{$j};Formula out with tokens:K88:3))
		End for 
		
		$results.push(New object:C1471("index";$INDEX_ID;"composite";$f.join(",")))
	End if 
	
End for 
$0:=$results.orderBy("index")

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
