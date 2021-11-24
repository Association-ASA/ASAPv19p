//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}

C_TEXT:C284($1;$case)
$case:=$1

Case of 
	: ($case="set")
		OB_windowNumberToStorage ("counter";QS_TBX_LH_counter)
		
	: ($case="get")
		QS_TBX_LH_counter:=Storage:C1525.windows.counter
		
End case 