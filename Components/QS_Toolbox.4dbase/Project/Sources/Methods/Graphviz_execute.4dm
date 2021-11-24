//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 01/07/19, 11:53:22
// ----------------------------------------------------
// Méthode : EXE_Graphviz
// Description
//  $1 : pointer on file path variable
// $2 : pointer on extension variable
//
// Paramètres
// ----------------------------------------------------

//C_TEXT($vt_path; $extension)
//C_POINTER($1; $2)

//$vt_path:=$1->
//$extension:=$2->

//// Start the Extrenal process setup
//SET ENVIRONMENT VARIABLE("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "false")
//$vt_out:=""
//$vt_err:=""

//If (Is macOS)  // Mac 0SX
//$vt_cmd:="/bin/sh"
//$vt_in:="/usr/local/bin/dot -T"+Substring($extension; 2)+" '"+$vt_path+"' -O"

//Else   // Windows
////$vt_path:=$vt_path+".txt"
//SET ENVIRONMENT VARIABLE("_4D_OPTION_HIDE_CONSOLE"; "true")
//$binpath:=Get 4D folder(Current resources folder)+Replace string("graphwiz-pc/bin/"; "/"; Folder separator)
//$vt_path:=Replace string($vt_path; "/"; Folder separator)
//$vt_cmd:="\""+$binpath+"dot.exe\" -T"+Substring($extension; 2)+" \""+$vt_path+"\" -O"
//$vt_in:=""
//End if 

//LAUNCH EXTERNAL PROCESS($vt_cmd; $vt_in; $vt_out; $vt_err)
//TOOL_fileSlowDown($vt_path+$extension)

