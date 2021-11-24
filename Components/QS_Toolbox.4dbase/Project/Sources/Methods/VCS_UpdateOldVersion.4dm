//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 22/06/18, 17:17:35
  // ----------------------------------------------------
  // Paramètres
  // $0 = Value of the OldVersion
  // $1 = Timestamp
  // $2 = Path
  // ----------------------------------------------------
  // Méthode : VCS_UpdateOldVersion
  // Description
  // VCS_UpdateOldVersion($Timestamp;$path)

C_LONGINT:C283($Timestamp;$1)
C_TEXT:C284($path;$2;$0)

$Timestamp:=$1
$path:=$2
$0:=VCS_GetOldVersion ($Timestamp;$path)