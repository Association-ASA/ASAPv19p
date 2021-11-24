//%attributes = {"invisible":true,"executedOnServer":false,"preemptive":"capable","publishedSql":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSoap":false,"published4DMobile":{"scope":"none"}}
  // ----------------------------------------------------
  // ----------------------------------------------------
  // Méthode : stats_schemas
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 24/10/19, 15:54:10
  // Paramètres

C_LONGINT:C283($0;$count)

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

Begin SQL
	
	SELECT COUNT(*) FROM _USER_SCHEMAS
	INTO :$count
	
End SQL
$0:=$count

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
