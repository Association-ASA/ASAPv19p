//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 09/04/18, 20:32:05
  // ----------------------------------------------------
  // Méthode : VCS_Refresh
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

Form:C1466.exportList:=VCS_ListExports 
Form:C1466.lastExport:=VCS_Get_LatestExport_Number 
Form:C1466.currentStamp:=VCS_Get_CurrentStamp 

If (Form:C1466.lastExport#Form:C1466.currentStamp)
	Form:C1466.VCS_LatestExport:=Form:C1466.lastExport
	Form:C1466.modified:=VCS_BuildArrays 
	
Else 
	
	ARRAY TEXT:C222($PathModified_at;0x0000)
	ARRAY DATE:C224($DateModified_at;0x0000)
	ARRAY LONGINT:C221($TimeModified_at;0x0000)
	C_COLLECTION:C1488($coll)
	$coll:=New collection:C1472
	ARRAY TO COLLECTION:C1563($coll;$PathModified_at;"path";$DateModified_at;"dateStamp";$TimeModified_at;"timeStamp")
	Form:C1466.modified:=$coll.copy()
End if 

OBJECT SET ENABLED:C1123(*;"btnExport";(Form:C1466.modified.length>0))

If (Form:C1466.modified.length>0)
	$FenetreInformation:=String:C10(Form:C1466.modified.length)+" new method(s) to insert in the next stamp point."
	displayInfo ($FenetreInformation)
End if 

Form:C1466.exportList:=Form:C1466.exportList
Form:C1466.modified:=Form:C1466.modified.orderBy("path asc, dateStamp asc, timeStamp asc")