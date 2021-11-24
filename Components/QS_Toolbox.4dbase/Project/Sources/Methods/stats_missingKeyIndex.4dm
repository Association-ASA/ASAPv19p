//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
C_LONGINT:C283($0;$count)
ARRAY LONGINT:C221($tn;0)
ARRAY LONGINT:C221($fn;0)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

  //1-field
Begin SQL
	
	SELECT _USER_COLUMNS.TABLE_ID,_USER_COLUMNS.COLUMN_ID
	FROM _USER_CONS_COLUMNS,_USER_COLUMNS,_USER_CONSTRAINTS
	WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
	AND _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
	AND _USER_COLUMNS.TABLE_ID = _USER_CONSTRAINTS.RELATED_TABLE_ID
	AND _USER_COLUMNS.COLUMN_ID = _USER_CONS_COLUMNS.RELATED_COLUMN_ID
	INTO :$tn,:$fn;
	
End SQL

$result:=0

For ($i;1;Size of array:C274($tn))
	
	$t:=$tn{$i}
	$f:=$fn{$i}
	
	Begin SQL
		
		SELECT COUNT(*)
		FROM _USER_IND_COLUMNS
		WHERE _USER_IND_COLUMNS.TABLE_ID = :$t
		AND _USER_IND_COLUMNS.COLUMN_ID = :$f
		INTO :$result;
		
	End SQL
	
	If ($result=0)
		$count:=$count+1
	End if 
	
End for 
$0:=$count
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
