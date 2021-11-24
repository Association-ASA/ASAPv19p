//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 27/05/20, 08:30:13
// ----------------------------------------------------
// Méthode : QuizzRectifieCode
// Description
// Méthode qui met l'ID du questionnaite dans le code
//  des [QuizzQuestions]CodeQuestion et des [QuizzReponses]CodeReponse
//  si pas de paramètre
//  et renvoie dans VarRapportQD les noms des questionnaires defectueux sinon
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $Fumé; $SFT)
VarRapportQD:=""
$Vérif:=(Count parameters:C259=1)
// LECTURE ÉCRITURE(*)
ALL RECORDS:C47([QuizzQuestionnaires:35])
SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]ID:1; $TbIdQuestionnaire)
$FT:=Size of array:C274($TbIdQuestionnaire)
For ($Salé; 1; $FT)
	$IdQuestionnaireCourantN:=$TbIdQuestionnaire{$Salé}
	$IdQuestionnaireCourantA:=String:C10($IdQuestionnaireCourantN)
	QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]IDQuestionnaire:2=$IdQuestionnaireCourantN)
	$CodeQuestion:=[QuizzQuestions:34]CodeQuestion:5
	UNLOAD RECORD:C212([QuizzQuestions:34])
	$Test:=$IdQuestionnaireCourantA+"@"
	If ($CodeQuestion#$Test)
		If ($Vérif)
			$L:=Find in array:C230(<>TbQuestionnaireId; $IdQuestionnaireCourantN)
			VarRapportQD:=VarRapportQD+<>TbQuestionnaireInstitution{$L}+" ("+<>TbQuestionnaireTitre{$L}+")"+<>ZCR
		Else 
			// Rectification des [QuizzQuestions]CodeQuestion
			SELECTION TO ARRAY:C260([QuizzQuestions:34]CodeQuestion:5; $TbCodeQuestions)
			$SFT:=Size of array:C274($TbCodeQuestions)
			ARRAY TEXT:C222($TbNewCode; $SFT)
			For ($Fumé; 1; $SFT)
				$Pos:=Position:C15("."; $TbCodeQuestions{$Fumé})
				$TbCodeQuestions{$Fumé}:=$IdQuestionnaireCourantA+Substring:C12($TbCodeQuestions{$Fumé}; $Pos)
			End for 
			ARRAY TO SELECTION:C261($TbCodeQuestions; [QuizzQuestions:34]CodeQuestion:5)
			// Rectification des [QuizzReponses]
			RELATE MANY SELECTION:C340([QuizzReponses:33]IDQuestion:2)
			SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5; $TbCodeReponses)
			$SFT:=Size of array:C274($TbCodeReponses)
			ARRAY TEXT:C222($TbNewCode; $SFT)
			For ($Fumé; 1; $SFT)
				$Pos:=Position:C15("."; $TbCodeReponses{$Fumé})
				$TbCodeReponses{$Fumé}:=$IdQuestionnaireCourantA+Substring:C12($TbCodeReponses{$Fumé}; $Pos)
			End for 
			ARRAY TO SELECTION:C261($TbCodeReponses; [QuizzReponses:33]CodeReponse:5)
		End if 
	End if 
End for 
ZAmnistieInternationale
Case of 
	: ($Vérif) & (VarRapportQD="")
		VarRapportQD:="Vérification initiale achevée sans problème"+<>ZCR2
		$0:=True:C214
	: ($Vérif) & (VarRapportQD#"")
		VarRapportQD:="Vérification initiale achevée avec problèmes sur :"+<>ZCR+VarRapportQD+<>ZCR2
		$0:=False:C215
	Else 
		ALERT:C41("Rectification achevée")
End case 