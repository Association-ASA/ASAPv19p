//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 26/04/18, 07:56:18
  // ----------------------------------------------------
  // Méthode : CONVERT_UpdateList
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

If (Form:C1466.konstant=Null:C1517)
	Form:C1466.konstant:=True:C214
End if 


If (Not:C34(Form:C1466.konstant))
	Form:C1466.display:=Form:C1466.konstante
Else   // Form.konstant=false
	Form:C1466.display:=Form:C1466.command
	
End if 
Form:C1466.konstant:=Not:C34(Form:C1466.konstant)
Form:C1466.display:=Form:C1466.display
Form:C1466.obsolete:=False:C215

$txt:="Found "+String:C10(Form:C1466.display.length)+" references."
displayInfo ($txt;"blue")