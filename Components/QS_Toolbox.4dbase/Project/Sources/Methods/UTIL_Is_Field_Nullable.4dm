//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 15/06/16, 17:08:16
  // ----------------------------------------------------
  // méthode : UTIL_Is_Field_Nullable
  // description
  //
  // http://kb.4d.com/assetid=77521
  // it is possible to Reject Null value inputs. In some cases it may be useful to get this information while the application is running. This can be done with SQL by querying the _USER_COLUMNS table and checking the NULLABLE field.
  //
  // paramètres
  // ----------------------------------------------------

C_POINTER:C301($1)  // pointer to to the field
C_BOOLEAN:C305($0;$out)
C_TEXT:C284($varName)
C_LONGINT:C283($tNum;$fNum)

If (Count parameters:C259=1)
	
	RESOLVE POINTER:C394($1;$varName;$tNum;$fNum)
	
	Begin SQL
		select NULLABLE
		from _USER_COLUMNS
		where TABLE_ID = :$tNum
		AND COLUMN_ID = :$fNum
		into :$out;
		
	End SQL
	$0:=Not:C34($out)
	
End if 
