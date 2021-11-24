//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
#DECLARE($option : Object; $signalToCheck : Object)

C_TEXT:C284($path)
C_COLLECTION:C1488($distinctPath)
$distinctPath:=Storage:C1525.allMethods.distinct("path")

C_OBJECT:C1216($signal)
$signal:=New signal:C1641
signal_setNew($signal; $distinctPath.length)

For each ($path; $distinctPath)
	$data:=Storage:C1525.allMethods.query("path =:1"; $path).orderBy("name asc").copy()
	CALL WORKER:C1389("Report - "+$path; "RAPPORT_export1methodType"; $data; $option; $Signal)
End for each 

$signal.wait()

For each ($path; $distinctPath)
	KILL WORKER:C1390("Report - "+$path)
End for each 

signal_addResult($signalToCheck; Current method name:C684)