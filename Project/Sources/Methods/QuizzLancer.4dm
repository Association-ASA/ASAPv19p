//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 24/05/19, 10:12:16
// ----------------------------------------------------
// Méthode : QuizzLancer
// Description
// Méthode qui écrit le html de lancement du questionnaire
//  dont le numéro d'enregistrement est passé en paramètre
// Paramètre : $1= quizzLancer + numéro d'enregistrement([QuizzQuestionnaires])
// ----------------------------------------------------

$Mess:=$1
$Pos:=Position:C15("£"; $Mess)
VarIdSuivi:=Substring:C12($Mess; ($Pos+1))+Generate UUID:C1066
$DebutMess:=Substring:C12($Mess; 1; ($Pos-1))
QuizzFabriqueTbGeneraux
$NumEnr:=Num:C11($DebutMess)
GOTO RECORD:C242([QuizzQuestionnaires:35]; $NumEnr)
$L:=Find in array:C230(<>TbQuestionnaireId; [QuizzQuestionnaires:35]ID:1)
NbreTotalQuestion:=<>TbQuestionnaireNbreQuestions{$L}
QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]IDQuestionnaire:2=[QuizzQuestionnaires:35]ID:1; *)
$Test:=String:C10([QuizzQuestionnaires:35]ID:1)+".1"
QUERY:C277([QuizzQuestions:34];  & [QuizzQuestions:34]CodeQuestion:5=$Test)
$Action:=[QuizzQuestions:34]LibelQuestion:3
QuizzNoteSuivi($Action; $1; VarIdSuivi)
QuizzEcritHTMLQuestion([QuizzQuestions:34]ID:1)
