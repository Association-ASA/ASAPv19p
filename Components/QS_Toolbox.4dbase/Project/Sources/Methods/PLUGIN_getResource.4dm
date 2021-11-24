//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}

/* PLUGIN_getResource
        Parameters:
        
        ----------------------------------------------------
        Creation: QualiSoft - Patrick EMANUEL, 15/09/21, 16:11:01
        ----------------------------------------------------
        Description:
            
*/

#DECLARE($path : Object)->$result : Object

$result:=New object:C1471("path"; ""; "type"; "")

$resourcesPath:=$path.folder("Contents/Resources").platformPath
$files:=$path.folder("Contents/Resources").files(fk ignore invisible:K87:22)

For each ($filePath; $files)
	
	If ($filePath.extension="rsrc") | ($filePath.extension="rsr")
		
		OB SET:C1220($result; "path"; $filePath.platformPath)
		OB SET:C1220($result; "type"; "rsr")
		
	Else 
		
		$manifestPath:=$path.folder("Contents").file("manifest.json")
		
		If ($manifestPath.isFile)
			OB SET:C1220($result; "path"; $manifestPath.platformPath)
			OB SET:C1220($result; "type"; "json")
		End if 
		
	End if 
	
End for each 