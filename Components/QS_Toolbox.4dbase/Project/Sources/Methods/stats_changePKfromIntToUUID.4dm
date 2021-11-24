//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
ARRAY LONGINT:C221($TABLE_IDS;0)
ARRAY TEXT:C222($TABLE_NAMES;0)

Begin SQL
	/* all tables with a primary key */
	SELECT TABLE_ID,TABLE_NAME
	FROM _USER_TABLES
	WHERE _USER_TABLES.TABLE_ID IN 
	(SELECT TABLE_ID FROM _USER_CONSTRAINTS WHERE CONSTRAINT_TYPE = 'P')
	INTO :$TABLE_IDS,:$TABLE_NAMES;
End SQL

For ($i;1;Size of array:C274($TABLE_IDS))
	
	$TABLE_ID:=$TABLE_IDS{$i}
	$TABLE_NAME:=$TABLE_NAMES{$i}
	
	$primaryKeyName:=""
	$COLUMN_ID:=0
	
	Begin SQL
		SELECT _USER_CONS_COLUMNS.COLUMN_NAME,_USER_CONS_COLUMNS.COLUMN_ID
		FROM _USER_CONSTRAINTS,_USER_CONS_COLUMNS
		WHERE CONSTRAINT_TYPE = 'P'
		AND _USER_CONS_COLUMNS.TABLE_ID = :$TABLE_ID
		AND _USER_CONS_COLUMNS.CONSTRAINT_ID = _USER_CONSTRAINTS.CONSTRAINT_ID
		INTO :$primaryKeyName,:$COLUMN_ID;
	End SQL
	
	$indexName:=$TABLE_NAME+"."+$primaryKeyName
	
	$SQL:="ALTER TABLE "+"["+$TABLE_NAME+"] DISABLE LOG;"+\
		"ALTER TABLE "+"["+$TABLE_NAME+"] DROP PRIMARY KEY;"+\
		"ALTER TABLE "+"["+$TABLE_NAME+"] DROP "+"["+$primaryKeyName+"];"+\
		"ALTER TABLE "+"["+$TABLE_NAME+"] ADD ["+$primaryKeyName+"] UUID AUTO_GENERATE;"
	
	Begin SQL
		EXECUTE IMMEDIATE :$SQL;
	End SQL
	
	$field:=Field:C253($TABLE_ID;$COLUMN_ID)
	ALL RECORDS:C47(Table:C252($TABLE_ID)->)
	$table:=Table:C252($TABLE_ID)  //to avoid compile error in line below
	APPLY TO SELECTION:C70($table->;$field->:=Generate UUID:C1066)
	
	$SQL:="ALTER TABLE "+"["+$TABLE_NAME+"] ADD PRIMARY KEY (["+$primaryKeyName+"]);"+\
		"ALTER TABLE "+"["+$TABLE_NAME+"] ENABLE LOG;"
	
	Begin SQL
		EXECUTE IMMEDIATE :$SQL;
	End SQL
	
End for 
