//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 26/11/17, 12:22:07
  // ----------------------------------------------------
  // Méthode : LINKS_ReadInitValues
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------


C_TEXT:C284($Path;$PropertyName;$PropertyValue)
C_LONGINT:C283($Majeur)
C_COLLECTION:C1488($coll)
$coll:=New collection:C1472
$Majeur:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMajeur

$Path:=Get 4D folder:C485(Active 4D Folder:K5:10;*)+"Favorites v"+String:C10($Majeur)+Replace string:C233("/Local/";"/";Folder separator:K24:12)
If (Form:C1466.linkName#Null:C1517)
	$Filename:=Form:C1466.linkName.short_name+".4Dlink"
	$FullPath:=$Path+$FileName
	
	$XmlDoc:=Document to text:C1236($FullPath)
	$ref_XML_Struct:=DOM Parse XML variable:C720($XmlDoc)
	
	$nbAttributs:=DOM Count XML attributes:C727($ref_XML_Struct)
	For ($i;1;$nbAttributs)
		DOM GET XML ATTRIBUTE BY INDEX:C729($ref_XML_Struct;$i;$PropertyName;$PropertyValue)
		$coll.push(New object:C1471("propName";$PropertyName;"propValue";$PropertyValue))
	End for 
	DOM CLOSE XML:C722($ref_XML_Struct)
	Form:C1466.linkProperties:=$coll
Else 
	Form:C1466.linkProperties:=New collection:C1472
End if 
LINKS_SetValuesAfterRead 
LINKS_UpdateDOM 
Form:C1466.linkProperties:=Form:C1466.linkProperties