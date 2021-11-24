//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 27/02/19, 13:42:05
// ----------------------------------------------------
// Méthode : CM_clearComments
// Description
// 
//
// Paramètres
// ----------------------------------------------------


C_COLLECTION:C1488($Methods)
$DocPath:=Storage:C1525.QS_TBX_SHARED_DATA.appPath+"Documentation"+Folder separator:K24:12
$folder:=Folder:C1567($DocPath; fk platform path:K87:2)
$files:=$folder.files(fk recursive:K87:7+fk ignore invisible:K87:22)

// Doesn't work
//$files:=Folder(Storage.QS_TBX_SHARED_DATA.appPath; fk platform path).folder("Documentation").files(fk recursive+fk ignore invisible)

$action:=False:C215
If (x_io_confirm_yesNo("Are you sure to want to delete method comments ("+String:C10($Methods.length)+")?"; ->$action))
	
	For each ($file; $files)
		$file.delete()
	End for each 
	
	$coll:=Storage:C1525.allMethods.query("hasDescription =:1"; True:C214)
	Use (Storage:C1525.allMethods)
		For each ($c; $coll)
			$c.hasDescription:=False:C215
		End for each 
	End use 
	
	MM_option_manager(3; False:C215)
	displayInfo("All comments have been deleted.")
	
End if 