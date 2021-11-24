//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"capable"}

var $1 : Text
var $buildNr4D : Integer
var $info4D; $major4D; $minor4D; $release4D; $version4D : Text

$version4D:=Application version:C493($buildNr4D)
$major4D:=$version4D[[1]]+$version4D[[2]]  //version number, e.g. 14
$release4D:=$version4D[[3]]  //Rx
$minor4D:=$version4D[[4]]  //.x
$info4D:="4D "+$major4D
If ($release4D="0")  //4D v14.x
	$info4D:=$info4D+Choose:C955($minor4D#"0"; "."+$minor4D; "")
Else   //4D v14 Rx
	$info4D:=$info4D+"R"+$release4D
End if 
$info4D:=$info4D+" (b"+String:C10($buildNr4D)+")"
//If (Version type ?? 64 bit version)
//$info4D:=$info4D+"(64bit)"
//Else
//$info4D:=$info4D+"(32bit)"
//End if
If (Is compiled mode:C492)
	$info4D:=$info4D+" compiled"
Else 
	$info4D:=$info4D+" interpreted"
End if 

$0:=$1+" | "+$info4D