//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 
// ----------------------------------------------------
// Méthode : MM_massiveMagikComment
// Description
//  
//
// Paramètres
// ----------------------------------------------------


C_COLLECTION:C1488($Methods)
$Methods:=New collection:C1472

If (Form:C1466.methodSelected.length>0)
	$Methods:=Form:C1466.methodSelected
Else 
	If (Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_hostInProjectMode)=False:C215)  // Binary Mode
		If ((OBJECT Get pointer:C1124(Object named:K67:5;"rd51"))->=1)
			$Methods:=Form:C1466.listboxDisplayed
		End if 
		
	Else   // Project Mode
		
/*
Cette documentation peut être générée pour des méthodes de type triggers, méthodes projet, méthodes formulaire, méthodes base ou les classes.
Note : Les formulaires et les méthodes formulaire partagent la même documentation.
*/
		
		$Methods:=Form:C1466.listboxDisplayed
	End if 
	
End if 

If ($Methods.length>0)
	$action:=False:C215
	If (x_io_confirm_yesNo("Do you want to apply 'Magik comments' on "+String:C10($Methods.length)+" method"+TOOL_plurial($Methods.length)+"?";->$action))
		C_OBJECT:C1216($signal)
		$signal:=New signal:C1641
		CALL WORKER:C1389("QST_job";"MM_magikCommentExecution";$Methods;Current form window:C827;$signal)
		$signal.wait()
		If (Form:C1466.currentElement#Null:C1517)
			MM_getCodeToDisplay(Form:C1466.currentElement)
		End if 
	End if 
	
Else 
	$txt:="You can only set a comment for a 'Path project method' method."
	displayInfo($txt;"red")
	
End if 