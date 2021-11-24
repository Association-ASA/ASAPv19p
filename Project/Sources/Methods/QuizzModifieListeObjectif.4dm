//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 19/12/19, 06:03:55
  // ----------------------------------------------------
  // Méthode : QuizzModifieListeObjectif
  // Description
  // Méthode qui prend en compte le changement 
  //  des objectifs généraux du questionnaire
  // Paramètre : $1 = message AJAX 
  //   du type "changeobjectif"+id du champ+"£"contenu du textarea 
  //   avec "£" comme séparateur de valeurs   changeobjectifobjectifs12£Lésions du foie£Tuberculose£Leucose£Diagnose espèce 
  // ----------------------------------------------------

$Mess:=$1
$Valeurs:=Substring:C12($Mess;15)  // élimination de "changeobjectif"
$Pos:=Position:C15("£";$Valeurs)
$IDQuestionnaire:=Num:C11(Substring:C12($Valeurs;1;($Pos-1)))
$Valeurs:=Substring:C12($Valeurs;($Pos+1))
ARRAY TEXT:C222($TbObjectifs;0)
ZTexteVersTableau ($Valeurs;->$TbObjectifs;"£")
READ WRITE:C146([QuizzQuestionnaires:35])
QUERY:C277([QuizzQuestionnaires:35];[QuizzQuestionnaires:35]ID:1=$IDQuestionnaire)
OB SET ARRAY:C1227([QuizzQuestionnaires:35]Argument:5;"TbObjectifs";$TbObjectifs)
SAVE RECORD:C53([QuizzQuestionnaires:35])
  // Chemin de fer
$Envoi:=QuizzEcritHTMLCdF   // recalcul du chemin de fer
WEB SEND TEXT:C677($Envoi)
