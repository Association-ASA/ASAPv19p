//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
  // key_getLicence

C_OBJECT:C1216($licence;$file)

$licence:=New object:C1471
$file:=Folder:C1567(fk licenses folder:K87:16).file("qs_toolbox.licence")

If ($file.exists)
	$licenceText:=$file.getText("UTF-8")
	$licence:=JSON Parse:C1218($licenceText)
End if 

$0:=$licence