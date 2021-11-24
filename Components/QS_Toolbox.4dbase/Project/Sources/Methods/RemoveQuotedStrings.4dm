//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_TEXT:C284($1;$0;$codeLine)
C_LONGINT:C283($start;$end)

$codeLine:=$1
$start:=Position:C15("\"";$codeLine)
If ($start>0)
	While ($start>0)
		$end:=Position:C15("\"";$codeLine;$start+1)
		$codeLine:=Substring:C12($codeLine;1;$start-1)+Substring:C12($codeLine;$end+1)
		$start:=Position:C15("\"";$codeLine)
	End while 
End if 
$0:=$codeLine

