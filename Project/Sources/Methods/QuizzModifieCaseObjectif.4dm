//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 19/12/19, 16:09:42
  // ----------------------------------------------------
  // Méthode : QuizzModifieCaseObjectif
  // Description
  //   Méthode qui prend en compte le cochage ou non  
  //   de la case des objectifs
  // Paramètre : $1 = message AJAX type cbtheme1.1.2.3_2£true
  // ----------------------------------------------------
$Mess:=$1
$Pos:=Position:C15("£";$Mess)
$CasaCochée:=(Substring:C12($Mess;($pos+1))="true")
$Mess:=Substring:C12($Mess;8)
$Pos:=Position:C15(".";$Mess)
$IdQuestionnaire:=Num:C11(Substring:C12($Mess;1;($Pos-1)))
$Pos:=Position:C15("_";$Mess)
$CodeReponse:=Substring:C12($Mess;1;($pos-1))
$Rang:=Num:C11(Substring:C12($Mess;($pos+1)))
QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
ARRAY TEXT:C222($TbObjectifsGénéraux;0)
OB GET ARRAY:C1229([QuizzQuestionnaires:35]Argument:5;"TbObjectifs";$TbObjectifsGénéraux)
$Valeur:=$TbObjectifsGénéraux{$rang}
READ WRITE:C146([QuizzReponses:33])
QUERY:C277([QuizzReponses:33];[QuizzReponses:33]CodeReponse:5=$CodeReponse)
ARRAY TEXT:C222($TbObjectifsRéponse;0)
OB GET ARRAY:C1229([QuizzReponses:33]Argument:7;"TbObjectifs";$TbObjectifsRéponse)
$L:=Find in array:C230($TbObjectifsRéponse;$Valeur)
If ($L<0) & ($CasaCochée)
	APPEND TO ARRAY:C911($TbObjectifsRéponse;$Valeur)
End if 
If ($L>0) & (Not:C34($CasaCochée))
	DELETE FROM ARRAY:C228($TbObjectifsRéponse;$L)
End if 
OB SET ARRAY:C1227([QuizzReponses:33]Argument:7;"TbObjectifs";$TbObjectifsRéponse)
SAVE RECORD:C53([QuizzReponses:33])


