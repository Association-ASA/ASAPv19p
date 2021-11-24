//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 22/11/21, 10:52:45
// ----------------------------------------------------
// Méthode : z_demarreWorkersStart
// Description
// 
//
// Paramètres
// ----------------------------------------------------


$signal:=New signal:C1641
signal_setNew($signal; 1)
CALL WORKER:C1389("initStorage"; "wCalcProp2Storage"; $signal)
$signal.wait()





