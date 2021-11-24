//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSql":false,"published4DMobile":{"scope":"none"},"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 07/07/20, 21:54:45
// ----------------------------------------------------
// Méthode : QST_progress_start
// Description
//
//
// Paramètres
// ----------------------------------------------------

#DECLARE($param : Object)->$result : Object
var $type : Integer

$type:=$param.type

// Initialisation
CALL WORKER:C1389("QST_Progress"; "_progress"; $param)
PROCESS_sleep(10)

$result:=New object:C1471("canvas"; "progress"; "content"; "Initialisation"; "value"; 0; "type"; $type; "window"; Num:C11(Storage:C1525.windows.progress))
CALL FORM:C1391($result.window; "progressBar_update"; $result)