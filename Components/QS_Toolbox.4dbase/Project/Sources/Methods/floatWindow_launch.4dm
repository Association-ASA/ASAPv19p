//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 21/05/17, 17:26:20
// ----------------------------------------------------
// Méthode : floatWindow_launch
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)

If (Count parameters:C259=0)
	ON ERR CALL:C155("Base_NoError")
	CALL WORKER:C1389("QST__follower"; Current method name:C684; 1)
	
Else 
	$ref_window:=Open form window:C675("_debug_floatwindow"; Palette form window:K39:9; On the left:K39:2; At the bottom:K39:6)
	OB_windowNumberToStorage("floatwindow"; $ref_window)
	DIALOG:C40("_debug_floatwindow"; *)
	
End if 