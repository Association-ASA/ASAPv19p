//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_OBJECT:C1216($licence;$1)
$licence:=$1

Use (Storage:C1525)
	Storage:C1525.licence:=New shared object:C1526
	Use (Storage:C1525.licence)
		OB_CopyToSharedObject ($licence;Storage:C1525.licence)
	End use 
End use 
