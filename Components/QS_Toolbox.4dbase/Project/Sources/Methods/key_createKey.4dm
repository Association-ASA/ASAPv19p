//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // ----------------------------------------------------
  // $1 : object containing basic information
  // ----------------------------------------------------
  // Méthode : key_createKey
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 30/08/19, 14:40:34
  // Paramètres

C_OBJECT:C1216($1;$licence)
C_LONGINT:C283($Total;$serial)
C_TEXT:C284($0)

$key:=""
$licence:=$1
$Total:=Date:C102($licence.end)-!1969-11-17!  // Get a number of days
$serial:=$Total*25
$isGood:=False:C215
$iteration:=0

  // Loop until a valid code will be found
While ($isGood=False:C215)
	$serial:=$serial+16
	$iteration:=$iteration+1
	If ($serial%3=0)  // On valid code has been found
		$isGood:=True:C214
	End if 
End while 

  // Check now the lenght
$key:=String:C10($serial)

While (Length:C16($key)<15)
	$letter:=Char:C90((Random:C100%26)+64)
	
	If ($letter#"E")  // To remove the case of Exponential interpretation.
		$Place:=(Random:C100%(Length:C16($key)))+1
		$key:=Substring:C12($key;1;$Place)+$letter+Substring:C12($key;$Place+1)
	End if 
End while 

  // add now the licence type
$key:=Substring:C12($key;0;$iteration)+String:C10(Num:C11($licence.server))+Substring:C12($key;$iteration+1)
$0:=String:C10($iteration)+"-"+$key