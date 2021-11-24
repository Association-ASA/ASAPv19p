//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 24/06/16, 19:50:55
  // ----------------------------------------------------
  // méthode : TOOL_Get_Table_PK
  // description
  // returns pointer to primary key field(s) of a given table
  // http://kb.4d.com/assetid=77571
  //
  // paramètres
  // ----------------------------------------------------
  //
  // parameters:
  // $1 - Pointer to table
  // $2 - Pointer to an array of pointers to contain primary key fields (OPTIONAL)
  // $0 - Returns pointer to field that is primary key

C_POINTER:C301($1;$tblPtr;$0;$pkPointer)
C_LONGINT:C283($tblNum;$i)
C_TEXT:C284($cID)

If (Count parameters:C259>=1)
	
	$tblPtr:=$1
	$tblNum:=Table:C252($tblPtr)
	ARRAY TEXT:C222($constrIDs;0x0000)
	
	Begin SQL
		Select CONSTRAINT_ID from _USER_CONSTRAINTS
		Where Table_ID=:$tblNum AND CONSTRAINT_TYPE='P'
		Into :$constrIDs
		
	End SQL
	
	ARRAY LONGINT:C221($colIDs;0x0000)
	
	For ($i;1;Size of array:C274($constrIDs))
		
		$cID:=$constrIDs{$i}
		
		Begin SQL
			Select COLUMN_ID from _USER_CONS_COLUMNS
			Where Table_ID=:$tblNum AND CONSTRAINT_ID=:$cID
			Into :$colIDs
			
		End SQL
		
	End for 
	
	If (Size of array:C274($colIDs)>=1)
		$pkPointer:=Field:C253($tblNum;$colIDs{1})
		$0:=$pkPointer
	End if 
	
	If (Count parameters:C259>=2)
		
		C_POINTER:C301($2;$arrPKs)
		$arrPKs:=$2
		
		For ($i;1;Size of array:C274($colIDs))
			APPEND TO ARRAY:C911($arrPKs->;Field:C253($tblNum;$colIDs{$i}))
		End for 
		
	End if 
End if 
