//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/10/17, 16:34:16
  // ----------------------------------------------------
  // Méthode : VCS_Compare
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($currentVersion;$old)
C_BOOLEAN:C305($result)
$currentVersion:=""
$old:=""

If (Form:C1466.oldPath#Null:C1517)
	$currentVersion:=""
	If (Form:C1466.oldPath#"")  // One method is selected. We are ready to compare
		$methCourante:=Method called on error:C704
		ON ERR CALL:C155("BASE_noERROR")
		METHOD GET CODE:C1190(Form:C1466.oldPath;$currentVersion;*)
		MM_removeFirstLine (->$currentVersion)
		ON ERR CALL:C155($methCourante)
	End if 
	Form:C1466.currentVersion:=$currentVersion
	$old:=Form:C1466.oldVersion
End if 

WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"Compare_VCS";"insertInEditor";$result;"mergeleft";$currentVersion)
PROCESS_sleep (5)
WA EXECUTE JAVASCRIPT FUNCTION:C1043(*;"Compare_VCS";"insertInEditor";$result;"mergeright";$old)
