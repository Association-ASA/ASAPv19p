//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
C_LONGINT:C283($0;$count)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

Begin SQL
	
	SELECT COUNT(*)
	FROM _USER_CONSTRAINTS
	WHERE _USER_CONSTRAINTS.CONSTRAINT_TYPE= '4DR'
	INTO :$count
	
End SQL
$0:=$count

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
