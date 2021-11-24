//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 07/03/19, 15:55:40
// ----------------------------------------------------
// Méthode : FE_build_LH
// Description
// 
//
// Paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($TbForms; 0x0000)  // form names
C_PICTURE:C286($pic_event; $pic_form; $pic_object; $pic_method; $pic_table)
C_POINTER:C301($Zpt)

LH_messageProcessingData

$mainList:=New list:C375
$sep:=":"
//$pic_method:=PIC_GetPicture("images/methods/icns_method.png")
//$pic_form:=PIC_GetPicture("images/methods/icns_form.png")
//$pic_object:=PIC_GetPicture("images/methods/icns_object.png")
//$pic_event:=PIC_GetPicture("images/methods/icns_event.png")
//$pic_table:=PIC_GetPicture("images/methods/icns_table.png")

QS_TBX_LH_counter:=Storage:C1525.windows.counter


$maxTableNumber:=Get last table number:C254  // Get the latest table number

For ($table; 0; $maxTableNumber)
	
	//Create the first level of the LH
	Case of 
		: ($table=0)  // Project forms
			
			FORM GET NAMES:C1167($TbForms; *)
			If (Size of array:C274($TbForms)>0)  // In case of there is no Project Forms
				$subListe2:=New list:C375
				//$subListe2:=LH_updateTB(->$mainList; ->$pic_table; "Project Forms")
				$subListe2:=LH_updateTBpath(->$mainList; "images/methods/icns_table.png"; "Project Forms")
				SET LIST ITEM PARAMETER:C986($mainList; 0; "type"; "")
				SET LIST ITEM PARAMETER:C986($mainList; 0; "tableNumber"; -1)
				SET LIST ITEM PARAMETER:C986($mainList; 0; "formName"; "")
				SET LIST ITEM PARAMETER:C986($mainList; 0; "page"; -1)
				SET LIST ITEM PARAMETER:C986($mainList; 0; "objects"; "")
				SET LIST ITEM PARAMETER:C986($mainList; 0; "clicked"; "")
			End if 
			
		: ($table>0)  // Table forms, so we need to loop on each table
			
			If (Is table number valid:C999($table))
				$Zpt:=Table:C252($table)
				FORM GET NAMES:C1167($Zpt->; $TbForms; *)
				If (Size of array:C274($TbForms)>0)  // In case of there is no Table Forms ?!?
					$subListe2:=New list:C375
					//$subListe2:=LH_updateTB(->$mainList; ->$pic_table; Table name($table))
					$subListe2:=LH_updateTBpath(->$mainList; "images/methods/icns_table.png"; Table name:C256($table))
					SET LIST ITEM PARAMETER:C986($mainList; 0; "type"; "")
					SET LIST ITEM PARAMETER:C986($mainList; 0; "tableNumber"; $table)
					SET LIST ITEM PARAMETER:C986($mainList; 0; "formName"; "")
					SET LIST ITEM PARAMETER:C986($mainList; 0; "page"; -1)
					SET LIST ITEM PARAMETER:C986($mainList; 0; "objects"; "")
					SET LIST ITEM PARAMETER:C986($mainList; 0; "clicked"; "")
					
				End if 
			End if 
	End case 
	
	// Now, work on each forms
	For ($a; 1; Size of array:C274($TbForms))
		//$Souslist:=LH_updateTB(->$subListe2; ->$pic_table; $TbForms{$a})
		$Souslist:=LH_updateTBpath(->$subListe2; "images/methods/icns_table.png"; $TbForms{$a})
		SET LIST ITEM PARAMETER:C986($subListe2; 0; "type"; "form")
		SET LIST ITEM PARAMETER:C986($subListe2; 0; "tableNumber"; $table)
		SET LIST ITEM PARAMETER:C986($subListe2; 0; "formName"; $TbForms{$a})
		SET LIST ITEM PARAMETER:C986($subListe2; 0; "page"; -1)
		SET LIST ITEM PARAMETER:C986($subListe2; 0; "objects"; "")
		SET LIST ITEM PARAMETER:C986($subListe2; 0; "clicked"; "")
		
		//$temp:=LH_updateTB(->$Souslist; ->$pic_event; "Event")
		$temp:=LH_updateTBpath(->$Souslist; "images/methods/icns_event.png"; "Event")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "event")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "tableNumber"; $table)
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "formName"; $TbForms{$a})
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "page"; -1)
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "objects"; "")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "-")
		
		//$temp:=LH_updateTB(->$Souslist; ->$pic_method; "Method")
		$temp:=LH_updateTBpath(->$Souslist; "images/methods/icns_method.png"; "Method")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "method")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "tableNumber"; $table)
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "formName"; $TbForms{$a})
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "page"; -1)
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "objects"; "")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "-")
		
		//$temp:=LH_updateTB(->$Souslist; ->$pic_form; "Page")
		$temp:=LH_updateTBpath(->$Souslist; "images/methods/icns_form.png"; "Page")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "type"; "page")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "tableNumber"; $table)
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "formName"; $TbForms{$a})
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "page"; -1)
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "objects"; "")
		SET LIST ITEM PARAMETER:C986($Souslist; 0; "clicked"; "-")
		
	End for 
	CLEAR VARIABLE:C89($TbForms)
	
End for 

StorageCounter("set")
Form:C1466.LH:=Copy list:C626($mainList)
Form:C1466.formulare:=""
SET LIST PROPERTIES:C387(Form:C1466.LH; 0; 0; 14; 0; 0; 0)
OBJECT SET LIST BY REFERENCE:C1266(*; "myLH"; Choice list:K42:19; Form:C1466.LH)
