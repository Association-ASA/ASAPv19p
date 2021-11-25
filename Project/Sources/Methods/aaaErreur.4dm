//%attributes = {"lang":"fr"}
// TRACE

ARRAY LONGINT:C221($tbCode; 0)
ARRAY TEXT:C222($TabInt; 0)
ARRAY TEXT:C222($TabLib; 0)
C_LONGINT:C283($i; $erreur)
C_TEXT:C284($PHP_Error_Txt)

GET LAST ERROR STACK:C1015($tbCode; $TabInt; $TabLib)
$erreur:=error
BEEP:C151
$PHP_Error_Txt:=""
For ($i; 1; Size of array:C274($tbCode))
	//$PHP_Error_Txt:=$PHP_Error_Txt+Chaîne($tbCode{​​$i}​​)+" - "+$TabInt{​​$i}​​+" - "+$TabLib{​​$i}​​+Caractère(Retour chariot)
End for 
SET TEXT TO PASTEBOARD:C523($PHP_Error_Txt)