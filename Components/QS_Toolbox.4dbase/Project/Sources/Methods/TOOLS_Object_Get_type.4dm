//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 04/02/17, 15:33:34
// ----------------------------------------------------
// méthode : TOOLS_Object_Get_type
// description
// récupère les constantes de type "Object Get Type" dans 1 collection
//
// paramètres
// ----------------------------------------------------
C_TEXT:C284($Lon_constanteValue)
C_TEXT:C284($Txt_constantName)
C_COLLECTION:C1488($QS_TBX_objectType)

$QS_TBX_objectType:=New shared collection:C1527
$Langue:=Config_getLanguage
$Txt_path:=FILE_GetRessourceApplication

ARRAY TEXT:C222($tDom_units; 0x0000)
FOLDER LIST:C473($Txt_path; $tTxt_folders)
$Lon_x:=Find in array:C230($tTxt_folders; "@.lproj")

If ($Lon_x>0)
	
	$Txt_path:=$Txt_path+$Langue+".lproj"+Folder separator:K24:12+"4D_Constants"+$Langue+".xlf"
	
	If (Test path name:C476($Txt_path)=Is a document:K24:1)
		
		$Dom_root:=DOM Parse XML source:C719($Txt_path)
		
		If (OK=1)
			
			$tDom_units{0}:=DOM Find XML element:C864($Dom_root; "/xliff/file/body/group[78]/trans-unit"; $tDom_units)
			
			If (OK=1)
				
				For ($Lon_i; 1; Size of array:C274($tDom_units))
					
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i}; "d4:value"; $Lon_constanteValue)
					DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group[78]/trans-unit["+String:C10($Lon_i)+"]/target"); $Txt_constantName)
					$Txt_constantName:=Replace string:C233($Txt_constantName; "Object type"; "")
					Use ($QS_TBX_objectType)
						$QS_TBX_objectType.push(New shared object:C1526("name"; $Txt_constantName; "val"; $Lon_constanteValue))
					End use 
				End for 
			End if 
			
			DOM CLOSE XML:C722($Dom_root)
			Use (Storage:C1525)
				Storage:C1525.objectType:=$QS_TBX_objectType  // Just because we use a Shared collection.
			End use 
			
		End if 
	End if 
End if 

If (Count parameters:C259=1)
	C_OBJECT:C1216($1)
	signal_addResult($1; Current method name:C684)
End if 