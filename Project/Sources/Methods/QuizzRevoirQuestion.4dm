//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 15/04/21, 17:22:03
// ----------------------------------------------------
// Méthode : QuizzRevoirQuestion
// Description
// Méthode qui intercepte l'AJAX de la page Web 
//   quand le visiteur souhaite revoir une question
// ----------------------------------------------------
$Mess:=$1
$CodeQuestion:=Substring:C12($Mess; 13)
QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]CodeQuestion:5=$CodeQuestion)
VarIdSuivi:=""
QuizzEcritHTMLQuestion([QuizzQuestions:34]ID:1; False:C215)
