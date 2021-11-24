//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // method: GetAutoUUID
  // parameters:
  // $1 - Table number
  // $2 - Field number
  // $0 Boolean Returns:
  // true - If field automatically generates a UUID value
  // false - If field does not automatically generates a UUID value
  // -----------------------------------------------------------------------

If (False:C215)
	
	$check_b:=GetAutoUUID (1;1)  // $check_b = False
	$check_b:=GetAutoUUID (1;2)  // $check_b = True
	$check_b:=GetAutoUUID (1;3)  // $check_b = False
	
End if 

  // -----------------------------------------------------------------------

C_LONGINT:C283($1;$table_id_l)
C_LONGINT:C283($2;$column_id_l)
C_BOOLEAN:C305($0;$autoGen_b)

If (Count parameters:C259>=2)
	
	$table_id_l:=$1
	$column_id_l:=$2
	
	Begin SQL
		SELECT AUTOGENERATE
		FROM _USER_COLUMNS
		WHERE TABLE_ID = :$table_id_l
		AND COLUMN_ID = :$column_id_l
		INTO :$autoGen_b;
		
	End SQL
	
	$0:=$autoGen_b
	
End if 
