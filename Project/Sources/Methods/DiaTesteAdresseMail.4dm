//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 10/12/19, 05:41:08
// ----------------------------------------------------
// Méthode : DiaTesteAdresseMail
// Description
// Méthode qui teste si le paramètre $1 est une adresse mail conforme
//
// Paramètre : $1 = chaine à tester
// ----------------------------------------------------

C_TEXT:C284($1; $emailAddress)
C_BOOLEAN:C305($0; $ok)
C_TEXT:C284($pattern)

$emailAddress:=$1
// $ok:=ZCapitaliseChamp(->$emailAddress;Faux)

$0:=False:C215
$pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,4})+)$"  // Olivier
//  $Pattern:="^([^@\\s]+)@((?:[-a-z0-9]{1,63}+\\.)+[a-z]{2,4})$"  ` Maurice - `Contrôle conforme au RFC 2181

ARRAY LONGINT:C221($_Position; 0)
ARRAY LONGINT:C221($_length; 0)

If (Match regex:C1019($pattern; $emailAddress; 1; $_Position; $_length))
	If ($_length{0}=Length:C16($emailAddress))
		//$email_username:=Substring($emailAddress;$_Position{1};$_length{1})
		//$email_domain:=Substring($emailAddress;$_Position{2};$_length{2})
		$0:=True:C214
	End if 
End if 

