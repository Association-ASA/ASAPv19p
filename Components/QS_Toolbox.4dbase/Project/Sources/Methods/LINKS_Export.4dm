//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 26/11/17, 12:41:50
// ----------------------------------------------------
// Méthode : LINKS_Export
// Description
//  
//
// Paramètres
// ----------------------------------------------------

C_LONGINT:C283($Majeur)
C_OBJECT:C1216($proprety)
$Majeur:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMajeur

$Path:=Get 4D folder:C485(Active 4D Folder:K5:10; *)+"Favorites v"+String:C10($Majeur)+Replace string:C233("/Local/"; "/"; Folder separator:K24:12)
If (Form:C1466.linkName#Null:C1517)
	$Filename:=Form:C1466.linkName.name
Else 
	$Filename:=""
	Repeat 
		$Filename:=Request:C163("What is the new name?")
		If (ok=1)
			$Filename:=$Filename+".4Dlink"
		End if 
	Until ($Filename#"")
End if 

$FullPath:=$Path+$FileName

$action:=False:C215
If (x_io_confirm_yesNo("Do you want to proceed?"; ->$action))
	$currentDom_ref:=DOM Create XML Ref:C861("database_shortcut")
	
	For each ($proprety; Form:C1466.linkProperties)
		DOM SET XML ATTRIBUTE:C866($currentDom_ref; $proprety.propName; $proprety.propValue)
	End for each 
	// DOM EXPORT TO VAR($currentDom_ref;$myVar)
	DOM EXPORT TO FILE:C862($currentDom_ref; $FullPath)
	If (OK=1)
		displayInfo("Shortlink updated succesfully. You can restart with \""+$FileName+"\"")
		(OBJECT Get pointer:C1124(Object named:K67:5; "ChangeDetected"))->:=0
	End if 
End if 