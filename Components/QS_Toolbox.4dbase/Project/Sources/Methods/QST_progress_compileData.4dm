//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 22/07/20, 11:58:57
// ----------------------------------------------------
// Méthode : QST_progress_compileData
// Description
// 
//
// Paramètres
// ----------------------------------------------------

#DECLARE($param : Object)

$param.value:=1
$param.content:="Compiling data"
CALL FORM:C1391(Num:C11($param.window); "progressBar_update"; $param)
PROCESS_sleep(10)