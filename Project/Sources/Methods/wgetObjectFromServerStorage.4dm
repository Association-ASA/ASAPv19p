//%attributes = {"preemptive":"capable"}
#DECLARE($propriete : Text)

var $ob : Object

$ob:=New object:C1471
$ob:=wgetSstorage($propriete)

Use (Storage:C1525)
	Storage:C1525[$propriete]:=OB Copy:C1225($ob; ck shared:K85:29)
End use 
