//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 08/10/14, 07:27:39
// ----------------------------------------------------
// méthode : SUPPORT_VersionApplication
// description
//
//
// paramètres
// ----------------------------------------------------
// QS - Patrick EMANUEL, 24/10/21 - 11:40:54

#DECLARE($obVersion : Object)
var $lon_build : Integer
var $txt_version : Text

If (Count parameters:C259=1)
	
	$txt_version:=Application version:C493($lon_build; *)
	
	$obVersion.type:=Choose:C955(Substring:C12($txt_version; 1; 1)="F"; "Final"; "R")
	$obVersion.major:=Num:C11($txt_version[[5]]+$txt_version[[6]])  // numéro de version : ex 14 // 1
	$obVersion.build:=$lon_build
	$obVersion.version:=String:C10($obVersion.major)+Choose:C955($txt_version[[8]]#"0"; "."+$txt_version[[8]]; "R"+$txt_version[[7]])  // 0
	$obVersion.full:=$obVersion.type+" "+$obVersion.version+" ("+String:C10($lon_build)+")"  // -1
	$obVersion.rVersion:=Choose:C955(Position:C15("R"; $obVersion.version)>0; True:C214; False:C215)
	$obVersion.minor:=Num:C11(Choose:C955($txt_version[[8]]#"0"; $txt_version[[8]]; $txt_version[[7]]))  // 2
	
Else 
	
	ALERT:C41("Error in called method.")
	
End if 
