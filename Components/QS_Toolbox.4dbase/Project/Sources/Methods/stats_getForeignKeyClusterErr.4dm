//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"indifferent","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
  // ----------------------------------------------------
  // $0 : Collection(Object("from";"to"))
  // ----------------------------------------------------
  // Méthode : stats_getForeignKeyClusterErr
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 26/10/19, 16:41:47
  // Paramètres
ARRAY LONGINT:C221($tn;0)
ARRAY LONGINT:C221($fn;0)
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

  //N-field
Begin SQL
	SELECT _USER_COLUMNS.TABLE_ID,_USER_COLUMNS.COLUMN_ID
	FROM _USER_CONS_COLUMNS,_USER_COLUMNS,_USER_CONSTRAINTS,_USER_INDEXES,_USER_IND_COLUMNS
	WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
	AND _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
	AND _USER_COLUMNS.TABLE_ID = _USER_CONSTRAINTS.TABLE_ID
	AND _USER_COLUMNS.COLUMN_ID = _USER_CONS_COLUMNS.COLUMN_ID
	AND _USER_COLUMNS.TABLE_ID = _USER_IND_COLUMNS.TABLE_ID
	AND _USER_COLUMNS.COLUMN_ID = _USER_IND_COLUMNS.COLUMN_ID
	AND _USER_INDEXES.INDEX_ID = _USER_IND_COLUMNS.INDEX_ID
	AND (_USER_INDEXES.INDEX_TYPE = 1 OR _USER_INDEXES.INDEX_TYPE = 7)
	INTO :$tn,:$fn;
End SQL

  //MULTI SORT ARRAY($tn;>;$fn;>)
$results:=New collection:C1472

For ($i;1;Size of array:C274($tn))
	
	$t:=$tn{$i}
	$f:=$fn{$i}
	
	$tr:=0
	$fr:=0
	
	Begin SQL
		SELECT _USER_CONSTRAINTS.RELATED_TABLE_ID,_USER_CONS_COLUMNS.RELATED_COLUMN_ID
		FROM _USER_CONS_COLUMNS,_USER_COLUMNS,_USER_CONSTRAINTS
		WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
		AND _USER_CONSTRAINTS.CONSTRAINT_ID = _USER_CONS_COLUMNS.CONSTRAINT_ID
		AND _USER_CONS_COLUMNS.TABLE_ID = :$t
		AND _USER_CONS_COLUMNS.COLUMN_ID = :$f
		LIMIT 1
		INTO :$tr,:$fr;
	End SQL
	
	$from:=Parse formula:C1576("[:"+String:C10($t)+"]:"+String:C10($f);Formula out with tokens:K88:3)
	$to:=Parse formula:C1576("[:"+String:C10($tr)+"]:"+String:C10($fr);Formula out with tokens:K88:3)
	$results.push(New object:C1471("from";$from;"to";$to))
	
End for 
$0:=$results.orderBy("from")
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
