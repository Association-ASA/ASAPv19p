//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 12/11/21, 18:29:00
// ----------------------------------------------------
// Méthode : QuizzImprimeQuestionnaire
// Description
// Méthode qui imprime le questionnaire sous forme PDF
//   et l'affiche sur le poste de l'internaute
// Paramètre: $1=message AJAX type ImpQuest + N° du questionnaire
// ----------------------------------------------------
$Mess:=$1
$IdQuestionnaire:=Num:C11($Mess)
$NomFichier:=Uppercase:C13($Mess)+".pdf"
$Cible:="/PDF/"+$NomFichier
// FIXER TEXTE DANS CONTENEUR($Cible)
ZPDFImprimer($NomFichier; ""; "QuizzImprimeLeQuestionnaire"; String:C10($IdQuestionnaire))
WEB SEND TEXT:C677($Cible)