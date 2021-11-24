//%attributes = {"invisible":true,"preemptive":"capable","publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 23/06/19, 18:22:49
// Paramètres
// ----------------------------------------------------
// $1 : Object with following properties
// name : name of file
// objects : array of objects
// pages : array of object pages
// methodPath : array of object methods
// dotContent : text which will be populated as return
// $2 : Pointer array
// ----------------------------------------------------
// Méthode : FORM_createDOTfile
// Description
//

C_OBJECT:C1216($method; $param; $1)
C_TEXT:C284($DOT_Content)
C_COLLECTION:C1488($cluster; $dot; $dotContent)
C_POINTER:C301($paramArray)
ARRAY TEXT:C222($listObject; 0x0000)
ARRAY LONGINT:C221($listPages; 0x0000)
ARRAY TEXT:C222($pathMethods; 0x0000)

$param:=$1
$tableNumber:=Num:C11($param.table)
OB GET ARRAY:C1229($param; "objects"; $listObject)
OB GET ARRAY:C1229($param; "pages"; $listPages)
OB GET ARRAY:C1229($param; "methodPath"; $pathMethods)
$name:=$param.name

$dotContent:=New collection:C1472
$cluster:=New collection:C1472
$ThePage:=-1
$Alignement:=""

For ($current; 1; Size of array:C274($listPages))
	
	$currentCluster:="cluster_"+String:C10($listPages{$current})
	
	// Graphviz schema
	If ($ThePage#Num:C11($listPages{$current}))
		If ($ThePage>-1)
			$Alignements:=$Alignement+" -> "+$listObject{$current}+" [ltail="+$oldCluster+" lhead="+$currentCluster+"];"
			$cluster.push($Alignements)
			$oldCluster:=$currentCluster
			
			$Alignement:="\""+$listObject{$current}+"\""
			$dotContent.push("}")
			$dotContent.push(Char:C90(Line feed:K15:40))
			
		Else 
			$oldCluster:=$currentCluster
			$Alignement:="\""+$listObject{$current}+"\""
			$Alignements:="\"Local variable\" -> "+$Alignement+" [ltail=cluster_1000 lhead="+$currentCluster+"];"
			$cluster.push($Alignements)
			
		End if 
		
		$dotContent.push("subgraph "+$currentCluster+" {")  // New frame
		$dotContent.push("label=\"Page "+String:C10($listPages{$current})+"\";")  // Title
		$dotContent.push("style=\"filled\";")  // forme arrondi des bords, et cadre rempli
		$dotContent.push("color=gainsboro;")  // Background color
		
		$ThePage:=Num:C11($listPages{$current})
		
	End if 
	$const:=""
	$value:=""
	
	//If (Is nil pointer($paramArray->{$current}))
	If (Is nil pointer:C315($paramArray))
		$Txt_name:=""
	Else 
		RESOLVE POINTER:C394($paramArray->{$current}; $Txt_name; $Lon_table; $Lon_field)
		If ($Lon_field>0)
			$Txt_name:="["+Table name:C256($Lon_table)+"]"+Field name:C257($Lon_table; $Lon_field)
		Else 
			
			If (Length:C16($Txt_name)>0)
				
				If ($Txt_name[[1]]="$")  // dynamic variable
					$Txt_name:="(dynamic)"
				End if 
				
			End if 
		End if 
	End if 
	
	Case of 
			
		: ($Txt_name="(@")  // Dynamic variable
			$const:=" [style=filled, fillcolor=grey]"
			
		: ($Txt_name="<>@")  // Global variable
			$value:="[label = \""+$Txt_name+"\"]"
			$const:=" [style=filled, fillcolor=red]"
			
		: ($Txt_name#"")  // local variable
			$value:="[label = \""+$Txt_name+"\"]"
			$const:=" [style=filled, fillcolor=coral]"
			
		: ($Txt_name="")  // interface object
			$const:=" [style=filled, fillcolor=lightblue2]"
			
	End case 
	
	If ($value="")
		$value:="\""+$listObject{$current}+"\""+$const+";"
	Else 
		$value:="\""+$listObject{$current}+"\" "+$value+$const+";"
	End if 
	
	$dotContent.push($value)
	
End for 

$dotContent.push("}")
$dotContent.push(Char:C90(Line feed:K15:40))

// -- Legend
$dotContent.push("subgraph cluster_1000 {")  // Borders
$dotContent.push("label=\"Legend\";")  // Title
$dotContent.push("\"Local variable\" [style=filled, fillcolor=coral];")
$dotContent.push("\"Interprocess Variable\" [style=filled, fillcolor=red];")
$dotContent.push("\"Dynamic variable\" [style=filled, fillcolor=grey];")
$dotContent.push("\"Interface Object \" [style=filled, fillcolor=lightblue2];")
$dotContent.push("\"Method\" [fillcolor=yellow, style=filled, shape=rectangle];")
$dotContent.push("}")
$dotContent.push(Char:C90(Line feed:K15:40))

// -- Creation of method links with objects
For ($current; 1; Size of array:C274($pathMethods))
	
	$path:=$pathMethods{$current}
	$pos:=0
	Repeat 
		$position:=Position:C15("/"; $path; $pos+1)
		If ($position>0)
			$pos:=$position
		End if 
	Until ($position=0)
	$object:=Substring:C12($path; $pos+1)
	
	$method:=Storage:C1525.index[$path]
	If ($method#Null:C1517)
		
		For each ($call; $method.callers)
			$dotContent.push($call+" [fillcolor=yellow, style=filled, shape=rectangle];")
			$value:="\""+$Method.name+"\" -> \""+$call+"\";"
			$dotContent.push($value)
		End for each 
		
		For each ($call; $method.callees)
			$dotContent.push($call+" [fillcolor=yellow, style=filled, shape=rectangle];")
			$value:="\""+$object+"\" -> \""+$call+"\";"
			$dotContent.push($value)
		End for each 
		
	End if 
	
End for 

// -- Create the DOT file
$dot:=New collection:C1472
$dot.push("digraph {\""+$name+"\" {")
$dot.push("label=\""+$name+" from "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName+" \";")
$dot.push("comment=\"Generated by QS_Toolbox from QualiSoft - www.association-qualisoft.eu\";")
$dot.push("node [style=filled , shape=rectangle];")
$dot.push("edge [fontsize=10];")
$dot.push("compound=true;")
$dot.push("rankdir=TB;")
$dot.push("ratio=auto;")

$param.dotContent:=$dot.join(Char:C90(Line feed:K15:40))\
+Char:C90(Line feed:K15:40)\
+$dotContent.join(Char:C90(Line feed:K15:40); ck ignore null or empty:K85:5)\
+Char:C90(Line feed:K15:40)\
+$cluster.join(Char:C90(Line feed:K15:40); ck ignore null or empty:K85:5)\
+Char:C90(Line feed:K15:40)\
+" }}"