//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Méthode : TOOLS_executeSQLcommands
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 22/07/19, 11:24:23
  // Paramètres

C_TEXT:C284($pbj)

$pbj:=(OBJECT Get pointer:C1124(Object named:K67:5;"SQLCommands"))->

Begin SQL
	execute IMMEDIATE :$pbj
End SQL

If (OK=1)
	If (Position:C15("into listbox";$pbj)>0)
		FORM LAST PAGE:C251
		LISTBOX SET COLUMN WIDTH:C833(*;"Lb_Balance";100)
		LB_ResizeHeader (OBJECT Get pointer:C1124(Object named:K67:5;"Lb_Balance"))
	End if 
Else 
	ALERT:C41("An error occured during execution of your SQL code.")
End if 