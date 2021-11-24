//%attributes = {"invisible":true,"publishedSoap":false,"publishedWsdl":false,"shared":true,"publishedWeb":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent","published4DMobile":{"scope":"none"}}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 14/03/12
// modifié par : Association QualiSoft (01/04/14)
// ----------------------------------------------------
// méthode : SUPPORT_Quitter_Relancer
// description
// paramètres
// ----------------------------------------------------
// appel pour un redémarrage de l'application.
//

$Name:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
CONFIRM:C162("Do you really want to restart '"+$Name+"'?")

If (OK=1)
	//variables_save 
	RESTART 4D:C1292(5; "Restart asked by user.")
End if 
