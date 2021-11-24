//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 01/04/19, 10:39:58
// ----------------------------------------------------
// Méthode : MA_LH_clicked
// Description
//
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($atKeys; 0x0000)
ARRAY TEXT:C222($atValues; 0x0000)
ARRAY TEXT:C222($toBecounted; 0x0000)
ARRAY TEXT:C222($tableau2D; 0x0000; 0x0000)
C_COLLECTION:C1488($data; $declarationDoneInMethod; $declarationFound; $ent; $indice; $Storage)
C_OBJECT:C1216($varObj)
C_LONGINT:C283($count; $eleRef; $key; $Pos)
C_TEXT:C284($declaration)
C_LONGINT:C283($End; $Start)
C_TEXT:C284($toSearch)
C_TEXT:C284($declaredNotUsedForTest)

Form:C1466.declarationToAdd:=""

$ent:=New collection:C1472
$newDeclaration:=New collection:C1472
$Storage:=Storage:C1525.symbols_variable.copy()
GET LIST ITEM:C378(*; "myLH"; *; $eleRef; $eleTxt; $eleSSL; $elebDep)
GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item
$key:=Find in array:C230($atKeys; "path")
$path:=""
If ($key>0)
	$path:=$atValues{$key}
End if 

$key:=Find in array:C230($atKeys; "type")
$type:=""
If ($key>0)
	$type:=$atValues{$key}
End if 

$key:=Find in array:C230($atKeys; "clicked")
$clicked:=""
If ($key>0)
	$clicked:=$atValues{$key}
End if 

displayInfo($path)
METHOD GET CODE:C1190($path; $codePreview; *)  // Get the current version of code
$firstNL:=Position:C15("\r"; $codePreview)

If ($firstNL>0)
	Content_MA:=Substring:C12($codePreview; $firstNL+1)  // Remove the first line before displays it
	METHOD_codeMirror_display
End if 

StorageCounter("get")

