//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_TEXT:C284($1;$0)

If (Count parameters:C259=1)
	
	C_LONGINT:C283($j)
	
	$value_t:=$1
	$metacharacters_t:=Char:C90(Quote:K15:44)+Char:C90(Double quote:K15:41)+"\\[]{}<>"
	
	For ($j;1;Length:C16($metacharacters_t))
		$metacharacter_t:=Substring:C12($metacharacters_t;$j;1)
		$value_t:=Replace string:C233($value_t;$metacharacter_t;"";*)  // remove the character
	End for 
	
	$0:=$value_t
	
End if 