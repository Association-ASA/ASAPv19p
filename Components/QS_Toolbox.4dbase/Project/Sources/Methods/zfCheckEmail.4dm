//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 04/05/18, 14:21:18
  // ----------------------------------------------------
  // Paramètres
  // $1= Email à tester
  // $0= false for wrong, true for correct
  // ----------------------------------------------------
  // Méthode : fCheck_Email
  // Description
  //  

C_TEXT:C284($1;$emailAddress)
C_BOOLEAN:C305($0)
C_TEXT:C284($pattern)

$emailAddress:=$1
$emailAddress:=Lowercase:C14($emailAddress)

$0:=False:C215
$pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,4})+)$"  // Olivier
  //  $Pattern:="^([^@\\s]+)@((?:[-a-z0-9]{1,63}+\\.)+[a-z]{2,4})$"  ` Maurice - `Contrôle conforme au RFC 2181

ARRAY LONGINT:C221($_Position;0)
ARRAY LONGINT:C221($_length;0)

If (Match regex:C1019($pattern;$emailAddress;1;$_Position;$_length))
	If ($_length{0}=Length:C16($emailAddress))
		  //$email_username:=Substring($emailAddress;$_Position{1};$_length{1})
		  //$email_domain:=Substring($emailAddress;$_Position{2};$_length{2})
		$0:=True:C214
	End if 
End if 

