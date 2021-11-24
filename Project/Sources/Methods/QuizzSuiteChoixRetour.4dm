//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 04/10/19, 07:04:10
// ----------------------------------------------------
// Méthode : QuizzSuiteChoixRetour
// Description
//  Méthode envoyée suite à un message AJAX
//  de type "retourquizz"+ID de la session du quizz
// Paramètre : $1 = message AJAX
// ----------------------------------------------------
$Ajax:=$1
VarIdSuivi:=Substring:C12($Ajax; 12)  // élimination de "retourquizz"
QUERY:C277([QuizzSuivi:32]; [QuizzSuivi:32]IdSessionVisiteur:9=VarIdSuivi)
ORDER BY:C49([QuizzSuivi:32]; [QuizzSuivi:32]Ordre:8; <)
// ENREGISTREMENT SUIVANT([QuizzSuivi])  // On se place sur le suivi précédent la page actuelle
QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]ID:1=[QuizzSuivi:32]IDQuestion:7)
$Action:="Retour à "+[QuizzQuestions:34]LibelQuestion:3
QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=[QuizzSuivi:32]IDQuestionnaire:2)
QuizzNoteSuivi($Action; $Ajax; VarIdSuivi)
QuizzEcritHTMLQuestion([QuizzQuestions:34]ID:1; True:C214)