//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $wa_p : Pointer
var $file : Text

$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5; "webZone")
$file:=Convert path system to POSIX:C1106(File:C1566("/RESOURCES/codemirror/index.html").platformPath)
WA OPEN URL:C1020($wa_p->; "file:///"+$file)
PROCESS_sleep(5)
