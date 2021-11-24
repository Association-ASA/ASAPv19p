//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // ----------------------------------------------------
  // méthode : Konstant_getName
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------
  // Konstant_getName -> txt
  // pour debug retourne chaine type d'événement formulaire


C_TEXT:C284($Language)
C_LONGINT:C283($1;$2)
C_COLLECTION:C1488($result)
$Group:=$1
$ID:=$2
$Language:=Config_getLanguage 

$result:=Storage:C1525.constants.query("token = :1";":K"+String:C10($Group)+":"+String:C10($ID))
If ($result.length=1)
	$0:=$result[0][$Language]
End if 
