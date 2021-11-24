//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/10/17, 16:52:39
  // ----------------------------------------------------
  // Méthode : VCS_CreateStampPoint
  // Description
  // Paramètres
  // ----------------------------------------------------


C_COLLECTION:C1488($coll)
$coll:=New collection:C1472

If ((Shift down:C543) | (Count parameters:C259=1))  // Force to export all methods | first time
	ARRAY TEXT:C222($PathModified_at;0x0000)
	ARRAY DATE:C224($DateModified_at;0x0000)
	ARRAY LONGINT:C221($TimeModified_at;0x0000)
	
	  // Determination of the latest Stamp, in case of a method has been modified / created in the meantime
	METHOD GET PATHS:C1163(Path all objects:K72:16;$PathModified_at;*)
	METHOD GET MODIFICATION DATE:C1170($PathModified_at;$DateModified_at;$TimeModified_at;*)
	ARRAY TO COLLECTION:C1563($coll;$PathModified_at;"path";$DateModified_at;"dateStamp";$TimeModified_at;"timeStamp")
	  //Form.toExport:=$coll.copy()
Else 
	Form:C1466.toExport:=Form:C1466.modified.copy()  // Create a deep copy
	$coll:=Form:C1466.toExport
End if 
Form:C1466.currentStamp:=VCS_Get_CurrentStamp 
Form:C1466.VCS_LatestExport:=Form:C1466.currentStamp
VCS_ExportPaths ($coll)  // Export to external database