If ($clicked="-") | (Shift down:C543)  // Shift down allow to redo the check, otehrwise, just the first time
	
	$data:=Storage:C1525.allMethods
	//$pic_command:=PIC_GetPicture("images/methods/icns_command.png")
	//$pic_method:=PIC_GetPicture("images/methods/icns_method.png")
	$pic_event:=PIC_GetPicture("images/methods/icns_event.png")
	$pic_form:=PIC_GetPicture("images/methods/icns_form.png")
	$pic_object:=PIC_GetPicture("images/methods/icn_object.png")
	$pic_table:=PIC_GetPicture("images/methods/icns_table.png")
	$pic_konstant:=PIC_GetPicture("images/methods/icns_konstant.png")
	$pic_plugIn:=PIC_GetPicture("images/methods/icns_plugin.png")
	
	Case of 
			
		: ($type="variable")
			
			C_COLLECTION:C1488($compilationData; $variableFoundInMethod)
			C_OBJECT:C1216($oneV)
			C_TEXT:C284($MethText)
			//$compilationData:="4D,form,ds,cs,form.,storage.,ds.,file.,folder.,cs.,4D."
			
			SET LIST ITEM PARAMETER:C986(*; "myLH"; $eleRef; "clicked"; "+")
			
			If ($clicked="-")  // | (Shift down & ($clicked="+")) // -> #debug only the LH is not reset at this point
				// Get the informaton from the DBName_symbols.txt file
				$MethText:=Storage:C1525.index[$path].clearCode
				
				$compilationData:=$storage.query("sourceName = :1"; $path)  // local variable
				$variableFoundInMethod:=New collection:C1472
				METHOD_getVariables($variableFoundInMethod; $MethText)  // obj: variable / declaration
				
				// -----------------
				// Get the informaton from the method itself
				$declarationDoneInMethod:=New collection:C1472
				//$MethText:=$codePreview
				METHOD GET CODE:C1190($path; $MethText; *)  // Already done
				//METHOD_getCleanCode(->$MethText)
				METHOD_getDeclarationType($declarationDoneInMethod; $MethText)
				
				// Then, check if $varDeclare exist in uniqueVariables
				If ($declarationDoneInMethod.length>0)
					For each ($varObj; $variableFoundInMethod)
						$result:=$declarationDoneInMethod.query("label IS :1"; $varObj.variable)
						If ($result.length=0)
							$varObj.declaration:="Declared -> Not used"
						Else 
							$varObj.declaration:=$result[0].declare
						End if 
					End for each 
				End if 
				
				
				If (True:C214)  // ⚠️
					CLEAR VARIABLE:C89($toBecounted)
					$ent.clear()
					$regex:="(\\$\\w+|<>[[:alpha:]ÄÖÄßéèçàßöäüô]\\w+|\\b[[:alpha:]ÄÖÄéèçàßöäüô]\\w+)"
					If (REGEX_ExtractText($regex; $MethText; "1"; ->$tableau2D; 0)=0)
						For ($a; 1; Size of array:C274($tableau2D))
							If ($tableau2D{$a}{1}#"")
								$ent.push($tableau2D{$a}{1})
							End if 
						End for 
					End if 
					
					$ent:=$ent.orderBy(ck ascending:K85:9)
					COLLECTION TO ARRAY:C1562($ent; $toBecounted)
				End if 
				
				$count:=0
				// So, some variables exist in the method
				
				For each ($varObj; $variableFoundInMethod)
					$variable:=$varObj.variable
					
					If ($variable="$@")  // Local variable
						$declarationFound:=$declarationDoneInMethod.indices("label = :1"; $variable)
						
						Case of 
								
							: ($variable="$_4D_auto_iter_@")
							: ($variable="@.value.@")
							: ($variable="@.result")
							: (Position:C15("."; $variable)=0)
								
								//$Souslist3:=LH_updateTB(->$eleSSL; ->$pic_event; $variable)
								$Souslist3:=LH_updateTBpath(->$eleSSL; "images/methods/icns_event.png"; $variable)
								$count:=$count+1
								
								Case of 
										
									: ($declarationFound.length=0)
										$declaration:=""
										
										For each ($oneV; $compilationData)
											If ($oneV.name=$Variable)
												$declaration:=$oneV.varType+Choose:C955($oneV.varDimension#""; " ("+$oneV.varDimension+")"; "")
											End if 
										End for each 
										
										If ($declaration#"")
											$declaration:="Not declared -> "+$declaration
											$newDeclaration.push(New object:C1471("var"; $variable; "decl"; $declaration))
										Else 
											
											// Manage $Variable which could be <> or Variable
											Case of 
												: ($variable#"$@")  // | ($variable="<>@")
													$compilationData:=$storage.query("name = :1"; $variable)
													If ($compilationData.length>0)
														$declaration:=$compilationData[0].varType+Choose:C955($compilationData[0].varDimension#""; " ("+$compilationData[0].varDimension+")"; "")
														SET LIST ITEM PARAMETER:C986($eleSSL; 0; Additional text:K28:7; $declaration)
													Else 
														$declaration:="Declared -> Not used"
														SET LIST ITEM PROPERTIES:C386($eleSSL; 0; False:C215; Italic:K14:3; 0; 0x00F79043)
													End if 
												Else 
													$declaration:="Not declared"
													SET LIST ITEM PROPERTIES:C386($eleSSL; 0; False:C215; Italic:K14:3; 0; 0x00FF0000)
											End case 
										End if 
										
										SET LIST ITEM PARAMETER:C986($eleSSL; 0; Additional text:K28:7; $declaration)
										SET LIST ITEM ICON:C950($eleSSL; 0; $pic_event)
										
										// Is it declared and not used ?
									: ($declarationFound.length>0)
										
										If (Position:C15($variable; $MethText)>0)
											
											$find:=Find in sorted array:C1333($toBecounted; $variable; >; $Start; $End)
											//$compilationData:=$declarationDoneInMethod.query("label = :1";$variable)
											If ($find)
												If ((1+$end-$start)<2)
													$declaration:="Declared -> Not used"
												Else 
													//$declaration:=$compilationData[0].varType+Choose($compilationData[0].varDimension#"";" ("+$compilationData[0].varDimension+")";"")
													$declaration:=$declarationDoneInMethod[$declarationFound[0]].declare
												End if 
											Else 
												//$declaration:=$compilationData[0].varType+Choose($compilationData[0].varDimension#"";" ("+$compilationData[0].varDimension+")";"")
												$declaration:=$declarationDoneInMethod[$declarationFound[0]].declare
											End if 
											
										Else   //We have to use QST routines -- Not optimized at all!!
											
											If ($compilationData.length=0)
												$declaration:=$declarationDoneInMethod[$declarationFound[0]].declare
											Else 
												For each ($oneV; $compilationData)
													If ($oneV.name=$Variable)
														$declaration:=$oneV.varType+Choose:C955($oneV.varDimension#""; " ("+$oneV.varDimension+")"; "")
													End if 
												End for each 
											End if 
											
										End if 
								End case 
								
							: (Position:C15("."; $variable)>0)
								
								//$Souslist3:=LH_updateTB(->$eleSSL; ->$pic_event; $variable)
								$Souslist3:=LH_updateTBpath(->$eleSSL; "images/methods/icns_event.png"; $variable)
								$count:=$count+1
								
								Case of 
									: ($variable="4D.")
										$declaration:="4D object"
										
									: (Substring:C12($variable; 1; 5)="Form.")
										$declaration:="Form object"
										
									: (Substring:C12($variable; 1; 8)="Storage.")
										$declaration:="Storage object"
										
									: (Substring:C12($variable; 1; 3)="ds.")
										$declaration:="DataStore"
										
									: (Substring:C12($variable; 1; 5)="file.")
										$declaration:="File object"
										
									: (Substring:C12($variable; 1; 7)="folder.")
										$declaration:="Folder object"
										
									: (Substring:C12($variable; 1; 3)="cs.")
										$declaration:="Class Store"
										
								End case 
						End case 
						
						// Update the UI
						SET LIST ITEM PARAMETER:C986($eleSSL; 0; Additional text:K28:7; $declaration)
						Case of 
							: ($declaration="Declared -> Not used")
								SET LIST ITEM PROPERTIES:C386($eleSSL; 0; False:C215; Italic:K14:3; 0; 0x00F79043)
							: ($declaration="Not declared -> @")
								SET LIST ITEM PROPERTIES:C386($eleSSL; 0; False:C215; Italic:K14:3; 0; 0x00FF0000)
								
						End case 
						
						SET LIST ITEM ICON:C950($eleSSL; 0; $pic_event)
					End if 
					
				End for each 
				
				
			End if 
			
			C_TEXT:C284($t)
			
			If ($newDeclaration.length>0)
				$coll:=$newDeclaration.distinct("decl")
				For each ($t; $coll)
					$sel:=$newDeclaration.query("decl =:1"; $t)
					
					Case of 
						: ($t="Long integer")
						: ($t="Picture")
						: ($t="Text")
						: ($t="Boolean")
						: ($t="Real")
						: ($t="Collection")
						: ($t="Object")
						: ($t="Pointer")
						: ($t="Variant")
							
					End case 
					
				End for each 
				
			End if 
			
			
			SET LIST ITEM PARAMETER:C986(*; "myLH"; $eleRef; Additional text:K28:7; String:C10($count))
			// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			
		: ($type="analysis")
			
			C_BOOLEAN:C305($enterable)
			C_LONGINT:C283($declarationFoundcon; $style)
			C_COLLECTION:C1488($result)
			$result:=New collection:C1472
			SET LIST ITEM PARAMETER:C986(*; "myLH"; $eleRef; "clicked"; "+")
			$sum:=0
			
			// ****************
			// search If False / 1=2 / 2=1...
			$result.clear()
			$result:=SC_check_If_False($path)
			//$Souslist:=LH_updateTB(->$eleSSL; ->$pic_event; "Dead code found between...")
			$Souslist:=LH_updateTBpath(->$eleSSL; "images/methods/icns_event.png"; "Dead code found between...")
			$sum:=$sum+Num:C11($result.length)
			If ($result.length>0)
				GET LIST ITEM PROPERTIES:C631(*; "myLH"; *; $enterable; $style; $declarationFoundcon)
				SET LIST ITEM PROPERTIES:C386(*; "myLH"; *; False:C215; $style; $declarationFoundcon; 0x00FF0000)
				SET LIST ITEM ICON:C950(*; "myLH"; *; $pic_event)
				SET LIST ITEM PARAMETER:C986(*; "myLH"; *; Additional text:K28:7; String:C10(Num:C11($result.length)))
				For each ($variable; $result)
					//$Souslist1:=LH_updateTB(->$Souslist; ->$pic_event; $variable)
					$Souslist1:=LH_updateTBpath(->$Souslist; "images/methods/icns_event.png"; $variable)
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "")
				End for each 
			End if 
			
			// ****************
			// Check SetName
			$result.clear()
			$result:=METHOD_check_setName($path)
			//$Souslist:=LH_updateTB(->$eleSSL; ->$pic_event; "Check Set name")
			$Souslist:=LH_updateTBpath(->$eleSSL; "images/methods/icns_event.png"; "Check Set name")
			$sum:=$sum+Num:C11($result.length)
			If ($result.length>0)
				GET LIST ITEM PROPERTIES:C631(*; "myLH"; *; $enterable; $style; $declarationFoundcon)
				SET LIST ITEM PROPERTIES:C386(*; "myLH"; *; False:C215; $style; $declarationFoundcon; 0x00FF0000)
				SET LIST ITEM ICON:C950(*; "myLH"; *; $pic_event)
				SET LIST ITEM PARAMETER:C986(*; "myLH"; *; Additional text:K28:7; String:C10(Num:C11($result.length)))
				For each ($variable; $result)
					//$Souslist1:=LH_updateTB(->$Souslist; ->$pic_event; $variable)
					$Souslist1:=LH_updateTBpath(->$Souslist; "images/methods/icns_event.png"; $variable)
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "")
				End for each 
			End if 
			
			// ****************
			// list form event manage
			$result.clear()
			$result:=METHOD_check_events($path)
			//$Souslist:=LH_updateTB(->$eleSSL; ->$pic_event; "Event")
			$Souslist:=LH_updateTBpath(->$eleSSL; "images/methods/icns_event.png"; "Event")
			$sum:=$sum+Num:C11($result.length)
			If ($result.length>0)
				GET LIST ITEM PROPERTIES:C631(*; "myLH"; *; $enterable; $style; $declarationFoundcon)
				SET LIST ITEM PROPERTIES:C386(*; "myLH"; *; False:C215; $style; $declarationFoundcon; 0x00FF0000)
				SET LIST ITEM ICON:C950(*; "myLH"; *; $pic_event)
				SET LIST ITEM PARAMETER:C986(*; "myLH"; *; Additional text:K28:7; String:C10(Num:C11($result.length)))
				For each ($variable; $result)
					//$Souslist1:=LH_updateTB(->$Souslist; ->$pic_event; $variable)
					$Souslist1:=LH_updateTBpath(->$Souslist; "images/methods/icns_event.png"; $variable)
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "")
				End for each 
			End if 
			
			// ****************
			// list depreceated command
			$result.clear()
			$result:=METHOD_check_depreceated($path)
			//$Souslist:=LH_updateTB(->$eleSSL; ->$pic_command; "Deprecated command")
			$Souslist:=LH_updateTBpath(->$eleSSL; "images/methods/icns_command.png"; "Deprecated command")
			$sum:=$sum+Num:C11($result.length)
			If ($result.length>0)
				GET LIST ITEM PROPERTIES:C631(*; "myLH"; *; $enterable; $style; $declarationFoundcon)
				SET LIST ITEM PROPERTIES:C386(*; "myLH"; *; False:C215; $style; $declarationFoundcon; 0x00FF0000)
				SET LIST ITEM ICON:C950(*; "myLH"; *; $pic_event)
				SET LIST ITEM PARAMETER:C986(*; "myLH"; *; Additional text:K28:7; String:C10(Num:C11($result.length)))
				For each ($variable; $result)
					//$Souslist1:=LH_updateTB(->$Souslist; ->$pic_event; $variable)
					$Souslist1:=LH_updateTBpath(->$Souslist; "images/methods/icns_event.png"; $variable)
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "")
				End for each 
			End if 
			
			// ****************
			// Check Open-close command
			$result.clear()
			$result:=METHOD_check_OpenClose($path)
			//$Souslist:=LH_updateTB(->$eleSSL; ->$pic_command; "Open-Close commands")
			$Souslist:=LH_updateTBpath(->$eleSSL; "images/methods/icns_command.png"; "Open-Close commands")
			$sum:=$sum+Num:C11($result.length)
			If ($result.length>0)
				GET LIST ITEM PROPERTIES:C631(*; "myLH"; *; $enterable; $style; $declarationFoundcon)
				SET LIST ITEM PROPERTIES:C386(*; "myLH"; *; False:C215; $style; $declarationFoundcon; 0x00FF0000)
				SET LIST ITEM ICON:C950(*; "myLH"; *; $pic_event)
				SET LIST ITEM PARAMETER:C986(*; "myLH"; *; Additional text:K28:7; String:C10(Num:C11($result.length)))
				For each ($variable; $result)
					//$Souslist1:=LH_updateTB(->$Souslist; ->$pic_event; $variable)
					$Souslist1:=LH_updateTBpath(->$Souslist; "images/methods/icns_event.png"; $variable)
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "path"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "")
					SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "")
				End for each 
			End if 
			
			SET LIST ITEM PARAMETER:C986(*; "myLH"; $eleRef; Additional text:K28:7; String:C10($sum))
			// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
			
		: ($type="syntax")
			C_COLLECTION:C1488($compilationData)
			$compilationData:=$data.query("name =:1"; $path)
			Content_MA:=$compilationData[0].syntax
			
			If (Content_MA="")
				Content_MA:=$path
			End if 
			
			METHOD_codeMirror_display
			
	End case 
	
End if 
StorageCounter("set")