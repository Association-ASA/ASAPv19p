//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 04/03/18, 17:56:55
// ----------------------------------------------------
// Méthode : _QST_CreateComponent
// Description
// Automatic component compilation and compiled version
// Automatic ZIP component created
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($table; 0x0000)
C_OBJECT:C1216($file; $myFile; $pathToZIP; $status; $storage)
C_COLLECTION:C1488($fileToDelete)

METHODS_getOnlyPorjectPaths(->$table)

// Check before creating the component
If (Find in sorted array:C1333($table; "__QST_HOST_temporary_method"; >))
	ALERT:C41("Method '__QST_HOST_temporary_method' must be delete from the component before any Build creation request's.")
Else 
	
	_cleanRessourcesFolder
	
	If (OK=1)
		
		// Force the compilator execution
		BUILD APPLICATION:C871(Get 4D file:C1418(Build application settings file:K5:60))
		
		If (OK=1)
			
			// Paths definition
			$storage:=OB Copy:C1225(Storage:C1525.QS_TBX_SHARED_DATA)
			$app:=$Storage.SoftName
			
			// 4d.js file
			$db:=Folder:C1567(Folder:C1567(fk database folder:K87:14; *).platformPath; fk platform path:K87:2; *)
			$compilePath_s:=$db.parent.path+$db.name
			$compilePath:=$compilePath_s+"_build/Base de données compilée/"+$app+".4dbase/"
			$codeMirror:=$compilePath_s+"_build/Base de données compilée/"+$app+".4dbase/Resources/codemirror/mode/4d/"
			
			$myFile:=Folder:C1567($codeMirror).file("4d_source.js")
			$file:=$myFile.copyTo(Folder:C1567($codeMirror); "4d.js"; fk overwrite:K87:5)
			//$myFile:=Folder($codeMirror; fk platform path).file("4d_source.js")
			//$file:=$myFile.copyTo(Folder($codeMirror; fk platform path); "4d.js"; fk overwrite)
			$myFile:=Folder:C1567($codeMirror).file("4d_source.js").delete()
			
			// Macros v2 folder
			//$pathToCreate:=Folder($compilePath+"Macros v2"; fk platform path) // Previous syntax
			$pathToCreate:=Folder:C1567($compilePath; fk platform path:K87:2).folder("Macros v2")
			
			If ($pathToCreate.create())
				$myFile:=Folder:C1567($db.platformPath+"Macros v2"; fk platform path:K87:2).file("Macros.xml")
				$file:=$myFile.copyTo(Folder:C1567($pathToCreate.path; fk platform path:K87:2); fk overwrite:K87:5)
			End if 
			
			$myFile:=Folder:C1567(fk database folder:K87:14; *).file("Info.plist")  // display information for ogPop or 4D Pop
			$file:=$myFile.copyTo(Folder:C1567($compilePath; fk platform path:K87:2); fk overwrite:K87:5)
			
			// Documentation folder
			//Folder($compilePath+"Documentation/Forms"; fk platform path).delete(Delete with contents)
			Folder:C1567($compilePath; fk platform path:K87:2).folder("Documentation/Forms").delete(Delete with contents:K24:24)
			
			$pathToDelete:=Folder:C1567($compilePath+"Documentation/Methods"; fk platform path:K87:2)
			$fileToDelete:=Storage:C1525.allMethods.query("attributes.invisible =:1 and path =:2"; True:C214; "Path project method")
			
			For each ($file; $fileToDelete)
				$myFile:=$pathToDelete.file($file.name+".md"; fk platform path:K87:2)  // Constant is very important here
				If ($myFile.exists)
					$myFile.delete()
				End if 
			End for each 
			
			$extension:=" "+$Storage.QS_TBX_Componant_Version+String:C10(Year of:C25(Current date:C33))+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")
			$pathToZIP:=Folder:C1567($compilePath_s+"_build/"; fk platform path:K87:2).file($app+$extension+".zip")
			
			// From keisuke:
			// https://discuss.4d.com/t/tips-on-using-native-zip-commands-to-update-xlsx-files/15193
			$compilePath:=$compilePath_s+"_build/Base de données compilée/"
			$folder:=Folder:C1567($compilePath; fk platform path:K87:2)
			$source:=New object:C1471
			$source.files:=$folder.files().combine($folder.folders())
			$status:=ZIP Create archive:C1640($source; $pathToZIP)
			
			SHOW ON DISK:C922($pathToZIP.platformPath)
		End if 
		
	End if 
	
End if 