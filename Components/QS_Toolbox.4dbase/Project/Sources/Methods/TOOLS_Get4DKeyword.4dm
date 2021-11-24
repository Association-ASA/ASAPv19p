//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 04/03/19, 18:57:23
// Paramètres
// ----------------------------------------------------
// $1 : language requested
// ----------------------------------------------------
// Méthode : TOOLS_Get4DKeyword
// Description
//

var $Langue_T; $MethodName_T : Text
$MethodName_T:=Current method name:C684

ARRAY TEXT:C222($tDom_units; 0x0000)
var $CommandsXLIFFFile_T; $ID; $txt_SourceKeyword; $txt_TargetKeyword : Text
var $QS_TBX_4D_Konstants : Collection

$QS_TBX_4D_Konstants:=New shared collection:C1527

If (Count parameters:C259=1)
	$Langue_T:=$1
Else 
	$Langue_T:="en"
End if 

$CommandsXLIFFFile_T:=FILE_GetRessourceApplication+Replace string:C233($Langue_T+".lproj/4D_LangEditKeyWords"+$Langue_T+".xlf"; "/"; Folder separator:K24:12)

If (Test path name:C476($CommandsXLIFFFile_T)#Is a document:K24:1)
	
	ALERT:C41("4D_LangEditKeyWords"+$Langue_T+".xlf file not found!")
	
Else 
	
	$Dom_root:=DOM Parse XML source:C719($CommandsXLIFFFile_T)
	
	If (OK=1)
		
		$n:=20000
		$index:=-1
		
		For ($a; 1; $n)
			
			$tDom_units{0}:=DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit"; $tDom_units)
			
			If (OK=1)
				
				For ($Lon_i; 1; Size of array:C274($tDom_units); 1)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i}; "id"; $ID)
					
					DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/source"); $txt_SourceKeyword)
					DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/target"); $txt_TargetKeyword)
					
					// This command is validated and usable
					If ($txt_SourceKeyword#":")
						Use ($QS_TBX_4D_Konstants)
							$QS_TBX_4D_Konstants.push(New shared object:C1526("EN"; $txt_SourceKeyword; "FR"; $txt_TargetKeyword; "token"; $ID))
						End use 
					End if 
				End for 
			End if 
		End for 
		
		DOM CLOSE XML:C722($Dom_root)
		Use (Storage:C1525)
			Storage:C1525.keywords:=$QS_TBX_4D_Konstants
		End use 
	End if 
End if 
$QS_TBX_4D_Konstants:=$QS_TBX_4D_Konstants.orderBy("EN desc")

If (Count parameters:C259=2)
	var $2 : Object
	signal_addResult($2; Current method name:C684)
End if 