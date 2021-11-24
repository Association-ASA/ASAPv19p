//%attributes = {"invisible":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 31/03/19, 09:23:12
  // Paramètres
  // ----------------------------------------------------
  // $1 : Object equal to the method to analyse
  // ----------------------------------------------------
  // Méthode : METHODS_get4dInformation
  // Description
  // Update the collection with Constant name & Constant token

C_COLLECTION:C1488($Konstants;$i;$commands)
C_OBJECT:C1216($ent;$1;$plugin)
C_TEXT:C284($language;$konst;$token)
ARRAY TEXT:C222($tableau2D;0x0000;0x0000)
C_COLLECTION:C1488($result)
C_LONGINT:C283($pos)

C_BOOLEAN:C305($LV_mode)
$LV_mode:=False:C215

ASSERT:C1129(Count parameters:C259=1;Current method name:C684+" expect 1 parameter (Object).")
ASSERT:C1129(Type:C295($1)=Is object:K8:27;"First parameter must be an object.")

$ent:=$1

If ($ent#Null:C1517)
	
	If ($ent.clearCode#"")  // No needs to do something if empty
		$method:=$ent.clearCode
		
		If (Not:C34($LV_mode))
			
			$Konstants:=New collection:C1472
			$Coll:=New collection:C1472
			$language:=Config_getLanguage 
			$PatternKonstant:="(:K\\d+:\\d+)"  // Get Konstant token only$commands:=Storage.commands4d
			$PatternCommands:="(:C\\d+)"  // Get command token token only
			
			If (REGEX_ExtractText ($PatternKonstant;$method;"1";->$tableau2D;0)=0)
				$Konstants.clear()
				For ($a;1;Size of array:C274($tableau2D))
					$Konstants.push($tableau2D{$a}{1})
				End for 
				$Konstants:=$Konstants.distinct()
				
				For each ($konst;$Konstants)
					$result:=Storage:C1525.constants.indices("token = :1";$konst)
					If ($result.length>0)
						$pos:=$ent.constantUsed.indexOf($konst)
						If ($pos<0)
							$ent.constantUsed.push(Storage:C1525.constants[$result[0]][$language])
							$ent.constantToken.push(Storage:C1525.constants[$result[0]].token)
							
							$toReplace:=Storage:C1525.constants[$result[0]][$language]+Storage:C1525.constants[$result[0]].token
							$method:=Replace string:C233($method;$toReplace;"")
						End if 
					End if 
				End for each 
			End if 
			
			$commands:=Storage:C1525.commands4d
			If (REGEX_ExtractText ($PatternCommands;$method;"1";->$tableau2D;0)=0)
				$Coll.clear()
				For ($a;1;Size of array:C274($tableau2D))
					$Coll.push($tableau2D{$a}{1})
				End for 
				$Coll:=$Coll.distinct()
				
				For each ($token;$Coll)
					$i:=$commands.indices("token = :1";$token)
					If ($i.length>0)
						If ($i[0]<$commands.length)
							$ent.commandUsed.push($commands[$i[0]][$language])
							$ent.commandToken.push($commands[$i[0]].token)
							
							$toReplace:=$commands[$i[0]][$language]+$commands[$i[0]].token
							$method:=Replace string:C233($method;$toReplace;"")
							
							Use ($commands)
								$commands[$i[0]].useIn.push($ent.name)
							End use 
							
						End if 
					End if 
				End for each 
			End if 
		End if 
		
		For each ($plugin;Storage:C1525.plugIn)
			$PatternPlugin:=$plugin.name
			
			If (Match regex:C1019($PatternPlugin;$method;1))
				$ent.pluginUsed.push($plugin.name)
				$ent.pluginToken.push($plugin.token)
			End if 
		End for each 
	End if 
	
	$ent.clearCode:=$method
	
End if 