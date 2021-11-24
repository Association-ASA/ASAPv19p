//%attributes = {"invisible":true,"publishedSoap":false,"publishedWsdl":false,"shared":true,"publishedWeb":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent","published4DMobile":{"scope":"none"}}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 19/06/19, 09:49:04
  // ----------------------------------------------------
  // Méthode : __ValidationRapport
  // Description
  // Reviewed on 20 March 2020


If (Storage:C1525.QS_TBX_SHARED_DATA.QS_initDone#Null:C1517)
	
	$FormParam:=New object:C1471
	$refFen:=Open form window:C675("_Report_Options";Palette form window:K39:9;Horizontally centered:K39:1;Vertically centered:K39:4;*)
	DIALOG:C40("_Report_Options";$FormParam)
	CLOSE WINDOW:C154($refFen)
	
	If (OK=1)
		CALL WORKER:C1389("QST_job";"RAPPORT_creations";$FormParam)
	End if 
Else 
	C_POINTER:C301($ptr)
	EXECUTE METHOD:C1007("qs_toolbox";*;$ptr)
End if 

