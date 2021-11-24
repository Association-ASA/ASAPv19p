//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 08/07/16, 08:01:42
// ----------------------------------------------------
// méthode : GraphvizAndNicmcd_Available
// description
// test  if Graphwiz is installed 
// -> On MAC, try to execute it
// -> On PC, test if it is present inside the Ressources folder
// ----------------------------------------------------

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(4) - "+Current method name:C684)

C_BOOLEAN:C305($Graphviz; $NirCmd)

// Check if the web is available
$Graphviz:=(ENV_FIndMyPublicIP#"")

// Check if NirCmd is present
$NirCmd:=True:C214
If (Is Windows:C1573)
	$NirCmd:=Folder:C1567("/RESOURCES/nircmd/"; fk posix path:K87:1).isFolder
End if 

$shared:=Storage:C1525.QS_TBX_SHARED_DATA
Use ($shared)
	$shared.NirCmd:=$NirCmd
	$shared.QS_TBX_Graphviz:=$Graphviz
End use 

If (Count parameters:C259=1)
	C_OBJECT:C1216($1)
	signal_addResult($1; Current method name:C684)
End if 