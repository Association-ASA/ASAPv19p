//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Paramètre :
// $1 : message Ajax de type Sauvegarde = [QuizzQuestionnaires]ID
// ----------------------------------------------------
// Méthode : QuizzSauveQuestionnaire
// Description
// Sauvegarde le questionnaire courant
//       à la demande de l'utilisateur
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 31/05/20, 18:25:49
$Mess:=$1
$IDQuestionnaireA:=String:C10(Num:C11($Mess))
QuizzExport($IDQuestionnaireA; $Mess)