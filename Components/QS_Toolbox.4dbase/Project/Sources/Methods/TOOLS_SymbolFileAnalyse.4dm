//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($2;$declaration)
C_TEXT:C284($line)
C_REAL:C285($step;$pas)
C_LONGINT:C283($i;$nb)
C_BOOLEAN:C305($onServer;$1)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

$onServer:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ServerMode)
$declaration:=$2
$nb:=$declaration.first.length

$pas:=100/$nb
$i:=0
$step:=0


For each ($line;$declaration.first)
	$i:=$i+1
	$step:=$step+$pas
	
	CALL WORKER:C1389("QST_symbolAnalyze";"TOOLS_SymbolFile_analyze";$line;$declaration)
	
End for each 

While ($declaration.count<$nb)
	PROCESS_sleep 
End while 

Use (Storage:C1525)
	Storage:C1525.symbols_variable:=New shared collection:C1527
	Use (Storage:C1525.symbols_variable)
		Storage:C1525.symbols_variable:=$declaration.declaration
	End use 
End use 

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
