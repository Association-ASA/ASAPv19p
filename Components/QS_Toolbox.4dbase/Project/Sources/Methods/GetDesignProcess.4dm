//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 23/03/18, 20:14:01
  // ----------------------------------------------------
  // Méthode : GetDesignProcess
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($0;$process)

C_LONGINT:C283($i;$state;$time;$id;$origin;$count)
C_BOOLEAN:C305($mode)

$count:=Count tasks:C335
$process:=0

For ($i;1;$count)
	PROCESS PROPERTIES:C336($i;$name;$state;$time;$mode;$id;$origin)
	If ($origin=Design process:K36:9)
		$process:=$i
		$i:=$count
	End if 
End for 

$0:=$process