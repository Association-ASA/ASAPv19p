//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 09/01/16, 07:19:24
  // ----------------------------------------------------
  // Méthode : WebRecruteSurTableau
  // Description
  //  Recrute les diapos pertinentes en fonction 
  // des lignes du tableau affiché
  // Paramètre $1= message AJAX
  // ----------------------------------------------------
C_LONGINT:C283($Pos;$NumPhoto)
$Mess:=$1
$Mess:=Substring:C12($Mess;15)
$Pos:=Position:C15(";";$Mess)
$NumPhoto:=Num:C11(Substring:C12($Mess;1;($Pos-1)))
$Mess:=Substring:C12($Mess;($Pos+1))
APPEND TO ARRAY:C911(TbNumDiaR;$NumPhoto)
$Pos:=Position:C15(";";$Mess)

While ($Pos>0)
	$NumPhoto:=Num:C11(Substring:C12($Mess;1;($Pos-1)))
	$Mess:=Substring:C12($Mess;($Pos+1))
	APPEND TO ARRAY:C911(TbNumDiaR;$NumPhoto)
	$Pos:=Position:C15(";";$Mess)
End while 
$0:=""
