//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 08/03/19, 08:38:38
// Paramètres
// ----------------------------------------------------
// Méthode : FE_analyseElementClicked
// Description
// Navigation into Form Explorer LH

C_BOOLEAN:C305($QS_TBX_hauteurFixe; $QS_TBX_largeurFixe)
C_LONGINT:C283($QS_TBX_NbPages; $QS_TBX_hauteur; $QS_TBX_nbPages; $QS_TBX_largeur; $PrintOrientation)
C_LONGINT:C283($tableNum)
C_OBJECT:C1216($MyObject; $FormDetail)
C_POINTER:C301($ZptTable)
C_TEXT:C284($formName; $codePreview; $oldErrorMethod)
C_TEXT:C284($QS_TBX_titre)
C_COLLECTION:C1488($mycoll)

$MyObject:=New object:C1471
$FormDetail:=New object:C1471
$mycoll:=New collection:C1472
$oldErrorMethod:=Method called on error:C704
$seeIt:=True:C214

ON ERR CALL:C155("BASE_noERROR")

ARRAY TEXT:C222($atKeys; 0x0000)
ARRAY TEXT:C222($atValues; 0x0000)
GET LIST ITEM:C378(*; "myLH"; Selected list items:C379(*; "myLH"); $vlItemRef; $eleTxt; $eleSSL; $elebDep)
GET LIST ITEM PARAMETER ARRAYS:C1195(*; "myLH"; *; $atKeys; $atValues)  // get parameter arrays for the selected item

$key:=Find in array:C230($atKeys; "type")
$key2:=Find in array:C230($atKeys; "formName")
$key3:=Find in array:C230($atKeys; "clicked")
$key4:=Find in array:C230($atKeys; "tableNumber")
$key5:=Find in array:C230($atKeys; "page")
$key6:=Find in array:C230($atKeys; "objects")

Case of 
		
	: ($atValues{$key}="form")
		$formName:=$atValues{$key2}
		$tableNum:=Num:C11($atValues{$key4})
		Form:C1466.formulare:=$formName
		Form:C1466.tableNum:=$tableNum
		
End case 

$formName:=Form:C1466.formulare

