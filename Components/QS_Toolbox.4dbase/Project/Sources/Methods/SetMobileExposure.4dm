//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // method: SetMobileExposure
  // details: Returns True if passed table or field is exposed to 4D Mobile/REST Services
  // parameters:
  // $1 - Table ID
  // $2 - Field ID, Optional
  // if not passed method will check the table passed
  // if passed method will check the field in the table passed

If (False:C215)
	
	$var1:=SetMobileExposure (2)  // $var1 is False
	$var2:=SetMobileExposure (1)  // $var2 is True
	$var3:=SetMobileExposure (1;1)  // $var3 is True
	$var4:=SetMobileExposure (1;2)  // $var4 is False
	
End if 

  // -------------------------------------------------------------------

C_LONGINT:C283($1;$table_id_l)
C_LONGINT:C283($2;$column_id_l)
C_BOOLEAN:C305($0;$exposed_b)

If (Count parameters:C259>=1)
	
	$table_id_l:=$1
	
	Case of 
			
		: (Count parameters:C259=1)
			GetMobileExposure ($table_id_l)
			
		: (Count parameters:C259>=2)
			$column_id_l:=$2
			GetMobileExposure ($table_id_l;$column_id_l)
			
	End case 
End if 

  // inversons le statut REST
$exposed_b:=Not:C34($exposed_b)

If (Count parameters:C259>=1)
	
	Case of 
			
		: (Count parameters:C259=1)
			
			Begin SQL
				UPDATE _USER_TABLES
				SET REST_AVAILABLE = :$exposed_b
				WHERE TABLE_ID = :$table_id_l;
				
			End SQL
			
		: (Count parameters:C259>=2)
			
			Begin SQL
				UPDATE _USER_TABLES
				SET REST_AVAILABLE = :$exposed_b
				WHERE TABLE_ID = :$table_id_l AND COLUMN_ID = :$column_id_l;
				
			End SQL
			
	End case 
End if 
