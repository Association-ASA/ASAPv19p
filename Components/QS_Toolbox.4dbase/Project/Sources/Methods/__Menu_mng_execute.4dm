//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
#DECLARE($window : Text)

var $myObj : Object
$myObj:=New object:C1471

CALL WORKER:C1389("QST_openWindow"; "STO_openWindow"; $myObj; $window)