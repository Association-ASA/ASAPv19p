//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // method: GetMobileExposure
  // details: Returns True if passed table or field is exposed to 4D Mobile/REST Services
  // parameters:
  // $1 - Table ID
  // $2 - Field ID, Optional
  // if not passed method will check the table passed
  // if passed method will check the field in the table passed
  // http://kb.4d.com/assetid=77218

If (False:C215)
	
	$var1:=GetMobileExposure (2)  // $var1 is False
	$var2:=GetMobileExposure (1)  // $var2 is True
	$var3:=GetMobileExposure (1;1)  // $var3 is True
	$var4:=GetMobileExposure (1;2)  // $var4 is False
	
End if 

  // -------------------------------------------------------------------

C_LONGINT:C283($1;$table_id_l)
C_LONGINT:C283($2;$column_id_l)
C_BOOLEAN:C305($0;$exposed_b)

If (Count parameters:C259>=1)
	
	$table_id_l:=$1
	
	Case of 
			
		: (Count parameters:C259=1)
			
			Begin SQL
				SELECT REST_AVAILABLE
				FROM _USER_TABLES
				WHERE TABLE_ID = :$table_id_l
				INTO :$exposed_b;
				
			End SQL
			
		: (Count parameters:C259>=2)
			$column_id_l:=$2
			
			Begin SQL
				SELECT REST_AVAILABLE
				FROM _USER_COLUMNS
				WHERE TABLE_ID = :$table_id_l
				AND COLUMN_ID = :$column_id_l
				INTO :$exposed_b;
				
			End SQL
			
	End case 
	
	$0:=$exposed_b
	
End if 
