//%attributes = {"invisible":true,"preemptive":"capable"}
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


C_TEXT:C284($MethodName_T;$Langue_T)
C_BOOLEAN:C305($thread)
C_TEXT:C284($CommandsXLIFFFile_T;$Txt_TargetconstantName;$Txt_SourceconstantName;$Lon_constanteValue)
ARRAY TEXT:C222($tDom_units;0x0000)
C_TEXT:C284($theme)
C_LONGINT:C283($threadsafe)
C_COLLECTION:C1488($result)
C_OBJECT:C1216($command)
$command:=New object:C1471("id";New object:C1471;"detail";New object:C1471;"threadsafe";New collection:C1472;"restriction";New object:C1471)
$detail:=$command.detail

$MethodName_T:=Current method name:C684
ON ERR CALL:C155("BASE_noERROR")

If (Count parameters:C259>=1)
	$Langue_T:=$1
Else 
	$Langue_T:="fr"
End if 

$CommandsXLIFFFile_T:=FILE_GetRessourceApplication +Replace string:C233($Langue_T+".lproj/4D_commands"+$Langue_T+".xlf";"/";Folder separator:K24:12)

If (Test path name:C476($CommandsXLIFFFile_T)#Is a document:K24:1)
	$Langue_T:="en"
End if 

$Dom_root:=DOM Parse XML source:C719($CommandsXLIFFFile_T)

If (OK=1)
	
	$n:=20000
	$index:=-1
	
	For ($a;1;$n)
		
		$tDom_units{0}:=DOM Find XML element:C864($Dom_root;"/xliff/file/body/group["+String:C10($a)+"]/trans-unit";$tDom_units)
		
		If (OK=1)
			
			For ($Lon_i;1;Size of array:C274($tDom_units);1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i};"id";$Lon_constanteValue)
				$Lon_constanteValue:=":C"+Replace string:C233($Lon_constanteValue;"_";":")
				$Txt_SourceconstantName:=""
				$Txt_TargetconstantName:=""
				DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root;"/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/source");$Txt_SourceconstantName)
				DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root;"/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/target");$Txt_TargetconstantName)
				
				Case of 
						  // Remove non Active / validated commands
					: (Substring:C12($Txt_SourceconstantName;1;3)="_4D")  // Command on going -> DO NOT USE
					: (Length:C16($Txt_SourceconstantName)=0)  // Command number reserved, not yet named
					: (Character code:C91(Substring:C12($Txt_SourceconstantName;1;1))=64)  // test of '@' symbol
						
					Else   // This command is validated and usable
						$Txt_command:=Command name:C538(Num:C11($Lon_constanteValue);$threadsafe;$theme)
						$thread:=Choose:C955($threadsafe ?? 0;True:C214;False:C215)
						
						$detail[$Lon_constanteValue]:=New object:C1471("EN";$Txt_SourceconstantName;"FR";$Txt_TargetconstantName;\
							"useIn";New collection:C1472;"countCalls";0;"token";$Lon_constanteValue;\
							"lengthEN";Length:C16($Txt_SourceconstantName);"lengthFR";Length:C16($Txt_TargetconstantName);\
							"theme";$theme;"threadsafe";$thread;"syntax";"";"id";String:C10(Num:C11($Lon_constanteValue));"restriction";New collection:C1472)
						
				End case 
				
			End for 
		End if 
	End for 
	
	DOM CLOSE XML:C722($Dom_root)
End if 

$Langue_T:="EN"  // To get syntax in English or French
$CommandsXLIFFFile_T:=FILE_GetRessourceApplication +Replace string:C233($Langue_T+".lproj/4DSyntax"+$Langue_T+".xlf";"/";Folder separator:K24:12)

If (Test path name:C476($CommandsXLIFFFile_T)#Is a document:K24:1)
	
	ALERT:C41("4DSyntax"+$Langue_T+".xlf file not found!\nQS_Toolbox will continue with 4DSyntaxEN.xlf")
	$Langue_T:="en"
Else 
	
	$Dom_root:=DOM Parse XML source:C719($CommandsXLIFFFile_T)
	
	If (OK=1)
		
		$n:=20000
		$index:=-1
		$val:=0
		
		For ($a;1;$n)
			
			$tDom_units{0}:=DOM Find XML element:C864($Dom_root;"/xliff/file/body/group["+String:C10($a)+"]/trans-unit";$tDom_units)
			
			If (OK=1)
				
				For ($Lon_i;1;Size of array:C274($tDom_units);1)
					
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i};"resname";$txt_constanteValue)
					DOM GET XML ATTRIBUTE BY NAME:C728($tDom_units{$Lon_i};"id";$Lon_constanteValue)
					
					If ($txt_constanteValue=("cmd"+$Lon_constanteValue))
						DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root;"/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/source");$Txt_SourceconstantName)
						DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($Dom_root;"/xliff/file/body/group["+String:C10($a)+"]/trans-unit["+String:C10($Lon_i)+"]/target");$Txt_TargetconstantName)
						
						  // tableOptionnal
						Case of 
							: ($Langue_T="fr")
								$pos1_l:=Position:C15("{( laTable";$Txt_TargetconstantName)
								$pos2_l:=Position:C15("( {laTable";$Txt_TargetconstantName)
								
							: ($Langue_T="en")
								$pos1_l:=Position:C15("{( aTable";$Txt_TargetconstantName)
								$pos2_l:=Position:C15("( {aTable";$Txt_TargetconstantName)
								
						End case 
						If (($pos1_l+$pos2_l)>0)
							$detail[":C"+$Lon_constanteValue].restriction.push("tableOptionnal")
						End if 
						
						  // Obsolete command
						If (Substring:C12($detail[":C"+$Lon_constanteValue].EN;1;3)="_o_")
							$detail[":C"+$Lon_constanteValue].restriction.push("Obsolete")
						End if 
						
						$detail[":C"+$Lon_constanteValue].syntax:=$Txt_TargetconstantName
						
						$val:=$val2
					End if 
					
				End for 
			End if 
		End for 
		
		DOM CLOSE XML:C722($Dom_root)
		
	End if 
End if 



C_COLLECTION:C1488($collThreadsafe)
C_OBJECT:C1216($detail;$id;$restriction)
C_TEXT:C284($name;$oneRestriction)

$start:=Tickcount:C458
$id:=$command.id
$restriction:=$command.restriction
$collThreadsafe:=$command.threadsafe

For each ($name;$detail)
	  // Object(id) -> acces direct
	If ($id[$detail[$name].id]=Null:C1517)
		$id[$detail[$name].id]:=New collection:C1472
	End if 
	$id[$detail[$name].id].push($detail[$name])
	
	  //ThreadSafe
	If ($detail[$name].threadsafe=True:C214)
		$collThreadsafe.push($detail[$name])
	End if 
	
End for each 

  // Not ThreadSafe
$x:=New collection:C1472
For each ($name;$detail)
	If ($detail[$name].threadsafe=False:C215)
		$x.push($detail[$name])
	End if 
End for each 



  // Restriction
For each ($name;$detail)
	If ($detail[$name].restriction.length>0)
		For each ($oneRestriction;$detail[$name].restriction)
			If ($restriction[$oneRestriction]=Null:C1517)
				$restriction[$oneRestriction]:=New collection:C1472
			End if 
			$restriction[$oneRestriction].push($name)
		End for each 
	End if 
	
End for each 


$end:=Tickcount:C458
$n:=$end-$start


