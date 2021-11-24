//%attributes = {"invisible":true,"executedOnServer":true}
C_TEXT:C284($QS_VCS_COMP_DB_PATH)
ARRAY TEXT:C222($Projects_at; 0x0000)

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

// Get all Project Names
Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT EXP_APPLICATION
	FROM EXPORTS
	INTO :[$Projects_at];
	
	USE DATABASE SQL_INTERNAL;
End SQL

// Redefine Project Names

$pos:=-1
$update:=False:C215
ARRAY TEXT:C222($Projects_sav; Size of array:C274($Projects_at))

For ($a; 1; Size of array:C274($Projects_at))
	
	$Projects_sav{$a}:=$Projects_at{$a}
	$pos:=Position:C15("."; $Projects_at{$a})
	If ($pos>0)
		$update:=True:C214
		$Projects_at{$a}:=Substring:C12($Projects_at{$a}; 1; $pos-1)
	End if 
End for 

// Update Project Names in EXPORTS

If ($update)
	Begin SQL
		
		USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
		
	End SQL
	
	For ($a; 1; Size of array:C274($Projects_at))
		
		$Value:=$Projects_at{$a}
		$Ref:=$Projects_sav{$a}
		
		Begin SQL
			
			UPDATE EXPORTS
			SET EXP_APPLICATION = :[$Value]
			WHERE EXP_APPLICATION = :[$Ref];
			
			UPDATE VCS
			SET VCS_APPLICATION = :[$Value]
			WHERE VCS_APPLICATION = :[$Ref];
			
		End SQL
		
	End for 
	
	Begin SQL
		
		USE DATABASE SQL_INTERNAL;
		
	End SQL
	
End if 