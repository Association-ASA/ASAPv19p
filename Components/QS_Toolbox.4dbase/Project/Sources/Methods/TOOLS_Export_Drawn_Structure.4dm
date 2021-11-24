//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 06/01/18, 10:19:32
  // ----------------------------------------------------
  // Méthode : TOOLS_Export_Drawn_Structure
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($vTStruc;$1;$NomImage;$2;$extension)

$NomImage:=$1
$structure:=$NomImage+".xml"
EXPORT STRUCTURE:C1311($vTStruc)
TEXT TO DOCUMENT:C1237($structure;$vTStruc)

If (Count parameters:C259=2)
	$extension:=$2
	$ScreenShot:=SUPPORT_Draw_Structure ($structure;$extension)
Else 
	$extension:=".svg"
	$ScreenShot:=SUPPORT_Draw_Structure ($structure)
End if 

DELETE DOCUMENT:C159($structure)