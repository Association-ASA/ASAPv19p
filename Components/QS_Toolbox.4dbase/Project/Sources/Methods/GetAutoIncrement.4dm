//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // method: GetAutoIncrement
  // parameters:
  // $1 - Table number
  // $2 - Field number
  // $0 Boolean Returns:
  // true - If field generates automaticly incrementing values
  // false - If field does not generates automaticly incrementing values
  // -----------------------------------------------------------------------

C_LONGINT:C283($1;$table_id_l)
C_LONGINT:C283($2;$column_id_l)
C_BOOLEAN:C305($0;$autoInc_b)

If (Count parameters:C259>=2)
	
	$table_id_l:=$1
	$column_id_l:=$2
	
	Begin SQL
		SELECT AUTOINCREMENT
		FROM _USER_COLUMNS
		WHERE TABLE_ID= :$table_id_l
		AND COLUMN_ID= :$column_id_l
		INTO :$autoInc_b;
		
	End SQL
	
	$0:=$autoInc_b
	
End if 
