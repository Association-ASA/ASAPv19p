//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 02/03/19, 21:26:06
// Paramètres
// ----------------------------------------------------
// $1 : language requested
// ----------------------------------------------------
// Méthode : TOOLS_Get4DCommand
// Description
// Purpose: Get all 4D command names and IDs.


C_TEXT:C284($MethodName_T; $Langue_T)
C_BOOLEAN:C305($thread)
C_TEXT:C284($CommandsXLIFFFile_T; $Txt_TargetconstantName; $Txt_SourceconstantName; $Lon_constanteValue)
C_TEXT:C284($theme)
C_LONGINT:C283($threadsafe)
C_COLLECTION:C1488($result)
ARRAY TEXT:C222($tDom_units; 0x0000)

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684)

$result:=New collection:C1472

$MethodName_T:=Current method name:C684
ON ERR CALL:C155("BASE_noERROR")

If (Count parameters:C259>=1)
	$Langue_T:=$1
Else 
	$Langue_T:="fr"
End if 

$CommandsXLIFFFile_T:=FILE_GetRessourceApplication+Replace string:C233($Langue_T+".lproj/4D_commands"+$Langue_T+".xlf"; "/"; Folder separator:K24:12)

If (Test path name:C476($CommandsXLIFFFile_T)#Is a document:K24:1)
	$Langue_T:="en"
End if 

$Dom_root:=DOM Parse XML source:C719($CommandsXLIFFFile_T)

If (OK=1)
	
	$n:=20000
	$index:=-1
	
	For ($a; 1; $n)
		
		$tDom_units{0}:=DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit"; $tDom_units)
		
		If (OK=1)
			
			For ($Lon_i; 1; Size of array:C274($tDom_units); 1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i}; "id"; $Lon_constanteValue)
				$Lon_constanteValue:=":C"+Replace string:C233($Lon_constanteValue; "_"; ":")
				$Txt_SourceconstantName:=""
				$Txt_TargetconstantName:=""
				DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/source"); $Txt_SourceconstantName)
				DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/target"); $Txt_TargetconstantName)
				
				Case of 
						// Remove non Active / validated commands
					: (Substring:C12($Txt_SourceconstantName; 1; 3)="_4D")  // Command on going -> DO NOT USE
					: (Length:C16($Txt_SourceconstantName)=0)  // Command number reserved, not yet named
					: (Character code:C91(Substring:C12($Txt_SourceconstantName; 1; 1))=64)  // test of '@' symbol
						
					Else   // This command is validated and usable
						$Txt_command:=Command name:C538(Num:C11($Lon_constanteValue); $threadsafe; $theme)
						$thread:=Choose:C955($threadsafe ?? 0; True:C214; False:C215)
						
						$result.push(New object:C1471("EN"; $Txt_SourceconstantName; "FR"; $Txt_TargetconstantName; \
							"useIn"; New collection:C1472; "countCalls"; 0; "token"; $Lon_constanteValue; \
							"lengthEN"; Length:C16($Txt_SourceconstantName); "lengthFR"; Length:C16($Txt_TargetconstantName); \
							"theme"; $theme; "threadsafe"; $thread; "syntax"; ""; "id"; String:C10(Num:C11($Lon_constanteValue)); "restriction"; New collection:C1472))
				End case 
				
			End for 
		End if 
	End for 
	
	DOM CLOSE XML:C722($Dom_root)
End if 

$Langue_T:=Config_getLanguage  // To get syntax in English or French
If ($Langue_T="")
	ALERT:C41("4DSyntax"+$Langue_T+".xlf file not found!\nQS_Toolbox will continue with 4DSyntaxEN.xlf")
	$Langue_T:="en"
End if 
$CommandsXLIFFFile_T:=FILE_GetRessourceApplication+Replace string:C233($Langue_T+".lproj/4DSyntax"+$Langue_T+".xlf"; "/"; Folder separator:K24:12)

If (Test path name:C476($CommandsXLIFFFile_T)#Is a document:K24:1)
	
	ALERT:C41("4DSyntax"+$Langue_T+".xlf file not found!\nQS_Toolbox will continue with 4DSyntaxEN.xlf")
Else 
	
	$Dom_root:=DOM Parse XML source:C719($CommandsXLIFFFile_T)
	
	If (OK=1)
		
		$n:=20000
		$index:=-1
		$val:=0
		
		For ($a; 1; $n)
			
			$tDom_units{0}:=DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit"; $tDom_units)
			
			If (OK=1)
				
				For ($Lon_i; 1; Size of array:C274($tDom_units); 1)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i}; "resname"; $txt_constanteValue)
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i}; "id"; $Lon_constanteValue)
					
					If ($txt_constanteValue=("cmd"+$Lon_constanteValue))
						DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/source"); $Txt_SourceconstantName)
						DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root; "/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/target"); $Txt_TargetconstantName)
						
						$val2:=$result.findIndex($val; "COLL_findId"; $Lon_constanteValue)  // $val2=3
						If ($val2>=0)
							
							// tableOptionnal
							Case of 
								: ($Langue_T="fr")
									$pos1_l:=Position:C15("{( laTable"; $Txt_TargetconstantName)
									$pos2_l:=Position:C15("( {laTable"; $Txt_TargetconstantName)
									
								: ($Langue_T="en")
									$pos1_l:=Position:C15("{( aTable"; $Txt_TargetconstantName)
									$pos2_l:=Position:C15("( {aTable"; $Txt_TargetconstantName)
									
							End case 
							If ($pos1_l>0) | ($pos2_l>0)
								$result[$val2].restriction.push("tableOptionnal")
							End if 
							
							// Obsolete command
							If (Substring:C12($result[$val2].EN; 1; 3)="_o_")
								$result[$val2].restriction.push("Obsolete")
							End if 
							
							$result[$val2].syntax:=$Txt_TargetconstantName
							$val:=$val2
						End if 
						//End case 
					End if 
					
				End for 
			End if 
		End for 
		
		DOM CLOSE XML:C722($Dom_root)
		
	End if 
End if 

Use (Storage:C1525.commands4d)
	Storage:C1525.commands4d.clear()
	OB_CopyToSharedCollection($result; Storage:C1525.commands4d)
End use 

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
End if 