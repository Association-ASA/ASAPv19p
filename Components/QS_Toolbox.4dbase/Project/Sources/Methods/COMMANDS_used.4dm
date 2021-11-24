//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($method)
C_BOOLEAN:C305($1; $isPop)
C_COLLECTION:C1488($data)
C_LONGINT:C283($posFirst; $posLast)
ARRAY TEXT:C222($Keyword; 0x0000)

$data:=Storage:C1525.allMethods
$isPop:=$1

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+"(A) -> Start")
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+"(B) -> extract code start")

$AllCodeLinesText:=$data.extract("clearCode").join("\r")
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+"(C) -> extract code end")
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+"(D) -> KEYWORDS start")
GET TEXT KEYWORDS:C1141($AllCodeLinesText; $Keyword)  // We want all occurences of each terms => NO STAR

SORT ARRAY:C229($Keyword; >)
CLEAR VARIABLE:C89($AllCodeLinesText)  // Get back some memory free
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+"(D) -> KEYWORDS end")

For each ($method; $data)  // $AllMethod
	
	If (Find in sorted array:C1333($Keyword; $method.name; >; $posFirst; $posLast))
		Use (Storage:C1525.allMethods)
			$method.nbNested:=$posLast-$posFirst+1
		End use 
	End if 
	CALL WORKER:C1389("QST_debug"; "floatWindow_send"; "Counting method"; $method.name+": x"+String:C10($method.nbNested))
End for each 
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684+"(A) -> End")

$signal:=New signal:C1641
signal_setNew($signal; 1)
CALL WORKER:C1389("QST_crossReference"; "CM_crossReference"; $isPop; $signal)
$signal.wait()

savingData
CM_analysisEnd

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
End if 