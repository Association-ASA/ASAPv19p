//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // ----------------------------------------------------
  // $1 : object containing licence
  // $0 : date
  // ----------------------------------------------------
  // Méthode : key_getExpirationDate
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 31/08/19, 09:10:21
  // Paramètres

C_OBJECT:C1216($licence;$1)
C_TEXT:C284($key)
C_LONGINT:C283($iteration;$total;$numKey)
C_DATE:C307($0)

$licence:=$1
$iteration:=Num:C11(Substring:C12($licence.key;1;Position:C15("-";$licence.key)-1))
$key:=Substring:C12($licence.key;Position:C15("-";$licence.key)+1)
$numkey:=Num:C11(Substring:C12($key;0;$iteration)+Substring:C12($key;$iteration+2))

Repeat 
	$iteration:=$iteration-1
	$numKey:=$numKey-16
Until ($iteration=0)

$total:=$numKey/25

$0:=!1969-11-17!+$total