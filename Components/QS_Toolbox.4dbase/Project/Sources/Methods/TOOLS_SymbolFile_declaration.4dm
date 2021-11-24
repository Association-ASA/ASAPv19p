//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

  //$method:=$1
  //$Keyword:=$2
  //$threadSafe:=$3

Use (Storage:C1525.allMethods)
	Storage:C1525.allMethods[$1].syntax:=$2
	Storage:C1525.allMethods[$1].isThread:=$3
End use 

KILL WORKER:C1390