//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // XXXX - Need to be evaluate
  // method: GetTableUUID
  // parameters:
  // $1 - String Table Name
  // output:
  // $0 - String Table's UUID
  // method does not check if table actually exists
  // http://kb.4d.com/assetid=77494
  // -----------------------------------------------------------------------

C_TEXT:C284($1;$tableName_t)
C_TEXT:C284($0)
C_TEXT:C284($struct_t;$xmlRef_t;$elemRef_t;$elemName_t;$value_t;$res_t)
C_BOOLEAN:C305($stop_b)

EXPORT STRUCTURE:C1311($struct_t)
$xmlRef_t:=DOM Parse XML variable:C720($struct_t)
DOM GET XML ELEMENT NAME:C730($xmlRef_t;$elemName_t)
$tableName_t:=$1

If ($elemName_t="base")
	
	$elemRef_t:=DOM Get first child XML element:C723($xmlRef_t;$elemName_t)
	$stop_b:=False:C215
	
	While ($stop_b=False:C215)
		
		If ($elemName_t="table")
			
			DOM GET XML ATTRIBUTE BY NAME:C728($elemRef_t;"name";$value_t)
			
			If ($value_t=$tableName_t)
				
				ON ERR CALL:C155("BASE_noERROR")
				DOM GET XML ATTRIBUTE BY NAME:C728($elemRef_t;"uuid";$res_t)
				
				If (ok=0)
					$res_t:="false"
				Else 
					$0:=$res_t
				End if 
				
				ON ERR CALL:C155("")
				$stop_b:=True:C214
				
			End if 
		End if 
		
		If ($stop_b=False:C215)
			
			$elemRef_t:=DOM Get next sibling XML element:C724($elemRef_t;$elemName_t)
			
			If (OK=0)
				$stop_b:=True:C214
			End if 
			
		End if 
	End while 
End if 

DOM CLOSE XML:C722($xmlRef_t)
