//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 22/09/19, 15:10:47
// ----------------------------------------------------
// Méthode : QuizzMontrerQuestionnaire
// Description
// Méthode qui affiche le questionnaire
//  à partir de l'interface de conception
// Paramètre : $1 = message de type montrequestionnaire+"oeil"+id du questionnaire
//    exemple : montrequestionnaireoeil1
//             {$2} =si retour au début du questionnaire = id de suivi
// ----------------------------------------------------

$Mess:=$1
QuizzFabriqueTbGeneraux
$Lo:=Length:C16("montrequestionnaire")
$IDQuestionnaire:=Num:C11(Substring:C12($Mess; ($Lo+5)))
QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IDQuestionnaire)
//CHERCHER([QuizzQuestions];[QuizzQuestions]IDQuestionnaire=$IDQuestionnaire;*)
// $Test:=Chaîne($IDQuestionnaire)+".1"
QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]CodeQuestion:5=(String:C10($IDQuestionnaire)+".1"))
$Action:=[QuizzQuestions:34]LibelQuestion:3
VarIdSuivi:=[QuizzQuestionnaires:35]Institution:4+Generate UUID:C1066
QuizzNoteSuivi($Action; $1; VarIdSuivi)
QuizzEcritHTMLQuestion([QuizzQuestions:34]ID:1)