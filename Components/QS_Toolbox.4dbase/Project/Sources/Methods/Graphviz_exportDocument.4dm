//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 09/05/16, 23:16:09
// Update by : Association QualiSoft (01/03/2019)
//
// ----------------------------------------------------
// {$1} : Object corresponding to 1 method with its all properties
// $0 : text
// ----------------------------------------------------
// méthode : Graphviz_exportDocument
// description
// create a schema file created by a DOT language and managed by Graphwiz

C_TEXT:C284($0; $extension; $methodName)
C_BOOLEAN:C305($workWithAllMethod)
C_COLLECTION:C1488($col)
C_OBJECT:C1216($1; $method)
$col:=New collection:C1472(".png"; ".pdf"; ".jpg"; ".svg")

// Graphviz_check

If (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Graphviz)  // New check, just in case
	
	$DOT_Content:=""
	$methodName:=""
	//$folderPath:=Folder(Folder(Storage.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath; fk platform path).path+"Export HTML/methods/").platformPath
	$folderPath:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath; fk platform path:K87:2).folder("Export HTML/methods/")
	$workWithAllMethod:=Choose:C955(Count parameters:C259=1; False:C215; True:C214)
	
	If ($workWithAllMethod)
		$Extension:=".pdf"  // by default
		
		C_COLLECTION:C1488($data)
		$data:=Storage:C1525.allMethods
		
		For each ($method; $data)
			$0:=Graphviz_exportDocument($method)  // Call Back function
		End for each 
		
	Else 
		
		$extension:=".svg"  // by default
		$col.clear()
		$method:=$1
		$methodName:=$method.name
		
		If ($methodName#"Compiler_@")
			
			$Path:=$methodName
			TOOL_trimCharacters(->$Path)
			$col.push("\""+$methodName+"\" [fillcolor=yellow, style=\"rounded,filled\", shape=rectangle, URL=\""+$Path+".html\"];")
			
			$0:=$folderPath.file($Path+$extension).platformPath
			
			// Check for CALLERS
			For each ($caller; $method.callers)
				Case of 
						// -- Ignored cases
					: ($caller="N/A")  // Nothing to link
					: ($caller="Compiler_@")  // Nothing for Compiler methods
					: ($caller=$methodName)  // Not on itself, even if callback is used
						
					Else 
						// --  Case taken in consideration
						$col.push("\""+$caller+"\" -> \""+$methodName+"\";")
						$PathCaller:=$caller
						TOOL_trimCharacters(->$PathCaller)
						$col.push("\""+$caller+"\" [fillcolor=cornflowerblue, style=\"rounded,filled\", shape=rectangle, URL=\""+$PathCaller+".html\"];")
				End case 
			End for each 
			
			// Check for CALLEES
			For each ($callees; $method.callees)
				Case of 
						// -- Ignored cases
					: ($callees="N/A")  // Nothing to link
					: ($callees="Compiler_@")  // Nothing for Compiler methods
					: ($callees=$methodName)  // Not on itself, even if callback is used
						
					Else 
						// --  Case taken in consideration
						$col.push("\""+$callees+"\" -> \""+$methodName+"\";")
						$PathCallees:=$callees
						TOOL_trimCharacters(->$PathCallees)
						$col.push("\""+$callees+"\" [fillcolor=cornflowerblue, style=\"rounded,filled\", shape=rectangle, URL=\""+$PathCallees+".html\"];")
				End case 
			End for each 
			
		Else 
			$Path:=""
			
		End if 
		
	End if 
	
	// Start the creation of Graphviz text file to be used in the batch
	If ($Path#"")
		// Modifié par : PE (22/10/2019)
		$col:=$col.distinct(ck diacritical:K85:3)
		
		$DOT_Content:="digraph {MethodLinks {"+Char:C90(Line feed:K15:40)+"ratio=fill;"+Char:C90(Line feed:K15:40)
		$DOT_Content:=$DOT_Content+"node [color=lightblue2, fontname=\"Helvetica\", fontsize=10, overlap=false, style=filled];"+Char:C90(Line feed:K15:40)
		$DOT_Content:=$DOT_Content+"rankdir=LR;"+Char:C90(Line feed:K15:40)
		$DOT_Content:=$DOT_Content+"ratio=auto;"+Char:C90(Line feed:K15:40)
		$DOT_Content:=$DOT_Content+$col.join(Char:C90(Line feed:K15:40); ck ignore null or empty:K85:5)
		$DOT_Content:=$DOT_Content+" }}"
		
		// Delete already existing export files
		If ($workWithAllMethod)
			$Path:="All project methods"
		End if 
		
		//$File:=$folderPath+$Path+$extension
		$File:=$folderPath.file($Path+$extension).platformPath
		
		C_OBJECT:C1216($resultDiagram)
		C_BLOB:C604($blobResponse)
		C_LONGINT:C283($result)
		C_OBJECT:C1216($content)
		C_PICTURE:C286($pict)
		
		$DOT_Content:=Replace string:C233($DOT_Content; Char:C90(Line feed:K15:40); "")
		$type:=Substring:C12($Extension; 2)
		
		$content:=New object:C1471(\
			"diagram_source"; $DOT_Content; \
			"diagram_type"; "graphviz"; \
			"output_format"; $type\
			)
		
		$result:=HTTP Request:C1158(HTTP POST method:K71:2; "https://kroki.io/"; $content; $blobResponse)
		
		$resultDiagram:=New object:C1471("success"; $result=200)
		If ($resultDiagram.success)
			If ($Extension=".svg")
				$resultDiagram[$type]:=BLOB to text:C555($blobResponse; UTF8 text without length:K22:17)
				//$svg:=Convert path system to POSIX($File)
				TEXT TO DOCUMENT:C1237($File; $resultDiagram[$type])
			Else 
				BLOB TO PICTURE:C682($blobResponse; $pict)
				WRITE PICTURE FILE:C680($file; $pict)
			End if 
		End if 
		
	End if 
	
	If ($workWithAllMethod)
		SHOW ON DISK:C922($folderPath.platformPath)
	End if 
End if 