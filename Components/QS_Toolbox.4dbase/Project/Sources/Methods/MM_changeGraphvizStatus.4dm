//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_BOOLEAN:C305($1)

$shared:=Storage:C1525.QS_TBX_SHARED_DATA
Use ($shared)
	$shared.QS_TBX_Graphviz:=$1
End use 