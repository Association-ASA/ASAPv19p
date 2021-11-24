//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/10/17, 17:31:25
  // ----------------------------------------------------
  // Méthode : TOOLS_CompactDB
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

$ficStruc:=Structure file:C489(*)
$ficDonnees:=Data file:C490
$Result:=Compact data file:C937($ficStruc;$ficDonnees)
If (OK=1)
	$mess:="Datafile compression finished."
Else 
	$mess:="An error has been detected during compactage.\nCheck your log file."
	
	$chemin:=Get 4D folder:C485(Logs folder:K5:19;*)
	SHOW ON DISK:C922($chemin)
End if 
displayInfo ($mess;"red")