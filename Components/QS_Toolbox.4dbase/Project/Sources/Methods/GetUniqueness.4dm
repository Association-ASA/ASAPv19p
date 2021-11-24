//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // method: GetUniqueness
  // parameters:
  // $1 - Table number
  // $2 - Field number
  // $0 Boolean Returns:
  // true - If field accept only Unique value
  // false - in other case
  // -----------------------------------------------------------------------

If (False:C215)
	
	$check_b:=GetUniqueness (1;1)  // $check_b = False
	$check_b:=GetUniqueness (1;2)  // $check_b = True
	$check_b:=GetUniqueness (1;3)  // $check_b = False
	
End if 

  // -----------------------------------------------------------------------

C_LONGINT:C283($1;$table_id_l)
C_LONGINT:C283($2;$column_id_l)
C_BOOLEAN:C305($0;$Uniqueness)

If (Count parameters:C259>=2)
	
	$table_id_l:=$1
	$column_id_l:=$2
	
	Begin SQL
		SELECT UNIQUENESS
		FROM _USER_COLUMNS
		WHERE TABLE_ID = :$table_id_l
		AND COLUMN_ID = :$column_id_l
		INTO :$Uniqueness;
		
	End SQL
	
	$0:=$Uniqueness
	
End if 
