//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 05/10/19, 11:12:14
// ----------------------------------------------------
// Méthode : QuizzSuiteChoixSuite
// Description
//  Méthode qui écrit la question suivante du questionnaire
//
// Paramètre $1 = message AJAX : suitequizz+ IdQuestionsuivante+"£"+IdSuivi
// ----------------------------------------------------
C_TEXT:C284($Ajax; $1; $Action)
C_LONGINT:C283($L; $IdQuestionSuivant; $L1)
ARRAY LONGINT:C221($TbNumQuestionAvecSuite; 0)


$Ajax:=$1
$Pos:=Position:C15("£"; $Ajax)
$IdQuestionSuivante:=Num:C11(Substring:C12($Ajax; 1; ($Pos-1)))
$L:=Find in array:C230(<>TbQuestionId; $IdQuestionSuivante)
If ($L>0)
	$Action:=<>TbQuestionLibelQuestion{$L}
Else 
	$Action:="Fin du questionnaire"
End if 
VarIdSuivi:=Substring:C12($Ajax; ($Pos+1))  // élimination de "suitequizz"+ IdQuestionsuivante+"£"
QUERY:C277([QuizzSuivi:32]; [QuizzSuivi:32]IdSessionVisiteur:9=VarIdSuivi)
ORDER BY:C49([QuizzSuivi:32]; [QuizzSuivi:32]Ordre:8; <)  // On se place sur le dernier suivi
OB GET ARRAY:C1229([QuizzSuivi:32]Argument:6; "TbQuestionsRestante"; $TbNumQuestionAvecSuite)
// $L:=Chercher dans tableau($TbNumQuestionAvecSuite;$IdQuestionSuivante)
If (Size of array:C274($TbNumQuestionAvecSuite)>0)
	$IdQuestionSuivante:=$TbNumQuestionAvecSuite{1}
	$L1:=Find in array:C230(<>TbQuestionId; $IdQuestionSuivante)
	$Action:=<>TbQuestionLibelQuestion{$L1}
	DELETE FROM ARRAY:C228($TbNumQuestionAvecSuite; 1)
	QuizzNoteSuivi($Action; $1; VarIdSuivi; ""; ->$TbNumQuestionAvecSuite)
Else 
	QuizzNoteSuivi($Action; $1; VarIdSuivi)
End if 

QuizzEcritHTMLQuestion($IdQuestionSuivante; True:C214)
