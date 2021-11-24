//%attributes = {}
  // Web_ConfirmeMdp

C_BOOLEAN:C305($OnContinue)
ARRAY TEXT:C222(tnoms;2)
ARRAY TEXT:C222(tvaleurs;2)
C_TEXT:C284(Adherent)
C_DATE:C307(Aujourdhui)

WEB GET VARIABLES:C683(tnoms;tvaleurs)
ttr:=String:C10(Size of array:C274(tnoms))
  //Par défaut, on n'a pas le droit d'aller plus loin
$OnContinue:=((tvaleurs{1}=tvaleurs{2}) & (tvaleurs{1}#""))

If ($OnContinue)
	Adherent:=tvaleurs{1}
	Aujourdhui:=Current date:C33
	WEB SEND FILE:C619("verifok.html")
Else 
	WEB SEND FILE:C619("verifko.html")
End if 
