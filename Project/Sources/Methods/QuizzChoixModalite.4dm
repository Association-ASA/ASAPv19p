//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/09/19, 07:53:47
  // ----------------------------------------------------
  // Méthode : QuizzChoixModalite
  // Description
  // Méthode qui attribue une modalité d'évaluation [QuizzQuestions]Argument.ModeEvaluation
  //  avec 0 ou 1 = "Réponse immédiate" et 2 = Réponse différée
  // Paramètre : $1 =  message de type modaliteevaluation + valeur choisie + "_" +code de la question
  // ----------------------------------------------------

$Mess:=$1
$Mess:=Substring:C12($Mess;19)  // On enlève modaliteevaluation
$Pos:=Position:C15("_";$Mess)
$ValeurChoisie:=Num:C11(Substring:C12($Mess;1;($Pos-1)))
$Code:=Substring:C12($Mess;($Pos+4))
READ WRITE:C146([QuizzQuestions:34])
QUERY:C277([QuizzQuestions:34];[QuizzQuestions:34]CodeQuestion:5=$Code)
OB SET:C1220([QuizzQuestions:34]Argument:6;"ModeEvaluation";$ValeurChoisie)
SAVE RECORD:C53([QuizzQuestions:34])
