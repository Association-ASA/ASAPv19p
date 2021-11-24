//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 10/05/16, 09:27:15
// ----------------------------------------------------
// méthode : FE_createGraphviz
// description
//
//
// paramètres
// ----------------------------------------------------

Graphviz_check

If (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Graphviz)
	
	$SkipFormat:=False:C215
	$Extension:=".png"
	
	C_OBJECT:C1216($param)
	C_LONGINT:C283($tableNumber)
	ARRAY TEXT:C222($pathMethods; 0x0000)
	ARRAY TEXT:C222($listObject; 0x0000)
	ARRAY POINTER:C280($listPtr_var; 0x0000)
	ARRAY INTEGER:C220($listPages; 0x0000)
	
	$tableNumber:=Form:C1466.tableNum
	$formName:=Form:C1466.formulare
	
	If ($formName#"")
		
		FE_getObjectsAndMethods($tableNumber; $formName; ->$listObject; ->$listPtr_var; ->$listPages; ->$pathMethods)
		FORM UNLOAD:C1299
		
		$param:=New object:C1471
		OB SET ARRAY:C1227($param; "objects"; $listObject)
		OB SET ARRAY:C1227($param; "pages"; $listPages)
		OB SET ARRAY:C1227($param; "methodPath"; $pathMethods)
		$param.dotContent:=New collection:C1472
		$param.name:=Str_GetTableOrProjectForm($tableNumber)+$formName
		
		FE_createDOTfile($param; ->$listPtr_var)
		$DOT_Content:=$param.dotContent
		
		// -- Export file creation
		$path:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"Forms"+Folder separator:K24:12
		$File:=$path+$param.name+$Extension
		TOOL_trimCharacters(->$File)
		
		// https://kroki.io/#try
		// https://dreampuf.github.io/GraphvizOnline/#digraph%20G%20%7B%0A%0A%20%20subgraph%20cluster_0%20%7B%0A%20%20%20%20style%3Dfilled%3B%0A%20%20%20%20color%3Dlightgrey%3B%0A%20%20%20%20node%20%5Bstyle%3Dfilled%2Ccolor%3Dwhite%5D%3B%0A%20%20%20%20a0%20-%3E%20a1%20-%3E%20a2%20-%3E%20a3%3B%0A%20%20%20%20label%20%3D%20%22process%20%231%22%3B%0A%20%20%7D%0A%0A%20%20subgraph%20cluster_1%20%7B%0A%20%20%20%20node%20%5Bstyle%3Dfilled%5D%3B%0A%20%20%20%20b0%20-%3E%20b1%20-%3E%20b2%20-%3E%20b3%3B%0A%20%20%20%20label%20%3D%20%22process%20%232%22%3B%0A%20%20%20%20color%3Dblue%0A%20%20%7D%0A%20%20start%20-%3E%20a0%3B%0A%20%20start%20-%3E%20b0%3B%0A%20%20a1%20-%3E%20b3%3B%0A%20%20b2%20-%3E%20a3%3B%0A%20%20a3%20-%3E%20a0%3B%0A%20%20a3%20-%3E%20end%3B%0A%20%20b3%20-%3E%20end%3B%0A%0A%20%20start%20%5Bshape%3DMdiamond%5D%3B%0A%20%20end%20%5Bshape%3DMsquare%5D%3B%0A%7D
		
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
			BLOB TO PICTURE:C682($blobResponse; $pict)
			WRITE PICTURE FILE:C680($file; $pict)
		End if 
		
		If (Not:C34($SkipFormat))
			
			$file:=Convert path system to POSIX:C1106($file)  // -- For Mac comptability
			WA OPEN URL:C1020(*; "webZone"; "file:///"+$file)
			
		End if 
		
	Else 
		
		ALERT:C41("Select a Form prior to call this function.")
	End if 
	
End if 