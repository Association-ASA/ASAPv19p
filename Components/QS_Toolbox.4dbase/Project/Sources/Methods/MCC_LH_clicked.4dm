//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// Depending of the version, analyse is not made by the same way
ARRAY TEXT:C222($atKeys; 0)
ARRAY TEXT:C222($atValues; 0)
C_LONGINT:C283($key; $key2)

GET LIST ITEM:C378(*; "myLH"; *; $refItem; $textItem; $subList; $isOpen)  // Get the refItem of the selected one
GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item
$key:=Find in array:C230($atKeys; "type")
$key2:=Find in array:C230($atKeys; "path")

If ($key>0)
	
	C_COLLECTION:C1488($data)
	$data:=Storage:C1525.allMethods
	
	If ($atValues{$key}#"")
		
		Case of 
			: (Form event code:C388=On Clicked:K2:4)
				If (Right click:C712)
				Else 
					
					C_TEXT:C284(content_CC)
					$codePreview:=""
					WA SET PAGE CONTENT:C1037(*; "webZone"; "<html><body><font face=\"Verdana\" size=\"2\">"+$codePreview+"</font></body></html>"; "")
					
					Case of 
							
						: ($atValues{$key}="Method")
							C_COLLECTION:C1488($callees; $pos; $pos2)
							C_TEXT:C284($oneMethod)
							
							$key:=Find in array:C230($atKeys; "clicked")
							$clicked:=""
							If ($key>0)
								$clicked:=$atValues{$key}
							End if 
							
							$parent:=List item parent:C633(*; "myLH"; *)
							$position:=List item position:C629(*; "myLH"; $parent)
							GET LIST ITEM:C378(*; "myLH"; $position; $refParent; $textParent)  // Get the refItem of the selected one
							
							METHOD GET CODE:C1190(Form:C1466.name; $codePreview; *)
							$firstNL:=Position:C15("\r"; $codePreview)
							If ($firstNL>0)
								content_CC:=Substring:C12($codePreview; $firstNL+1)
							End if 
							METHOD_codeMirror_display
							
							If ($clicked#"+") & (Count list items:C380($subList)=0)
								
								SET LIST ITEM PARAMETER:C986(*; "myLH"; $refItem; "clicked"; "+")
								
								$pos:=$data.indices("name =:1"; $textItem)
								If ($pos.length>0)  // We found one
									//$pic_method:=PIC_GetPicture("images/methods/icns_method.png")
									$howMany:=$data[$pos[0]].callees.length
									SET LIST ITEM PARAMETER:C986($subList; 0; Additional text:K28:7; "call "+String:C10($howMany)+" method"+("s"*Num:C11($howMany>1)))
									
									If ($howMany>0)
										$callees:=$data[$pos[0]].callees
										StorageCounter("get")
										
										For each ($oneMethod; $callees)
											Case of 
													
												: ($oneMethod=$textItem) | ($oneMethod=$textParent)
													//SET LIST ITEM PARAMETER(*;"myLH";$refItem;Additional text;"recursive call")
													
												Else 
													//$Souslist1:=LH_updateTB(->$subList; ->$pic_method; $oneMethod)
													$Souslist1:=LH_updateTBpath(->$subList; "images/methods/icns_method.png"; $oneMethod)
													SET LIST ITEM PARAMETER:C986($subList; 0; "path"; $oneMethod)
													SET LIST ITEM PARAMETER:C986($subList; 0; "clicked"; "-")
													SET LIST ITEM PARAMETER:C986($subList; 0; "type"; "method")
													
													$pos2:=$data.indices("name =:1"; $oneMethod)
													If ($pos2.length>0)
														If ($data[$pos2[0]].callees.length>0)
															$howMany2:=$data[$pos2[0]].callees.length
															SET LIST ITEM PARAMETER:C986($subList; 0; Additional text:K28:7; "call "+String:C10($howMany2)+" method"+("s"*Num:C11($howMany2>1)))
														End if 
													End if 
													
											End case 
											
										End for each 
										StorageCounter("set")
										
									End if 
									
									SET LIST ITEM:C385(*; "myLH"; *; $textItem; $refItem; $subList; True:C214)
									
								End if 
							End if 
							
					End case 
				End if 
				
			: (Form event code:C388=On Double Clicked:K2:5)
				If (Right click:C712)
				Else 
					
					Case of 
							
						: ($atValues{$key}="Method")
							METHOD OPEN PATH:C1213($atValues{$key2}; *)
							
					End case 
				End if 
				
		End case 
	End if 
End if 