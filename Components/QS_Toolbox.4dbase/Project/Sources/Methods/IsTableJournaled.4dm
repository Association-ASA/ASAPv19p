//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// Method: IsTableJournaled
// Parameters:
// $1 - String Table Name
// Output:
// $0 = True: Is Journaled / logged
// $0 = False: Is NOT Journaled /logged
// Method does not check if table actually exists
// Source:  http://kb.4d.com/assetid=77414
//-----------------------------------------------------------------------

C_TEXT:C284($elemName_t; $elemRef_t; $res_t; $struct_t; $value_t; $xmlRef_t; $tableName_t; $1)
C_BOOLEAN:C305($stop_b; $result; $0)

If (Count parameters:C259=1)
	$struct_t:=$1
	EXPORT STRUCTURE:C1311($struct_t)
	$xmlRef_t:=DOM Parse XML variable:C720($struct_t)
Else 
	$xmlRef_t:=DOM Parse XML variable:C720($2->)
End if 

$onErrCallMethod:=Method called on error:C704
ON ERR CALL:C155("BASE_GetError")

DOM GET XML ELEMENT NAME:C730($xmlRef_t; $elemName_t)
If ($elemName_t="base")
	$elemRef_t:=DOM Get first child XML element:C723($xmlRef_t; $elemName_t)
	$stop_b:=False:C215
	While ($stop_b=False:C215)
		If ($elemName_t="table")
			DOM GET XML ATTRIBUTE BY NAME:C728($elemRef_t; "name"; $value_t)
			If ($value_t=$tableName_t)
				DOM GET XML ATTRIBUTE BY NAME:C728($elemRef_t; "prevent_journaling"; $res_t)
				If (ok=0)
					$res_t:="false"
				End if 
				$stop_b:=True:C214
			End if 
		End if 
		If ($stop_b=False:C215)
			$elemRef_t:=DOM Get next sibling XML element:C724($elemRef_t; $elemName_t)
			If (OK=0)
				$stop_b:=True:C214
			End if 
		End if 
	End while 
End if 

ON ERR CALL:C155($onErrCallMethod)
$result:=Bool:C1537(Choose:C955($res_t="true"; 0; 1))
$0:=$result