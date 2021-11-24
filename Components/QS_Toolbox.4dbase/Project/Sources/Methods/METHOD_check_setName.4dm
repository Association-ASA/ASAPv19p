//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 05/04/19, 14:46:15
// ----------------------------------------------------
// Paramètres
// $1 = path (text)
// $0 = collection
// ----------------------------------------------------
// Méthode : METHOD_check_setName
// Description
// Following discussion on http://forums.4d.com/Post/FR/21949953/3/21998331#21998331
// The most important sentences: 
// Aurais tu des ensembles de même nom sur des tables différentes ?
// Même des ensemble de surlignage dans des listes box ?

C_TEXT:C284($langage; $1; $MethText; $path; $Motif; $methodRef)
C_COLLECTION:C1488($coll; $pattern; $coll2; $allCommands; $j; $ref; $data)
ARRAY TEXT:C222($tableau2D; 0x0000; 0x0000)
C_OBJECT:C1216($temp)
C_OBJECT:C1216($methodToCheck)

$path:=$1
$langage:=Config_getLanguage
$coll:=New collection:C1472
$coll2:=New collection:C1472
$pattern:=New collection:C1472

$pattern.push("116"; "140"; "185")
METHOD GET CODE:C1190($path; $MethText; *)  // this is the method to check
$data:=Storage:C1525.allMethods

$j:=$data.indices("name = :1"; $path)
If ($j.length>0)
	
	$allCommands:=$data[$j[0]].commandToken
	For each ($token; $pattern)
		$setName:=":C"+$token
		
		If ($allCommands.indexOf($setName)#-1)  // One command setting a name has been found, so we have to check all method path
			
			// Setting in first record the reference to compare after ($coll[0])
			$Motif:="(?mi-s)("+Command name:C538(116)+")\\((\\[.*];)?(\\\".*\\\")"  // CREATE SET
			If (REGEX_ExtractText($Motif; $MethText; "1 2 3"; ->$tableau2D; 0)=0)
				For ($i; 1; Size of array:C274($tableau2D))
					$coll.push(New object:C1471("methodName"; $path; "result"; $tableau2D{$i}{3}; "tableName"; Substring:C12($tableau2D{$i}{2}; 1; Length:C16($tableau2D{$i}{2})-1)))
				End for 
			End if 
			
			$Motif:="(?mi-s)("+Command name:C538(140)+")\\((\\[.*];)?(\\\".*\\\")"  // CREATE EMPTY SET
			If (REGEX_ExtractText($Motif; $MethText; "1 2 3"; ->$tableau2D; 0)=0)
				For ($i; 1; Size of array:C274($tableau2D))
					$coll.push(New object:C1471("methodName"; $path; "result"; $tableau2D{$i}{3}; "tableName"; Substring:C12($tableau2D{$i}{2}; 1; Length:C16($tableau2D{$i}{2})-1)))
				End for 
			End if 
			
			$Motif:="(?mi-s)("+Command name:C538(185)+")\\((\\[.*];)?(\\\".*\\\")(;\\\".*\\\")"  // LOAD SET
			If (REGEX_ExtractText($Motif; $MethText; "1 2 3 4"; ->$tableau2D; 0)=0)
				For ($i; 1; Size of array:C274($tableau2D))
					$coll.push(New object:C1471("methodName"; $path; "result"; $tableau2D{$i}{3}; "tableName"; Substring:C12($tableau2D{$i}{2}; 1; Length:C16($tableau2D{$i}{2})-1)))
				End for 
			End if 
			
			// Now check all others methods
			For each ($methodToCheck; $data)
				
				For each ($includedtoken; $pattern)  // For each item of the pattern
					$includedSetName:=":C"+$includedtoken
					
					If ($allCommands.indexOf($includedSetName)#-1)  // One command setting a name has been found, so we have to check all method path
						
						$path:=$methodToCheck.name
						METHOD GET CODE:C1190($path; $MethText; *)  // this is the code of method to check (lastest version)
						
						$Motif:="(?mi-s)("+Command name:C538(116)+")\\((\\[.*];)?(\\\".*\\\")"  // CREATE SET
						If (REGEX_ExtractText($Motif; $MethText; "1 2 3"; ->$tableau2D; 0)=0)
							For ($i; 1; Size of array:C274($tableau2D))
								$coll.push(New object:C1471("methodName"; $path; "result"; $tableau2D{$i}{3}; "tableName"; Substring:C12($tableau2D{$i}{2}; 1; Length:C16($tableau2D{$i}{2})-1)))
							End for 
						End if 
						
						$Motif:="(?mi-s)("+Command name:C538(140)+")\\((\\[.*];)?(\\\".*\\\")"  // CREATE EMPTY SET
						If (REGEX_ExtractText($Motif; $MethText; "1 2 3"; ->$tableau2D; 0)=0)
							For ($i; 1; Size of array:C274($tableau2D))
								$coll.push(New object:C1471("methodName"; $path; "result"; $tableau2D{$i}{3}; "tableName"; Substring:C12($tableau2D{$i}{2}; 1; Length:C16($tableau2D{$i}{2})-1)))
							End for 
						End if 
						
						$Motif:="(?mi-s)("+Command name:C538(185)+")\\((\\[.*];)?(\\\".*\\\")(;\\\".*\\\")"  // LOAD SET
						If (REGEX_ExtractText($Motif; $MethText; "1 2 3 4"; ->$tableau2D; 0)=0)
							For ($i; 1; Size of array:C274($tableau2D))
								$coll.push(New object:C1471("methodName"; $path; "result"; $tableau2D{$i}{3}; "tableName"; Substring:C12($tableau2D{$i}{2}; 1; Length:C16($tableau2D{$i}{2})-1)))
							End for 
						End if 
					End if 
					
				End for each 
				
			End for each 
			
		End if 
		
	End for each 
	
	// Now, we have to chelc if there is an issue
	$ref:=$coll[0].result
	$methodRef:=$coll[0].methodName
	// Need to check if it is unique ($vCount = 1)
	$vCount:=$coll.countValues($ref; "result")
	If ($vCount=1)
		$coll.clear()
	Else 
		For each ($temp; $coll; $coll.length-1)
			If ($temp.tableName=$coll[0].tableName)
				$colL2.push($temp.tableName+" -> "+$temp.result)
			End if 
		End for each 
	End if 
	
End if 

$0:=$coll2