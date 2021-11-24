//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 23/04/18, 20:52:41
// ----------------------------------------------------
// Méthode : Graphviz_neightbouring
// Description
//
//
// Paramètres
// ----------------------------------------------------
#DECLARE($param : Object)

var $call; $CurrentMethod; $Extension; $path : Text
var $method : Object
var $docRef : Time
var $data; $methods; $MethodTree; $ToBuild : Collection

$MethodTree:=New collection:C1472
$ToBuild:=New collection:C1472
$methods:=New collection:C1472
$method:=New object:C1471
$data:=Storage:C1525.allMethods

$CurrentMethod:=$param.name
If (OB Is defined:C1231($1; "ext"))
	$Extension:=$1.ext
End if 
If ($Extension="")
	$Extension:=".svg"
End if 

$path:=$param.path
$MethodTree.push($CurrentMethod)

For each ($call; $param.callees)
	$MethodTree.push($call)
End for each 
For each ($call; $param.callers)
	$MethodTree.push($call)
End for each 

$const:="[fillcolor=yellow, style=\"rounded,filled\", shape=rectangle]"
$value:="\""+$CurrentMethod+"\""+$const+";"
$ToBuild.push($value)

For each ($SourceMethod; $MethodTree)
	
	If ($SourceMethod#"Compiler_@")
		$myMethod:=New object:C1471
		$myMethod:=Storage:C1525.index[$SourceMethod]
		
		For each ($call; $myMethod.callees)
			$ToBuild.push("\""+$SourceMethod+"\" -> \""+$call+"\";")
		End for each 
		
		For each ($call; $myMethod.callers)
			$ToBuild.push("\""+$call+"\" -> \""+$SourceMethod+"\";")
		End for each 
		
	End if 
	
End for each 

$ToBuild:=$ToBuild.distinct(ck diacritical:K85:3)  // Just to keep one instance of each

$DOT_Content:="digraph MethodLinks { ratio=fill; "
$DOT_Content:=$DOT_Content+"node [color=lightblue2, fontname=Helvetica, fontsize=10, overlap=false, style=filled]; "
$DOT_Content:=$DOT_Content+"rankdir=LR; "
$DOT_Content:=$DOT_Content+"ratio=auto; "
$DOT_Content:=$DOT_Content+$ToBuild.join(" "; ck ignore null or empty:K85:5)
$DOT_Content:=$DOT_Content+" }"

// https://kroki.io/#try
var $resultDiagram : Object
var $blobResponse : Blob
var $result : Integer
var $content : Object
var $pict : Picture

$type:=Substring:C12($Extension; 2)

$content:=New object:C1471(\
"diagram_source"; $DOT_Content; \
"diagram_type"; "graphviz"; \
"output_format"; $type\
)

$result:=HTTP Request:C1158(HTTP POST method:K71:2; "https://kroki.io/"; $content; $blobResponse)

$resultDiagram:=New object:C1471("success"; $result=200)
If ($resultDiagram.success)
	TOOL_trimCharacters(->$CurrentMethod)
	$file:=Folder:C1567($param.path; fk platform path:K87:2).file($CurrentMethod+$Extension)
	BLOB TO PICTURE:C682($blobResponse; $pict)
	WRITE PICTURE FILE:C680($file.platformPath; $pict)
End if 

If (Count parameters:C259=2)
	var $2 : Object
	$2.trigger()
End if 