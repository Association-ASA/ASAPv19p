//%attributes = {"invisible":true}
// getConvertToProjectLogs
// Parameters:
// $0: collection
// ----------------------------------------------------
// Description:
// 
// ----------------------------------------------------
// Creation: Patrick EMANUEL, 21/11/20, 20:45:13
//


C_COLLECTION:C1488($path;$file)
ARRAY TEXT:C222($tbFiles;0x0000)
$file:=New collection:C1472()
$path:=Folder:C1567(fk logs folder:K87:17).files()

For each ($ent;$path)
	If ($ent.fullName="Conversion@")
		$file.push($ent)
	End if 
End for each 

$0:=$file

