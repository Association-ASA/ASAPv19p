//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 09/12/17, 11:26:15
// ----------------------------------------------------
// Méthode : QST_CREATE_FOLDERS
// Description
//
//
// Paramètres
// ----------------------------------------------------

var $destinationFolder; $sourceFolder : Object
var $path : 4D:C1709.Folder
var $dbName : Text

ON ERR CALL:C155("BASE_noERROR")
// To be able to export locally (on client if C/S)
$path:=QS_s_Get_DB_Name
$dbName:=$path.name
$path:=Folder:C1567(fk documents folder:K87:21; *).folder("QS_Toolbox").folder($path.name)  // type 4D file
Use (Storage:C1525)
	Use (Storage:C1525.QS_TBX_SHARED_DATA)
		Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath:=$Path.platformPath
		Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName:=$dbName
	End use 
End use 

$sourceFolder:=$path.folder("Forms")
If (Not:C34($sourceFolder.exists))
	$sourceFolder.create()
End if 

$sourceFolder:=$path.folder("All Project Methods")
If (Not:C34($sourceFolder.exists))
	$sourceFolder.create()
End if 

$sourceFolder:=$path.folder("Export")
If (Not:C34($sourceFolder.exists))
	$sourceFolder.create()
End if 

$sourceFolder:=$path.folder("Report Validation")
If (Not:C34($sourceFolder.exists))
	$sourceFolder.create()
End if 

$sourceFolder:=$path.folder("Export JSON")
If (Not:C34($sourceFolder.exists))
	$sourceFolder.create()
End if 

$sourceFolder:=$path.folder("Export HTML")
If (Not:C34($sourceFolder.exists))
	$sourceFolder:=Folder:C1567(fk resources folder:K87:11).folder("Export HTML")
	$destinationFolder:=$sourceFolder.copyTo($path; fk overwrite:K87:5)
End if 

KILL WORKER:C1390