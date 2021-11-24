//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 27/01/17, 14:31:08
  // ----------------------------------------------------
  // méthode : TOOLS_ReadOnly
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_TEXT:C284($1;$MethodName)

If (Form:C1466.readAndWrite)
	
	$MethodName:=$1
	EXECUTE METHOD:C1007($1)
	
Else 
	
	$txt:="You are on 'Read-Only' mode.\nClic on the padlock to switch to 'Read-Write' mode."
	CALL FORM:C1391(Current form window:C827;"displayInfo";$txt)
	
End if 