If ($formName#"")  // Don't waste any time
	
	$type:=$atValues{$key}
	$clicked:=$atValues{$key3}
	$tableNum:=Num:C11($atValues{$key4})
	$currentPage:=Num:C11($atValues{$key5})
	
	If ($key6>0)
		$objects:=$atValues{$key6}
	End if 
	
	If ($tableNum>0)
		C_POINTER:C301($ZptTable)
		$ZptTable:=Table:C252($tableNum)
	End if 
	
	If ($type="form")  // No action on Project forms
		
		FE_formLoad($tableNum; $formName)
		GET PRINT OPTION:C734(Orientation option:K47:2; $PrintOrientation)
		
		If ($tableNum=0)
			If (Not:C34(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode))
				$MyObject.formName:=$formName
				$MyObject.tableNum:=$tableNum
				FE_getFormAttributes($MyObject)
				$QS_TBX_largeur:=Num:C11($MyObject.largeur)
				$QS_TBX_hauteur:=Num:C11($MyObject.hauteur)
				$QS_TBX_nbPages:=Num:C11($MyObject.nbpages)
				$QS_TBX_largeurFixe:=$MyObject.largeurfixe
				$QS_TBX_hauteurFixe:=$MyObject.hauteurfixe
				$QS_TBX_titre:=$MyObject.titre
			Else 
				FORM GET PROPERTIES:C674($formName; $QS_TBX_largeur; $QS_TBX_hauteur; $QS_TBX_nbPages; $QS_TBX_largeurFixe; $QS_TBX_hauteurFixe; $QS_TBX_titre)
			End if 
		Else 
			FORM GET PROPERTIES:C674($ZptTable->; $formName; $QS_TBX_largeur; $QS_TBX_hauteur; $QS_TBX_nbPages; $QS_TBX_largeurFixe; $QS_TBX_hauteurFixe; $QS_TBX_titre)
		End if 
		FORM UNLOAD:C1299
		
		$QS_TBX_titre:=Choose:C955($QS_TBX_titre=""; "{No form title defined}"; $QS_TBX_titre)
		(OBJECT Get pointer:C1124(Object named:K67:5; "QS_TBX_largeur"))->:=$QS_TBX_Largeur
		(OBJECT Get pointer:C1124(Object named:K67:5; "QS_TBX_hauteur"))->:=$QS_TBX_Hauteur
		(OBJECT Get pointer:C1124(Object named:K67:5; "QS_TBX_nbPages"))->:=$QS_TBX_NbPages
		(OBJECT Get pointer:C1124(Object named:K67:5; "QS_TBX_LargeurFixe"))->:=Num:C11($QS_TBX_largeurFixe)
		(OBJECT Get pointer:C1124(Object named:K67:5; "QS_TBX_HauteurFixe"))->:=Num:C11($QS_TBX_hauteurFixe)
		(OBJECT Get pointer:C1124(Object named:K67:5; "QS_TBX_Titre"))->:=$QS_TBX_titre
		(OBJECT Get pointer:C1124(Object named:K67:5; "PrintOrientation"))->:=Choose:C955($PrintOrientation; "No defined"; "Portrait"; "Landscape")
		
	End if 
	
	If ($clicked="-")  // Need to update first the LH
		
		Case of 
				
			: ($type="method")
				StorageCounter("get")
				
				ARRAY TEXT:C222($tabChemins; 0x0000)
				C_PICTURE:C286($pic_method)
				$pic_method:=PIC_GetPicture("images/methods/icns_method.png")
				
				If ($tableNum>0)
					METHOD GET PATHS FORM:C1168($ZptTable->; $tabChemins; $formName; *)
				Else 
					METHOD GET PATHS FORM:C1168($tabChemins; $formName; *)
				End if 
				
				For ($page; 1; Size of array:C274($tabChemins))
					//$temp:=LH_updateTB(->$eleSSL; ->$pic_method; $tabChemins{$page})
					$temp:=LH_updateTBpath(->$eleSSL; "images/methods/icns_method.png"; $tabChemins{$page})
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "type"; $type)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "tableNumber"; $tableNum)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "formName"; $tabChemins{$page})
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "page"; -1)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "object"; "")
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "clicked"; "+")
				End for 
				
				SET LIST ITEM PARAMETER:C986(*; "myLH"; $vlItemRef; Additional text:K28:7; String:C10(Size of array:C274($tabChemins)))
				OBJECT SET VISIBLE:C603(*; "properties"; False:C215)
				OBJECT SET VISIBLE:C603(*; "webZone"; True:C214)
				StorageCounter("set")
				
				
			: ($type="event")
				ARRAY LONGINT:C221($tabEvenement; 0x0000)
				FE_formLoad($tableNum; $formName)
				OBJECT GET EVENTS:C1238(*; ""; $tabEvenement)
				FORM UNLOAD:C1299
				StorageCounter("get")
				C_PICTURE:C286($pic_method)
				$pic_method:=PIC_GetPicture("images/methods/icns_method.png")
				
				For ($page; 1; Size of array:C274($tabEvenement))
					$newEvent:=Konstant_getName(2; $tabEvenement{$page})
					//$temp:=LH_updateTB(->$eleSSL; ->$pic_method; $newEvent)
					$temp:=LH_updateTBpath(->$eleSSL; "images/methods/icns_method.png"; $newEvent)
					//APPEND TO LIST($eleSSL;$newEvent;$newEvent+"-"+String($tableNum))
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "type"; "event")
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "tableNumber"; $tableNum)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "formName"; $newEvent)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "page"; -1)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "object"; "")
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "clicked"; "+")
				End for 
				SET LIST ITEM PARAMETER:C986(*; "myLH"; $vlItemRef; Additional text:K28:7; String:C10(Size of array:C274($tabEvenement)))
				StorageCounter("set")
				
			: ($type="page")
				ARRAY TEXT:C222($tabChemins; 0x0000)
				ARRAY TEXT:C222($listObject; 0x0000)
				ARRAY POINTER:C280($listPtr_var; 0x0000)
				ARRAY INTEGER:C220($listPages; 0x0000)
				C_PICTURE:C286($pic_form; $pic_object)
				
				$pic_object:=PIC_GetPicture("images/methods/icns_object.png")
				$pic_form:=PIC_GetPicture("images/methods/icns_form.png")
				$QS_TBX_NbPages:=(OBJECT Get pointer:C1124(Object named:K67:5; "QS_TBX_nbPages"))->
				
				// We have to download the form again to get all objects
				FE_getObjectsAndMethods($tableNum; $formName; ->$listObject; ->$listPtr_var; ->$listPages; ->$tabChemins)
				FORM UNLOAD:C1299
				StorageCounter("get")
				
				For ($page; 0; $QS_TBX_nbPages)
					//$Souslist2:=LH_updateTB(->$eleSSL; ->$pic_form; String($page))
					$Souslist2:=LH_updateTBpath(->$eleSSL; "images/methods/icns_form.png"; String:C10($page))
					
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "type"; "page")
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "tableNumber"; $tableNum)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "formName"; $formName)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "page"; $page)
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "objects"; "")
					SET LIST ITEM PARAMETER:C986($eleSSL; 0; "clicked"; "+")
					
					For ($b; 1; Size of array:C274($listPages))
						If ($page=$listPages{$b})  // This object is on this page
							//$temp:=LH_updateTB(->$Souslist2; ->$pic_object; $listObject{$b})
							$temp:=LH_updateTBpath(->$Souslist2; "images/methods/icns_object.png"; $listObject{$b})
							SET LIST ITEM PARAMETER:C986($Souslist2; 0; "type"; "object")
							SET LIST ITEM PARAMETER:C986($Souslist2; 0; "tableNumber"; $tableNum)
							SET LIST ITEM PARAMETER:C986($Souslist2; 0; "formName"; $formName)
							SET LIST ITEM PARAMETER:C986($Souslist2; 0; "page"; $page)
							SET LIST ITEM PARAMETER:C986($Souslist2; 0; "objects"; $listObject{$b})
							SET LIST ITEM PARAMETER:C986($Souslist2; 0; "clicked"; "+")
						End if 
						
					End for 
					
				End for 
				StorageCounter("set")
				
		End case 
		
		SET LIST ITEM:C385(*; "myLH"; $vlItemRef; $eleTxt; $vlItemRef; $eleSSL; True:C214)  // update the listbox
		SET LIST ITEM PARAMETER:C986(*; "myLH"; $vlItemRef; "clicked"; "+")
		
	Else   // Clicked # "-"
		
		Case of 
				
			: ($type="Method")
				METHOD GET CODE:C1190($atValues{$key2}; $codePreview; *)
				$firstNL:=Position:C15("\r"; $codePreview)
				If ($firstNL>0)
					Content_FE:=Substring:C12($codePreview; $firstNL+1)
					METHOD_codeMirror_display
				End if 
				
			: ($type="event")
				// Nothing to do
				
			: ($type="page")
				If ($currentPage=-1)
					$currentPage:=1
				End if 
				FE_ScreenShot($tableNum; $formName; $currentPage)
				
			: ($type="form")
				FE_ScreenShot($tableNum; $formName)
				
			: ($type="object")
				$seeIt:=False:C215
				$mycoll.clear()
				FE_formLoad($tableNum; $formName)
				$FormDetail.tableNum:=$tableNum
				$FormDetail.formName:=$formName
				$mycoll:=FE_GetObjectDetails($FormDetail; $objects)
				FORM UNLOAD:C1299
				Form:C1466.objectProperties:=$mycoll
				
			Else 
				Content_FE:=""
				METHOD_codeMirror_display
		End case 
		
	End if 
	
Else 
	UTIL_noPicturePath
End if 

OBJECT SET VISIBLE:C603(*; "properties"; Not:C34($seeIt))
OBJECT SET VISIBLE:C603(*; "webZone"; $seeIt)

ON ERR CALL:C155($oldErrorMethod)