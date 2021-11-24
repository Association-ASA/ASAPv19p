//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 28/02/19, 07:16:42
  // Paramètres
  // ----------------------------------------------------
  // Méthode : PM_renameVariable
  // Description
  // 
  //  Allow to rename a local variable
  // ----------------------------------------------------
  // 1st step: get all local variable

ARRAY TEXT:C222($tableau2D;0x0000;0x0000)
C_POINTER:C301($Nil)

If (Form:C1466.currentElement#Null:C1517)
	
	$MethText:=""
	$MethName:=Form:C1466.currentElement.name
	$PatternVariables:="(\\$[a-zA-Z_0-9]*\\b)|(<>\\b[^\\d][a-zA-Z_0-9]*\\b)"
	
	$Txt_CurrentMethodError:=""
	$Txt_CurrentMethodError:=Method called on error:C704
	ON ERR CALL:C155("BASE_GetError")
	  // Get the latest version of the code, in case of a modification since the last update
	METHOD GET CODE:C1190($MethName;$MethText;*)
	
	  // Check if we can update the code, otherwise, we stop.
	METHOD SET CODE:C1194($MethName;$MethText;*)
	
	If (gerror=-9766)  // Method already opened - 
		gerror:=0
		ON ERR CALL:C155($Txt_CurrentMethodError)
		ALERT:C41("The method '"+$MethName+"' is opened. Close it before trying to rename a variable.")
		
	Else 
		
		MM_removeFirstLine (->$MethText)
		If (REGEX_ExtractText ($PatternVariables;$MethText;"1 2";->$tableau2D;0)=0)
			
			ARRAY TEXT:C222($OldVariables;0x0000)
			C_COLLECTION:C1488($coll)
			$coll:=New collection:C1472
			
			For ($a;1;Size of array:C274($tableau2D))
				
				Case of 
					: ($tableau2D{$a}{1}#"")
						$coll.push($tableau2D{$a}{1})
						
					: ($tableau2D{$a}{2}#"")
						$coll.push($tableau2D{$a}{2})
						
				End case 
				
			End for 
			
			$coll:=$coll.distinct(ck diacritical:K85:3)
			COLLECTION TO ARRAY:C1562($coll;$OldVariables)
			
			C_COLLECTION:C1488($menu)
			$menu:=New collection:C1472
			$isOk:=True:C214
			
			For ($n;1;Size of array:C274($OldVariables))
				$menu.push(New object:C1471("label";$OldVariables{$n};"menu";String:C10($n)))
			End for 
			
			C_TEXT:C284($action_txt)
			$action_txt:=""
			$path_icons:="images/methods/icn_upd_"
			$isOk:=x_btnPopup_coll (On Clicked:K2:4;->$action_txt;$Nil;$path_icons;$menu)
			If ($isOk)
				
				$Variable:=$OldVariables{Num:C11($action_txt)}
				
				If ($Variable#"")
					
					$New:=Request:C163("Change '"+$Variable+"' by:\r(let empty to cancel or click on Cancel button)";$Variable)
					
					If ($New#"")
						
						If (Generate digest:C1147($New;MD5 digest:K66:1)#Generate digest:C1147($Variable;MD5 digest:K66:1)) & (OK=1)  // We need at least a word and not a clic on Cancel button
							
							ARRAY TEXT:C222($rT_Old_Directive;0x0000)
							ARRAY TEXT:C222($rT_New_Directive;0x0000)
							
							APPEND TO ARRAY:C911($rT_Old_Directive;"(?mi-s)(\\"+$Variable+")")
							APPEND TO ARRAY:C911($rT_New_Directive;$New)
							
							$erreur:=REGEX_SubstituteText ($rT_Old_Directive{1};$rT_New_Directive{1};->$MethText)
							
							$before:=Method called on error:C704
							ON ERR CALL:C155("BASE_noERROR")
							If (gerror=0)
								METHOD SET CODE:C1194($MethName;$MethText;*)
								Form:C1466.currentElement.code:=$MethText  // Update the current selection
								content_t:=$MethText
								METHOD_codeMirror_display 
							End if 
							ON ERR CALL:C155($before)
							  // ---
							
						Else 
							ALERT:C41("No change detected.")
						End if 
					Else 
						ALERT:C41("No variable has been selected.")
						
					End if 
				End if 
			End if 
			
		Else 
			ALERT:C41("No local / global variable in the method '"+$MethName+"'.")
		End if 
	End if 
Else 
	ALERT:C41("No method has been selected.")
	
End if 